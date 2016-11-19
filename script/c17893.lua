function c17893.initial_effect(c)
	--summon success
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(17893,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetRange(LOCATION_DECK)
	e1:SetTarget(c17893.sumtr)
	e1:SetOperation(c17893.sumop)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(17893,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c17893.spcost)
	e2:SetTarget(c17893.sptg)
	e2:SetOperation(c17893.spop)
	c:RegisterEffect(e2)
	--ss success
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(17893,4))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY+EFFECT_FLAG_CHAIN_UNIQUE)
	e3:SetCondition(c17893.condition)
	e3:SetTarget(c17893.target)
	e3:SetOperation(c17893.operation)
	c:RegisterEffect(e3)
end
function c17893.filter(c,e,tp)
	return c:GetLevel()==4 and c:IsSetCard(0x91) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c17893.sumtr(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,17893)==0 
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c17893.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
	Duel.RegisterFlagEffect(tp,17893,RESET_PHASE+PHASE_END,0,1)
end
function c17893.sumop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c17893.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c17893.cfilter(c,e,tp)
	return c:IsAbleToDeck()
end
function c17893.sfilter(c,e,tp)
	return c:GetLevel()==4 and c:IsSetCard(0x91) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c17893.efilter(c,e,tp)
	return c:IsSetCard(0x91)
end
function c17893.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,17893)==0
		and Duel.IsExistingMatchingCard(c17893.cfilter,tp,LOCATION_HAND,0,3,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c17893.cfilter,tp,LOCATION_HAND,0,3,3,nil)
	Duel.ConfirmCards(1-tp,g)
	Duel.SendtoDeck(g,nil,3,REASON_COST)
	Duel.RegisterFlagEffect(tp,17893,RESET_PHASE+PHASE_END,0,1)
end
function c17893.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingMatchingCard(c17893.sfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c17893.spop(e,tp,eg,ep,ev,re,r,rp)
	local ft1=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft1<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c17893.sfilter,tp,LOCATION_DECK,0,ft1,ft1,nil,e,tp)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
		while tc do
			Duel.SpecialSummonStep(tc, 0, tp, tp, false, false, POS_FACEUP)
			tc=g:GetNext()
		end
		Duel.SpecialSummonComplete()
	end
end
function c17893.dfilter(c)
	return c:IsDestructable()
	end
function c17893.condition(e,tp,eg,ep,ev,re,r,rp)
	if not re then return false end
	local rc=re:GetHandler()
	return rc:IsSetCard(0x91)
end
function c17893.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,17893)==0
		and Duel.IsExistingTarget(c17893.dfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	if chkc then return chkc:IsOnField() and c17893.dfilter(chkc) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c17893.dfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,2,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.RegisterFlagEffect(tp,17893,RESET_PHASE+PHASE_END,0,1)
end
function c17893.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	Duel.Destroy(sg,REASON_EFFECT)
end