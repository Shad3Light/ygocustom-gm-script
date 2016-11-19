--Blessing of Arc
--Part of St. Joan Take 2 Project by Amaroq
--
function c49188012.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	--Activate
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Special Summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(49188012,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTarget(c49188012.sptg)
	e2:SetOperation(c49188012.spop)
	c:RegisterEffect(e2)
	--Shuffle
	e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(49188012,1))
	e3:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_TODECK)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetTarget(c49188012.shfltarget)
	e3:SetOperation(c49188012.shflop)
	c:RegisterEffect(e3)
end
function c49188012.filter(c,e,tp)
	return (c:IsCode(84080938) or c:IsCode(57579381)) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c49188012.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c49188012.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c49188012.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c49188012.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		Duel.BreakEffect()
		Duel.Destroy(e:GetHandler(),REASON_EFFECT)
	end
end


--WIP
function c49188012.shflfilter(c,code)
	return c:IsSetCard(0xEF1) and c:IsAbleToDeck()
end
function c49188012.filter2(c,e,tp)
	return c:IsCode(21175632)
end
function c49188012.shfltarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c49188012.filter2(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c49188012.filter2,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c49188012.filter2,tp,LOCATION_MZONE,0,1,1,nil)
--	Duel.SetOperationInfo(0,CATEGORY_TODECK,g1,g1:GetCount(),0,0)
end
function c49188012.shflop(e,tp,eg,ep,ev,re,r,rp)
    local tc=Duel.GetFirstTarget()
    if not tc or not tc:IsRelateToEffect(e) or tc:IsFacedown() then return end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
    local g=Duel.SelectMatchingCard(tp,c49188012.shflfilter,tp,LOCATION_GRAVE,0,1,99,nil)
    local n=g:GetCount()
    if n>0 and Duel.SendtoDeck(g,nil,2,REASON_EFFECT)~=0 then
        local e1=Effect.CreateEffect(e:GetHandler())
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_UPDATE_ATTACK)
        e1:SetValue(n*100)
        tc:RegisterEffect(e1)
    end
end
