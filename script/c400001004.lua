--Orichalcos Tritos
function c400001004.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCondition(c400001004.atcon)
	e1:SetTarget(c400001004.acttg)
	e1:SetOperation(c400001004.sdop)
	c:RegisterEffect(e1)
	--immune
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_SET_AVAILABLE)
	e3:SetCode(EFFECT_IMMUNE_EFFECT)
	e3:SetRange(LOCATION_FZONE)
	e3:SetTargetRange(LOCATION_ONFIELD,0)
	e3:SetTarget(c400001004.etg)
	e3:SetValue(c400001004.efilter)
	c:RegisterEffect(e3)
end
function c400001004.atcon(e)
	local tc=Duel.GetFieldCard(e:GetHandler():GetControler(),LOCATION_SZONE,5)	
	return tc~=nil and tc:IsFaceup() and tc:GetCode()==110000100
end
function c400001004.acttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetChainLimit(aux.FALSE)
end
function c400001004.sdop(e,tp,eg,ep,ev,re,r,rp)	
	e:GetHandler():CopyEffect(400001002,RESET_EVENT+0x1fe0000)
	e:GetHandler():CopyEffect(400001003,RESET_EVENT+0x1fe0000)
end

function c400001004.etg(e,c)
	return c:IsType(TYPE_MONSTER)
end
function c400001004.efilter(e,te)
	return te:GetHandler():GetControler()~=e:GetHandler():GetControler()
end
