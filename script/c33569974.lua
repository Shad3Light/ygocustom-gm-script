--Proctector From Beyond
--scripted by GameMaster (GM)
function c33569974.initial_effect(c)
--removed
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_REMOVE)
	e1:SetOperation(c33569974.rmop)
	c:RegisterEffect(e1)
	--draw 2
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(33569974,0))
	e2:SetCategory(CATEGORY_TO_HAND)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetRange(LOCATION_REMOVED)
	e2:SetCondition(c33569974.condition)
	e2:SetTarget(c33569974.target)
	e2:SetOperation(c33569974.operation)
	c:RegisterEffect(e2)
end
function c33569974.rmop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsFacedown() then return end
	if tp==Duel.GetTurnPlayer() then
		e:GetHandler():RegisterFlagEffect(33569974,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,3)
	else
		e:GetHandler():RegisterFlagEffect(33569974,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,2)
	end
end
function c33569974.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:GetTurnID()~=Duel.GetTurnCount() and tp==Duel.GetTurnPlayer() and e:GetHandler():GetFlagEffect(33569974)~=0
end
function c33569974.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(33569974)~=0 end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,tp,LOCATION_REMOVED)
	e:GetHandler():RegisterFlagEffect(33569974,RESET_PHASE+PHASE_STANDBY,0,1)
end
function c33569974.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SendtoHand(c,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,c)
		if Duel.IsPlayerCanDraw(tp,2) then
			Duel.Draw(tp,2,REASON_EFFECT)
			end
	end
end
