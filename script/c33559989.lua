--MeatalSeadramon
function c33559989.initial_effect(c)
	c:SetUniqueOnField(1,0,33559989)
--Summon with 3 Tribute
	local e0=Effect.CreateEffect(c)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetCode(EFFECT_LIMIT_SUMMON_PROC)
	e0:SetCondition(c33559989.sumoncon)
	e0:SetOperation(c33559989.sumonop)
	e0:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e0)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_LIMIT_SET_PROC)
	e1:SetCondition(c33559989.setcon)
	c:RegisterEffect(e1)
	--immune spell/trap
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c33559989.econ)
	e2:SetValue(c33559989.efilter)
	c:RegisterEffect(e2)
	--atk
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCode(EFFECT_IGNORE_BATTLE_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c33559989.econ)
	c:RegisterEffect(e3)
	--spsummon
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_BE_MATERIAL)
	e4:SetCondition(c33559989.spcon2)
	e4:SetOperation(c33559989.spop2)
	c:RegisterEffect(e4)
	--spsummon
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(33559989,0))
	e5:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e5:SetRange(LOCATION_GRAVE)
	e5:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e5:SetCondition(c33559989.spcon1)
	e5:SetTarget(c33559989.sptg1)
	e5:SetOperation(c33559989.spop1)
	c:RegisterEffect(e5)
	--summon divermon
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(33559989,1))
	e6:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e6:SetType(EFFECT_TYPE_IGNITION)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCountLimit(1,33559989)
	e6:SetCondition(c33559989.spcon3)
	e6:SetTarget(c33559989.sptg3)
	e6:SetOperation(c33559989.spop3)
	c:RegisterEffect(e6)
	--attack all
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetCode(EFFECT_ATTACK_ALL)
	e7:SetValue(1)
	c:RegisterEffect(e7)
	-- Cannot Banish (Loyalty to controller)
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e8:SetCode(EFFECT_CANNOT_REMOVE)
	e8:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e8)
	--control
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_SINGLE)
	e9:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e9:SetRange(LOCATION_MZONE)
	e9:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
	c:RegisterEffect(e9)
	--Summon Cannot be Negated
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_SINGLE)
	e10:SetCode(EFFECT_CANNOT_DISABLE_SUMMON)
	e10:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(e10)
	--cannot be target
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_SINGLE)
	e11:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e11:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e11:SetRange(LOCATION_MZONE)
	e11:SetValue(c33559989.tgfilter)
	c:RegisterEffect(e11)
	--immune effect
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_SINGLE)
	e12:SetCode(EFFECT_IMMUNE_EFFECT)
	e12:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e12:SetRange(LOCATION_MZONE)
	e12:SetValue(c33559989.efilter1)
	c:RegisterEffect(e12)
	--indes
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_MZONE)
	e13:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e13:SetValue(1)
	c:RegisterEffect(e13)
	-- Cannot Disable effect
	local e14=Effect.CreateEffect(c)
	e14:SetType(EFFECT_TYPE_SINGLE)
	e14:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e14:SetCode(EFFECT_CANNOT_DISABLE)
	e14:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e14)
	--cannot special summon
	local e15=Effect.CreateEffect(c)
	e15:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SINGLE_RANGE)
	e15:SetType(EFFECT_TYPE_SINGLE)
	e15:SetRange(LOCATION_HAND)
	e15:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e15)
end
function c33559989.sumoncon(e,c)
if c==nil then return true end
return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-3 and Duel.GetTributeCount(c)>=3
end
function c33559989.sumonop(e,tp,eg,ep,ev,re,r,rp,c)
local g=Duel.SelectTribute(tp,c,3,3)
c:SetMaterial(g)
Duel.Release(g,REASON_SUMMON+REASON_MATERIAL)
end
function c33559989.setcon(e,c)
	if not c then return true end
	return false
end
function c33559989.spcon2(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
return c:IsLocation(LOCATION_GRAVE) and r==REASON_SUMMON
end
function c33559989.spop2(e,tp,eg,ep,ev,re,r,rp)
e:GetHandler():RegisterFlagEffect(33559989,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN,0,1)
end
function c33559989.spcon1(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
return c:GetTurnID()~=Duel.GetTurnCount() and tp==Duel.GetTurnPlayer() and c:GetFlagEffect(33559989)>0
end
function c33559989.sptg1(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
local c=e:GetHandler()
Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
c:ResetFlagEffect(33559989)
end
function c33559989.spop1(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
if c:IsRelateToEffect(e) then
Duel.SpecialSummon(c,1,tp,tp,false,false,POS_FACEUP)
end
end
function c33559989.spfilter(c)
return c:IsCode(22222223)
end
function c33559989.spcon3(e,tp,eg,ep,ev,re,r,rp)
if Duel.IsExistingMatchingCard(c33559989.spfilter,tp,LOCATION_MZONE,0,1,nil) then return false
else return true end
end
function c33559989.sptg3(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1
and Duel.IsPlayerCanSpecialSummonMonster(tp,22222223,0,0x4011,500,100,2,RACE_SPELLCASTER,ATTRIBUTE_DARK) end
Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,2,0,0)
Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
end
function c33559989.spop3(e,tp,eg,ep,ev,re,r,rp)
if Duel.GetLocationCount(tp,LOCATION_MZONE)<=1 then return end
if Duel.IsPlayerCanSpecialSummonMonster(tp,22222223,0,0x4011,500,100,2,RACE_SPELLCASTER,ATTRIBUTE_DARK) then
local token1=Duel.CreateToken(tp,22222223)
Duel.SpecialSummonStep(token1,0,tp,tp,false,false,POS_FACEUP)
local token2=Duel.CreateToken(tp,22222223)
Duel.SpecialSummonStep(token2,0,tp,tp,false,false,POS_FACEUP)
Duel.SpecialSummonComplete()
end
end
function c33559989.filter(c)
	return c:IsFaceup() and c:IsCode(22702055)
end
function c33559989.econ(e)
	return Duel.IsExistingMatchingCard(c33559989.filter,0,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
		or Duel.IsEnvironment(22702055)
end
function c33559989.efilter(e,te)
	return te:IsActiveType(TYPE_SPELL+TYPE_TRAP)
end
function c33559989.efilter1(e,te)
	return te:IsActiveType(TYPE_EFFECT) and te:GetOwner()~=e:GetOwner()
end
function c33559989.tgfilter(e,re)
	if not re or not re:IsActiveType(TYPE_SPELL+TYPE_TRAP) then return false end
	return re:IsHasCategory(CATEGORY_TOHAND+CATEGORY_DESTROY+CATEGORY_REMOVE+CATEGORY_TODECK+CATEGORY_RELEASE+CATEGORY_TOGRAVE)
end
