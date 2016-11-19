--Sacred Intervention
function c33559973.initial_effect(c)
--Activate
local e1=Effect.CreateEffect(c)
e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCode(EVENT_CHAINING)
e1:SetCondition(c33559973.condition)
e1:SetTarget(c33559973.target)
e1:SetOperation(c33559973.activate)
c:RegisterEffect(e1)
end
function c33559973.cfilter(c)
return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_DEVINE)
end
function c33559973.condition(e,tp,eg,ep,ev,re,r,rp)
return Duel.IsExistingMatchingCard(c33559973.cfilter,tp,LOCATION_MZONE,0,1,nil) and Duel.IsChainNegatable(ev)
end
function c33559973.target(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
end
end
function c33559973.activate(e,tp,eg,ep,ev,re,r,rp)
Duel.NegateActivation(ev)
if re:GetHandler():IsRelateToEffect(re) then
Duel.Destroy(eg,REASON_EFFECT)
end
end