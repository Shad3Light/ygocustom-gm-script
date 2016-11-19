--Sacred Stone of Ojhat (GM)
function c33559938.initial_effect(c)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(33559938,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE+LOCATION_REMOVED)
	e1:SetCondition(c33559938.spcon)
	c:RegisterEffect(e1)
	--opponent cannot draw
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SKIP_DP)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(0,1)
	e2:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e2)
end
function c33559938.spfilter(c,code)
	return c:IsCode(code) and c:IsFaceup()
end
function c33559938.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c33559938.spfilter,tp,LOCATION_MZONE,0,1,nil,511000164)
		and Duel.IsExistingMatchingCard(c33559938.spfilter,tp,LOCATION_MZONE,0,1,nil,511000165)
end
