--Elemental Hero Toon Neos
--scripted by GameMaster (GM)
function c33569992.initial_effect(c)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c33569992.spcon)
	e1:SetOperation(c33569992.spop)
	c:RegisterEffect(e1)
	--direct attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DIRECT_ATTACK)
	e2:SetCondition(c33569992.dircon)
	c:RegisterEffect(e2)
	--must atk toons
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	e3:SetCondition(c33569992.atcon)
	c:RegisterEffect(e3)
	--spsummon monster from grave
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(33569992,0))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetCost(c33569992.cost)
	e4:SetTarget(c33569992.sptg)
	e4:SetOperation(c33569992.spop2)
	c:RegisterEffect(e4)
end
	

function c33569992.filter(c,e,tp)
	return c:IsType(TYPE_MONSTER) and (c:IsSetCard(0x62) and not c:IsCode(33569992) and c:IsCanBeSpecialSummoned(e,0,tp,true,false))
end


function c33569992.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c33569992.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c33569992.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c33569992.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c33569992.spop2(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)
	end
end


function c33569992.filter3(c)
	return c:IsType(TYPE_MONSTER) and ( c:IsSetCard(0x62) and c:IsDiscardable())
end


function c33569992.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c33569992.filter3,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,c33569992.filter3,1,1,REASON_COST+REASON_DISCARD)
end
function c33569992.cfilter(c)
	return c:IsFaceup() and c:IsCode(15259703)
end
function c33569992.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(c33569992.cfilter,tp,LOCATION_ONFIELD,0,1,nil) 
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>-2 and Duel.CheckReleaseGroup(tp,nil,2,nil)
end
function c33569992.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local tp=c:GetControler()
	local g=Duel.SelectReleaseGroup(tp,nil,2,2,nil)
	Duel.Release(g,REASON_COST)
end

function c33569992.atkfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_TOON)
end
function c33569992.dircon(e)
	return not Duel.IsExistingMatchingCard(c33569992.atkfilter,e:GetHandlerPlayer(),0,LOCATION_MZONE,1,nil)
end
function c33569992.atcon(e)
	return Duel.IsExistingMatchingCard(c33569992.atkfilter,e:GetHandlerPlayer(),0,LOCATION_MZONE,1,nil)
end

