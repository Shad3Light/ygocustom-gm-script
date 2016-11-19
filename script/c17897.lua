--Dragon-Z Altair Star Duster
function c17897.initial_effect(c)
	--summon success
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(17897,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetRange(LOCATION_DECK)
	e1:SetTarget(c17897.sumtr)
	e1:SetOperation(c17897.sumop)
	c:RegisterEffect(e1)
	--Immune
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(17897,0))
	e2:SetCategory(CATEGORY_IMMUNE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_HAND)
	e2:SetCost(c17897.acost)
	e2:SetTarget(c17897.acon)
	e2:SetOperation(c17897.aop)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(17897,0))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY+EFFECT_FLAG_CHAIN_UNIQUE)
	e3:SetCondition(c17897.spcon)
	e3:SetTarget(c17897.sptg)
	e3:SetOperation(c17897.spop)
	c:RegisterEffect(e3)
end
function c17897.filter1(c,e,tp)
	return c:GetLevel()==4 and c:IsSetCard(0x91) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c17897.sumtr(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,17897)==0 
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>=3
		and Duel.IsExistingMatchingCard(c17897.filter1,tp,LOCATION_REMOVED,0,3,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,3,tp,LOCATION_REMOVED)
	Duel.RegisterFlagEffect(tp,17897,RESET_PHASE+PHASE_END,0,1)
end
function c17897.sumop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c17897.filter1,tp,LOCATION_REMOVED,0,3,3,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c17897.costfilter(c)
	return c:IsSetCard(0x91) and c:IsDiscardable()
end
function c17897.acost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetFlagEffect(tp,17897)==0 and c:IsDiscardable()
		and Duel.IsExistingMatchingCard(c17897.costfilter,tp,LOCATION_HAND,0,1,c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local g=Duel.SelectMatchingCard(tp,c17897.costfilter,tp,LOCATION_HAND,0,1,1,c)
	g:AddCard(c)
	Duel.SendtoGrave(g,REASON_COST+REASON_DISCARD)
	Duel.RegisterFlagEffect(tp,17897,RESET_PHASE+PHASE_END,0,1)
end
function c17897.aop(e,tp,eg,ep,ev,re,r,rp)
	if chk==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_UNAFFECTED)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetTargetRange(LOCATION_ONFIELD,LOCATION_HAND,LOCATION_DECK,LOCATION_GRAVE)
	e1:SetTarget(c17897.cfilter)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetValue(c17897.nfilter)
	Duel.RegisterEffect(e1,tp)
end
function c17897.acon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_ONFIELD+LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,nil,0x91)
end
function c17897.nfilter(e,re)
	return e:GetHandlerPlayer()~=re:GetHandlerPlayer() and re:IsActiveType(TYPE_SPELL+TYPE_TRAP+TYPE_MONSTER)
end
function c17897.cfilter(e,c)
	return c:IsSetCard(0x91)
end
function c17897.spcon(e,tp,eg,ep,ev,re,r,rp)
	if not re then return false end
	local rc=re:GetHandler()
	return rc:IsSetCard(0x91)
end
function c17897.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,17896)==0
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingMatchingCard(c17897.filter1,tp,LOCATION_REMOVED,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_REMOVED)
	Duel.RegisterFlagEffect(tp,17897,RESET_PHASE+PHASE_END,0,1)
end
function c17897.spop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c17897.filter1,tp,LOCATION_REMOVED,0,ft,ft,nil,e,tp)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
		while tc do
			Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
			tc:RegisterFlagEffect(17897,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
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
		e1:SetOperation(c17897.rmop)
		Duel.RegisterEffect(e1,tp)
	end
end
function c17897.rmfilter(c)
	return c:GetFlagEffect(17897)>0
end
function c17897.rmop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local tg=g:Filter(c17897.rmfilter,nil)
	g:DeleteGroup()
	Duel.Destroy(tg,REASON_EFFECT)
end