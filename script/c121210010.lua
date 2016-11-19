--Valkyrie Crusader Revival
-- concept by Phikage
-- script By Shad3
--[[
Once per turn, when a "Valkyrie Crusader" card (and no other cards) is sent to the Extra Deck: You can activate 1 of the following effects.
● Draw 1 card.
● Special Summon 1 "Valkyrie Crusader" monster from your hand or Graveyard.
When this card is destroyed by a card effect: You can Special Summon 1 "Valkyrie Crusader" monster from your Graveyard. You can only control 1 "Valkyrie Crusader Revival".
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
	--unique
	c:SetUniqueOnField(1,0,s_id)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Draw/Summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_DECK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetDescription(aux.Stringid(s_id,2))
	e2:SetCondition(scard.a_cd)
	e2:SetTarget(scard.a_tg)
	c:RegisterEffect(e2)
	--destroyed
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetDescription(aux.Stringid(s_id,1))
	e3:SetCondition(scard.c_cd)
	e3:SetTarget(scard.c_tg)
	e3:SetOperation(scard.c_op)
	c:RegisterEffect(e3)
end

function scard.a_fil(c)
	return c:IsSetCard(sc_id) and c:IsLocation(LOCATION_EXTRA)
end

function scard.a_cd(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(scard.a_fil,1,nil)
end

function scard.a_tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) or (Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(scard.b_fil,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp)) end
	local op
	if Duel.IsPlayerCanDraw(tp,1) then
		if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(scard.b_fil,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) then
			op=Duel.SelectOption(tp,aux.Stringid(s_id,0),aux.Stringid(s_id,1))
		else
			op=Duel.SelectOption(tp,aux.Stringid(s_id,0))
		end
	else
		op=Duel.SelectOption(tp,aux.Stringid(s_id,1))+1
	end
	if op==0 then
		e:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e:SetCategory(CATEGORY_DRAW)
		e:SetOperation(scard.a_op)
		Duel.SetTargetPlayer(tp)
		Duel.SetTargetParam(1)
		Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
	else
		e:SetProperty(0)
		e:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e:SetOperation(scard.b_op)
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
	end
end

function scard.a_op(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p,v=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,v,REASON_EFFECT)
end

function scard.b_fil(c,e,tp)
	return c:IsSetCard(sc_id) and c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end

function scard.b_op(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<1 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,scard.b_fil,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP) end
end

function scard.c_cd(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_EFFECT)~=0
end

function scard.c_tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.b_fil,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end

function scard.c_op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,scard.b_fil,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP) end
end
