--Konjiki Ashisogi Jizō
function c33559958.initial_effect(c)
	c:SetUniqueOnField(1,0,33559958)
	--atk destruction effect
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(33559958,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c33559958.regcon1)
	e1:SetOperation(c33559958.regop1)
	c:RegisterEffect(e1)
	--indes by battle
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--attack all
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_ATTACK_ALL)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--selfdes
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_ADJUST)
	e4:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_RANGE)
	e4:SetRange(0xff)
	e4:SetOperation(c33559958.operation)
	c:RegisterEffect(e4)
	-- Cannot Banish (Loyalty to controller)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetCode(EFFECT_CANNOT_REMOVE)
	e5:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e5)
	--Summon Cannot be Negated
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_CANNOT_DISABLE_SUMMON)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(e6)
	--cannot be target
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e7:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e7:SetRange(LOCATION_MZONE)
	e7:SetValue(c33559958.tgfilter)
	c:RegisterEffect(e7)
	--immune effect
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetCode(EFFECT_IMMUNE_EFFECT)
	e8:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e8:SetRange(LOCATION_MZONE)
	e8:SetValue(c33559958.efilter)
	c:RegisterEffect(e8)
	-- Cannot Disable effect
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_SINGLE)
	e10:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e10:SetCode(EFFECT_CANNOT_DISABLE)
	e10:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e10)
	--predraw return
	local e11=Effect.CreateEffect(c)
	e11:SetDescription(aux.Stringid(33559958,2))
	e11:SetCategory(CATEGORY_TOHAND)
	e11:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e11:SetCode(EVENT_PREDRAW)
	e11:SetRange(LOCATION_GRAVE)
	e11:SetCondition(c33559958.retcon)
	e11:SetTarget(c33559958.rettg)
	e11:SetOperation(c33559958.retop)
	c:RegisterEffect(e11)
	--special summon
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD)
	e12:SetCode(EFFECT_SPSUMMON_PROC)
	e12:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e12:SetRange(LOCATION_HAND+LOCATION_GRAVE+LOCATION_DECK)
	e12:SetCountLimit(1,82593758+EFFECT_COUNT_CODE_DUEL)
	e12:SetCondition(c33559958.spcon)
	c:RegisterEffect(e12)	
		--release limit
local e13=Effect.CreateEffect(c)
e13:SetType(EFFECT_TYPE_SINGLE)
e13:SetCode(EFFECT_UNRELEASABLE_SUM)
e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e13:SetRange(LOCATION_MZONE)
e13:SetValue(c33559958.recon)
c:RegisterEffect(e13)
local e14=e13:Clone()
e14:SetCondition(c33559958.recon2)
e14:SetCode(EFFECT_UNRELEASABLE_NONSUM)
c:RegisterEffect(e14)
--kojiki ashisohi jizo poision/paralasis
	local e15=Effect.CreateEffect(c)
	e15:SetDescription(aux.Stringid(33559958,0))
	e15:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e15:SetCode(EVENT_ATTACK_ANNOUNCE)
	e15:SetCondition(c33559958.condition)
	e15:SetTarget(c33559958.target)
	e15:SetOperation(c33559958.operation2)
	c:RegisterEffect(e15)
	--indes
	local e16=Effect.CreateEffect(c)
	e16:SetType(EFFECT_TYPE_SINGLE)
	e16:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e16:SetCondition(c33559958.effcon5)
	e16:SetValue(1)
	c:RegisterEffect(e16)
	--dam
	local e17=Effect.CreateEffect(c)
	e17:SetType(EFFECT_TYPE_SINGLE)
	e17:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e17:SetCondition(c33559958.effcon5)
	e17:SetValue(1)
	c:RegisterEffect(e17)
	--immune effect
	local e18=Effect.CreateEffect(c)
	e18:SetType(EFFECT_TYPE_SINGLE)
	e18:SetCode(EFFECT_IMMUNE_EFFECT)
	e18:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e18:SetRange(LOCATION_MZONE)
	e18:SetCondition(c33559958.effcon5)
	e18:SetValue(c33559958.efilterx)
	c:RegisterEffect(e18)
