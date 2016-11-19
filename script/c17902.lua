--Dragon-Z Galaxy Fire Hole 
function c17902.initial_effect(c)
	--negate activate
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(17902,1))
	e3:SetCategory(CATEGORY_NEGATE+CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_ACTIVATE)
	e3:SetCode(EVENT_CHAINING)
	e3:SetCondition(c17902.condition)
	e3:SetTarget(c17902.target)
	e3:SetOperation(c17902.operation)
	c:RegisterEffect(e3)
end
function c17902.efilter(c,e,tp,eg,ep,ev,re,r,rp,chk)
	return c:IsSetCard(0x91) and c:IsFaceup() 
end
function c17902.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c17902.efilter,tp,LOCATION_MZONE,0,1,nil)
end
function c17902.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c17902.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,POS_FACEUP,REASON_EFFECT)
	end
end