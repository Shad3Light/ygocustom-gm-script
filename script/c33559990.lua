--Dark Master-Puppetmon
function c33559990.initial_effect(c)
	c:SetUniqueOnField(1,0,33559990)
	--Summon with 3 Tribute
	local e0=Effect.CreateEffect(c)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetCode(EFFECT_LIMIT_SUMMON_PROC)
	e0:SetCondition(c33559990.sumoncon)
	e0:SetOperation(c33559990.sumonop)
	e0:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e0)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_LIMIT_SET_PROC)
	e1:SetCondition(c33559990.setcon)
	c:RegisterEffect(e1)
	--puppet strings
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(33559990,2))
	e2:SetCategory(CATEGORY_CONTROL)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c33559990.cost)
	e2:SetTarget(c33559990.target)
	e2:SetOperation(c33559990.operation)
	c:RegisterEffect(e2)
	--cannot change control
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
	c:RegisterEffect(e3)
	--spsummon
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_BE_MATERIAL)
	e4:SetCondition(c33559990.spcon2)
	e4:SetOperation(c33559990.spop2)
	c:RegisterEffect(e4)
	--spsummon
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(33559990,0))
	e5:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e5:SetRange(LOCATION_GRAVE)
	e5:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e5:SetCondition(c33559990.spcon1)
	e5:SetTarget(c33559990.sptg1)
	e5:SetOperation(c33559990.spop1)
	c:RegisterEffect(e5)
	--token
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(33559990,1))
	e6:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e6:SetType(EFFECT_TYPE_IGNITION)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCountLimit(1,33559990)
	e6:SetCondition(c33559990.spcon3)
	e6:SetTarget(c33559990.sptg3)
	e6:SetOperation(c33559990.spop3)
	c:RegisterEffect(e6)
	--Token 4 lp-puppetmansion
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(33559990,3))
	e7:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e7:SetType(EFFECT_TYPE_IGNITION)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCountLimit(1,33559990+EFFECT_COUNT_CODE_DUEL)
	e7:SetCondition(c33559990.spcon4)
	e7:SetCost(c33559990.spcost)
	e7:SetTarget(c33559990.sptg4)
	e7:SetOperation(c33559990.spop4)
	c:RegisterEffect(e7)
	-- Cannot Banish (Loyalty to controller)
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e8:SetCode(EFFECT_CANNOT_REMOVE)
	e8:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e8)
	--Summon Cannot be Negated
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_SINGLE)
	e9:SetCode(EFFECT_CANNOT_DISABLE_SUMMON)
	e9:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(e9)
	--cannot be target
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_SINGLE)
	e10:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e10:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e10:SetRange(LOCATION_MZONE)
	e10:SetValue(c33559990.tgfilter)
	c:RegisterEffect(e10)
	--immune effect
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_SINGLE)
	e11:SetCode(EFFECT_IMMUNE_EFFECT)
	e11:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e11:SetRange(LOCATION_MZONE)
	e11:SetValue(c33559990.efilter)
	c:RegisterEffect(e11)
	--indes
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_SINGLE)
	e12:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e12:SetRange(LOCATION_MZONE)
	e12:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e12:SetValue(1)
	c:RegisterEffect(e12)
	-- Cannot Disable effect
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetCode(EFFECT_CANNOT_DISABLE)
	e13:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e13)
	--cannot special summon
	local e14=Effect.CreateEffect(c)
	e14:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SINGLE_RANGE)
	e14:SetType(EFFECT_TYPE_SINGLE)
	e14:SetRange(LOCATION_HAND)
	e14:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e14)
end
function c33559990.sumoncon(e,c)
if c==nil then return true end
return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-3 and Duel.GetTributeCount(c)>=3
end
function c33559990.sumonop(e,tp,eg,ep,ev,re,r,rp,c)
local g=Duel.SelectTribute(tp,c,3,3)
c:SetMaterial(g)
Duel.Release(g,REASON_SUMMON+REASON_MATERIAL)
end
function c33559990.setcon(e,c)
	if not c then return true end
	return false
end
function c33559990.efilter(e,te)
	return te:IsActiveType(TYPE_EFFECT) and te:GetOwner()~=e:GetOwner()
end
function c33559990.tgfilter(e,re)
	if not re or not re:IsActiveType(TYPE_SPELL+TYPE_TRAP) then return false end
	return re:IsHasCategory(CATEGORY_TOHAND+CATEGORY_DESTROY+CATEGORY_REMOVE+CATEGORY_TODECK+CATEGORY_RELEASE+CATEGORY_TOGRAVE)