end
function c33559958.target(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return not e:GetHandler():IsStatus(STATUS_CHAINING) end
Duel.SetOperationInfo(0,CATEGORY_DESTROY,0,0,ep,1)
end
function c33559958.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()	
	if c:GetControler()~=c:GetOwner() then
		Duel.Destroy(c,REASON_EFFECT)
	end
end
function c33559958.regcon1(e,tp,eg,ep,ev,re,r,rp)
	return (e:GetHandler()==Duel.GetAttacker() and Duel.GetAttackTarget()~=nil) or e:GetHandler()==Duel.GetAttackTarget()
end
function c33559958.regop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_NO_BATTLE_DAMAGE)
		e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
		e2:SetValue(1)
		c:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e3:SetCode(EVENT_BATTLED)
		e3:SetOperation(c33559958.desop1)
		e3:SetReset(RESET_PHASE+PHASE_DAMAGE)
		Duel.RegisterEffect(e3,tp)
	end
end
function c33559958.desop1(e,tp,eg,ep,ev,re,r,rp)
	local tg=e:GetOwner():GetBattleTarget()
	if tg then
		Duel.Destroy(tg,REASON_EFFECT)
	end
end
function c33559958.efilter(e,te)
	return te:IsActiveType(TYPE_EFFECT) and te:GetOwner()~=e:GetOwner()
end
function c33559958.tgfilter(e,re)
	if not re or not re:IsActiveType(TYPE_SPELL+TYPE_TRAP) then return false end
	return re:IsHasCategory(CATEGORY_TOHAND+CATEGORY_DESTROY+CATEGORY_REMOVE+CATEGORY_TODECK+CATEGORY_RELEASE+CATEGORY_TOGRAVE)
end
function c33559958.retcon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer() and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0
		and Duel.GetDrawCount(tp)>0
end
function c33559958.rettg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToHand() end
	local dt=Duel.GetDrawCount(tp)
	if dt~=0 then
		_replace_count=0
		_replace_max=dt
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EFFECT_DRAW_COUNT)
		e1:SetTargetRange(1,0)
		e1:SetReset(RESET_PHASE+PHASE_DRAW)
		e1:SetValue(0)
		Duel.RegisterEffect(e1,tp)
	end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c33559958.retop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	_replace_count=_replace_count+1
	if _replace_count<=_replace_max and c:IsRelateToEffect(e) then
		Duel.SendtoHand(c,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,c)
	end
end
function c33559958.spcon(e,c)
	if c==nil then return true end
	return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_MZONE,0)==0
		and	Duel.GetFieldGroupCount(c:GetControler(),0,LOCATION_MZONE)>0
		and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c33559958.recon(e,c)
	return c:GetControler()~=e:GetHandler():GetControler()
end
function c33559958.recon2(e)
	return Duel.GetTurnPlayer()~=e:GetOwnerPlayer()
end
function c33559958.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttackTarget()
	return tc and tc:IsControler(1-tp)
end
function c33559958.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetAttackTarget()
	if chk==0 then return true end
	Duel.SetTargetCard(tc)
end
function c33559958.operation2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetAttackTarget()
	if not tc or tc:IsControler(tp) or not tc:IsRelateToEffect(e) then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN,2)
	tc:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetLabel(0)
	e2:SetCondition(c33559958.descon)
	e2:SetOperation(c33559958.desop)
	e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN,2)
	tc:RegisterEffect(e2)
	tc:RegisterFlagEffect(33559958,RESET_EVENT+0x1fe0000,0,0)
end

function c33559958.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=e:GetOwner():GetControler()
end
function c33559958.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=e:GetLabel()
	ct=ct+1
	Duel.HintSelection(Group.FromCards(c))
	e:GetOwner():SetTurnCounter(ct)
	e:SetLabel(ct)
	if ct==2 then
		c:ResetFlagEffect(33559958)
		Duel.Destroy(c,REASON_EFFECT)
	end
end


function c33559958.efilter2(c)
	return c:IsFaceup() and c:GetFlagEffect(33559958)>0
end
function c33559958.effcon5(e)
	return Duel.IsExistingMatchingCard(c33559958.efilter2,e:GetOwnerPlayer(),LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function c33559958.efilterx(e,te)
	if not te then return false end
	return te:IsHasCategory(CATEGORY_TOHAND+CATEGORY_DESTROY+CATEGORY_REMOVE+CATEGORY_TODECK+CATEGORY_RELEASE+CATEGORY_TOGRAVE)
end
