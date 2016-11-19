--Gate Defender The Living Shield from another Dimension
function c23216174.initial_effect(c)
	c:EnableReviveLimit()
	--Cannot be Summoned/Set
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_FLIP_SUMMON)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e3)
	--Equip
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(23216174,0))
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetCategory(CATEGORY_EQUIP)
	e4:SetRange(LOCATION_HAND)
	e4:SetTarget(c23216174.eqtg)
	e4:SetOperation(c23216174.eqop)
	c:RegisterEffect(e4)
	local e4a=Effect.CreateEffect(c)
	e4a:SetType(EFFECT_TYPE_SINGLE)
	e4a:SetCode(EFFECT_EQUIP_LIMIT)
	e4a:SetValue(1)
	c:RegisterEffect(e4a)
	--Equip Effect
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_EQUIP)
	e5:SetCode(EFFECT_SET_DEFENSE)
	e5:SetValue(6500)
	c:RegisterEffect(e5)
	--Re-equip
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(23216174,1))
	e6:SetType(EFFECT_TYPE_QUICK_O)
	e6:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e6:SetCategory(CATEGORY_EQUIP)
	e6:SetCode(EVENT_FREE_CHAIN)
	e6:SetRange(LOCATION_SZONE)
	e6:SetCountLimit(1)
	e6:SetCondition(c23216174.eqcon)
	e6:SetTarget(c23216174.eqtg)
	e6:SetOperation(c23216174.eqop2)
	c:RegisterEffect(e6)
	--Unaffected
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e8:SetCode(EFFECT_IMMUNE_EFFECT)
	e8:SetRange(LOCATION_SZONE)
	e8:SetCondition(c23216174.econ)
	e8:SetValue(c23216174.efilter)
	e8:SetOwnerPlayer(tp)
	c:RegisterEffect(e8)
	--Cannot Leave
	local e9=Effect.CreateEffect(c)
	e9:SetDescription(aux.Stringid(23216174,2))
	e9:SetType(EFFECT_TYPE_EQUIP)
	e9:SetCode(EFFECT_CANNOT_REMOVE)
	e9:SetValue(1)
	c:RegisterEffect(e9)
	local e9a=e9:Clone()
	e9a:SetCode(EFFECT_CANNOT_TO_DECK)
	c:RegisterEffect(e9a)
	local e9b=e9:Clone()
	e9b:SetCode(EFFECT_CANNOT_TO_HAND)
	c:RegisterEffect(e9b)
	local e9c=e9:Clone()
	e9c:SetCode(EFFECT_CANNOT_TO_GRAVE)
	c:RegisterEffect(e9c)
end
function c23216174.filter(c)
	return c:IsFaceup() and c:IsCode(92216322)
end
function c23216174.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c23216174.filter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c23216174.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c23216174.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c23216174.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 or tc:IsFacedown() or not tc:IsRelateToEffect(e) or not tc:IsControler(tp) then
		Duel.SendtoGrave(c,REASON_EFFECT)
		return
	end
	Duel.Equip(tp,c,tc,true)
end
function c23216174.econ(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ec=c:GetEquipTarget()
	return ec and ec:IsLocation(LOCATION_MZONE) and ec:IsFaceup() and not ec:IsStatus(STATUS_LEAVE_CONFIRMED)
end
function c23216174.efilter(e,te)
	return te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
function c23216174.eqcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c23216174.eqop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 or tc:IsFacedown() or not tc:IsRelateToEffect(e) or not tc:IsControler(tp) then
		Duel.SendtoGrave(c,REASON_EFFECT)
		return
	end
	Duel.Equip(tp,c,tc,true)
	if tc:GetPosition()==POS_FACEUP_ATTACK then
		Duel.ChangePosition(tc,POS_FACEUP_DEFENSE)
	end
end