--Valkyrie Crusader Dracovera
-- concept by Phikage
-- script By Shad3
--[[
Pendulum Scale = 2
[ Pendulum Effect ]
When this card is activated: You can pay 1000 Life Points and target 1 "Valkyrie Crusader" monster you control; it gains 1000 ATK until the End Phase. You can destroy this card in your Pendulum Zone, and if you do, place 1 face-up "Valkyrie Crusader" Pendulum Monster from your Extra Deck in your Pendulum Zone, except "Valkyrie Crusader Dracovera".
----------------------------------------
[ Monster Effect ]
During either player's turn: You can discard this card, then target 1 "Valkyrie Crusader" monster you control; it gains 500 ATK and cannot be destroyed by battle or card effects, until the End Phase. During your turn, except during the turn this card was sent to the Graveyard: You can banish this card; add 1 "Valkyrie Crusader" monster from your Deck to your hand, except "Valkyrie Crusader Dracovera". You can only use each monster effect of "Valkyrie Crusader Dracovera" once per turn.
]]

local function getID()
	local str=string.match(debug.getinfo(2,'S')['source'],"c%d+%.lua")
	str=string.sub(str,1,string.len(str)-4)
	local scard=_G[str]
	local s_id=tonumber(string.sub(str,2))
	return scard,s_id
end

local scard,s_id=getID()
local sc_id=0x7c1

function scard.initial_effect(c)
	--pendulum
	aux.EnablePendulumAttribute(c,false)
	--Pendulum act
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(1160)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND)
	e1:SetTarget(scard.a_tg)
	c:RegisterEffect(e1)
	--Putpendulum
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetCountLimit(1)
	e2:SetTarget(scard.b_tg)
	e2:SetOperation(scard.b_op)
	c:RegisterEffect(e2)
	--discard
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_HAND)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetCountLimit(1,s_id)
	e3:SetDescription(aux.Stringid(s_id,2))
	e3:SetCost(scard.c_cs)
	e3:SetTarget(scard.c_tg)
	e3:SetOperation(scard.c_op)
	c:RegisterEffect(e3)
	--banish
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_GRAVE)
	e4:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e4:SetCountLimit(1,s_id+1)
	e4:SetDescription(aux.Stringid(s_id,1))
	e4:SetCondition(aux.exccon)
	e4:SetCost(scard.d_cs)
	e4:SetTarget(scard.d_tg)
	e4:SetOperation(scard.d_op)
	c:RegisterEffect(e4)
end

function scard.a_fil(c)
	return c:IsSetCard(sc_id) and c:IsFaceup()
end

function scard.a_tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and scard.a_fil(chkc) end
	if chk==0 then return true end
	if Duel.IsExistingTarget(scard.a_fil,tp,LOCATION_MZONE,0,1,nil) and Duel.CheckLPCost(tp,1000) and Duel.SelectYesNo(tp,aux.Stringid(s_id,0)) then
		Duel.PayLPCost(tp,1000)
		e:SetProperty(EFFECT_FLAG_CARD_TARGET)
		e:SetCategory(CATEGORY_ATKCHANGE)
		e:SetOperation(scard.a_op)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
		Duel.SelectTarget(tp,scard.a_fil,tp,LOCATION_MZONE,0,1,1,nil)
	else
		e:SetProperty(0)
		e:SetCategory(0)
		e:SetOperation(nil)
	end
end

function scard.a_op(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(1000)
		tc:RegisterEffect(e1)
	end
end

function scard.b_fil(c)
	return c:IsSetCard(sc_id) and c:IsFaceup() and not c:IsCode(s_id)
end

function scard.b_tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.b_fil,tp,LOCATION_EXTRA,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,tp,0)
end

function scard.b_op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.Destroy(c,REASON_EFFECT)~=0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
		local tc=Duel.SelectMatchingCard(tp,scard.b_fil,tp,LOCATION_EXTRA,0,1,1,nil):GetFirst()
		if tc then Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true) end
	end
end

function scard.c_cs(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end

function scard.c_tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and scard.a_fil(chkc) end
	if chk==0 then return Duel.IsExistingTarget(scard.a_fil,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,scard.a_fil,tp,LOCATION_MZONE,0,1,1,nil)
end

function scard.c_op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local c=e:GetHandler()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(500)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e2:SetValue(1)
		tc:RegisterEffect(e2)
		local e3=e2:Clone()
		e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		tc:RegisterEffect(e3)
	end
end

function scard.d_fil(c)
	return c:IsSetCard(sc_id) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end

function scard.d_cs(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end

function scard.d_tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.d_fil,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end

function scard.d_op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,scard.d_fil,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 and Duel.SendtoHand(g,nil,REASON_EFFECT)~=0 then Duel.ConfirmCards(1-tp,g) end
end
