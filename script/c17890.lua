function c17890.initial_effect(c)
	--summon success
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(17890,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetTarget(c17890.sumtr)
	e1:SetOperation(c17890.sumop)
	c:RegisterEffect(e1)
	--ss success
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(17890,4))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c17890.condition)
	e2:SetCost(c17890.cost)
	e2:SetTarget(c17890.target)
	e2:SetOperation(c17890.operation)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(17890,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCost(c17890.spcost)
	e3:SetTarget(c17890.sptg)
	e3:SetOperation(c17890.spop)
	c:RegisterEffect(e3)
end
function c17890.filter(c,e,tp)
	return c:GetLevel()==4 and c:IsSetCard(0x91) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c17890.sumtr(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,17890)==0 
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c17890.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
	Duel.RegisterFlagEffect(tp,17890,RESET_PHASE+PHASE_END,0,1)
end
function c17890.sumop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c17890.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
	function c17890.condition(e,tp,eg,ep,ev,re,r,rp)
	if not re then return false end
	local rc=re:GetHandler()
	return rc:IsSetCard(0x91)
end
function c17890.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,17890)==0 end
	Duel.RegisterFlagEffect(tp,17890,RESET_PHASE+PHASE_END,0,1)
end
function c17890.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,17890)==0 end
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,PLAYER_ALL,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,PLAYER_ALL,5)
	Duel.RegisterFlagEffect(tp,17890,RESET_PHASE+PHASE_END,0,1)
end
function c17890.operation(e,tp,eg,ep,ev,re,r,rp)
	if chk==0 then return Duel.GetFlagEffect(tp,17890)==0 end
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,LOCATION_HAND)
	if g:GetCount()>0 then Duel.SendtoGrave(g,REASON_DISCARD+REASON_COST) end
	Duel.BreakEffect()
	Duel.Draw(tp,5,REASON_EFFECT)
	Duel.Draw(1-tp,5,REASON_EFFECT)
	Duel.RegisterFlagEffect(tp,17890,RESET_PHASE+PHASE_END,0,1)
end
function c17890.spfilter(c,e,tp)
	return c:IsSetCard(0x91) and c:IsAbleToRemoveAsCost()
end
function c17890.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,17890)==0 
		and Duel.IsExistingMatchingCard(c17890.spfilter,tp,LOCATION_HAND,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g1=Duel.SelectMatchingCard(tp,c17890.spfilter,tp,LOCATION_HAND,0,2,2,nil,e,tp)
	Duel.Remove(g1,POS_FACEUP,REASON_COST)
	Duel.RegisterFlagEffect(tp,17890,RESET_PHASE+PHASE_END,0,1)
end
function c17890.ssfilter(c,e,tp)
	return c:GetLevel()==4 and c:IsSetCard(0x91) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c17890.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>=2
		and Duel.IsExistingMatchingCard(c17890.ssfilter,tp,LOCATION_DECK,0,2,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_DECK)
end
function c17890.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<2 then return end
	local g=Duel.GetMatchingGroup(c17890.filter,tp,LOCATION_DECK,0,nil,e,tp)
	if g:GetCount()>=2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,2,2,nil)
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
		local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		Duel.RegisterEffect(e3,tp)
	end
end