--MALware Computer Virus
function c33559927.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetTarget(c33559927.target)
	e1:SetOperation(c33559927.activate)
	c:RegisterEffect(e1)
end
function c33559927.afilter(c)
	return c:IsType(TYPE_MONSTER+TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
end
function c33559927.target(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.IsExistingMatchingCard(c33559927.afilter,tp,LOCATION_DECK,LOCATION_DECK,1,nil) end
Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c33559927.activate(e,tp,eg,ep,ev,re,r,rp)
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
local sg=Duel.GetMatchingGroup(c33559927.afilter,tp,LOCATION_DECK,LOCATION_DECK,nil)
Duel.ConfirmCards(tp,sg)
local g=sg:Select(tp,1,1,nil)
if g:GetCount()>0 then
Duel.SendtoHand(g,tp,nil,REASON_EFFECT)
Duel.ConfirmCards(1-tp,g)
end
end