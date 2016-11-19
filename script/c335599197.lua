--ShapeSnatch 1 Card Trick
--scripted by GameMaster (GM)
function c335599197.initial_effect(c)	
--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCost(c335599197.cost)
	e1:SetTarget(c335599197.target)
	e1:SetOperation(c335599197.activate)
	c:RegisterEffect(e1)
end

function c335599197.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end

function c335599197.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,335599175,0,0x4011,0,0,1,RACE_REPTILE,ATTRIBUTE_DEVINE) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c335599197.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=1 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,335599175,0,0x4011,0,0,1,RACE_REPTILE,ATTRIBUTE_DEVINE) then return end
	for i=1,1 do
		local token=Duel.CreateToken(tp,335599175)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
		end
	Duel.SpecialSummonComplete()
end