--Lord Onyx-King of the fire world
function c335599009.initial_effect(c)
--Activate
local e0=Effect.CreateEffect(c)
e0:SetType(EFFECT_TYPE_ACTIVATE)
e0:SetCode(EVENT_FREE_CHAIN)
e0:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
e0:SetCost(c335599009.cost)
c:RegisterEffect(e0)
--immune
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_IMMUNE_EFFECT)
e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e1:SetRange(LOCATION_FZONE)
e1:SetValue(c335599009.efilter)
c:RegisterEffect(e1)
	--self destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SELF_DESTROY)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(0,LOCATION_SZONE)
	e2:SetTarget(c335599009.destg)
	c:RegisterEffect(e2)
	--Def down
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	e3:SetValue(-700)
	c:RegisterEffect(e3)
	--Atk up
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetRange(LOCATION_FZONE)
	e4:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetTarget(aux.TargetBoolFunction(Card.IsAttribute,ATTRIBUTE_FIRE))
	e4:SetValue(1000)
	c:RegisterEffect(e4)
	--damage
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(335599009,0))
	e5:SetCategory(CATEGORY_DAMAGE)
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e5:SetRange(LOCATION_FZONE)
	e5:SetCountLimit(1)
	e5:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e5:SetTarget(c335599009.damtg)
	e5:SetOperation(c335599009.damop)
	c:RegisterEffect(e5)
--damage reduce
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD)
	e6:SetCode(EFFECT_CHANGE_DAMAGE)
	e6:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e6:SetRange(LOCATION_FZONE)
	e6:SetTargetRange(1,0)
	e6:SetValue(c335599009.damval)
	c:RegisterEffect(e6)
	local e7=e6:Clone()
	e7:SetCode(EFFECT_NO_EFFECT_DAMAGE)
	c:RegisterEffect(e7)
	--ATK down
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_FIELD)
	e8:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e8:SetRange(LOCATION_SZONE)
	e8:SetTargetRange(0,LOCATION_MZONE)
	e8:SetCode(EFFECT_UPDATE_ATTACK)
	e8:SetValue(-1000)
	c:RegisterEffect(e8)
	-- Cannot Disable effect
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_SINGLE)
	e9:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e9:SetCode(EFFECT_CANNOT_DISABLE)
	e9:SetRange(LOCATION_FZONE)
	c:RegisterEffect(e9)
	-- Cannot Banish (Loyalty to controller)
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_SINGLE)
	e10:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e10:SetCode(EFFECT_CANNOT_REMOVE)
	e10:SetRange(LOCATION_FZONE)
	c:RegisterEffect(e10)
--token
local e11=Effect.CreateEffect(c)
e11:SetDescription(aux.Stringid(110,0))
e11:SetCategory(CATEGORY_SPECIAL_SUMMON)
e11:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
e11:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
e11:SetCode(EVENT_PHASE+PHASE_STANDBY)
e11:SetRange(LOCATION_FZONE)
e11:SetCountLimit(2)
e11:SetCondition(c335599009.spcon)
e11:SetTarget(c335599009.sptg)
e11:SetOperation(c335599009.spop)
c:RegisterEffect(e11)
	end
function c335599009.destg(e,c)
	return c==Duel.GetFieldCard(c:GetControler(),LOCATION_SZONE,5)
end
function c335599009.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local cp=Duel.GetTurnPlayer()
	Duel.SetTargetPlayer(cp)
	Duel.SetTargetParam(1000)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,cp,1000)
end
function c335599009.damop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c335599009.spfilter(c)
return c:IsCode(22222209)
end
function c335599009.spcon(e,tp,eg,ep,ev,re,r,rp)
if Duel.IsExistingMatchingCard(c335599009.spfilter,tp,LOCATION_MZONE,0,2,nil) then return false
else return true end
end
function c335599009.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,2,0,0)
Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
end
function c335599009.spop(e,tp,eg,ep,ev,re,r,rp)
if not e:GetHandler():IsRelateToEffect(e) then return end
if Duel.GetLocationCount(tp,LOCATION_MZONE)> 0
and Duel.IsPlayerCanSpecialSummonMonster(tp,22222209,0,0x4011,500,500,1,RACE_AQUA,ATTRIBUTE_WATER) then
local token=Duel.CreateToken(tp,22222209)
Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP_ATTACK)
end
end
----Activate
function c335599009.cost(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
local c=e:GetHandler()
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_IMMUNE_EFFECT)
e1:SetValue(c335599009.imfilter)
e1:SetReset(RESET_CHAIN)
Duel.RegisterEffect(e1,tp)
end
function c335599009.imfilter(e,re)
return re:IsActiveType(TYPE_SPELL+TYPE_TRAP) and re:GetOwner()~=e:GetOwner()
end
----Immune
function c335599009.efilter(e,te)
return te:GetOwner()~=e:GetOwner() and te:IsActiveType(TYPE_SPELL+TYPE_TRAP)
end
function c335599009.damval(e,re,val,r,rp,rc)
	if bit.band(r,REASON_EFFECT)~=0 then return 0 end
	return val
end