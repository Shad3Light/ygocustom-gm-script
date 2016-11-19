--Seto,The Dragon Master
--Scripted by GameMaster(GM)
function c75233703.initial_effect(c)
--special summon rule
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c75233703.spcon)
	c:RegisterEffect(e1)
	--cannot be target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c75233703.etarget)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--Increase Blueeyes monsters attack by 1500
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0xDD))
	e3:SetValue(1500)
	c:RegisterEffect(e3)
end
function c75233703.etarget(e,c)
	return c:IsCode(75233702)
end

	
	
function c75233703.cfilter(c)
	return c:IsFaceup() and c:IsCode(75233702)
end
function c75233703.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c75233703.cfilter,tp,LOCATION_ONFIELD,0,1,nil) 
end