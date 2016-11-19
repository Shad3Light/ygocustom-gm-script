--Guardian of Acient Secrets
function c33559969.initial_effect(c)
--special summon hand
local e1=Effect.CreateEffect(c)
e1:SetDescription(aux.Stringid(33559969,0))
e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
e1:SetType(EFFECT_TYPE_IGNITION)
e1:SetCountLimit(1)
e1:SetRange(LOCATION_MZONE)
e1:SetCost(c33559969.spcost)
e1:SetTarget(c33559969.sptg)
e1:SetOperation(c33559969.spop)
c:RegisterEffect(e1)
--special summon deck
local e2=Effect.CreateEffect(c)
e2:SetDescription(aux.Stringid(33559969,1))
e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
e2:SetType(EFFECT_TYPE_IGNITION)
e2:SetCountLimit(1)
e2:SetRange(LOCATION_MZONE)
e2:SetCost(c33559969.spcost2)
e2:SetTarget(c33559969.sptg2)
e2:SetOperation(c33559969.spop2)
c:RegisterEffect(e2)
end
function c33559969.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.CheckReleaseGroup(tp,nil,1,nil) end
local g=Duel.SelectReleaseGroup(tp,nil,1,1,nil)
Duel.Release(g,REASON_COST)
end
function c33559969.filter(c,e,tp)
return (c:GetLevel()==5 or c:GetLevel()==6) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c33559969.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
and Duel.IsExistingMatchingCard(c33559969.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c33559969.spop(e,tp,eg,ep,ev,re,r,rp)
if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
local g=Duel.SelectMatchingCard(tp,c33559969.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
local tc=g:GetFirst()
if	Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP) then
tc:RegisterFlagEffect(33559969,RESET_EVENT+0x1fe0000,0,1)
local e1=Effect.CreateEffect(e:GetHandler())
e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
e1:SetCode(EVENT_PHASE+PHASE_END)
e1:SetCountLimit(1)
e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
e1:SetLabelObject(tc)
e1:SetCondition(c33559969.descon)
e1:SetOperation(c33559969.desop)
Duel.RegisterEffect(e1,tp)
end
end
function c33559969.descon(e,tp,eg,ep,ev,re,r,rp)
local tc=e:GetLabelObject()
if tc:GetFlagEffect(33559969)~=0 then
return true
else
e:Reset()
return false
end
end
function c33559969.desop(e,tp,eg,ep,ev,re,r,rp)
local tc=e:GetLabelObject()
Duel.Destroy(tc,REASON_EFFECT)
end
function c33559969.spcost2(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.CheckReleaseGroup(tp,nil,1,e:GetHandler()) end
local g=Duel.SelectReleaseGroup(tp,nil,1,1,e:GetHandler())
g:AddCard(e:GetHandler())
Duel.Release(g,REASON_COST)
end
function c33559969.filter2(c,e,tp)
return (c:GetLevel()==7 or c:GetLevel()==8) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c33559969.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
and Duel.IsExistingMatchingCard(c33559969.filter2,tp,LOCATION_DECK,0,1,nil,e,tp) end
Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c33559969.spop2(e,tp,eg,ep,ev,re,r,rp)
if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
local g=Duel.SelectMatchingCard(tp,c33559969.filter2,tp,LOCATION_DECK,0,1,1,nil,e,tp)
local tc=g:GetFirst()
Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
end