--Cocoon of Evolution (DOR)
--scripted by GameMaster (GM)
function c33569927.initial_effect(c)
--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c33569927.cost)
	e1:SetTarget(c33569927.target)
	e1:SetOperation(c33569927.activate)
	c:RegisterEffect(e1)
end

c33569927.collection={ [87756343]=true; [58192742]=true; [81179446]=true; [81843628]=true; [77568553]=true; }


function c33569927.filter(c)
	return c:IsFaceup() and c33569927.collection[c:GetCode()]
end


function c33569927.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c33569927.filter,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,c33569927.filter,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c33569927.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,335599167,0,0x4011,500,1200,4,RACE_INSECT,ATTRIBUTE_EARTH) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c33569927.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and Duel.IsPlayerCanSpecialSummonMonster(tp,335599167,0,0x4011,500,1200,4,RACE_INSECT,ATTRIBUTE_EARTH) then
		for i=1,1 do
			local token=Duel.CreateToken(tp,335599167)
			Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
			end
		Duel.SpecialSummonComplete()
	end
end

