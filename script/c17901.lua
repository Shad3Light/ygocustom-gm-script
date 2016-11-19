--
function c17901.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Control
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_CONTROL)
	e2:SetDescription(aux.Stringid(17901,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c17901.condition)
	e2:SetCost(c17901.cost)
	e2:SetTarget(c17901.target1)
	e2:SetOperation(c17901.operation1)
	c:RegisterEffect(e2)
	--Immune
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_IMMUNE)
	e3:SetDescription(aux.Stringid(17901,2))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c17901.condition)
	e3:SetCost(c17901.cost)
	e3:SetOperation(c17901.operation2)
	c:RegisterEffect(e3)
	--Banish
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_REMOVE)
	e4:SetDescription(aux.Stringid(17901,3))
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCondition(c17901.condition3)	
	e4:SetCost(c17901.cost)
	e4:SetTarget(c17901.target3)
	e4:SetOperation(c17901.operation3)
	c:RegisterEffect(e4)
end
function c17901.cfilter(e,c)
	return c:IsSetCard(0x91)
end
function c17901.dfilter(c)
	return c:IsAbleToRemoveAsCost()
end
function c17901.efilter(c,e,tp,eg,ep,ev,re,r,rp,chk)
	return c:IsSetCard(0x91) and c:IsAbleToRemoveAsCost() 
end
function c17901.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c17901.efilter,tp,LOCATION_HAND,0,2,nil)
end
function c17901.condition3(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c17901.efilter,tp,LOCATION_HAND,0,2,nil)
		and Duel.IsExistingMatchingCard(c17901.dfilter,tp,LOCATION_GRAVE,0,1,nil)
end
function c17901.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(17901)==0 end
	local g1=Duel.SelectMatchingCard(tp,c17901.efilter,tp,LOCATION_HAND,0,2,2,nil,e,tp)
	e:GetHandler():RegisterFlagEffect(17901,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.Remove(g1,POS_FACEUP,REASON_COST)
end
function c17901.target1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_ONFIELD) and chkc:IsControler(1-tp) and chkc:IsControlerCanBeChanged() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsControlerCanBeChanged,tp,0,LOCATION_ONFIELD,1,nil) end
	local g=Duel.SelectTarget(tp,Card.IsControlerCanBeChanged,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c17901.operation1(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler() then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_GCONTROL)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and not Duel.GetControl(tc,tp,PHASE_END,1) then
		if not tc:IsImmuneToEffect(e) and tc:IsAbleToChangeControler() then
			Duel.Destroy(tc,REASON_EFFECT)
		end
	end
end
function c17901.operation2(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler() then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_UNAFFECTED)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetTargetRange(LOCATION_ONFIELD,LOCATION_HAND,LOCATION_DECK,LOCATION_GRAVE)
	e1:SetTarget(c17901.cfilter)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetValue(c17901.nfilter)
	Duel.RegisterEffect(e1,tp)
end
function c17901.nfilter(e,re)
	return e:GetHandlerPlayer()~=re:GetHandlerPlayer() and re:IsActiveType(TYPE_SPELL+TYPE_TRAP+TYPE_MONSTER)
end
function c17901.target3(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsOnField() and chkc:IsControler(tp) and chkc:IsAbleToRemove() end
	if chk==0 then return Duel.IsPlayerCanDraw(tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOREMOVE)
	local g=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,LOCATION_GRAVE,0,1,ct,e:GetHandler())
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_TOREMOVE,nil,1,tp,LOCATION_GRAVE)
end
function c17901.operation3(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler() then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOREMOVE)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local g=Duel.GetMatchingGroup(c17901.dfilter,tp,LOCATION_GRAVE,0,nil)
	local h=Duel.GetMatchingGroup(c17901.efilter,tp,LOCATION_GRAVE,0,nil)
	if g:GetCount()==0 then return end
	Duel.Remove(g,h,nil,2,REASON_EFFECT)
	Duel.BreakEffect()
	Duel.Draw(p,h:GetCount(),REASON_EFFECT)
end