--Zombie's Jewel
function c33559914.initial_effect(c)
--get card
local e1=Effect.CreateEffect(c)
e1:SetDescription(aux.Stringid(33559914,0))
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetTarget(c33559914.target)
e1:SetOperation(c33559914.operation)
c:RegisterEffect(e1)
end
function c33559914.filter(c)
return c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end
function c33559914.target(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.IsPlayerCanDraw(1-tp,1) and 
Duel.IsExistingMatchingCard(c33559914.filter,tp,0,LOCATION_GRAVE,1,nil)end
Duel.SetTargetPlayer(1-tp)
Duel.SetTargetParam(1)
Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,1-tp,1)
end
function c33559914.operation(e,tp,eg,ep,ev,re,r,rp)
local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
local g=Duel.SelectMatchingCard(tp,c33559914.filter,tp,0,LOCATION_GRAVE,1,1,nil)
if g:GetCount()>0 then
Duel.SendtoHand(g,tp,REASON_EFFECT)
end
Duel.Draw(p,d,REASON_EFFECT)
end