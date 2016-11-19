function c17894.initial_effect(c)
	--summon success
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(17894,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetRange(LOCATION_REMOVED)
	e1:SetTarget(c17894.sumtr)
	e1:SetOperation(c17894.sumop)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(17894,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c17894.spcost)
	e2:SetTarget(c17894.sptg)
	e2:SetOperation(c17894.spop)
	c:RegisterEffect(e2)
	--ss success
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(17894,4))
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCondition(c17894.rtcon)
	e3:SetCost(c17894.rtcost)
	e3:SetTarget(c17894.rttg)
	e3:SetOperation(c17894.rtop)
	c:RegisterEffect(e3)
end
function c17894.filter(c,e,tp)
	return c:GetLevel()==4 and c:IsSetCard(0x91) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c17894.sumtr(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,17894)==0 
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>=2
		and Duel.IsExistingMatchingCard(c17894.filter,tp,LOCATION_REMOVED,0,2,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_REMOVED)
	Duel.RegisterFlagEffect(tp,17894,RESET_PHASE+PHASE_END,0,1)
end
function c17894.sumop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c17894.filter,tp,LOCATION_REMOVED,0,2,2,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c17894.cfilter(c,e,tp)
	return c:IsAbleToDeck()
end
function c17894.dfilter(c)
	return c:IsDiscardable() and c:IsAbleToGraveAsCost()
end
function c17894.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,17894)==0
		and Duel.IsExistingMatchingCard(c17894.cfilter,tp,LOCATION_GRAVE,0,1,nil)
		and Duel.IsExistingMatchingCard(c17894.dfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c17894.cfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.ConfirmCards(1-tp,g)
	Duel.SendtoDeck(g,nil,2,REASON_COST)
	Duel.DiscardHand(tp,c17894.cfilter,1,1,REASON_COST+REASON_DISCARD,e:GetHandler())
	Duel.RegisterFlagEffect(tp,17894,RESET_PHASE+PHASE_END,0,1)
end
function c17894.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,17894)==0 
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>=3
		and Duel.IsExistingMatchingCard(c17894.filter,tp,LOCATION_REMOVED,0,3,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,3,tp,LOCATION_REMOVED)
	Duel.RegisterFlagEffect(tp,17894,RESET_PHASE+PHASE_END,0,1)
end
function c17894.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c17894.filter,tp,LOCATION_REMOVED,0,3,3,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c17894.dfilter(c)
	return c:IsAbleToRemoveAsCost()
end
function c17894.efilter(c)
	return c:IsAbleToHand()
end
function c17894.rtcon(e,tp,eg,ep,ev,re,r,rp)
	if not re then return false end
	local rc=re:GetHandler()
	return rc:IsSetCard(0x91)
end
function c17894.rtcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,17894)==0 
		and Duel.IsExistingMatchingCard(c17894.dfilter,tp,LOCATION_GRAVE,0,1,nil) end
	local g=Duel.GetMatchingGroup(c17894.dfilter,tp,LOCATION_GRAVE,0,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	Duel.RegisterFlagEffect(tp,17894,RESET_PHASE+PHASE_END,0,1)
end
function c17894.rttg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c17894.efilter,tp,0,LOCATION_ONFIELD,1,nil) end
	local sg=Duel.GetMatchingGroup(c17894.efilter,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,sg,sg:GetCount(),0,0)
end
function c17894.rtop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c17894.efilter,tp,0,LOCATION_ONFIELD,nil)
	Duel.SendtoHand(sg,nil,REASON_EFFECT)
end