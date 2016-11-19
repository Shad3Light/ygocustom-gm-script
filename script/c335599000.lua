--No Face No draw
function c335599000.initial_effect(c)
	--control
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(335599000,0))
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c335599000.ctltg)
	e1:SetOperation(c335599000.ctlop)
	c:RegisterEffect(e1)
	--cannot release
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UNRELEASABLE_SUM)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UNRELEASABLE_NONSUM)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e4:SetValue(1)
	c:RegisterEffect(e4)
	--Summon Cannot be Negated
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_CANNOT_DISABLE_SUMMON)
	e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(e5)
	-- Cannot Disable effect
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e6:SetCode(EFFECT_CANNOT_DISABLE)
	e6:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e6)
	--Skip Draw Phase
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_FIELD)
	e7:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e7:SetRange(LOCATION_MZONE)
	e7:SetTargetRange(1,0)
	e7:SetCode(EFFECT_SKIP_DP)
	c:RegisterEffect(e7)
	--selfdes
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e8:SetRange(LOCATION_MZONE)
	e8:SetCode(EVENT_DAMAGE)
	e8:SetOperation(c335599000.dmop)
	c:RegisterEffect(e8)
	local e9=Effect.CreateEffect(c)
	e9:SetDescription(aux.Stringid(335599000,0))
	e9:SetCategory(CATEGORY_DESTROY)
	e9:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e9:SetCode(EVENT_BATTLED)
	e9:SetRange(LOCATION_MZONE)
	e9:SetCondition(c335599000.descon)
	e9:SetTarget(c335599000.destg)
	e9:SetOperation(c335599000.desop)
	c:RegisterEffect(e9)
	local e10=Effect.CreateEffect(c)
	e10:SetDescription(aux.Stringid(335599000,0))
	e10:SetCategory(CATEGORY_DESTROY)
	e10:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e10:SetCode(EVENT_BATTLED)
	e10:SetRange(LOCATION_MZONE)
	e10:SetCondition(c335599000.descon2)
	e10:SetTarget(c335599000.destg)
	e10:SetOperation(c335599000.desop)
	c:RegisterEffect(e10)
	local e11=Effect.CreateEffect(c)
	e11:SetDescription(aux.Stringid(335599000,0))
	e11:SetCategory(CATEGORY_DESTROY)
	e11:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e11:SetRange(LOCATION_MZONE)
	e11:SetCode(EVENT_DAMAGE)
	e11:SetCondition(c335599000.descon3)
	e11:SetTarget(c335599000.destg)
	e11:SetOperation(c335599000.desop)
	c:RegisterEffect(e11)
	end
function c335599000.ctltg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,e:GetHandler(),1,0,0)
end
function c335599000.ctlop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	if not Duel.GetControl(c,1-tp) and not c:IsImmuneToEffect(e) and c:IsAbleToChangeControler() then
		Duel.Destroy(c,REASON_EFFECT)
	end
end
function c335599000.dmop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetControler()~=ep then return end
	if bit.band(r,REASON_BATTLE)~=0 then
		c:RegisterFlagEffect(335599000,RESET_PHASE+PHASE_DAMAGE,0,1)
	elseif Duel.GetCurrentPhase()==PHASE_DAMAGE and not Duel.IsDamageCalculated() then
		c:RegisterFlagEffect(11662743,RESET_PHASE+PHASE_DAMAGE,0,1)
	end
end
function c335599000.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(335599000)>0
end
function c335599000.descon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(11662743)>0
end
function c335599000.descon3(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_EFFECT)~=0 and e:GetHandler():GetControler()==ep
		and (Duel.GetCurrentPhase()~=PHASE_DAMAGE or Duel.IsDamageCalculated())
end
function c335599000.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c335599000.desop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.Destroy(e:GetHandler(),REASON_EFFECT)
	end
end