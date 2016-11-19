--Immortal God Slime
function c335599136.initial_effect(c)
--fusion material
c:EnableReviveLimit()
aux.AddFusionProcCode2(c,26905245,31709826,true,true)
--change name
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e1:SetCode(EFFECT_CHANGE_CODE)
e1:SetRange(LOCATION_MZONE)
e1:SetValue(31709826)
c:RegisterEffect(e1)
--atk
local e2=Effect.CreateEffect(c)
e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
e2:SetCode(EVENT_SPSUMMON_SUCCESS)
e2:SetOperation(c335599136.atkop)
c:RegisterEffect(e2)
--special summon
local e3=Effect.CreateEffect(c)
e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
e3:SetCode(EVENT_DESTROYED)
e3:SetCondition(c335599136.spcon)
e3:SetOperation(c335599136.spop)
c:RegisterEffect(e3)
end

function c335599136.atkop(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
local g=c:GetMaterial()
local sum=0
local tc=g:GetFirst()
while tc do
if tc:IsCode(26905245) then
local def=tc:GetPreviousDefenseOnField()
if def<0 then def=0 end
sum=sum+def
end
tc=g:GetNext()
end
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_SET_ATTACK)
e1:SetValue(sum)
e1:SetReset(RESET_EVENT+0x1ff0000)
c:RegisterEffect(e1)
local e2=e1:Clone()
e2:SetCode(EFFECT_SET_DEFENSE)
c:RegisterEffect(e2)
end
function c335599136.spcon(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
local pos=c:GetPreviousPosition()
if pos==POS_FACEDOWN_DEFENSE then pos=POS_FACEUP_DEFENSE end
if pos==POS_FACEDOWN_ATTACK then pos=POS_FACEUP_ATTACK end
e:SetLabel(pos)
return c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsLocation(LOCATION_GRAVE)
end
function c335599136.spop(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
local pos=e:GetLabel()
if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false) then
Duel.SpecialSummon(c,0,tp,tp,false,false,pos)
end
end