--Valkyrie Crusader Vlad
-- concept by Phikage
-- script By Shad3
--[[
Pendulum Scale = 2
[ Pendulum Effect ]
When this card is activated: You can target 1 "Valkyrie Crusader" monster on the field; destroy it, and if you do, gain Life Points equal to the destroyed monster's original ATK.
----------------------------------------
[ Monster Effect ]
When this card is Special Summoned: You can target 1 other monster on the field; destroy it, and if you do, this card gains ATK equal to half of the destroyed monster's original ATK. When this card destroys an opponent's monster by battle: You can pay 1000 Life Points; send this card to the Extra Deck face-up, and if you do, Special Summon 1 "Valkyrie Crusader" monster from your Deck. You can only use each monster effect of "Valkyrie Crusader Vlad" once per turn.
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
	--Spsum trigger
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_ATKCHANGE)
	e2:SetCountLimit(1,s_id)
	e2:SetDescription(aux.Stringid(s_id,1))
	e2:SetTarget(scard.b_tg)
	e2:SetOperation(scard.b_op)
	c:RegisterEffect(e2)
	--Spsum 2
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_DESTROYING)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetCountLimit(1,s_id+1)
	e3:SetDescription(aux.Stringid(s_id,2))
	e3:SetCondition(aux.bdocon)
	e3:SetCost(scard.c_cs)
	e3:SetTarget(scard.c_tg)
	e3:SetOperation(scard.c_op)
	c:RegisterEffect(e3)
end

function scard.a_fil(c)
	return c:IsSetCard(sc_id) and c:IsFaceup()
end

function scard.a_tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and scard.a_fil(chkc) end
	if chk==0 then return true end
	if Duel.IsExistingTarget(scard.a_fil,tp,LOCATION_MZONE,0,1,nil) and Duel.SelectYesNo(tp,aux.Stringid(s_id,0)) then
		e:SetProperty(EFFECT_FLAG_CARD_TARGET)
		e:SetCategory(CATEGORY_DESTROY+CATEGORY_RECOVER)
		e:SetOperation(scard.a_op)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
		local g=Duel.SelectTarget(tp,scard.a_fil,tp,LOCATION_MZONE,0,1,1,nil)
		local val=g:GetFirst():IsFaceup() and g:GetFirst():GetAttack() or 0
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,tp,0)
		Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,val)
	else
		e:SetProperty(0)
		e:SetCategory(0)
		e:SetOperation(nil)
	end
end

function scard.a_op(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if not tc then return end
	if tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)~=0 then
		local val=tc:GetBaseAttack()
		if val>0 then Duel.Recover(tp,val,REASON_EFFECT) end
	end
end

function scard.b_tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc~=e:GetHandler() and chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,e:GetHandler())
	local val=g:GetFirst():IsFaceup() and g:GetFirst():GetBaseAttack()/2 or 0
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,tp,0)
	Duel.SetOperationInfo(0,CATEGORY_ATKCHANGE,e:GetHandler(),1,tp,val)
end

function scard.b_op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local c=e:GetHandler()
	if tc and tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)~=0 and c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(tc:GetBaseAttack()/2)
		c:RegisterEffect(e1)
	end
end

function scard.c_fil(c,e,tp)
	return c:IsSetCard(sc_id) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end

function scard.c_cs(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end

function scard.c_tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToExtra() and Duel.IsExistingMatchingCard(scard.c_fil,tp,LOCATION_DECK,0,1,nil,e,tp) and Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0)
end

function scard.c_op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or Duel.SendtoExtraP(c,nil,REASON_EFFECT)==0 then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<1 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,scard.c_fil,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.BreakEffect()
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
