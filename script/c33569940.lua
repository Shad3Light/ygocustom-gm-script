--MetalMorph (DOR)
--scripted by GameMaster (GM)
function c33569940.initial_effect(c)
	--Activate red eyes
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c33569940.cost1)
	e1:SetTarget(c33569940.target1)
	e1:SetOperation(c33569940.activate1)
	c:RegisterEffect(e1)
	--Activate zoa
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCost(c33569940.cost2)
	e2:SetTarget(c33569940.target2)
	e2:SetOperation(c33569940.activate2)
	c:RegisterEffect(e2)
end

function c33569940.filter1(c)
    return c:IsFaceup() and c:IsCode(74677422)
end

function c33569940.filter2(c)
    return c:IsFaceup() and c:IsCode(24311372)
end


function c33569940.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c33569940.filter1,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,c33569940.filter1,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c33569940.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,64335804,0,0x4011,500,1200,4,RACE_INSECT,ATTRIBUTE_EARTH) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
end
function c33569940.activate1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and Duel.IsPlayerCanSpecialSummonMonster(tp,64335804,0,0x4011,500,1200,4,RACE_INSECT,ATTRIBUTE_EARTH) then
		for i=1,1 do
			local token=Duel.CreateToken(tp,64335804)
			Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
			end
		Duel.SpecialSummonComplete()
	end
end

function c33569940.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c33569940.filter2,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,c33569940.filter2,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c33569940.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,50705071,0,0x4011,500,1200,4,RACE_INSECT,ATTRIBUTE_EARTH) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
end
function c33569940.activate2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and Duel.IsPlayerCanSpecialSummonMonster(tp,50705071,0,0x4011,500,1200,4,RACE_INSECT,ATTRIBUTE_EARTH) then
		for i=1,1 do
			local token=Duel.CreateToken(tp,50705071)
			Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
			end
		Duel.SpecialSummonComplete()
	end
end
