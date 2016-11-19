--Bunillas' Radioactive Super Carrot Friend
function c33579902.initial_effect(c)
c:EnableCounterPermit(0x2000,LOCATION_GRAVE)  
  --Activate
    local e1=Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_EQUIP)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e1:SetTarget(c33579902.target)
    e1:SetOperation(c33579902.operation)
    c:RegisterEffect(e1)
    --Equip limit
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_SINGLE)
    e2:SetCode(EFFECT_EQUIP_LIMIT)
    e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
    e2:SetValue(c33579902.eqlimit)
    c:RegisterEffect(e2)
	-- Cannot Disable effect
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCode(EFFECT_CANNOT_DISABLE)
	e3:SetRange(LOCATION_SZONE)
	c:RegisterEffect(e3)
	--set turn counter
	local e4=Effect.CreateEffect(c)
    e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
    e4:SetCode(EVENT_PHASE+PHASE_END)
    e4:SetRange(LOCATION_SZONE)
    e4:SetCountLimit(1)
    e4:SetOperation(function (e) e:GetHandler():SetTurnCounter(e:GetHandler():GetTurnCounter()+1) end)
    c:RegisterEffect(e4)
	--destroy
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e5:SetCode(EVENT_PHASE+PHASE_END)
	e5:SetCountLimit(1)
	e5:SetRange(LOCATION_SZONE)
	e5:SetTarget(function (e) return e:GetHandler():GetTurnCounter()>=3 end)
	e5:SetOperation(c33579902.operation2)
	c:RegisterEffect(e5)
	c:SetTurnCounter(0)
	--Destroy
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e6:SetCode(EVENT_LEAVE_FIELD_P)
	e6:SetOperation(c33579902.checkop)
	c:RegisterEffect(e6)
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e7:SetCode(EVENT_LEAVE_FIELD)
	e7:SetOperation(c33579902.desop)
	e7:SetLabelObject(e6)
	c:RegisterEffect(e7)
	--Destroy2
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_EQUIP)
	e8:SetRange(LOCATION_SZONE)
	e8:SetCode(EVENT_LEAVE_FIELD)
	e8:SetCondition(c33579902.descon2)
	e8:SetOperation(c33579902.desop2)
	c:RegisterEffect(e8)
	--token-summon werebunny
	local e9=Effect.CreateEffect(c)
	e9:SetDescription(aux.Stringid(33579902,0))
	e9:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e9:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e9:SetCode(EVENT_LEAVE_FIELD)
	e9:SetTarget(c33579902.sptg3)
	e9:SetOperation(c33579902.spop3)	
	c:RegisterEffect(e9)
	--battle indestructable
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_EQUIP)
	e10:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e10:SetValue(1)
	c:RegisterEffect(e10)
	--battle dam 0
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_EQUIP)
	e11:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e11:SetValue(1)
	c:RegisterEffect(e11)
	--opponents monster lose atk/gain same atk lost
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e12:SetCode(EVENT_BATTLE_DAMAGE)
	e12:SetRange(LOCATION_SZONE)
	e12:SetCondition(c33579902.condition4)
	e12:SetOperation(c33579902.operation4)
	c:RegisterEffect(e12)
end




function c33579902.condition4(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	if not at then return false end
	if at:IsControler(tp) then at=Duel.GetAttacker() end
	return at and at:IsRelateToBattle() and not at:IsStatus(STATUS_BATTLE_DESTROYED)
end
function c33579902.operation4(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local at=Duel.GetAttackTarget()
	if at:IsControler(tp) then at=Duel.GetAttacker() end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_DEFENSE)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e1:SetValue(-ev)
	at:RegisterEffect(e1)
	if e:GetHandler():IsRelateToEffect(e) then
	local tc=e:GetHandler():GetEquipTarget(e)
	local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_UPDATE_ATTACK)
		e2:SetValue(ev)
		tc:RegisterEffect(e2)
	local e3=e2:Clone()
		e3:SetCode(EFFECT_UPDATE_DEFENSE)
		tc:RegisterEffect(e3)
end
end

function c33579902.spfilter(c)
return c:IsCode(22222200)
end
function c33579902.sptg3(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
and Duel.IsPlayerCanSpecialSummonMonster(tp,22222200,0,0x4011,500,100,2,RACE_SPELLCASTER,ATTRIBUTE_DARK) end
Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c33579902.spop3(e,tp,eg,ep,ev,re,r,rp)
if not Duel.IsPlayerCanSpecialSummonMonster(tp,22222200,0,0x4011,1200,0,4,RACE_INSECT,ATTRIBUTE_EARTH) then return end
	local token=Duel.CreateToken(tp,22222200)
	Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP_ATTACK)
	--counter permit
	local e0=Effect.CreateEffect(e:GetHandler())
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e0:SetCode(EFFECT_COUNTER_PERMIT+0x1)
	e0:SetRange(LOCATION_MZONE)
	token:RegisterEffect(e0)
	--atk up
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c33579902.atkval)
	token:RegisterEffect(e1)
	--add counter
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetDescription(aux.Stringid(33579902,0))
	e2:SetCategory(CATEGORY_COUNTER)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c33579902.target83)
	e2:SetOperation(c33579902.operation83)
	token:RegisterEffect(e2)
end

function c33579902.target83(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanAddCounter(0x1,1) end
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,nil,1,0,0)
end
function c33579902.operation83(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():AddCounter(0x1,1)
end

function c33579902.atkval(e,token)
	return token:GetCounter(0x1)*300
end	
	
	
function c33579902.checkop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsDisabled() then
		e:SetLabel(1)
	else e:SetLabel(0) end
end

function c33579902.desop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabelObject():GetLabel()~=0 then return end
	local tc=e:GetHandler():GetFirstCardTarget()
	if tc and tc:IsLocation(LOCATION_MZONE) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end

function c33579902.descon2(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetEquipTarget(e)
	Debug.Message("descon2")
	return tc and eg:IsContains(tc) and tc:IsReason(REASON_DESTROY)
end
function c33579902.desop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
	Debug.Message("desop2")
end

function c33579902.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local c=e:GetHandler()
end

function c33579902.operation2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local c=e:GetHandler()
	local ct=c:GetTurnCounter()
	if  ct==3 then
		Duel.Destroy(c,REASON_RULE)
		end
end


function c33579902.eqlimit(e,c)
	return c:IsCode(69380702)
end

function c33579902.filter(c)
	return c:IsCode(69380702)
end
	function c33579902.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c33579902.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c33579902.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c33579902.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c33579902.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) then
		Duel.Equip(tp,e:GetHandler(),tc) 
		local c=Duel.GetFirstTarget()
		c:SetCardTarget(tc)
	end
end	
