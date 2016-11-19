function c17891.initial_effect(c)
	--summon success
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(17891,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetRange(LOCATION_REMOVED)
	e1:SetTarget(c17891.sumtr)
	e1:SetOperation(c17891.sumop)
	c:RegisterEffect(e1)
	--Add
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(17891,0))
	e2:SetCategory(CATEGORY_TODECK+CATEGORY_HANDES)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c17891.acost)
	e2:SetCondition(c17891.acon)
	e2:SetTarget(c17891.atg)
	e2:SetOperation(c17891.aop)
	c:RegisterEffect(e2)
	--ss success
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(17891,4))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCondition(c17891.condition)
	e3:SetTarget(c17891.target)
	e3:SetOperation(c17891.operation)
	c:RegisterEffect(e3)
end
function c17891.filter(c,e,tp)
	return c:GetLevel()==4 and c:IsSetCard(0x91) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c17891.sumtr(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,17891)==0 
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c17891.filter,tp,LOCATION_REMOVED,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_REMOVED)
	Duel.RegisterFlagEffect(tp,17891,RESET_PHASE+PHASE_END,0,1)
end
function c17891.sumop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c17891.filter,tp,LOCATION_REMOVED,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c17891.afilter(c,e,tp)
	return c:IsSetCard(0x91) and c:IsAbleToDeck()
end
function c17891.acost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,17891)==0
		and Duel.IsExistingMatchingCard(c17891.afilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c17891.afilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.ConfirmCards(1-tp,g)
	Duel.SendtoDeck(g,nil,1,REASON_COST)
	Duel.RegisterFlagEffect(tp,17891,RESET_PHASE+PHASE_END,0,1)
end
function c17891.thfilter(c)
	return c:IsSetCard(0x91) and c:IsAbleToHand()
end
function c17891.atg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c17891.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c17891.aop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c17891.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c17891.acon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c17891.thfilter,tp,LOCATION_DECK,0,1,nil)
end
function c17891.condition(e,tp,eg,ep,ev,re,r,rp)
	if not re then return false end
	local rc=re:GetHandler()
	return rc:IsSetCard(0x91)
end
function c17891.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsOnField() and chkc:IsControler(tp) and chkc:IsAbleToDeck() end
	if chk==0 then return Duel.GetFlagEffect(tp,17891)==0
		and Duel.IsPlayerCanDraw(tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTODECK)
	local g=Duel.SelectTarget(tp,Card.IsAbleToDeck,tp,LOCATION_ONFIELD,0,1,ct,e:GetHandler())
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,tp,LOCATION_ONFIELD)
	Duel.RegisterFlagEffect(tp,17891,RESET_PHASE+PHASE_END,0,1)
end
function c17891.operation(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.Hint(HINT_SELECTMSG,p,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(p,Card.IsAbleToDeck,p,LOCATION_ONFIELD,0,1,63,nil)
	if g:GetCount()==0 then return end
	Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
	Duel.ShuffleDeck(p)
	Duel.BreakEffect()
	Duel.Draw(p,g:GetCount(),REASON_EFFECT)
end