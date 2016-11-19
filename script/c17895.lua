--Dragon-Z Altair Star Gatherer
function c17895.initial_effect(c)
	--summon success
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(17895,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetTarget(c17895.sumtr)
	e1:SetOperation(c17895.sumop)
	c:RegisterEffect(e1)
	--Add
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(17895,0))
	e2:SetCategory(CATEGORY_TODECK+CATEGORY_HANDES)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY+EFFECT_FLAG_CHAIN_UNIQUE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c17895.acost)
	e2:SetCondition(c17895.acon)
	e2:SetTarget(c17895.atg)
	e2:SetOperation(c17895.aop)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(17895,0))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY+EFFECT_FLAG_CHAIN_UNIQUE)
	e3:SetCondition(c17895.spcon)
	e3:SetTarget(c17895.sptg)
	e3:SetOperation(c17895.spop)
	c:RegisterEffect(e3)
end
function c17895.filter1(c,e,tp)
	return c:GetLevel()==4 and c:IsSetCard(0x91) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c17895.sumtr(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,17895)==0 
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>=3
		and Duel.IsExistingMatchingCard(c17895.filter1,tp,LOCATION_GRAVE,0,3,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,3,tp,LOCATION_GRAVE)
	Duel.RegisterFlagEffect(tp,17895,RESET_PHASE+PHASE_END,0,1)
end
function c17895.sumop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c17895.filter1,tp,LOCATION_GRAVE,0,3,3,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c17895.afilter(c,e,tp)
	return c:IsSetCard(0x91) and c:IsAbleToDeck()
end
function c17895.acost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,17895)==0
		and Duel.IsExistingMatchingCard(c17895.afilter,tp,LOCATION_HAND,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c17895.afilter,tp,LOCATION_HAND,0,2,2,nil)
	Duel.ConfirmCards(1-tp,g)
	Duel.SendtoDeck(g,nil,2,REASON_COST)
	Duel.RegisterFlagEffect(tp,17895,RESET_PHASE+PHASE_END,0,1)
end
function c17895.thfilter(c)
	return c:IsSetCard(0x91) and c:IsAbleToHand()
end
function c17895.atg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c17895.thfilter,tp,LOCATION_DECK,0,2,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,2,tp,LOCATION_DECK)
end
function c17895.aop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c17895.thfilter,tp,LOCATION_DECK,0,2,2,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c17895.acon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c17895.thfilter,tp,LOCATION_DECK,0,2,nil)
end
function c17895.spcon(e,tp,eg,ep,ev,re,r,rp)
	if not re then return false end
	local rc=re:GetHandler()
	return rc:IsSetCard(0x91)
end
function c17895.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,17895)==0
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingMatchingCard(c17895.filter1,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
	Duel.RegisterFlagEffect(tp,17895,RESET_PHASE+PHASE_END,0,1)
end
function c17895.spop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c17895.filter1,tp,LOCATION_GRAVE,0,ft,ft,nil,e,tp)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
		while tc do
			Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
			tc:RegisterFlagEffect(17895,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
			tc=g:GetNext()
		end
		Duel.SpecialSummonComplete()
		g:KeepAlive()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetReset(RESET_PHASE+PHASE_END)
		e1:SetCountLimit(1)
		e1:SetLabelObject(g)
		e1:SetOperation(c17895.rmop)
		Duel.RegisterEffect(e1,tp)
	end
end
function c17895.rmfilter(c)
	return c:GetFlagEffect(17895)>0
end
function c17895.rmop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local tg=g:Filter(c17895.rmfilter,nil)
	g:DeleteGroup()
	Duel.Remove(tg,POS_FACEUP,REASON_EFFECT)
end