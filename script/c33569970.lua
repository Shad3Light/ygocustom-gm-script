--Hero Protection
--scripted by GameMaster (GM)
function c33569970.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c33569970.cost)
	c:RegisterEffect(e1)
	--cannot be target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_SELECT_EFFECT_TARGET)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IMMEDIATELY_APPLY)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(0,0xff)
	e2:SetValue(c33569970.etarget)
	c:RegisterEffect(e2)
	--indes
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e3:SetCountLimit(2)
	e3:SetValue(c33569970.valcon)
	c:RegisterEffect(e3)
	end
	
function c33569970.valcon(e,re,r,rp)
	return bit.band(r,REASON_EFFECT)~=0
end

	function c33569970.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000)
	else Duel.PayLPCost(tp,1000)	
	end
end

function c33569970.etarget(e,re,c)
	return c:IsFaceup() and c:IsControler(e:GetHandlerPlayer()) and c:IsLocation(LOCATION_MZONE) and c:IsSetCard(0x8)
end
