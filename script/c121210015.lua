--Valkyrie Crusader Skyfield
-- concept by Phikage
-- script By Shad3
--[[
When this card is activated: You can Special Summon 1 "Valkyrie Crusader" monster from your hand. You can only Special Summon "Valkyrie Crusader" monsters. All "Valkyrie Crusader" monsters on the field gain 300 ATK and DEF. When a "Valkyrie Crusader" card(s) is destroyed by battle or card effect: You can Special Summon 1 "Valkyrie Crusader" monster from your Deck. You can only use each effect of "Valkyrie Crusader Skyfield" once per turn.
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
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetDescription(aux.Stringid(s_id,0))
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetCountLimit(1,s_id)
	e2:SetDescription(aux.Stringid(s_id,1))
	e2:SetTarget(scard.a_tg)
	e2:SetOperation(scard.a_op)
	c:RegisterEffect(e2)
	--Limitsummon
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e3:SetRange(LOCATION_FZONE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetTargetRange(1,0)
	e3:SetTarget(scard.b_tg)
	c:RegisterEffect(e3)
	--ATK/DEF
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetRange(LOCATION_FZONE)
	e4:SetTargetRange(LOCATION_MZONE,LOCATION_FZONE)
	e4:SetTarget(scard.c_tg)
	e4:SetValue(300)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e5)
	--Summon(AGAIN)
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e6:SetCode(EVENT_DESTROYED)
	e6:SetRange(LOCATION_FZONE)
	e6:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e6:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e6:SetCountLimit(1,s_id+1)
	e6:SetDescription(aux.Stringid(s_id,1))
	e6:SetCondition(scard.d_cd)
	e6:SetTarget(scard.d_tg)
	e6:SetOperation(scard.d_op)
	c:RegisterEffect(e6)
end

function scard.a_fil(c,e,tp)
	return c:IsSetCard(sc_id) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end

function scard.a_cd(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(s_id)==0
end

function scard.a_tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(scard.a_fil,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end

function scard.a_op(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<1 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sc=Duel.SelectMatchingCard(tp,scard.a_fil,tp,LOCATION_HAND,0,1,1,nil,e,tp):GetFirst()
	if sc then Duel.SpecialSummon(sc,0,tp,tp,false,false,POS_FACEUP) end
end

function scard.b_tg(e,c,sump,sumtype,sumpos,targetp,re)
	return bit.band(sumtype,SUMMON_TYPE_SPECIAL)~=0 and not c:IsSetCard(sc_id)
end

function scard.c_tg(e,c)
	return c:IsSetCard(sc_id)
end

function scard.d_fil(c)
	return c:IsSetCard(sc_id) and c:IsReason(REASON_BATTLE+REASON_EFFECT)
end

function scard.d_cd(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(scard.d_fil,1,nil)
end

function scard.d_tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(scard.a_fil,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end

function scard.d_op(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<1 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sc=Duel.SelectMatchingCard(tp,scard.a_fil,tp,LOCATION_DECK,0,1,1,nil,e,tp):GetFirst()
	if sc then Duel.SpecialSummon(sc,0,tp,tp,false,false,POS_FACEUP) end
end
