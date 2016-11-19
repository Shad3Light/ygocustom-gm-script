--Zalera
function c33559970.initial_effect(c)
 aux.EnablePendulumAttribute(c,false)
c:SetUniqueOnField(1,1,33559970)
--Activate
local e0=Effect.CreateEffect(c)
e0:SetType(EFFECT_TYPE_ACTIVATE)
e0:SetCode(EVENT_FREE_CHAIN)
e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
e0:SetCost(c33559970.cost)
c:RegisterEffect(e0)
--special summon
local e2=Effect.CreateEffect(c)
e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
e2:SetType(EFFECT_TYPE_QUICK_O)
e2:SetRange(LOCATION_PZONE)
e2:SetCode(EVENT_FREE_CHAIN)
e2:SetTarget(c33559970.sptg)
e2:SetOperation(c33559970.spop)
c:RegisterEffect(e2)
--Return
local e3=Effect.CreateEffect(c)
e3:SetType(EFFECT_TYPE_QUICK_O)
e3:SetCode(EVENT_FREE_CHAIN)
e3:SetRange(LOCATION_MZONE)
e3:SetTarget(c33559970.rtg)
e3:SetOperation(c33559970.rop)
c:RegisterEffect(e3)
end


--add procedure to Pendulum monster, also allows registeration of activation effect
function Auxiliary.EnablePendulumAttribute(c,reg)
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetCode(EFFECT_SPSUMMON_PROC_G)
    e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
    e1:SetRange(LOCATION_PZONE)
    e1:SetCountLimit(1,10000000)
    e1:SetCondition(Auxiliary.PendCondition())
    e1:SetOperation(Auxiliary.PendOperation())
    e1:SetValue(SUMMON_TYPE_PENDULUM)
    c:RegisterEffect(e1)
    --register by default
    if reg==nil or reg then
        local e2=Effect.CreateEffect(c)
        e2:SetDescription(1160)
        e2:SetType(EFFECT_TYPE_ACTIVATE)
        e2:SetCode(EVENT_FREE_CHAIN)
        e2:SetRange(LOCATION_HAND)
        c:RegisterEffect(e2)
    end
end

function c33559970.cost(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
local c=e:GetHandler()
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_IMMUNE_EFFECT)
e1:SetValue(c33559970.imfilter)
e1:SetReset(RESET_CHAIN)
Duel.RegisterEffect(e1,tp)
end
function c33559970.imfilter(e,re)
return re:IsActiveType(TYPE_SPELL+TYPE_TRAP) and re:GetOwner()~=e:GetOwner()
end
function c33559970.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) and not e:GetHandler():IsStatus(STATUS_CHAINING) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c33559970.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e2:SetValue(1)
		c:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_UNRELEASABLE_SUM)
		e3:SetValue(1)
		e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e3,true)
		local e4=e3:Clone()
		e4:SetCode(EFFECT_UNRELEASABLE_NONSUM)
		c:RegisterEffect(e4,true)
		local e6=Effect.CreateEffect(c)
		e6:SetType(EFFECT_TYPE_SINGLE)
		e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e6:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
		e6:SetValue(1)
		e6:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e6)
		local e7=Effect.CreateEffect(c)
		e7:SetType(EFFECT_TYPE_SINGLE)
		e7:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
		e7:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
		e7:SetValue(1)
		e7:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e7)
		local e8=Effect.CreateEffect(e:GetHandler())
		e8:SetType(EFFECT_TYPE_SINGLE)
		e8:SetCode(EFFECT_DISABLE)
		e8:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e8,true)
		local e9=Effect.CreateEffect(e:GetHandler())
		e9:SetType(EFFECT_TYPE_SINGLE)
		e9:SetCode(EFFECT_DISABLE_EFFECT)
		e9:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e9,true)
	end
end
function c33559970.rtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc1=Duel.GetFieldCard(e:GetHandlerPlayer(),LOCATION_SZONE,6)
	local tc2=Duel.GetFieldCard(e:GetHandlerPlayer(),LOCATION_SZONE,7)
	if chk==0 then return e:GetHandler():CheckActivateEffect(false,false,false)~=nil and (not tc1 or not tc2) 
		and not e:GetHandler():IsStatus(STATUS_CHAINING) end
end
function c33559970.rop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	local tpe=c:GetType()
	local te=c:GetActivateEffect()
	local tg=te:GetTarget()
	local co=te:GetCost()
	local op=te:GetOperation()
	e:SetCategory(te:GetCategory())
	e:SetProperty(te:GetProperty())
	Duel.ClearTargetCard()
	Duel.Hint(HINT_CARD,0,c:GetCode())
	c:CreateEffectRelation(te)
	if co then co(te,tp,eg,ep,ev,re,r,rp,1) end
	if tg then tg(te,tp,eg,ep,ev,re,r,rp,1) end
	Duel.BreakEffect()
	if op then op(te,tp,eg,ep,ev,re,r,rp) end
	c:ReleaseEffectRelation(te)
end
