--Kisara,The Dragon Protector
--Scripted by GameMaster(GM)
function c75233702.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(75233702,1))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCountLimit(1)
	e1:SetCondition(c75233702.spcon)
	e1:SetTarget(c75233702.sptg)
	e1:SetOperation(c75233702.spop)
	c:RegisterEffect(e1)
	--change target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_BE_BATTLE_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c75233702.condition)
	e2:SetTarget(c75233702.target)
	e2:SetOperation(c75233702.operation)
	c:RegisterEffect(e2)
	--spsummon blue eyes ultimate dragon
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_IGNITION+EFFECT_SPSUMMON_PROC)
	e4:SetCountLimit(1)
	e4:SetTarget(c75233702.sptg2)
	e4:SetOperation(c75233702.spop2)
	e4:SetCondition(c75233702.spcon2)
	e4:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e4)
	--blue eyes monster battle indesturctable
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetTargetRange(LOCATION_MZONE,0)
	e5:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0xDD))
	e5:SetValue(1)
	c:RegisterEffect(e5)
end

function c75233702.jnfilter(c)
	return c:IsFaceup() and c:IsCode(75233703)
end

function c75233702.spcon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c75233702.jnfilter,tp,LOCATION_MZONE,0,1,nil)
end

function c75233702.filter2(c,e,tp)
return c:IsType(TYPE_MONSTER) and c:IsCode(23995346) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end


function c75233702.sptg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_EXTRA) and chkc:IsControler(tp) and c75233702.filter2(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c75233702.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c75233702.filter2,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c75233702.spop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)
	end
	Duel.SpecialSummonComplete()
end



function c75233702.filter(c)
	return c:IsFaceup() and c:IsCode(89631139) 
end

function c75233702.filter5(c)
    return c:IsFaceup() and c:IsCode(75233702)
end
function c75233702.condition(e,tp,eg,ep,ev,re,r,rp)
    local ct=Duel.GetMatchingGroupCount(c75233702.filter5,tp,LOCATION_MZONE,0,nil)
    return not e:GetHandler():IsStatus(STATUS_CHAINING) and tp~=Duel.GetTurnPlayer()
end


function c75233702.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c75233702.filter,tp,LOCATION_MZONE,0,1,1,Duel.GetAttacker())
end
function c75233702.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		--Duel.ChangeAttackTarget(tc)
		Duel.CalculateDamage(Duel.GetAttacker(),tc)
	end
end


function c75233702.spfilter(c,e,tp)
	return c:IsCode(89631139) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end

function c75233702.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsContains(e:GetHandler())
end
function c75233702.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c75233702.spfilter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE)
end
function c75233702.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c75233702.spfilter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp)
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		local tc=Duel.GetFirstTarget()
		Duel.ChangeAttackTarget(tc)
		end
end 

