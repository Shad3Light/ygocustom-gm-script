--Valkyrie Crusader Yata-Garasu
-- concept by Phikage
-- script By Shad3
--[[
Pendulum Scale = 6
[ Pendulum Effect ]
When this card is activated: You send 1 "Valkyrie Crusader" Pendulum Monster from your Deck to the Extra Deck face-up. "Valkyrie Crusader" monsters you control gain 100 ATK for each "Valkyrie Crusader" Spell/Trap Card you control other than this card.
----------------------------------------
[ Monster Effect ]
When this card is Normal or Pendulum Summoned: You can pay 1000 Life Points; add 1 "Valkyrie Crusader" Spell/Trap Card from your Deck to your hand. During either player's Battle Phase: You can pay 1000 Life Points; send this card you control or in your hand to the Extra Deck face-up, then Special Summon 1 "Valkyrie Crusader" monster from your Deck, except "Valkyrie Crusader Yata-Garasu". You can only use each monster effect of "Valkyrie Crusader Yata-Garasu" once per turn.
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
	--ATKChange
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_PZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(scard.b_tg)
	e2:SetValue(scard.b_val)
	c:RegisterEffect(e2)
	--Normal/Pend
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetCountLimit(1,s_id)
	e3:SetDescription(aux.Stringid(s_id,1))
	e3:SetCost(scard.c_cs)
	e3:SetTarget(scard.c_tg)
	e3:SetOperation(scard.c_op)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	e4:SetCondition(scard.c_cd)
	c:RegisterEffect(e4)
	--Spsum
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_QUICK_O)
	e5:SetCode(EVENT_FREE_CHAIN)
	e5:SetRange(LOCATION_HAND+LOCATION_MZONE)
	e5:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e5:SetCountLimit(1,s_id+1)
	e5:SetDescription(aux.Stringid(s_id,2))
	e5:SetCost(scard.d_cs)
	e5:SetCondition(scard.d_cd)
	e5:SetTarget(scard.d_tg)
	e5:SetOperation(scard.d_op)
	c:RegisterEffect(e5)
end

function scard.a_fil(c)
	return c:IsSetCard(sc_id) and c:IsType(TYPE_PENDULUM) and c:IsAbleToExtra()
end

function scard.a_tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if Duel.IsExistingMatchingCard(scard.a_fil,tp,LOCATION_DECK,0,1,nil) and Duel.SelectYesNo(tp,aux.Stringid(s_id,0)) then
		e:SetOperation(scard.a_op)
	else
		e:SetOperation(nil)
	end
end

function scard.a_op(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectMatchingCard(tp,scard.a_fil,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 and Duel.SendtoExtraP(g,nil,REASON_EFFECT)~=0 then Duel.ConfirmCards(1-tp,g) end
end

function scard.b_fil(c)
	return c:IsSetCard(sc_id) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsFaceup()
end

function scard.b_tg(e,c)
	return c:IsSetCard(sc_id) and c:IsFaceup()
end

function scard.b_val(e,c)
	return Duel.GetMatchingGroupCount(scard.b_fil,e:GetHandlerPlayer(),LOCATION_ONFIELD,0,e:GetHandler())*100
end

function scard.c_fil(c)
	return c:IsSetCard(sc_id) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
end

function scard.c_cs(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end

function scard.c_cd(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_PENDULUM
end

function scard.c_tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.c_fil,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end

function scard.c_op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,scard.c_fil,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 and Duel.SendtoHand(g,nil,REASON_EFFECT)~=0 then Duel.ConfirmCards(1-tp,g) end
end

function scard.d_fil(c,e,tp)
	return c:IsSetCard(sc_id) and c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end

function scard.d_cs(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end

function scard.d_cd(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE and Duel.GetCurrentChain()==0 and e:GetHandler():IsAbleToExtra()
end

function scard.d_tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return ((e:GetHandler():IsLocation(LOCATION_MZONE) and Duel.GetLocationCount(tp,LOCATION_MZONE)>-1) or Duel.GetLocationCount(tp,LOCATION_MZONE)>0) and Duel.IsExistingMatchingCard(scard.d_fil,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end

function scard.d_op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or Duel.SendtoExtraP(c,nil,REASON_EFFECT)==0 or Duel.GetLocationCount(tp,LOCATION_MZONE)<1 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,scard.d_fil,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP) end
end
