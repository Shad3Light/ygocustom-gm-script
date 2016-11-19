--Immortal Cataclysm
function c33559967.initial_effect(c)
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
e1:SetCode(EVENT_TO_GRAVE)
e1:SetCountLimit(1,33559967+EFFECT_COUNT_CODE_DUEL)
e1:SetCondition(c33559967.condition)
e1:SetCost(c33559967.cost)
e1:SetTarget(c33559967.target)
e1:SetOperation(c33559967.operation)
c:RegisterEffect(e1)
end
function c33559967.spfilter(c,tp)
return c:GetPreviousControler()==tp and c:IsReason(REASON_DESTROY) and c:IsPreviousLocation(LOCATION_MZONE)
end
function c33559967.condition(e,tp,eg,ep,ev,re,r,rp)
return eg:IsExists(c33559967.spfilter,1,nil,tp) and eg:GetCount()==1
end
function c33559967.cost(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then
local tc=eg:GetFirst()
return tc:IsAbleToRemove()
end
Duel.Remove(eg,POS_FACEUP,REASON_COST)
end
function c33559967.target(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.IsExistingMatchingCard(Card.IsReleasable,tp,LOCATION_MZONE,LOCATION_MZONE,3,nil) end
local g=Duel.GetMatchingGroup(Card.IsReleasable,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
Duel.SetOperationInfo(0,CATEGORY_RELASE,nil,g:GetCount(),tp,LOCATION_MZONE)
end
function c33559967.operation(e,tp,eg,ep,ev,re,r,rp)
local g=Duel.GetMatchingGroup(Card.IsReleasable,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
if Duel.Release(g,REASON_EFFECT)~=0 and Duel.IsExistingMatchingCard(Card.IsAbleToHand,tp,LOCATION_DECK,0,1,nil) 
and Duel.IsExistingMatchingCard(Card.IsAbleToHand,1-tp,LOCATION_DECK,0,1,nil) then
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
local g1=Duel.SelectMatchingCard(tp,Card.IsAbleToHand,tp,LOCATION_DECK,0,1,1,nil)
local g2=Duel.SelectMatchingCard(1-tp,Card.IsAbleToHand,1-tp,LOCATION_DECK,0,1,1,nil)
if g1:GetCount()>0 and g2:GetCount()>0 then
g1:Merge(g2)
Duel.SendtoHand(g1,nil,REASON_EFFECT)
Duel.ConfirmCards(1-tp,g1)
end
end
end