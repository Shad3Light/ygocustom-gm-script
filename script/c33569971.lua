--Masked Hero Kiaki
--scripted by GameMaster (GM)
function c33569971.initial_effect(c)
	c:EnableReviveLimit()
	--spsummon condition- mask change- make sure add masked hero setcode when reusing this-
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION+EFFECT_SPSUMMON_PROC)
	e2:SetCountLimit(1)
	e2:SetTarget(c33569971.sptg)
	e2:SetOperation(c33569971.spop)
	e2:SetCost(c33569971.cost)
	e2:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e2)
end

c33569971.collection={ [21143940]=true; [84536654]=true; [93600443]=true; [511002369]=true; }

function c33569971.costfilter(c)
    return c33569971.collection[c:GetCode()]
end


function c33569971.cost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c33569971.costfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) end
    Duel.DiscardHand(tp,c33569971.costfilter,1,1,REASON_COST+REASON_DISCARD)
end


function c33569971.filter(c,e,tp)
return c:IsType(TYPE_MONSTER) and c:IsSetCard(0xa008) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c33569971.jnfilter(c)
	return c:IsFaceup() and c:IsCode(33569971)
end
function c33569971.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c33569971.jnfilter,tp,LOCATION_MZONE,0,1,nil) 
end
function c33569971.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_EXTRA) and chkc:IsControler(tp) and c33569971.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c33569971.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c33569971.filter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c33569971.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)
	end
	Duel.SpecialSummonComplete()
end