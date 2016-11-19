--Homunculus-GREED
function c335599101.initial_effect(c)
c:EnableCounterPermit(0x359)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(335599101,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)	
	e1:SetCategory(CATEGORY_DEFCHANGE)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c335599101.defcon)
	e1:SetOperation(c335599101.defop)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(335599101,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)	
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c335599101.atkcon)
	e2:SetOperation(c335599101.atkop)
	c:RegisterEffect(e2)
	--draw
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_DRAW)
	e3:SetRange(LOCATION_MZONE)
	e3:SetOperation(c335599101.addc)
	c:RegisterEffect(e3)
	--attackup
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetValue(c335599101.attackup)
	c:RegisterEffect(e4)
	--draw
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e5:SetCode(EVENT_CHAINING)
	e5:SetRange(LOCATION_MZONE)
	e5:SetOperation(c335599101.regop)
	c:RegisterEffect(e5)
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e6:SetCode(EVENT_CHAIN_SOLVING)
	e6:SetProperty(EFFECT_FLAG_DELAY)
	e6:SetRange(LOCATION_MZONE)
	e6:SetOperation(c335599101.drawop)
	c:RegisterEffect(e6)
	-- Cannot Banish (Loyalty to controller)
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e7:SetCode(EFFECT_CANNOT_REMOVE)
	e7:SetRange(LOCATION_ONFIELD)
	c:RegisterEffect(e7)
	--control
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_SINGLE)
	e9:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e9:SetRange(LOCATION_MZONE)
	e9:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
	c:RegisterEffect(e9)
	--battle/effect indes
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_SINGLE)
	e10:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e10:SetRange(LOCATION_MZONE)
	e10:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e10:SetCountLimit(2)
	e10:SetValue(c335599101.valcon)
	c:RegisterEffect(e10)
	-- Cannot Disable effect
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_SINGLE)
	e11:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e11:SetCode(EFFECT_CANNOT_DISABLE)
	e11:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e11)
	--draw 2 as normal draw
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD)
	e12:SetCode(EFFECT_DRAW_COUNT)
	e12:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e12:SetRange(LOCATION_MZONE)
	e12:SetCondition(c335599101.con)
	e12:SetTargetRange(1,0)
	e12:SetValue(2)
	c:RegisterEffect(e12)
	--to grave
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e13:SetCode(EVENT_TO_GRAVE)
	e13:SetOperation(c335599101.regop2)
	c:RegisterEffect(e13)
end
function c335599101.regop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsReason(REASON_DESTROY) and bit.band(c:GetPreviousLocation(),LOCATION_ONFIELD)~=0 then
		--spsummon
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(335599101,0))
		e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
		e1:SetRange(LOCATION_GRAVE)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetCost(c335599101.spcost)
		e1:SetTarget(c335599101.sptg)
		e1:SetOperation(c335599101.spop)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end

function c335599101.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:GetFlagEffect(335599101)==0 end
	c:RegisterFlagEffect(335599101,nil,0,1)
end

function c335599101.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end

function c335599101.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	 Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end



function c335599101.cfilter(c)
	return c:IsFaceup() and c:IsCode(335599101)
end
function c335599101.con(e)
		local tp=e:GetHandlerPlayer()
	return Duel.IsExistingMatchingCard(c335599101.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c335599101.defcon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c335599101.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c335599101.defop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_DEFENSE)
	e1:SetProperty(EFFECT_FLAG_COPY_INHERIT)
	e1:SetReset(RESET_EVENT+0x1ff0000)
	e1:SetValue(950)
	c:RegisterEffect(e1)
end
function c335599101.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetProperty(EFFECT_FLAG_COPY_INHERIT)
	e2:SetReset(RESET_EVENT+0x1ff0000)
	e2:SetValue(400)
	c:RegisterEffect(e2)
end
function c335599101.addc(e,tp,eg,ep,ev,re,r,rp)
	if ep==tp then
	ct=e:GetHandler():AddCounter(0x359,1)
	end
end
function c335599101.attackup(e,c)
	return c:GetCounter(0x359)*700
end
function c335599101.regop(e,tp,eg,ep,ev,re,r,rp)
	if re:GetHandler():IsCode(55144522) then
		e:GetHandler():RegisterFlagEffect(335599101,RESET_EVENT+0x1fe0000+RESET_CHAIN,0,2)
	end
end
function c335599101.drawop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():GetFlagEffect(335599101)~=0 and re:GetHandler():IsCode(55144522) then
		Duel.Draw(tp,2,REASON_EFFECT)
	end
end
function c335599101.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE+REASON_EFFECT)~=0
end

