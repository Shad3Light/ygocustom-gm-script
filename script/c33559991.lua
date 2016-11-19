--Piedmon
function c33559991.initial_effect(c)
c:SetUniqueOnField(1,0,33559991)
--Summon with 3 Tribute
	local e0=Effect.CreateEffect(c)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetCode(EFFECT_LIMIT_SUMMON_PROC)
	e0:SetCondition(c33559991.sumoncon)
	e0:SetOperation(c33559991.sumonop)
	e0:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e0)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_LIMIT_SET_PROC)
	e1:SetCondition(c33559991.setcon)
	c:RegisterEffect(e1)	
--remove
local e2=Effect.CreateEffect(c)
e2:SetDescription(aux.Stringid(33559991,0))
e2:SetCategory(CATEGORY_REMOVE)
e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
e2:SetCode(EVENT_FREE_CHAIN)
e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
e2:SetHintTiming(TIMING_BATTLE_PHASE)
e2:SetRange(LOCATION_MZONE)
e2:SetCondition(c33559991.rmcon1)
e2:SetTarget(c33559991.rmtg1)
e2:SetOperation(c33559991.rmop1)
c:RegisterEffect(e2)
--triple attack
local e3=Effect.CreateEffect(c)
e3:SetType(EFFECT_TYPE_SINGLE)
e3:SetCode(EFFECT_EXTRA_ATTACK)
e3:SetValue(3)
c:RegisterEffect(e3)
--half damage
local e4=Effect.CreateEffect(c)
e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
e4:SetRange(LOCATION_MZONE)
e4:SetCode(EVENT_PRE_BATTLE_DAMAGE)
e4:SetCondition(c33559991.dcon)
e4:SetOperation(c33559991.dop)
c:RegisterEffect(e4)
--cannot direct attack
local e5=Effect.CreateEffect(c)
e5:SetType(EFFECT_TYPE_SINGLE)
e5:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
c:RegisterEffect(e5)
--cannot special summon
local e6=Effect.CreateEffect(c)
e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SINGLE_RANGE)
e6:SetType(EFFECT_TYPE_SINGLE)
e6:SetRange(LOCATION_HAND)
e6:SetCode(EFFECT_SPSUMMON_CONDITION)
c:RegisterEffect(e6)
end
function c33559991.sumoncon(e,c)
if c==nil then return true end
return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-3 and Duel.GetTributeCount(c)>=3
end
function c33559991.sumonop(e,tp,eg,ep,ev,re,r,rp,c)
local g=Duel.SelectTribute(tp,c,3,3)
c:SetMaterial(g)
Duel.Release(g,REASON_SUMMON+REASON_MATERIAL)
end
function c33559991.setcon(e,c)
	if not c then return true end
	return false
end
function c33559991.dcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return ep~=tp and (c==Duel.GetAttacker() or c==Duel.GetAttackTarget())
end
function c33559991.dop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(ep,ev/2)
end
function c33559991.rmcon1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_BATTLE and not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c33559991.rmtg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if chk==0 then return bc and bc:IsOnField() and bc:IsCanBeEffectTarget(e) and c:IsAbleToRemove() and bc:IsAbleToRemove() end
	Duel.SetTargetCard(bc)
	local g=Group.FromCards(c,bc)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,2,0,0)
end
function c33559991.rmop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not c:IsRelateToEffect(e) or not tc:IsRelateToEffect(e) then return end
	local g=Group.FromCards(c,tc)
	local mcount=0
	if tc:IsFaceup() then mcount=tc:GetOverlayCount() end
	if Duel.Remove(g,0,REASON_EFFECT+REASON_TEMPORARY)~=0 then
		local og=Duel.GetOperatedGroup()
		if not og:IsContains(tc) then mcount=0 end
		local oc=og:GetFirst()
		while oc do
			oc:RegisterFlagEffect(33559991,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
			oc=og:GetNext()
		end
		og:KeepAlive()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_BATTLE)
		e1:SetReset(RESET_PHASE+PHASE_BATTLE)
		e1:SetLabel(mcount)
		e1:SetCountLimit(1)
		e1:SetLabelObject(og)
		e1:SetOperation(c33559991.retop)
		Duel.RegisterEffect(e1,tp)
	end
end
function c33559991.retfilter(c)
	return c:GetFlagEffect(33559991)~=0
end
function c33559991.retop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local sg=g:Filter(c33559991.retfilter,nil)
	g:DeleteGroup()
	local tc=sg:GetFirst()
	while tc do
		if Duel.ReturnToField(tc) and tc==e:GetOwner() and tc:IsFaceup() and e:GetLabel()~=0 then
			local e1=Effect.CreateEffect(e:GetOwner())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetReset(RESET_EVENT+0x1ff0000)
			e1:SetValue(e:GetLabel()*500)
			e:GetOwner():RegisterEffect(e1)
		end
		tc=sg:GetNext()
	end
end