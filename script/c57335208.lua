function c57335208.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,57335203,23995346,true,true)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(c57335208.atkval)
	c:RegisterEffect(e2)
end
function c57335208.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_DRAGON)
end
function c57335208.atkval(e,c)
	return Duel.GetMatchingGroupCount(c57335208.filter,c:GetControler(),LOCATION_MZONE,0,c)*500
end
c57335203.material_setcode=0x3b