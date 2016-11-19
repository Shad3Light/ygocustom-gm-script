--Moon Sister
--scripted by GameMaster (GM)
function c75233707.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_LEAVE_FIELD)
	e1:SetCondition(c75233707.sdescon)
	e1:SetOperation(c75233707.sdesop)
	c:RegisterEffect(e1)
	--draw 2 as normal draw
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DRAW_COUNT)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c75233707.con)
	e2:SetTargetRange(1,0)
	e2:SetValue(2)
	c:RegisterEffect(e2)
	--REborn
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetTarget(c75233707.target)
	e3:SetOperation(c75233707.operation)
	e3:SetCondition(c75233707.con2)
	e3:SetValue(1)
	e3:SetCountLimit(1)
	c:RegisterEffect(e3)
end

function c75233707.filter1(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c75233707.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c75233707.filter1(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c75233707.filter1,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c75233707.filter1,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c75233707.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end

function c75233707.filter3(c)
	return c:IsFaceup() and c:GetCode(75233708)
end
function c75233707.con2(e)
		local tp=e:GetHandlerPlayer()
	return Duel.IsExistingMatchingCard(c75233707.filter3,tp,LOCATION_SZONE,0,1,nil)
end

function c75233707.cfilter(c)
	return c:IsFaceup() and c:GetCode(75233705,75233706,75233707)
end
function c75233707.con(e)
		local tp=e:GetHandlerPlayer()
	return Duel.IsExistingMatchingCard(c75233707.cfilter,tp,LOCATION_MZONE,0,3,nil)
end

function c75233707.sfilter(c)
	return c:IsReason(REASON_DESTROY) and c:IsPreviousPosition(POS_FACEUP) and c:GetPreviousCodeOnField()==75233708 and c:IsPreviousLocation(LOCATION_ONFIELD)
end
function c75233707.sdescon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c75233707.sfilter,1,nil)
end
function c75233707.sdesop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end