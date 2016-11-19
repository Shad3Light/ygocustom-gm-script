--Etemon 
function c33559992.initial_effect(c)
c:SetUniqueOnField(1,0,33559992)
--spsummon
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
e1:SetCode(EVENT_BE_MATERIAL)
e1:SetCondition(c33559992.spcon1)
e1:SetOperation(c33559992.spop1)
c:RegisterEffect(e1)
--spsummon
local e2=Effect.CreateEffect(c)
e2:SetDescription(aux.Stringid(33559992,0))
e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
e2:SetRange(LOCATION_GRAVE)
e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
e2:SetCondition(c33559992.spcon)
e2:SetTarget(c33559992.sptg)
e2:SetOperation(c33559992.spop)
c:RegisterEffect(e2)
--token
local e3=Effect.CreateEffect(c)
e3:SetDescription(aux.Stringid(33559992,1))
e3:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
e3:SetType(EFFECT_TYPE_IGNITION)
e3:SetRange(LOCATION_MZONE)
e3:SetCountLimit(1,33559992)
e3:SetCondition(c33559992.spcon2)
e3:SetTarget(c33559992.sptg2)
e3:SetOperation(c33559992.spop2)
c:RegisterEffect(e3)
	--atkup
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(LOCATION_MZONE,0)
	e4:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_BEAST))
	e4:SetValue(300)
	c:RegisterEffect(e4)
end
function c33559992.spcon1(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
return c:IsLocation(LOCATION_GRAVE) and r==REASON_SUMMON
end
function c33559992.spop1(e,tp,eg,ep,ev,re,r,rp)
e:GetHandler():RegisterFlagEffect(33559992,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN,0,1)
end
function c33559992.spcon(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
return c:GetTurnID()~=Duel.GetTurnCount() and tp==Duel.GetTurnPlayer() and c:GetFlagEffect(33559992)>0
end
function c33559992.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
local c=e:GetHandler()
Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
c:ResetFlagEffect(33559992)
end
function c33559992.spop(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
if c:IsRelateToEffect(e) then
Duel.SpecialSummon(c,1,tp,tp,false,false,POS_FACEUP)
end
end
function c33559992.spfilter(c)
return c:IsCode(22222202)
end
function c33559992.spcon2(e,tp,eg,ep,ev,re,r,rp)
if Duel.IsExistingMatchingCard(c33559992.spfilter,tp,LOCATION_MZONE,0,1,nil) then return false
else return true end
end
function c33559992.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1
and Duel.IsPlayerCanSpecialSummonMonster(tp,22222202,0,0x4011,500,100,2,RACE_SPELLCASTER,ATTRIBUTE_DARK) end
Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,2,0,0)
Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
end
function c33559992.spop2(e,tp,eg,ep,ev,re,r,rp)
if Duel.GetLocationCount(tp,LOCATION_MZONE)<=1 then return end
if Duel.IsPlayerCanSpecialSummonMonster(tp,22222202,0,0x4011,500,100,2,RACE_SPELLCASTER,ATTRIBUTE_DARK) then
local token1=Duel.CreateToken(tp,22222202)
Duel.SpecialSummonStep(token1,0,tp,tp,false,false,POS_FACEUP)
local token2=Duel.CreateToken(tp,22222202)
Duel.SpecialSummonStep(token2,0,tp,tp,false,false,POS_FACEUP)
Duel.SpecialSummonComplete()
end
end