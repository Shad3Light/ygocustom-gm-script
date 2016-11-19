--Rain Force - Indictment
function c77700008.initial_effect(c)
	--send to extra
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(77700008,0))
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c77700008.sumtg)
	e1:SetOperation(c77700008.sumop)
	c:RegisterEffect(e1)
	--place in pzone
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(77700008,1))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,77700008)
	e2:SetCost(c77700008.cost)
	e2:SetTarget(c77700008.settg)
	e2:SetOperation(c77700008.setop)
	c:RegisterEffect(e2)
end
--Effect 1
function c77700008.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c77700008.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,tp,LOCATION_DECK)
end
function c77700008.sumop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c77700008.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 and g:GetFirst():IsAbleToExtra() then
		Duel.SendtoExtraP(g,tp,REASON_EFFECT)
	end
end
function c77700008.filter(c)
	return c:IsSetCard(0x777) and c:IsType(TYPE_PENDULUM)
end
--Effect 2
function c77700008.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c77700008.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c77700008.cfilter,tp,LOCATION_EXTRA,0,1,nil) and not (Duel.GetMatchingGroup(c77700008.pendfil,tp,LOCATION_SZONE,0,nil):GetCount()>1) end
end
function c77700008.setop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectMatchingCard(tp,c77700008.cfilter,tp,LOCATION_EXTRA,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.MoveToField(g:GetFirst(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	end
end
function c77700008.cfilter(c)
	return c:IsType(TYPE_PENDULUM) and c:IsPosition(POS_FACEUP) and c:IsRace(RACE_WARRIOR)
end
function c77700008.pendfil(c)
	return c:IsType(TYPE_PENDULUM) and c:GetSequence()>5
end
