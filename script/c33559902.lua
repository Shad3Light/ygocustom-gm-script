--Emerald's Dark Crystal Wedge
function c33559902.initial_effect(c)
	c:SetUniqueOnField(1,0,33559902)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_ONFIELD,LOCATION_ONFIELD)
	e2:SetTarget(c33559902.infilter)
	c:RegisterEffect(e2)
end
function c33559902.infilter(e,c)
	return bit.band(c:GetType(),0x1000000)==0x1000000 and c:GetCode()~=33559902
end