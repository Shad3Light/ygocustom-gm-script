--Black Dragon Roost
--57335212
function c57335212.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,57335212+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c57335212.cost)
	e1:SetTarget(c57335212.target)
	e1:SetOperation(c57335212.activate)
	c:RegisterEffect(e1)
	Duel.AddCustomActivityCounter(57335212,ACTIVITY_SPSUMMON,c57335212.counterfilter)
end
function c57335212.counterfilter(c)
	return c:IsSetCard(0x3B)
end
function c57335212.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCustomActivityCount(57335212,tp,ACTIVITY_SPSUMMON)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	e1:SetLabelObject(e)
	e1:SetTarget(c57335212.splimit)
	Duel.RegisterEffect(e1,tp)
end
function c57335212.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsSetCard(0x3B)
end
function c57335212.filter1(c,e,tp)
	return c:IsFaceup() and c:IsSetCard(0x3B)
		and Duel.IsExistingMatchingCard(c57335212.filter2,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp,c:GetCode())
end
function c57335212.filter2(c,e,tp,code)
	return c:IsCode(code) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c57335212.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsCode(e:GetLabel()) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c57335212.filter1,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c57335212.filter1,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	e:SetLabel(g:GetFirst():GetCode())
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,LOCATION_DECK+LOCATION_HAND)
end
function c57335212.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local code=tc:GetCode()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c57335212.filter2,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,e,tp,code)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
		end
	end
end
