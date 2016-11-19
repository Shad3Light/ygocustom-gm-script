--Clear Prism Puppet
function c33559961.initial_effect(c)
	--control
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(33559961,0))
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCost(c33559961.cost)
	e1:SetTarget(c33559961.target)
	e1:SetOperation(c33559961.operation)
	c:RegisterEffect(e1)
end
function c33559961.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c33559961.filter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_DARK+ATTRIBUTE_LIGHT) and c:IsControlerCanBeChanged()
end
function c33559961.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c33559961.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c33559961.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c33559961.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c33559961.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsAttribute(ATTRIBUTE_DARK+ATTRIBUTE_LIGHT) then
		if not Duel.GetControl(tc,tp,PHASE_END,1) and not tc:IsImmuneToEffect(e) and tc:IsAbleToChangeControler() then
			Duel.Destroy(tc,REASON_EFFECT)
		end
	end
end
