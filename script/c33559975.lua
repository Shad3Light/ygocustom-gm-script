--Clear World Larva
function c33559975.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCost(c33559975.cost)
	e1:SetTarget(c33559975.target)
	e1:SetOperation(c33559975.activate)
	c:RegisterEffect(e1)
	if not c33559975.global_check then
		c33559975.global_check=true
		--atk limit
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD)
		ge1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
		ge1:SetTargetRange(0,LOCATION_MZONE)
		ge1:SetCondition(c33559975.atcon)
		ge1:SetValue(c33559975.atlimit)
		ge1:SetLabel(0)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD)
		ge2:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
		ge2:SetTargetRange(0,LOCATION_MZONE)
		ge2:SetCondition(c33559975.atcon)
		ge2:SetValue(c33559975.atlimit)
		ge2:SetLabel(1)
		Duel.RegisterEffect(ge2,1)
	end
end
function c33559975.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c33559975.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>2 
		and Duel.IsPlayerCanSpecialSummonMonster(tp,22222214,0,0x4011,0,0,1,RACE_REPTILE,ATTRIBUTE_DEVINE) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,3,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,3,0,0)
end
function c33559975.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=2 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,22222214,0,0x4011,0,0,1,RACE_REPTILE,ATTRIBUTE_DEVINE) then return end
	for i=1,3 do
		local token=Duel.CreateToken(tp,22222214)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		token:RegisterEffect(e1,true)
	end
	Duel.SpecialSummonComplete()
end
function c33559975.atcon(e)
	return Duel.IsExistingMatchingCard(Card.IsCode,e:GetLabel(),LOCATION_ONFIELD,0,1,nil,22222214)
end
function c33559975.atlimit(e,c)
	return c:GetCode()~=22222214
end
