	--RE Shadow Flare Dragon	
function c57335214.initial_effect(c)
		--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x3b),aux.NonTuner(Card.IsSetCard,0x3b),1)
		--negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(50954680,0))
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(3)
	e1:SetCondition(c57335214.condition)
	e1:SetTarget(c57335214.target)
	e1:SetOperation(c57335214.operation)
	c:RegisterEffect(e1)
		--atk
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE+LOCATION_GRAVE)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetValue(c57335214.atkval)
	c:RegisterEffect(e3)
		--Unaffected by Opponent Card Effects
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_IMMUNE_EFFECT)
	e4:SetValue(c57335214.unval)
	c:RegisterEffect(e4)
end
function c57335214.unval(e,te)
	return te:GetHandlerPlayer()~=e:GetHandlerPlayer()
end
function c57335214.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local rc=re:GetHandler()
	return re:IsActiveType(TYPE_MONSTER) and rc~=c and not c:IsStatus(STATUS_BATTLE_DESTROYED) and Duel.IsChainNegatable(ev)
end
function c57335214.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c57335214.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	local c=e:GetHandler()
	local rc=re:GetHandler()
	if rc:IsRelateToEffect(re) and Duel.Destroy(rc,REASON_EFFECT)~=0 and rc:GetBaseAttack()>=0
		and c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END)
		e1:SetValue(rc:GetBaseAttack())
		c:RegisterEffect(e1)
	end
end
function c57335214.atkfilter(c)
    return c:IsRace(RACE_DRAGON) and c:IsFaceup()
end
function c57335214.atkval(e,c)
    return Duel.GetMatchingGroupCount(c57335209.atkfilter,c:GetControler(),LOCATION_MZONE+LOCATION_GRAVE,0,c)*100
end