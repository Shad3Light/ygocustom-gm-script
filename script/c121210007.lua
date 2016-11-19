--Valkyrie Crusader Necrosia
-- concept by Phikage
-- script By Shad3
--[[
Pendulum Scale = 6
[ Pendulum Effect ]
When this card is activated: You can return all "Valkyrie Crusader" Spell/Trap Cards from your Graveyard to your Deck, and if you do, pay Life Points equal to the number of cards returned x 500.
----------------------------------------
[ Monster Effect ]
When this card is Normal or Pendulum Summoned: You can Special Summon 1 Level 4 or lower "Valkyrie Crusader" monster face-up from your Extra Deck or from your Graveyard, and if you do, pay Life Points equal to half of the Special Summoned monster's original ATK. When this card is destroyed by a card effect: You can Special Summon 1 "Valkyrie Crusader" monster from your Deck, except "Valkyrie Crusader Necrosia". You can only use each monster effect of "Valkyrie Crusader Necrosia" once per turn.
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
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetCountLimit(1,s_id)
	e2:SetDescription(aux.Stringid(s_id,1))
	e2:SetTarget(scard.b_tg)
	e2:SetOperation(scard.b_op)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCondition(scard.b_cd)
	c:RegisterEffect(e3)
	--destroyed
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_DESTROYED)
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetCountLimit(1,s_id+1)
	e4:SetDescription(aux.Stringid(s_id,2))
	e4:SetCondition(scard.c_cd)
	e4:SetTarget(scard.c_tg)
	e4:SetOperation(scard.c_op)
	c:RegisterEffect(e4)
end

function scard.a_fil(c)
	return c:IsSetCard(sc_id) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToDeck()
end

function scard.a_tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(scard.a_fil,tp,LOCATION_GRAVE,0,nil)
	local n=g:GetCount()
	if n>0 and Duel.CheckLPCost(tp,n*500) and Duel.SelectYesNo(tp,aux.Stringid(s_id,0)) then
		e:SetCategory(CATEGORY_TODECK)
		e:SetOperation(scard.a_op)
		local g=Duel.GetMatchingGroup(scard.a_fil,tp,LOCATION_GRAVE,0,nil)
		Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),tp,LOCATION_GRAVE)
	else
		e:SetCategory(0)
		e:SetOperation(nil)
	end
end

function scard.a_op(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(scard.a_fil,tp,LOCATION_GRAVE,0,nil)
	if g:GetCount()>0 then
		local n=Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
		if n>0 then	Duel.PayLPCost(tp,n*500) end
	end
end

function scard.b_fil(c,e,tp)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(sc_id) and c:IsLevelBelow(4) and (c:IsLocation(LOCATION_GRAVE) or c:IsFaceup()) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.CheckLPCost(tp,c:GetBaseAttack()/2)
end

function scard.b_cd(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_PENDULUM
end

function scard.b_tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(scard.b_fil,tp,LOCATION_GRAVE+LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE+LOCATION_EXTRA)
end

function scard.b_op(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<1 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sc=Duel.SelectMatchingCard(tp,scard.b_fil,tp,LOCATION_GRAVE+LOCATION_EXTRA,0,1,1,nil,e,tp):GetFirst()
	if sc and Duel.SpecialSummon(sc,0,tp,tp,false,false,POS_FACEUP)~=0 then Duel.PayLPCost(tp,sc:GetBaseAttack()/2)	end
end

function scard.c_fil(c,e,tp)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(sc_id) and not c:IsCode(s_id) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end

function scard.c_cd(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_EFFECT)~=0
end

function scard.c_tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.c_fil,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end

function scard.c_op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,scard.c_fil,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP) end
end