end
function c33559990.spcon2(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
return c:IsLocation(LOCATION_GRAVE) and r==REASON_SUMMON
end
function c33559990.spop2(e,tp,eg,ep,ev,re,r,rp)
e:GetHandler():RegisterFlagEffect(33559990,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN,0,1)
end
function c33559990.spcon1(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
return c:GetTurnID()~=Duel.GetTurnCount() and tp==Duel.GetTurnPlayer() and c:GetFlagEffect(33559990)>0
end
function c33559990.sptg1(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
local c=e:GetHandler()
Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
c:ResetFlagEffect(33559990)
end
function c33559990.spop1(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
if c:IsRelateToEffect(e) then
Duel.SpecialSummon(c,1,tp,tp,false,false,POS_FACEUP)
end
end
function c33559990.spfilter(c)
return c:IsCode(22222208)
end
function c33559990.spcon3(e,tp,eg,ep,ev,re,r,rp)
if Duel.IsExistingMatchingCard(c33559990.spfilter,tp,LOCATION_MZONE,0,1,nil) then return false
else return true end
end
function c33559990.sptg3(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1
and Duel.IsPlayerCanSpecialSummonMonster(tp,22222208,0,0x4011,500,100,2,RACE_SPELLCASTER,ATTRIBUTE_DARK) end
Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,2,0,0)
Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
end
function c33559990.spop3(e,tp,eg,ep,ev,re,r,rp)
if Duel.GetLocationCount(tp,LOCATION_MZONE)<=1 then return end
if Duel.IsPlayerCanSpecialSummonMonster(tp,22222208,0,0x4011,500,100,2,RACE_SPELLCASTER,ATTRIBUTE_DARK) then
local token1=Duel.CreateToken(tp,22222208)
Duel.SpecialSummonStep(token1,0,tp,tp,false,false,POS_FACEUP)
local token2=Duel.CreateToken(tp,22222208)
Duel.SpecialSummonStep(token2,0,tp,tp,false,false,POS_FACEUP)
Duel.SpecialSummonComplete()
end
end
function c33559990.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c33559990.filter(c)
	return c:IsFaceup() and c:IsLevelBelow(13) and c:IsControlerCanBeChanged()
end
function c33559990.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c33559990.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,nil,1,1-tp,LOCATION_MZONE)
end
function c33559990.operation(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectMatchingCard(tp,c33559990.filter,tp,0,LOCATION_MZONE,ft,ft,nil)
	local tc=g:GetFirst()
	while tc do
		if Duel.GetControl(tc,tp,PHASE_END,1) then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UNRELEASABLE_SUM)
			e1:SetReset(RESET_EVENT+0x1fc0000+RESET_PHASE+PHASE_END)
			e1:SetValue(1)
			tc:RegisterEffect(e1)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_UNRELEASABLE_NONSUM)
			e2:SetReset(RESET_EVENT+0x1fc0000+RESET_PHASE+PHASE_END)
			e2:SetValue(1)
			tc:RegisterEffect(e2)
			local e3=Effect.CreateEffect(c)
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetCode(EFFECT_CANNOT_TRIGGER)
			e3:SetReset(RESET_EVENT+0x1fc0000+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e3)
			local e4=Effect.CreateEffect(c)
			e4:SetType(EFFECT_TYPE_SINGLE)
			e4:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
			e4:SetReset(RESET_EVENT+0x1fc0000+RESET_PHASE+PHASE_END)
			e4:SetValue(1)
			tc:RegisterEffect(e4)
		elseif not tc:IsImmuneToEffect(e) and tc:IsAbleToChangeControler() then
			Duel.Destroy(tc,REASON_EFFECT)
		end
		tc=g:GetNext()
	end
end
function c33559990.spfilter2(c)
return c:IsCode(22222207)
end
function c33559990.spcon4(e,tp,eg,ep,ev,re,r,rp)
if Duel.IsExistingMatchingCard(c33559990.spfilter2,tp,LOCATION_MZONE,0,1,nil) then return false
else return true end
end
function c33559990.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c33559990.sptg4(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,22222207,0,0x4011,0,0,1,RACE_PLANT,ATTRIBUTE_EARTH) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c33559990.spop4(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,22222207,0,0x4011,0,0,1,RACE_PLANT,ATTRIBUTE_EARTH) then return end
	local token=Duel.CreateToken(tp,22222207)
	Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
end