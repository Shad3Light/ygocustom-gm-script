--Valkyrie Crusader Titania
-- concept by Phikage
-- script By Shad3
--[[
Pendulum Scale = 6
[ Pendulum Effect ]
When this card is activated: You can destroy Spell/Trap Cards on the field, up to the number of "Valkyrie Crusader" monsters you control, and if you do, pay Life Points equal to the number of destroyed cards x 500.
----------------------------------------
[ Monster Effect ]
When this card is Normal or Pendulum Summoned: You can pay 1000 Life Points; add 1 "Valkyrie Crusader" monster from your Deck to your hand. You can destroy 1 other "Valkyrie Crusader" monster you control, and if you do, this card gains ATK equal to half of the destroyed monster's original ATK until the end of the turn. You can only use each monster effect of "Valkyrie Crusader Titania" once per turn.
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
	--Normal/Pend
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetCountLimit(1,s_id)
	e2:SetDescription(aux.Stringid(s_id,1))
	e2:SetCost(scard.b_cs)
	e2:SetTarget(scard.b_tg)
	e2:SetOperation(scard.b_op)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCondition(scard.b_cd)
	c:RegisterEffect(e3)
	--Destroy, draw
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCategory(CATEGORY_DESTROY+CATEGORY_ATKCHANGE)
	e4:SetCountLimit(1,s_id+1)
	e4:SetDescription(aux.Stringid(s_id,2))
	e4:SetTarget(scard.c_tg)
	e4:SetOperation(scard.c_op)
	c:RegisterEffect(e4)
end

function scard.a_fil(c)
	return c:IsSetCard(sc_id) and c:IsFaceup()
end

function scard.a_tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if Duel.GetMatchingGroupCount(scard.a_fil,tp,LOCATION_MZONE,0,nil)>0 and Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_SZONE,LOCATION_SZONE,1,nil) and Duel.CheckLPCost(tp,500) and Duel.SelectYesNo(tp,aux.Stringid(s_id,0)) then
		e:SetCategory(CATEGORY_DESTROY)
		e:SetOperation(scard.a_op)
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,nil,1,PLAYER_ALL,LOCATION_SZONE)
	else
		e:SetCategory(0)
		e:SetOperation(nil)
	end
end

function scard.a_op(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local m=Duel.GetLP(tp)/500
	local n=Duel.GetMatchingGroupCount(scard.a_fil,tp,LOCATION_MZONE,0,nil)
	if n>m then n=m end
	if n<1 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,aux.TRUE,tp,LOCATION_SZONE,LOCATION_SZONE,1,n,nil)
	if g:GetCount()>0 then
		local ct=Duel.Destroy(g,REASON_EFFECT)
		if ct>0 then Duel.PayLPCost(tp,ct*500) end
	end
end

function scard.b_fil(c)
	return c:IsSetCard(sc_id) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end

function scard.b_cd(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_PENDULUM
end

function scard.b_cs(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end

function scard.b_tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.b_fil,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end

function scard.b_op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,scard.b_fil,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 and Duel.SendtoHand(g,nil,REASON_EFFECT)~=0 then Duel.ConfirmCards(1-tp,g) end
end

function scard.c_fil(c)
	return c:IsSetCard(sc_id) and c:IsFaceup()
end

function scard.c_tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.c_fil,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,nil,1,tp,LOCATION_MZONE)
	Duel.SetOperationInfo(0,CATEGORY_ATKCHANGE,e:GetHandler(),1,tp,0)
end

function scard.c_op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local tc=Duel.SelectMatchingCard(tp,scard.c_fil,tp,LOCATION_MZONE,0,1,1,e:GetHandler()):GetFirst()
	local c=e:GetHandler()
	if tc and Duel.Destroy(tc,REASON_EFFECT)~=0 and c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(tc:GetBaseAttack()/2)
		c:RegisterEffect(e1)
	end
end
