--Clap Trap
function c335599125.initial_effect(c)
    --CallCardBanishFaceDown
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(335599125,0))
    e1:SetType(EFFECT_TYPE_QUICK_O)
    e1:SetRange(LOCATION_MZONE)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetCountLimit(1)
    e1:SetHintTiming(0,0x1c0)
    e1:SetTarget(c335599125.target)
    e1:SetOperation(c335599125.operation)
    c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(810000038,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c335599125.spcon)
	e2:SetTarget(c335599125.sptg)
	e2:SetOperation(c335599125.spop)
	c:RegisterEffect(e2)
	--cannot attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetTarget(c335599125.atktarget)
	c:RegisterEffect(e3)
	--maintain
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e4:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetCondition(c335599125.mtcon)
	e4:SetOperation(c335599125.mtop)
	c:RegisterEffect(e4)
	--atkup
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(EFFECT_UPDATE_ATTACK)
	e5:SetValue(c335599125.value)
	c:RegisterEffect(e5)
	--pierce
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e6)
end

function c335599125.filter2(c)
	return c:IsFaceup() and c:IsRace(RACE_MACHINE)
end
function c335599125.value(e,c)
	return Duel.GetMatchingGroupCount(c335599125.filter2,0,LOCATION_MZONE,LOCATION_MZONE,nil)*600
end


function c335599125.atktarget(e,c)
	return c:GetAttack()>=3000
end
function c335599125.mtcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c335599125.mtop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.CheckLPCost(tp,400) and Duel.SelectYesNo(tp,aux.Stringid(11111112,0)) then
		Duel.PayLPCost(tp,400)
	else
		Duel.Destroy(e:GetHandler(),REASON_COST)
	end
end

function c335599125.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c335599125.spfilter(c,e,tp)
	return c:IsLevelBelow(4) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c335599125.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c335599125.spop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c335599125.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	elseif Duel.IsPlayerCanSpecialSummon(tp) then
		local cg=Duel.GetFieldGroup(tp,LOCATION_DECK,0)
		Duel.ConfirmCards(1-tp,cg)
		Duel.ShuffleDeck(tp)
	end
end


function c335599125.filter(c)
    return not c:IsFaceup()
end
function c335599125.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and chkc:IsAbleToRemove() end
    if chk==0 then return Duel.IsExistingTarget(c335599125.filter,tp,0,LOCATION_ONFIELD,1,nil) end
    Duel.Hint(HINT_SELECTMSG,tp,0)
    Duel.SelectTarget(tp,c335599125.filter,tp,0,LOCATION_ONFIELD,1,1,nil)
    local ac=Duel.AnnounceCard(tp)
    Duel.SetTargetParam(ac)
    Duel.SetOperationInfo(0,CATEGORY_ANNOUNCE,nil,0,tp,ANNOUNCE_CARD)
end
function c335599125.operation(e,tp,eg,ep,ev,re,r,rp)
    local tc=Duel.GetFirstTarget()
    local ac=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
    Duel.ConfirmCards(tp,tc)
    if not tc:IsCode(ac) then return end
    if tc:IsCode(ac) and tc:IsAbleToRemove() then
        Duel.Remove(tc,POS_FACEDOWN,REASON_EFFECT)
    end
end
