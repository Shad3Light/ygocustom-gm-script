--Seal Of the anicients (DOR)
--scripted by GameMaster (GM)
function c335599192.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetOperation(c335599192.activate)
	e1:SetTarget(c335599192.target)
	e1:SetCondition(c335599192.condition)
	c:RegisterEffect(e1)
	--negate destroy ritual
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_QUICK_F)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c335599192.condition)
	e2:SetTarget(c335599192.target)
	e2:SetOperation(c335599192.activate)
	c:RegisterEffect(e2)
end
function c335599192.condition(e,tp,eg,ep,ev,re,r,rp)
return re:IsActiveType(TYPE_RITUAL) and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev) 
end


function c335599192.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end


function c335599192.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
