--Legacy of Joan
function c335599122.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION+EFFECT_SPSUMMON_PROC)
	e1:SetCountLimit(1,335599122)
	e1:SetTarget(c335599122.sptg)
	e1:SetOperation(c335599122.spop)
	e1:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e1)
end
function c335599122.filter(c,e,tp)
	return c:IsRace(RACE_FAIRY) and (c:GetLevel()==7 and c:IsCanBeSpecialSummoned(e,0,tp,true,false))
end
function c335599122.jnfilter(c)
	return c:IsFaceup() and c:IsCode(21175632)
end
function c335599122.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c335599122.jnfilter,tp,LOCATION_ONFIELD,0,1,nil) 
end
function c335599122.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_EXTRA) and chkc:IsControler(tp) and c335599122.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c335599122.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c335599122.filter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c335599122.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)
	end
	Duel.SpecialSummonComplete()
end