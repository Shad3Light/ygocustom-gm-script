--Super Majin Buu
function c33569960.initial_effect(c)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(33569960,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetProperty(EFFECT_FLAG_CHAIN_UNIQUE)
	e1:SetCode(EVENT_CUSTOM+33569959)
	e1:SetCondition(c33569960.spcon)
	e1:SetCost(c33569960.cost)
	e1:SetTarget(c33569960.sptg)
	e1:SetOperation(c33569960.spop)
	c:RegisterEffect(e1)
	--destroy monster turn to chocolate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(33569960,0))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(5)
	e2:SetTarget(c33569960.destg)
	e2:SetOperation(c33569960.desop)
	c:RegisterEffect(e2)
	--tribute eff-eat candy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(33569960,1))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(2)
	e3:SetCost(c33569960.Pcost)
	e3:SetOperation(c33569960.operation2)
	c:RegisterEffect(e3)
	-- Cannot Banish 
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetCode(EFFECT_CANNOT_REMOVE)
	e4:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e4)
	--control
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
	c:RegisterEffect(e5)
	--revive
	local e6=Effect.CreateEffect(c)
	e6:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e6:SetCode(EVENT_DESTROYED)
	e6:SetCondition(c33569960.spcon2)
	e6:SetOperation(c33569960.spop2)
	c:RegisterEffect(e6)
	-- Cannot Disable effect
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e7:SetCode(EFFECT_CANNOT_DISABLE)
	e7:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e7)
--turn monster to candy
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e8:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e8:SetCode(EVENT_BATTLE_DESTROYING)
	e8:SetOperation(c33569960.regop)
	c:RegisterEffect(e8)
	local e9=Effect.CreateEffect(c)
	e9:SetDescription(aux.Stringid(33569960,0))
	e9:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e9:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e9:SetRange(LOCATION_MZONE)
	e9:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e9:SetCountLimit(1)
	e9:SetCondition(c33569960.spcon5)
	e9:SetTarget(c33569960.sptg5)
	e9:SetOperation(c33569960.spop5)
	c:RegisterEffect(e9)
	--gain effect
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e10:SetCode(EVENT_BATTLE_DESTROYING)
	e10:SetProperty(EFFECT_FLAG_DELAY)
	e10:SetCondition(aux.bdocon)
	e10:SetTarget(c33569960.efftg)
	e10:SetOperation(c33569960.effop)
	c:RegisterEffect(e10)
	end

c33569960.collection={ [11111125]=true; [11111126]=true; }

function c33569960.candyfilter(c)
	return c33569960.collection[c:GetCode()]
end

function c33569960.filter(c)
    return c:IsFaceup() and c:IsCode(33569960)
end

function c33569960.efftg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local bc=e:GetHandler():GetBattleTarget()
	Duel.SetTargetCard(bc)
end
function c33569960.effop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and e:GetHandler():IsRelateToEffect(e) then
		e:GetHandler():CopyEffect(tc:GetOriginalCode(),RESET_EVENT+0x1fe0000,1)
	end
end

function c33569960.spcon2(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
local pos=c:GetPreviousPosition()
if pos==POS_FACEDOWN_DEFENSE then pos=POS_FACEUP_DEFENSE end
if pos==POS_FACEDOWN_ATTACK then pos=POS_FACEUP_ATTACK end
e:SetLabel(pos)
return c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsLocation(LOCATION_GRAVE)
end
function c33569960.spop2(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
local pos=e:GetLabel()
if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false) then
Duel.SpecialSummon(c,0,tp,tp,false,false,pos)
end
end


function c33569960.operation2(e,tp,eg,ep,ev,re,r,rp,chk)	
	local c=e:GetHandler()
    if c:IsRelateToEffect(e) and c33569960.filter(c) then
        local e1=Effect.CreateEffect(e:GetHandler())
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_UPDATE_ATTACK)
        e1:SetValue(500)
        e1:SetReset(RESET_EVENT+0x1fe0000)
        c:RegisterEffect(e1)
        local e2=e1:Clone()
        e2:SetCode(EFFECT_UPDATE_DEFENSE)
        c:RegisterEffect(e2)
    end
end

function c33569960.Pcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c33569960.candyfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	local c = Duel.SelectMatchingCard(tp,c33569960.candyfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.Destroy(c,REASON_COST)
end


function c33569960.filter2(c)
	return c:IsType(TYPE_MONSTER) and not c33569960.collection[c:GetCode()]
end

function c33569960.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c33569960.filter2(chkc) and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingTarget(c33569960.filter2,tp,0,LOCATION_MZONE,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c33569960.filter2,tp,0,LOCATION_MZONE,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c33569960.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	if Duel.Destroy(tc,REASON_EFFECT)>0  then
	return  Duel.GetLocationCount(1-tp,LOCATION_MZONE,tp)>0 and Duel.IsPlayerCanSpecialSummonMonster(tp,11111126,0,0x4011,2500,2500,7,RACE_FIEND,ATTRIBUTE_DARK,POS_FACEUP,1-tp) end
			local token=Duel.CreateToken(tp,11111126)
			Duel.SpecialSummon(token,0,tp,1-tp,false,false,POS_FACEUP_DEFENSE)
			end
 end

function c33569960.spcon(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp
end

function c33569960.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsCode,1,nil,33569959) end
	local g=Duel.SelectReleaseGroup(tp,Card.IsCode,1,1,nil,33569959)
	Duel.Release(g,REASON_COST)
end

function c33569960.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,true,false) end
	if e:GetHandler():IsLocation(LOCATION_DECK) then
		Duel.ConfirmCards(1-tp,e:GetHandler())
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end

function c33569960.spop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) and Duel.SpecialSummon(e:GetHandler(),0,tp,tp,true,false,POS_FACEUP)>0 then
		e:GetHandler():CompleteProcedure()
	end
end

function c33569960.regop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(33569960,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
function c33569960.spcon5(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(33569960)~=0
end
function c33569960.sptg5(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c33569960.spop5(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,11111125,0,0x4011,1200,0,4,RACE_INSECT,ATTRIBUTE_EARTH) then return end
	local token=Duel.CreateToken(tp,11111125)
	Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
end
