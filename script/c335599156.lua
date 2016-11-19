--Ancient tree of Enlightenment (DOR)
--scripted by GameMaster (GM)
function c335599156.initial_effect(c)
	--cannot trigger
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(1,1)
	e1:SetCondition(c335599156.con)
	e1:SetValue(c335599156.aclimit)
	c:RegisterEffect(e1)
end

function c335599156.aclimit(e,re,tp)
	return re:IsActiveType(TYPE_TRAP)
end


function c335599156.con(e)
	return e:GetHandler():IsDefensePos()
end