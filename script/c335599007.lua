--Judicator, Angel of Negation
function c335599007.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(33559900,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetOperation(c335599007.attop)
	c:RegisterEffect(e1)
	--disable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e2:SetCode(EFFECT_DISABLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_SZONE,0,1)
	e2:SetTarget(c335599007.distg)
	c:RegisterEffect(e2)
	--disable effect
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_CHAIN_SOLVING)
	e3:SetRange(LOCATION_MZONE)
	e3:SetOperation(c335599007.disop)
	c:RegisterEffect(e3)
	--cannot set
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_CANNOT_MSET)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(0,1)
	e4:SetTarget(aux.TRUE)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_CANNOT_SSET)
	c:RegisterEffect(e5)
	local e6=e4:Clone()
	e6:SetCode(EFFECT_CANNOT_TURN_SET)
	c:RegisterEffect(e6)
	local e7=e4:Clone()
	e7:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e7:SetTarget(c335599007.sumlimit)
	c:RegisterEffect(e7)
	--Activate
	local e8=Effect.CreateEffect(c)
	e8:SetDescription(aux.Stringid(33559900,1))
	e8:SetType(EFFECT_TYPE_IGNITION)
	e8:SetRange(LOCATION_MZONE)
	e8:SetCountLimit(1)
	e8:SetOperation(c335599007.racop)
	c:RegisterEffect(e8)
	--indes
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_FIELD)
	e9:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e9:SetRange(LOCATION_ONFIELD)
	e9:SetTargetRange(LOCATION_MZONE,0)
	e9:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_CREATORGOD))
	e9:SetValue(c335599007.indval)
	c:RegisterEffect(e9)
	--immune monster effect
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_FIELD)
	e10:SetCode(EFFECT_IMMUNE_EFFECT)
	e10:SetRange(LOCATION_ONFIELD)
	e10:SetTargetRange(LOCATION_MZONE,0)
	e10:SetTarget(aux.TargetBoolFunction(Card.IsRace,0x200000))
	e10:SetValue(c335599007.efilter)
	c:RegisterEffect(e10)
end
function c335599007.efilter(e,te)
	return te:GetOwnerPlayer()~=e:GetHandlerPlayer() and te:IsActiveType(TYPE_MONSTER)
end
function c335599007.indval(e,c)
	return c:GetRace()~=RACE_CREATORGOD
end
function c335599007.racop(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,563)
	local rc=Duel.AnnounceRace(tp,1,0xffffff)
	e:GetLabelObject()
	e:GetHandler():SetHint(CHINT_RACE,rc)
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetProperty(EFFECT_FLAG_COPY_INHERIT)
	e8:SetCode(EFFECT_CHANGE_RACE)
	e8:SetValue(rc)
	e8:SetReset(RESET_EVENT+0x1ff0000)
	c:RegisterEffect(e8)
end
function c335599007.sumlimit(e,c,sump,sumtype,sumpos,targetp)
	return bit.band(sumpos,POS_FACEDOWN)>0
end
function c335599007.attop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		Duel.Hint(HINT_SELECTMSG,tp,562)
		local catt=c:GetAttribute()
		local att=Duel.AnnounceAttribute(tp,1,0xffff - catt)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_COPY_INHERIT)
		e1:SetCode(EFFECT_CHANGE_ATTRIBUTE)
		e1:SetValue(att)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		c:RegisterEffect(e1)
	end
end
function c335599007.distg(e,c)
	return c:IsType(TYPE_TRAP+TYPE_SPELL)
end
function c335599007.disop(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	if re:IsActiveType(TYPE_TRAP+TYPE_SPELL) and rc:IsOnField() then
		Duel.NegateEffect(ev)
		if rc:IsRelateToEffect(re) then
			rc=Duel.Destroy(eg,REASON_EFFECT)
		end
	end
end
