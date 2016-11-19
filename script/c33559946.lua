--Toon Yako, Wako, & Dot!
function c33559946.initial_effect(c)
	c:EnableReviveLimit()	
	--special summon rule
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c33559946.spcon)
	c:RegisterEffect(e1)
	--atk def
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetTarget(c33559946.tg)
	e2:SetValue(1000)
	c:RegisterEffect(e2)
end
function c33559946.cfilter(c)
	return c:IsFaceup() and c:IsCode(15259703)
end
function c33559946.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c33559946.cfilter,tp,LOCATION_ONFIELD,0,1,nil) 
end
function c33559946.tg(e,c)
	return c:IsType(TYPE_TOON)
end
