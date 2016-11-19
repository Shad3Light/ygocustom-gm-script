--Ceremonialist Priest
function c33559968.initial_effect(c)
--search
local e1=Effect.CreateEffect(c)
e1:SetDescription(aux.Stringid(33559968,0))
e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
e1:SetRange(LOCATION_MZONE)
e1:SetCode(EVENT_SUMMON_SUCCESS)
e1:SetCountLimit(1,33559968)
e1:SetTarget(c33559968.target)
e1:SetOperation(c33559968.operation)
c:RegisterEffect(e1)
end
function c33559968.filter(c)
return c:GetLevel()==10 and c:IsAbleToHand()
end
function c33559968.target(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.IsExistingMatchingCard(c33559968.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) end
Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,tp,1)
end
function c33559968.operation(e,tp,eg,ep,ev,re,r,rp)
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
local g=Duel.SelectMatchingCard(tp,c33559968.filter,tp,LOCATION_DECK,0,1,1,nil)
if g:GetCount()>0 then
Duel.SendtoHand(g,nil,REASON_EFFECT)
Duel.ConfirmCards(1-tp,g)
Duel.DiscardHand(tp,nil,1,1,REASON_EFFECT+REASON_DISCARD)
end
end