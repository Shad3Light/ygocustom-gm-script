--The Selection (Anime)
function c33559930.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SUMMON)
	e1:SetCondition(c33559930.condition)
	e1:SetCost(c33559930.cost)
	e1:SetTarget(c33559930.target)
	e1:SetOperation(c33559930.activate)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_SPSUMMON)
	c:RegisterEffect(e3)
end
function c33559930.cfilter(c,rc)
	return c:IsFaceup() and c:IsRace(rc)
end
function c33559930.filter(c)
	return Duel.IsExistingMatchingCard(c33559930.cfilter,0,LOCATION_MZONE,LOCATION_MZONE,1,nil,c:GetRace())
end
function c33559930.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentChain()==0 and eg:IsExists(c33559930.filter,1,nil)
end
function c33559930.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,0) end
	Duel.PayLPCost(tp,0)
end
function c33559930.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=eg:Filter(c33559930.filter,nil)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c33559930.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c33559930.filter,nil)
	Duel.NegateSummon(g)
	Duel.Destroy(g,REASON_EFFECT)
end
