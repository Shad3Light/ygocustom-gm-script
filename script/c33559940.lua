--Rescuer from the Grave (GM)
function c33559940.initial_effect(c)
--disable attack
local e1=Effect.CreateEffect(c)
e1:SetDescription(aux.Stringid(91990040,0))
e1:SetType(EFFECT_TYPE_QUICK_O)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetHintTiming(TIMING_BATTLE_PHASE)
e1:SetRange(LOCATION_GRAVE)
e1:SetCondition(c33559940.condition)
e1:SetCost(c33559940.cost)
e1:SetOperation(c33559940.operation)
c:RegisterEffect(e1)
-- Cannot Disable effect
local e2=Effect.CreateEffect(c)
e2:SetType(EFFECT_TYPE_SINGLE)
e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e2:SetCode(EFFECT_CANNOT_DISABLE)
e2:SetRange(LOCATION_GRAVE)
c:RegisterEffect(e2)
end
function c33559940.condition(e,tp,eg,ep,ev,re,r,rp)
return Duel.GetAttacker()~=nil and tp~=Duel.GetTurnPlayer()
end
function c33559940.filter1(c)
return c:IsAbleToRemoveAsCost()
end
function c33559940.cost(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.IsExistingMatchingCard(c33559940.filter1,tp,LOCATION_GRAVE,0,5,nil) end
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
local g=Duel.SelectMatchingCard(tp,c33559940.filter1,tp,LOCATION_GRAVE,0,5,5,nil)
Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c33559940.operation(e,tp,eg,ep,ev,re,r,rp)
Duel.NegateAttack()
Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
end