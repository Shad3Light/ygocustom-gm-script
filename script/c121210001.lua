--Valkyrie Crusader Bahamut
-- concept by Phikage
-- script By Shad3
--[[
Pendulum Scale = 2
[ Pendulum Effect ]
When this card is activated: You can pay 2000 Life Points; add 1 "Valkyrie Crusader" card from your Deck to your hand. Monsters you control gain 100 ATK for each monster your opponent controls.
----------------------------------------
[ Monster Effect ]
When this card is Normal or Pendulum Summoned: You can Special Summon 1 Level 4 or lower "Valkyrie Crusader" monster from your Deck, except "Valkyrie Crusader Bahamut", and if you do, pay Life Points equal to half of the Special Summoned monster's original ATK. You can destroy 2 cards you control, and if you do, draw 1 card. You can only use each monster effect of "Valkyrie Crusader Bahamut" once per turn.
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
	--ATK gain (Peffect)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_PZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetValue(scard.b_val)
	c:RegisterEffect(e2)
	--Normal/Pend
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetCountLimit(1,s_id)
	e3:SetDescription(aux.Stringid(s_id,1))
	e3:SetTarget(scard.c_tg)
	e3:SetOperation(scard.c_op)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	e4:SetCondition(scard.c_cd)
	c:RegisterEffect(e4)
	--Destroy, draw
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCategory(CATEGORY_DESTROY+CATEGORY_DRAW)
	e5:SetCountLimit(1,s_id+1)
	e5:SetDescription(aux.Stringid(s_id,2))
	e5:SetTarget(scard.d_tg)
	e5:SetOperation(scard.d_op)
	c:RegisterEffect(e5)
end

function scard.a_fil(c)
	return c:IsSetCard(sc_id) and c:IsAbleToHand()
end

function scard.a_tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if Duel.IsExistingMatchingCard(scard.a_fil,tp,LOCATION_DECK,0,1,nil) and Duel.CheckLPCost(tp,2000) and Duel.SelectYesNo(tp,aux.Stringid(s_id,0)) then
		Duel.PayLPCost(tp,2000)
		e:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
		e:SetOperation(scard.a_op)
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	else
		e:SetCategory(0)
		e:SetOperation(nil)
	end
end

function scard.a_op(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,scard.a_fil,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 and Duel.SendtoHand(g,nil,REASON_EFFECT)~=0 then Duel.ConfirmCards(1-tp,g) end
end

function scard.b_val(e,c)
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),0,LOCATION_MZONE)*100
end

function scard.c_fil(c,e,tp)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(sc_id) and not c:IsCode(s_id) and c:IsLevelBelow(4) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.CheckLPCost(tp,c:GetBaseAttack()/2)
end

function scard.c_cd(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_PENDULUM
end

function scard.c_tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(scard.c_fil,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end

function scard.c_op(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<1 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sc=Duel.SelectMatchingCard(tp,scard.c_fil,tp,LOCATION_DECK,0,1,1,nil,e,tp):GetFirst()
	if sc and Duel.SpecialSummon(sc,0,tp,tp,false,false,POS_FACEUP)~=0 then Duel.PayLPCost(tp,sc:GetBaseAttack()/2) end
end

function scard.d_tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_ONFIELD,0)>1 and Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,nil,2,tp,LOCATION_ONFIELD)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end

function scard.d_op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local tg=Duel.GetFieldGroup(tp,LOCATION_ONFIELD,0):Select(tp,2,2,nil)
	if tg:GetCount()==2 and Duel.Destroy(tg,REASON_EFFECT)~=0 then Duel.Draw(tp,1,REASON_EFFECT) end
end
