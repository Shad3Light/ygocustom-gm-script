--Piercing Thunder The Living Halberd from another Dimension
function c51597397.initial_effect(c)
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
	e4:SetDescription(aux.Stringid(51597397,0))
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetCategory(CATEGORY_EQUIP)
	e4:SetRange(LOCATION_HAND)
	e4:SetTarget(c51597397.eqtg)
	e4:SetOperation(c51597397.eqop)
	c:RegisterEffect(e4)
	local e4a=Effect.CreateEffect(c)
	e4a:SetType(EFFECT_TYPE_SINGLE)
	e4a:SetCode(EFFECT_EQUIP_LIMIT)
	e4a:SetValue(1)
	c:RegisterEffect(e4a)
	--Equip Effect
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_EQUIP)
	e5:SetCode(EFFECT_SET_ATTACK)
	e5:SetValue(2800)
	c:RegisterEffect(e5)
	--Extra Attack
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_EQUIP)
	e6:SetCode(EFFECT_EXTRA_ATTACK)
	e6:SetValue(1)
	c:RegisterEffect(e6)
	--pierce
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_EQUIP)
	e7:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e7)
	--Unaffected
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e8:SetCode(EFFECT_IMMUNE_EFFECT)
	e8:SetRange(LOCATION_SZONE)
	e8:SetCondition(c51597397.econ)
	e8:SetValue(c51597397.efilter)
	e8:SetOwnerPlayer(tp)
	c:RegisterEffect(e8)
	--Negate
	local e9=Effect.CreateEffect(c)
	e9:SetDescription(aux.Stringid(51597397,1))
	e9:SetType(EFFECT_TYPE_IGNITION)
	e9:SetRange(LOCATION_SZONE)
	e9:SetCountLimit(1)
	e9:SetTarget(c51597397.negtg)
	e9:SetOperation(c51597397.negop)
	c:RegisterEffect(e9)
end
function c51597397.filter(c)
	return c:IsFaceup() and c:IsCode(92216322)
end
function c51597397.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c51597397.filter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c51597397.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c51597397.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c51597397.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 or tc:IsFacedown() or not tc:IsRelateToEffect(e) or not tc:IsControler(tp) then
		Duel.SendtoGrave(c,REASON_EFFECT)
		return
	end
	Duel.Equip(tp,c,tc,true)
end
function c51597397.econ(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ec=c:GetEquipTarget()
	return ec and ec:IsLocation(LOCATION_MZONE) and ec:IsFaceup() and not ec:IsStatus(STATUS_LEAVE_CONFIRMED)
end
function c51597397.efilter(e,te)
	return te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
function c51597397.negfilter(c,ec)
	return c:IsType(TYPE_SPELL+TYPE_TRAP+TYPE_EFFECT) and c:IsFaceup() and c~=ec
end
function c51597397.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local ec=c:GetEquipTarget()
	if chk==0 then return Duel.IsExistingMatchingCard(c51597397.negfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,c,ec) end
end
function c51597397.negop(e,tp,eg,ep,ev,re,r,rp) 
	local c=e:GetHandler()
	local ec=c:GetEquipTarget()
	local g=Duel.GetMatchingGroup(c51597397.negfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,c,ec)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2)
		if tc:IsType(TYPE_TRAPMONSTER) then
			local e3=Effect.CreateEffect(c)
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetCode(EFFECT_DISABLE_TRAPMONSTER)
			e3:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e3)
		end
		tc=g:GetNext()
	end
end	