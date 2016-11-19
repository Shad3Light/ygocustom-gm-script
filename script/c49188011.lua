--Armor of Holy Arms
--Part of St. Joan Take 2 Project by Amaroq
--Attempts to activate even when no equip spells are in grave
function c49188011.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c49188011.target)
	e1:SetOperation(c49188011.operation)
	c:RegisterEffect(e1)
	--Equip limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EQUIP_LIMIT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(c49188011.eqlimit)
	c:RegisterEffect(e2)
	--Cannot be destroyed by card effects
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e3:SetCountLimit(1)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--Cannot be tributed
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_EQUIP)
	e4:SetCode(EFFECT_UNRELEASABLE_SUM)
	e4:SetValue(1)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_UNRELEASABLE_NONSUM)
	--Armades
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_EQUIP+EFFECT_TYPE_CONTINUOUS)
	e6:SetCode(EVENT_ATTACK_ANNOUNCE)
	e6:SetOperation(c49188011.atkop)
	c:RegisterEffect(e6)
	--Equip
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(49188011,0))
	e7:SetCategory(CATEGORY_EQUIP)
	e7:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e7:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e7:SetCode(EVENT_TO_GRAVE)
	e7:SetTarget(c49188011.eqtg)
	e7:SetOperation(c49188011.eqop)
	c:RegisterEffect(e7)
end
function c49188011.eqlimit(e,c)
	return c:IsCode(21175632)
end
function c49188011.filter(c)
	return c:IsFaceup() and c:IsCode(21175632)
end
function c49188011.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c49188011.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c49188011.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c49188011.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c49188011.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end
function c49188011.atkop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(0,1)
	e1:SetValue(c49188011.aclimit)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
end
function c49188011.aclimit(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
--Grave Effect
function c49188011.filter2(c,e,tp)
	return c:IsCode(21175632)
end
function c49188011.eqtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c49188011.filter2(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c49188011.filter2,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c49188011.filter2,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,g,1,0,0)
end
function c49188011.eqfilter(c,tc,tp)
	return c:IsType(TYPE_EQUIP) and c:IsSetCard(0xEF1) and not c:IsCode(49188011)
	and c:CheckEquipTarget(tc) and c:CheckUniqueOnField(tp)
end
function c49188011.eqop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	local tg=Duel.GetMatchingGroup(c49188011.eqfilter,tp,LOCATION_GRAVE,0,nil,tc,tp)
	if tc:IsRelateToEffect(e) and tg:GetCount()>0 and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
		local sg=tg:Select(tp,1,1,nil)
		Duel.Equip(tp,sg:GetFirst(),tc,true)
	end
end