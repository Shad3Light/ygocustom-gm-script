--Dragon-Z Galaxy Warp Returner
function c17903.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c17903.condition)
	e1:SetTarget(c17903.target)
	e1:SetOperation(c17903.activate)
	c:RegisterEffect(e1)
end
function c17903.efilter(c,e,tp,eg,ep,ev,re,r,rp,chk)
	return c:IsSetCard(0x91) and c:IsFaceup() 
end
function c17903.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c17903.efilter,tp,LOCATION_REMOVED,0,1,nil)
		and Duel.IsExistingMatchingCard(c17903.efilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c17903.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and c17903.efilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c17903.efilter,tp,LOCATION_REMOVED,0,1,nil) end
	local g=Duel.GetMatchingGroup(c17903.efilter,tp,LOCATION_REMOVED,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_REMOVED)
end
function c17903.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c17903.efilter,tp,LOCATION_REMOVED,0,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,nil,1,REASON_EFFECT+REASON_RETURN)
	end
end