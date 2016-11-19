--Control Spire
function c33559994.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--spsummon monster from grave
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(33559994,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c33559994.sptg)
	e2:SetCost(c33559994.cost1)
	e2:SetOperation(c33559994.spop)
	c:RegisterEffect(e2)
	--destroy card on field
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(33559994,0))
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_IGNORE_IMMUNE)
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetCost(c33559994.cost2)
	e3:SetTarget(c33559994.destg)
	e3:SetOperation(c33559994.desop)
	c:RegisterEffect(e3)
	--immune
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_IMMUNE_EFFECT)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_SZONE)
	e4:SetValue(c33559994.efilter)
	c:RegisterEffect(e4)
	--extra summon
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetRange(LOCATION_SZONE)
	e5:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
	e5:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e5:SetTarget(aux.TargetBoolFunction(Card.IsType,0xff))
	c:RegisterEffect(e5)
	--atk down
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD)
	e6:SetCode(EFFECT_UPDATE_ATTACK)
	e6:SetRange(LOCATION_SZONE)
	e6:SetTargetRange(0,LOCATION_MZONE)
	e6:SetValue(c33559994.val)
	c:RegisterEffect(e6)
	--negate
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(60100231,0))
	e7:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e7:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e7:SetType(EFFECT_TYPE_QUICK_O)
	e7:SetRange(LOCATION_SZONE)
	e7:SetCountLimit(1)
	e7:SetCode(EVENT_CHAINING)
	e7:SetCondition(c33559994.discon)
	e7:SetTarget(c33559994.distg)
	e7:SetOperation(c33559994.disop)
	c:RegisterEffect(e7)
	--cost
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e8:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e8:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e8:SetRange(LOCATION_SZONE)
	e8:SetCountLimit(1)
	e8:SetCondition(c33559994.mtcon)
	e8:SetOperation(c33559994.mtop)
	c:RegisterEffect(e8)
end

function c33559994.mtcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c33559994.mtop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLP(tp)>1500 and Duel.SelectYesNo(tp,aux.Stringid(33559994,2)) then
		Duel.PayLPCost(tp,1500)
	else
		Duel.Destroy(e:GetHandler(),REASON_RULE)
	end
end

function c33559994.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,800)
	else Duel.PayLPCost(tp,800)	end
end

function c33559994.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,700)
	else Duel.PayLPCost(tp,700)	end
end

function c33559994.val(e,c)
	return c:GetLevel()*-100
end
function c33559994.discon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED)
		and ep~=tp and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev)
end
function c33559994.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c33559994.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
function c33559994.filter(c)
	return c:IsType(TYPE_MONSTER)
end
function c33559994.filter2(c)
	return c:IsType(TYPE_MONSTER+TYPE_SPELL+TYPE_TRAP)
end
----Activate
function c33559994.cost(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
local c=e:GetHandler()
local e4=Effect.CreateEffect(c)
e4:SetType(EFFECT_TYPE_SINGLE)
e4:SetCode(EFFECT_IMMUNE_EFFECT)
e4:SetValue(c33559994.imfilter)
e4:SetReset(RESET_CHAIN)
Duel.RegisterEffect(e4,tp)
end
function c33559994.imfilter(e,re)
return re:IsActiveType(TYPE_SPELL+TYPE_TRAP+TYPE_MONSTER) and re:GetOwner()~=e:GetOwner()
end
----Immune
function c33559994.efilter(e,te)
return te:GetOwner()~=e:GetOwner() and te:IsActiveType(TYPE_SPELL+TYPE_TRAP+TYPE_MONSTER)
end
function c33559994.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c33559994.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c33559994.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c33559994.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c33559994.spop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c33559994.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c33559994.filter2(chkc) and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingTarget(c33559994.filter2,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c33559994.filter2,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c33559994.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end