--amazon trio FishEye
function c335599124.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION+EFFECT_SPSUMMON_PROC)
	e1:SetCountLimit(1,335599124)
	e1:SetTarget(c335599124.sptg)
	e1:SetOperation(c335599124.spop)
	e1:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e1)
--pos change
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(335599124,0))
	e2:SetCategory(CATEGORY_POSITION)
	e2:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_SINGLE)
	e2:SetCode(EVENT_BE_BATTLE_TARGET)
	e2:SetOperation(c335599124.posop)
	c:RegisterEffect(e2)
end
function c335599124.filter(c,e,tp)
	return c:IsRace(RACE_FISH) and (c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,true,false))
end
function c335599124.jnfilter(c)
	return c:IsFaceup() and c:IsCode(335599124)
end
function c335599124.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c335599124.jnfilter,tp,LOCATION_ONFIELD,0,1,nil) 
end
function c335599124.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_DECK) and chkc:IsControler(tp) and c335599124.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c335599124.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c335599124.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c335599124.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)
	end
	Duel.SpecialSummonComplete()
end
function c335599124.becon(e)
	return e:GetHandler():IsAttackable()
end
function c335599124.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		Duel.ChangePosition(c,POS_FACEUP_DEFENSE,0,POS_FACEUP_ATTACK,0)
	end
end

