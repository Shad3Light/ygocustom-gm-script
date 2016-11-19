--Night Clock Sound Wave
function c1018.initial_effect(c)
	--Negate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c1018.condition)
	e1:SetTarget(c1018.target)
	e1:SetOperation(c1018.operation)
	c:RegisterEffect(e1)
	--Negate
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_NEGATE+CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCondition(c1018.condition2)
	e2:SetCost(c1018.cost)
	e2:SetTarget(c1018.target2)
	e2:SetOperation(c1018.operation2)
	c:RegisterEffect(e2)
end
function c1018.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x3)
end
function c1018.condition(e,tp,eg,ep,ev,re,r,rp)
	return rp~=tp and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev)
		and Duel.IsExistingMatchingCard(c1018.filter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c1018.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsRelateToEffect(re) and re:GetHandler():IsDestructable() then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,re:GetHandler(),1,0,0)
	end
end
function c1018.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(re:GetHandler(),REASON_EFFECT)
	end
end
function c1018.filter2(c,tp)
	return c:IsSetCard(0x3) and c:IsType(TYPE_MONSTER)
end
function c1018.condition2(e,tp,eg,ep,ev,re,r,rp)
	return rp~=tp and re:GetActivateLocation()==LOCATION_GRAVE and Duel.IsChainNegatable(ev)
		and Duel.IsExistingMatchingCard(c1018.filter2,tp,LOCATION_GRAVE,0,1,nil)
end
function c1018.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c1018.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_TODECK,eg,1,0,0)
	end
end
function c1018.operation2(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		re:GetHandler():CancelToGrave()
		Duel.SendtoDeck(re:GetHandler(),nil,2,REASON_EFFECT)
	end
end