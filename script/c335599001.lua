--Ruka, the enchantress
function c335599001.initial_effect(c)
	c:SetUniqueOnField(1,1,335599001)
	--draw 2 cards
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(45812361,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c335599001.condition)
	e1:SetCost(c335599001.cost)
	e1:SetTarget(c335599001.target)
	e1:SetOperation(c335599001.operation)
	e1:SetCountLimit(1)
	c:RegisterEffect(e1)
	--battle dam 0
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--cannot attack same turn summoned
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_ATTACK)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetTarget(c335599001.target1)
	c:RegisterEffect(e3)
		--negate attack
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(511000867,0))
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetRange(LOCATION_MZONE)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e4:SetCode(EVENT_ATTACK_ANNOUNCE)
	e4:SetLabel(0)
	e4:SetCondition(c335599001.condition1)
	e4:SetOperation(c335599001.activate)
	c:RegisterEffect(e4)
	--reset
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e5:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCountLimit(1)
	e5:SetCondition(c335599001.rescon)
	e5:SetOperation(c335599001.resop)
	e5:SetLabelObject(e4)
	c:RegisterEffect(e5)
	--recover
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(335599001,0))
	e6:SetCategory(CATEGORY_RECOVER)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e6:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e6:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCountLimit(1)
	e6:SetCondition(c335599001.condition2)
	e6:SetTarget(c335599001.target2)
	e6:SetOperation(c335599001.operation1)
	c:RegisterEffect(e6)
	-- Cannot Disable effect
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e7:SetCode(EFFECT_CANNOT_DISABLE)
	e7:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e7)
	-- Cannot Banish (Loyalty to controller)
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e8:SetCode(EFFECT_CANNOT_REMOVE)
	e8:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e8)
	--control
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_SINGLE)
	e9:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e9:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e9:SetRange(LOCATION_MZONE)
	e9:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
	c:RegisterEffect(e9)
	--prevent atk 1turn/pos
	local e10=Effect.CreateEffect(c)
	e10:SetDescription(aux.Stringid(33559997,6))
	e10:SetType(EFFECT_TYPE_IGNITION)
	e10:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e10:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e10:SetRange(LOCATION_MZONE)
	e10:SetCountLimit(2)
	e10:SetTarget(c335599001.target3)
	e10:SetOperation(c335599001.operation2)
	c:RegisterEffect(e10)
	--release limit
local e11=Effect.CreateEffect(c)
e11:SetType(EFFECT_TYPE_SINGLE)
e11:SetCode(EFFECT_UNRELEASABLE_SUM)
e11:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e11:SetRange(LOCATION_MZONE)
e11:SetValue(c335599001.recon)
c:RegisterEffect(e11)
local e12=e11:Clone()
e12:SetCondition(c335599001.recon2)
e12:SetCode(EFFECT_UNRELEASABLE_NONSUM)
c:RegisterEffect(e12)
--indes
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_MZONE)
	e13:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e13:SetValue(1)
	c:RegisterEffect(e13)
		--recover
	local e14=Effect.CreateEffect(c)
	e14:SetDescription(aux.Stringid(335599001,0))
	e14:SetCategory(CATEGORY_RECOVER)
	e14:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e14:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e14:SetRange(LOCATION_MZONE)
	e14:SetCountLimit(1)
	e14:SetCode(EVENT_PHASE+PHASE_DRAW)
	e14:SetCondition(c335599001.reccon)
	e14:SetTarget(c335599001.rectg)
	e14:SetOperation(c335599001.recop)
	c:RegisterEffect(e14)
	if not c335599001.global_check then
		c335599001.global_check=true
		c335599001[0]=0
		c335599001[1]=0
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_PAY_LPCOST)
		ge1:SetOperation(c335599001.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge14=Effect.CreateEffect(c)
		ge14:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge14:SetCode(EVENT_PHASE_START+PHASE_DRAW)
		ge14:SetOperation(c335599001.clear)
		Duel.RegisterEffect(ge14,0)
	end
end

function c335599001.target3(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(nil,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,nil,tp,0,LOCATION_MZONE,1,1,nil)
end
function c335599001.operation2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e)  then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,2)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,2)
		tc:RegisterEffect(e2)
	end
end


function c335599001.condition2(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c335599001.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(800)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,800)
end
function c335599001.operation1(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		Duel.Recover(p,d,REASON_EFFECT)
	end
end
function c335599001.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER)
end
function c335599001.condition1(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(c335599001.filter,tp,LOCATION_MZONE,0,nil)
	return not e:GetHandler():IsStatus(STATUS_CHAINING) and tp~=Duel.GetTurnPlayer() and ct>0 and e:GetLabel()<ct
end
function c335599001.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
	local ct=e:GetLabel()
	ct=ct+1
	e:SetLabel(ct)
end
function c335599001.rescon(e)
	return e:GetLabelObject():GetLabel()>0
end
function c335599001.resop(e,tp,eg,ep,ev,re,r,rp)
	e:GetLabelObject():SetLabel(0)
end

function c335599001.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(tp)>=4000
end
function c335599001.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.PayLPCost(tp,2000)
end
function c335599001.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,1,0,tp,2)
end
function c335599001.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function c335599001.target1(e,c)
	return c:IsStatus(STATUS_SUMMON_TURN+STATUS_FLIP_SUMMON_TURN+STATUS_SPSUMMON_TURN)
end
function c335599001.recon(e,c)
	return c:GetControler()~=e:GetHandler():GetControler()
end
function c335599001.recon2(e)
	return Duel.GetTurnPlayer()~=e:GetOwnerPlayer()
end

function c335599001.reccon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c335599001.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(c335599001[2]/2)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,c335599001[2]/2)
end
function c335599001.recop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Recover(p,d,REASON_EFFECT)
end

