--Cute Guard
function c45879789.initial_effect(c)
	--Named
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_ADD_CODE)
	e1:SetRange(LOCATION_MZONE+LOCATION_GRAVE)
	e1:SetValue(92216322)
	c:RegisterEffect(e1)
	--Indestructible
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCountLimit(1)
	e2:SetTarget(c45879789.val)
	e2:SetValue(aux.TRUE)
	c:RegisterEffect(e2)
end
function c45879789.val(e,c)
	return c:IsCode(92216322)
end