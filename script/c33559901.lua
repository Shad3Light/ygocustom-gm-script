--Spell Force Field
function c33559901.initial_effect(c)
	c:SetUniqueOnField(1,0,33559901)
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
	e2:SetTarget(c33559901.infilter)
	c:RegisterEffect(e2)
end
function c33559901.infilter(e,c)
	return bit.band(c:GetType(),0x20002)==0x20002 and c:GetCode()~=33559901
end