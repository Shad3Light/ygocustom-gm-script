--Arukenimon
function c33559985.initial_effect(c)
	c:SetUniqueOnField(1,1,33559985)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(33559985,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_DAMAGE_STEP_END)
	e1:SetCondition(c33559985.condition)
	e1:SetOperation(c33559985.operation1)
	c:RegisterEffect(e1)
	--token when attacked
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(33559985,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BE_BATTLE_TARGET)
	e2:SetTarget(c33559985.tg)
	e2:SetOperation(c33559985.operation2)
	c:RegisterEffect(e2)
	--indes
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--atkup4insects
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetValue(c33559985.value)
	c:RegisterEffect(e4)
	--atkup4destroyedinsect
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_BATTLED)
	e5:SetOperation(c33559985.atkop)
	c:RegisterEffect(e5)
	--Flymon at endturn
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(33559985,0))
	e6:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCode(EVENT_PHASE+PHASE_END)
	e6:SetCountLimit(1)
	e6:SetCondition(c33559985.spcon3)
	e6:SetTarget(c33559985.sptg3)
	e6:SetOperation(c33559985.spop3)
	c:RegisterEffect(e6)
	--target
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_FIELD)
	e7:SetRange(LOCATION_MZONE)
	e7:SetTargetRange(LOCATION_MZONE,0)
	e7:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e7:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e7:SetCondition(c33559985.con4)
	e7:SetTarget(c33559985.tglimit4)
	e7:SetValue(1)
	c:RegisterEffect(e7)
	-- Cannot Disable effect
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e8:SetCode(EFFECT_CANNOT_DISABLE)
	e8:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e8)
	--must attack
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_FIELD)
	e9:SetCode(EFFECT_MUST_ATTACK)
	e9:SetRange(LOCATION_MZONE)
	e9:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	c:RegisterEffect(e9)
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_FIELD)
	e10:SetCode(EFFECT_CANNOT_EP)
	e10:SetRange(LOCATION_MZONE)
	e10:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e10:SetTargetRange(0,1)
	e10:SetCondition(c33559985.becon5)
	c:RegisterEffect(e10)
	--special summon rule
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_FIELD)
	e11:SetCode(EFFECT_SPSUMMON_PROC)
	e11:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e11:SetRange(LOCATION_HAND)
	e11:SetCondition(c33559985.spcon)
	c:RegisterEffect(e11)
	--battle indes
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_SINGLE)
	e12:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e12:SetRange(LOCATION_MZONE)
	e12:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e12:SetCountLimit(4)
	e12:SetValue(c33559985.valcon)
	c:RegisterEffect(e12)
	--control
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_MZONE)
	e13:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
	c:RegisterEffect(e13)
end
function c33559985.cfilter(c)
	return c:IsFaceup() and c:IsCode(33559984)
end
function c33559985.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c33559985.cfilter,tp,LOCATION_ONFIELD,0,1,nil) 
end
function c33559985.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_INSECT)
end
function c33559985.value(e,c)
	return Duel.GetMatchingGroupCount(c33559985.filter,0,LOCATION_MZONE,LOCATION_MZONE,nil)*250
end
function c33559985.con4(e)
	return e:GetHandler():IsDefensePos()
end
function c33559985.tglimit4(e,c)
	return c~=e:GetHandler()
end
function c33559985.spcon3(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c33559985.sptg3(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c33559985.spop3(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,11111118,0,0x4011,200,200,1,RACE_MACHINE,ATTRIBUTE_EARTH) then return end
	local token=Duel.CreateToken(tp,11111118)
	Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP_ATTACK)
end
function c33559985.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,tp,0)
end
function c33559985.operation2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,11111117,0,0x4011,0,0,1,RACE_PLANT,ATTRIBUTE_EARTH,POS_FACEUP_DEFENSE,1-tp) then
		local token=Duel.CreateToken(tp,11111117)
		if Duel.SpecialSummonStep(token,0,tp,1-tp,false,false,POS_FACEUP_DEFENSE) then
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
			e2:SetCode(EVENT_DESTROY)
			e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e2:SetOperation(c33559985.damop)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			token:RegisterEffect(e2,true)
			local e3=Effect.CreateEffect(e:GetHandler())
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetCode(EFFECT_UNRELEASABLE_SUM)
			e3:SetReset(RESET_EVENT+0x1fe0000)
			e3:SetValue(1)
			token:RegisterEffect(e3,true)
			local e4=e3:Clone()
			e4:SetCode(EFFECT_UNRELEASABLE_NONSUM)
			token:RegisterEffect(e4,true)
		end
		Duel.SpecialSummonComplete()
	end
end
function c33559985.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Damage(tp,500,REASON_EFFECT)
end
function c33559985.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler()==Duel.GetAttackTarget() and not Duel.GetAttacker():IsRace(RACE_INSECT)
end
function c33559985.operation1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetAttacker()
	if tc:IsRelateToBattle() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetCountLimit(1)
		e1:SetRange(LOCATION_MZONE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetCondition(c33559985.descon)
		e1:SetOperation(c33559985.desop)
		e1:SetLabel(0)
		e1:SetOwnerPlayer(tp)
		tc:RegisterEffect(e1)
	end
end
function c33559985.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetOwnerPlayer()~=Duel.GetTurnPlayer()
end
function c33559985.desop(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetLabel()
	ct=ct+1
	e:SetLabel(ct)
	e:GetOwner():SetTurnCounter(ct)
	if ct==3 then
		Duel.Destroy(e:GetHandler(),REASON_EFFECT)
	end
end
function c33559985.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if bc and bc:IsStatus(STATUS_BATTLE_DESTROYED) and bc:IsRace(RACE_INSECT) then
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_SINGLE)
		e4:SetCode(EFFECT_UPDATE_ATTACK)
		e4:SetValue(500)
		e4:SetReset(RESET_EVENT+0x1ff0000)
		c:RegisterEffect(e4)
	end
end
function c33559985.becon5(e)
	return Duel.IsExistingMatchingCard(Card.IsAttackable,Duel.GetTurnPlayer(),LOCATION_MZONE,0,1,nil)
end
function c33559985.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE)~=0
end
