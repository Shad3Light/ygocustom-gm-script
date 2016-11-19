--ONI Capture Jar
function c33559947.initial_effect(c)
	--attach
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ADJUST)
	e1:SetRange(LOCATION_MZONE)	
	e1:SetOperation(c33559947.operation)
	c:RegisterEffect(e1)
	--detach
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHANGE_POS)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetOperation(c33559947.flipop)
	c:RegisterEffect(e2)
end
function c33559947.filter(c)
	return c:IsRace(RACE_FIEND) and c:IsFaceup() and not c:IsCode(50045299)
end
function c33559947.operation(e,tp,eg,ep,ev,re,r,rp)
	local wg=Duel.GetMatchingGroup(c33559947.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.Overlay(e:GetHandler(),wg)
end
function c33559947.flipop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local og=c:GetOverlayGroup()
	Duel.SendtoGrave(og,REASON_RULE)
end
