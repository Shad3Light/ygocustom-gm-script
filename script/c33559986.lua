--Jean Grey
function c33559986.initial_effect(c)
	--atkdown
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetDescription(aux.Stringid(33559986,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c33559986.condition)
	e1:SetCost(c33559986.cost)
	e1:SetTarget(c33559986.target)
	e1:SetOperation(c33559986.operation)
	c:RegisterEffect(e1)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e2)
	--atkup
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetValue(c33559986.value)
	c:RegisterEffect(e3)
end
function c33559986.condition(e,tp,eg,ep,ev,re,r,rp)
	local phase=Duel.GetCurrentPhase()
	if phase~=PHASE_DAMAGE or Duel.IsDamageCalculated() then return false end
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if a:IsControler(tp) then
		e:SetLabelObject(d)
		return a:IsFaceup() and a:IsRace(RACE_PSYCHO) and a:IsRelateToBattle() and d and d:IsFaceup() and d:IsRelateToBattle()
	else
		e:SetLabelObject(a)
		return d:IsFaceup() and d:IsRace(RACE_PSYCHO) and d:IsRelateToBattle() and a and a:IsFaceup() and a:IsRelateToBattle()
	end
end
function c33559986.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local bc=e:GetLabelObject()
	if chk==0 then return Duel.CheckLPCost(tp,100) and e:GetHandler():GetFlagEffect(33559986)==0
						and (bc:IsAttackAbove(100) or bc:IsDefenseAbove(100)) end
	local lp=Duel.GetLP(tp)-1
	local alp=100
	local maxpay=bc:GetAttack()
	local def=bc:GetDefense()
	if maxpay<def then maxpay=def end
	if maxpay<lp then lp=maxpay end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(33559986,1))
	if lp>=500 then alp=Duel.AnnounceNumber(tp,100,200,300,400,500)
	elseif lp>=400 then alp=Duel.AnnounceNumber(tp,100,200,300,400)
	elseif lp>=300 then alp=Duel.AnnounceNumber(tp,100,200,300)
	elseif lp>=200 then alp=Duel.AnnounceNumber(tp,100,200)
	end
	Duel.PayLPCost(tp,alp)
	e:SetLabel(-alp)
	e:GetHandler():RegisterFlagEffect(33559986,RESET_PHASE+PHASE_DAMAGE,0,1)
end
function c33559986.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tc=e:GetLabelObject()
	if chkc then return chkc==tc end
	if chk==0 then return tc:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tc)
end
function c33559986.operation(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetFirstTarget()
	local c=e:GetHandler()
	if not tc or not tc:IsRelateToEffect(e) or not tc:IsControler(1-tp) then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e1:SetValue(e:GetLabel())
	tc:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	tc:RegisterEffect(e2)
end
function c33559986.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_PSYCHO)
end
function c33559986.value(e,c)
	return Duel.GetMatchingGroupCount(c33559986.filter,0,LOCATION_MZONE,LOCATION_MZONE,nil)*600
end