--Elegant egotist
function c335599145.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c335599145.condition)
	e1:SetTarget(c335599145.target)
	e1:SetOperation(c335599145.activate)
	c:RegisterEffect(e1)
end
function c335599145.cfilter(c)
	return c:IsFaceup() and c:IsCode(76812113)
end
function c335599145.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c335599145.cfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
end
function c335599145.filter(c,e,tp)
	return c:IsCode(76812113,12206212) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c335599145.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c335599145.filter,tp,LOCATION_HAND+LOCATION_DECK,0,2,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_HAND+LOCATION_DECK)
end
function c335599145.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=2 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=Duel.SelectMatchingCard(tp,c335599145.filter,tp,LOCATION_HAND+LOCATION_DECK,0,2,2,nil,e,tp)
	local tc=sg:Select(tp,2,2,nil)
	if tc and Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)~=0 then
	end
end
