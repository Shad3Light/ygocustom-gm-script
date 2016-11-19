--Heratic Prophecy
function c33559972.initial_effect(c)
local e1=Effect.CreateEffect(c)
e1:SetCategory(CATEGORY_DRAW)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetCost(c33559972.cost)
e1:SetTarget(c33559972.target)
e1:SetOperation(c33559972.activate)
c:RegisterEffect(e1)
end
function c33559972.cost(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.IsExistingMatchingCard(Card.IsRace,tp,LOCATION_HAND,0,1,nil,RACE_DEVINE) end
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
local g=Duel.SelectMatchingCard(tp,Card.IsRace,tp,LOCATION_HAND,0,1,1,nil,RACE_DEVINE)
Duel.ConfirmCards(1-tp,g)
Duel.ShuffleHand(tp)
end
function c33559972.filter(c,e,tp)
return c:IsLevelBelow(4) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c33559972.filter2(c,e,tp,rc,lv,att)
return (c:GetLevel()==lv or c:IsRace(rc) or c:IsAttribute(att)) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c33559972.target(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
and Duel.IsExistingMatchingCard(c33559972.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c33559972.activate(e,tp,eg,ep,ev,re,r,rp)
if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
local g=Duel.SelectMatchingCard(tp,c33559972.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
local tc=g:GetFirst()
if g:GetCount()>0 then
if Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP) and
Duel.IsExistingMatchingCard(c33559972.filter2,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp,tc:GetRace(),tc:GetLevel(),tc:GetAttribute())then
g2=Duel.SelectMatchingCard(tp,c33559972.filter2,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,2,nil,e,tp,tc:GetRace(),tc:GetLevel(),tc:GetAttribute())
local c=e:GetHandler()
local tc=g2:GetFirst()
while tc do
if Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)then
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_CANNOT_ATTACK)
e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
e1:SetReset(RESET_EVENT+0x1fe0000)
tc:RegisterEffect(e1)
local e2=Effect.CreateEffect(c)
e2:SetType(EFFECT_TYPE_SINGLE)
e2:SetCode(EFFECT_DISABLE)
e2:SetReset(RESET_EVENT+0x1fe0000)
tc:RegisterEffect(e2)
local e3=Effect.CreateEffect(c)
e3:SetType(EFFECT_TYPE_SINGLE)
e3:SetCode(EFFECT_DISABLE_EFFECT)
e3:SetReset(RESET_EVENT+0x1fe0000)
tc:RegisterEffect(e3)
end
tc=g2:GetNext()
end	
Duel.SpecialSummonComplete()
end
end
end