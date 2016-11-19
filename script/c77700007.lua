--Rain Force - Imagination
function c77700005.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x777),3,false)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetTarget(c77700005.atkdeffil)
	e1:SetValue(600)
	c:RegisterEffect(e1)
	--def
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e2)
	--immune
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(49032236,0))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c77700005.cost)
	e2:SetTarget(c77700005.target)
	e2:SetOperation(c77700005.operation)
	c:RegisterEffect(e2)
	--Add to hand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(77700005,1))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetCountLimit(1,77700005)
	e3:SetCondition(c77700005.setcon)
	e3:SetTarget(c77700005.settg)
	e3:SetOperation(c77700005.setop)
	c:RegisterEffect(e3)
	--negate
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(77700005,2))
	e4:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetRange(LOCATION_PZONE)
	e4:SetCode(EVENT_CHAINING)
	e4:SetCountLimit(1)
	e4:SetCost(c77700005.discost)
	e4:SetCondition(c77700005.discon)
	e4:SetTarget(c77700005.distg)
	e4:SetOperation(c77700005.disop)
	c:RegisterEffect(e4)
end
--Effect 1
function c77700005.atkdeffil(e,c)
	return c:IsType(TYPE_MONSTER) and c:GetLevel()==5 and c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WATER)
end
--Effect 2
function c77700005.costfil(c)
	return c:IsSetCard(0x777) and c:IsLocation(LOCATION_MZONE) and c:IsPosition(POS_FACEUP)
end
function c77700005.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroupEx(tp,c77700005.costfil,1,nil) end
	local g=Duel.SelectReleaseGroupEx(tp,c77700005.costfil,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c77700005.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c77700005.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_IMMUNE_EFFECT)
		e1:SetValue(c77700005.efilter)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
function c77700005.efilter(e,re)
	return true --e:GetHandler()~=re:GetOwner()
end
--Effect 3
function c77700005.setcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsLocation(LOCATION_EXTRA) and c:IsPosition(POS_FACEUP) and c:GetPreviousControler()==tp and c:IsPreviousLocation(LOCATION_ONFIELD)
end

function c77700005.cfilter(c)
	return c:IsSetCard(0x777) and c:IsType(TYPE_PENDULUM) and c:IsPosition(POS_FACEUP)
end
function c77700005.settg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return (chkc:IsLocation(LOCATION_GRAVE) or chkc:IsLocation(LOCATION_EXTRA)) and chkc:IsControler(tp) and chkc:IsAbleToHand() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToHand,tp,LOCATION_GRAVE+LOCATION_EXTRA,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,Card.IsAbleToHand,tp,LOCATION_GRAVE+LOCATION_EXTRA,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c77700005.setop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
--Effect 4
function c77700005.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroupEx(tp,c77700005.costfil,1,nil) end
	local g=Duel.SelectReleaseGroupEx(tp,c77700005.costfil,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c77700005.discon(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetHandler():GetOverlayGroup()
	return ep~=tp and Duel.IsChainNegatable(ev)
end
function c77700005.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsCanTurnSet() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c77700005.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	local rc=re:GetHandler()
	if rc:IsDestructable() then
		Duel.Destroy(rc,REASON_EFFECT)
	end
end
