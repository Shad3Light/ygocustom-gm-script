--Guardian Force Diablos
function c335599132.initial_effect(c)
	--turn set
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(335599132,0))
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c335599132.target)
	e1:SetOperation(c335599132.operation)
	c:RegisterEffect(e1)
	-- Cannot Disable effect
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_CANNOT_DISABLE)
	e2:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e2)
end

function c335599132.filter(c)
	return c:IsFaceup() and c:IsCanTurnSet() and (c:IsType(TYPE_MONSTER) and not c:IsType(TYPE_FLIP)) 
end
function c335599132.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c335599132.filter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c335599132.filter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end
function c335599132.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c335599132.filter,tp,0,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		Duel.ChangePosition(g,POS_FACEDOWN_DEFENSE)
	end
end