function c17898.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,aux.FilterBoolFunction(Card.IsSetCard,0x91),3,true,true)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON)
	e1:SetValue(c17898.splimit)
	c:RegisterEffect(e1)
	--special summon rule
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(17898,1))
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(c17898.sprcon)
	e2:SetOperation(c17898.sprop)
	c:RegisterEffect(e2)
	--SS Monster Banished
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(17898,2))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY+EFFECT_FLAG_CHAIN_UNIQUE)
	e3:SetCondition(c17898.descon)
	e3:SetTarget(c17898.destg)
	e3:SetOperation(c17898.desop)
	c:RegisterEffect(e3)
end
function c17898.spfilter(c)
	local tpe=c:GetOriginalType()
	return c:IsSetCard(0x91) and c:IsCanBeFusionMaterial() and
		((bit.band(tpe,TYPE_FUSION)>=0 and c:IsAbleToExtraAsCost()) or 
		(bit.band(tpe,TYPE_FUSION)==0 and c:IsAbleToDeckAsCost()))
end
function c17898.splimit(e,se,sp,st)
	return e:GetHandler():GetLocation()~=LOCATION_EXTRA
end
function c17898.sprcon(e,c)
	if c==nil then return true end 
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-3
		and Duel.IsExistingMatchingCard(c17898.spfilter,tp,LOCATION_MZONE,0,3,nil)
end
function c17898.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectMatchingCard(tp,c17898.spfilter,tp,LOCATION_MZONE,0,3,3,nil)
	local tc=g:GetFirst()
	while tc do
		if not tc:IsFaceup() then Duel.ConfirmCards(1-tp,tc) end
		tc=g:GetNext()
	end
	Duel.SendtoDeck(g,nil,3,REASON_COST)
end
function c17898.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SPECIAL
end
function c17898.ssfilter(c,e,tp)
	return c:GetLevel()==4 and c:IsSetCard(0x91) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c17898.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,17898)==0 
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>=2
		and Duel.IsExistingMatchingCard(c17898.ssfilter,tp,LOCATION_REMOVED,0,2,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_REMOVED)
	Duel.RegisterFlagEffect(tp,17898,RESET_PHASE+PHASE_END,0,1)
end
function c17898.desop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c17898.ssfilter,tp,LOCATION_REMOVED,0,2,2,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
