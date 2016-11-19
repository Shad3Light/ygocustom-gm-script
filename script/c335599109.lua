--Amazoness Hunter
function c335599109.initial_effect(c)
--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(335599109,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCountLimit(1,335599109)
	e1:SetCondition(aux.bdogcon)
	e1:SetTarget(c335599109.sptg)
	e1:SetOperation(c335599109.spop)
	c:RegisterEffect(e1)
	--destroyed
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(45812361,0))
	e2:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetHintTiming(TIMING_TOGRAVE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCondition(c335599109.condition)
	e2:SetCost(c335599109.cost)
	e2:SetTarget(c335599109.target)
	e2:SetOperation(c335599109.operation)
	c:RegisterEffect(e2)
end
function c335599109.filter(c,e,tp)
	return c:IsSetCard(0x4) and c:GetCode()~=335599109 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c335599109.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE+LOCATION_DECK) and chkc:IsControler(tp) and c335599109.filter(chkc,e,tp) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c335599109.filter,tp,LOCATION_GRAVE+LOCATION_DECK,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c335599109.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c335599109.filter1(c)
return c:IsLevelBelow(4) and c:IsRace(RACE_WARRIOR) and c:GetCode()~=335599109 and c:IsAbleToHand() 
end
function c335599109.condition(e,tp,eg,ep,ev,re,r,rp)
return rp~=tp and e:GetHandler():GetPreviousControler()==tp
end
function c335599109.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c335599109.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c335599109.filter1,tp,LOCATION_DECK,0,1,nil) end
Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c335599109.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
local g=Duel.SelectMatchingCard(tp,c335599109.filter1,tp,LOCATION_DECK,0,1,1,nil)
if g:GetCount()>0 then
Duel.SendtoHand(g,nil,REASON_EFFECT)
Duel.ConfirmCards(1-tp,g)
end
end