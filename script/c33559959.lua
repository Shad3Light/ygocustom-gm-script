--Toon Medusa
function c33559959.initial_effect(c)
	--pos change
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SET_POSITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c33559959.target)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetValue(POS_FACEUP_DEFENSE)
	c:RegisterEffect(e1)
	--def
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c33559959.deftg)
	e2:SetValue(c33559959.defval)
	c:RegisterEffect(e2)
end
function c33559959.target(e,c)
	return c:IsPosition(POS_FACEUP_ATTACK) and not c:IsType(TYPE_TOON)
		and bit.band(c:GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL
		and bit.band(c:GetSummonLocation(),LOCATION_DECK+LOCATION_EXTRA)~=0
end
function c33559959.deftg(e,c)
	return c:IsFaceup() and not c:IsType(TYPE_TOON)
		and bit.band(c:GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL
		and bit.band(c:GetSummonLocation(),LOCATION_DECK+LOCATION_EXTRA)~=0
end
function c33559959.defval(e,c)
	return -c:GetBaseDefense()
end
