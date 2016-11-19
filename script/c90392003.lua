--Deathbringer The Living Sword from another Dimension
function c90392003.initial_effect(c)
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
	e4:SetDescription(aux.Stringid(90392003,0))
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetCategory(CATEGORY_EQUIP)
	e4:SetRange(LOCATION_HAND)
	e4:SetTarget(c90392003.eqtg)
	e4:SetOperation(c90392003.eqop)
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
	e5:SetValue(3000)
	c:RegisterEffect(e5)
	--Halve
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e6:SetCode(EVENT_ATTACK_ANNOUNCE)
	e6:SetRange(LOCATION_SZONE)
	e6:SetCondition(c90392003.atkcon)
	e6:SetTarget(c90392003.atktg)
	e6:SetOperation(c90392003.atkop)
	c:RegisterEffect(e6)
	--Banish
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_EQUIP)
	e7:SetCode(EFFECT_BATTLE_DESTROY_REDIRECT)
	e7:SetValue(LOCATION_REMOVED)
	c:RegisterEffect(e7)
	--Unaffected
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e8:SetCode(EFFECT_IMMUNE_EFFECT)
	e8:SetRange(LOCATION_SZONE)
	e8:SetCondition(c90392003.econ)
	e8:SetValue(c90392003.efilter)
	e8:SetOwnerPlayer(tp)
	c:RegisterEffect(e8)
end
function c90392003.filter(c)
	return c:IsFaceup() and c:IsCode(92216322)
end
function c90392003.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c90392003.filter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c90392003.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c90392003.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c90392003.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 or tc:IsFacedown() or not tc:IsRelateToEffect(e) or not tc:IsControler(tp) then
		Duel.SendtoGrave(c,REASON_EFFECT)
		return
	end
	Duel.Equip(tp,c,tc,true)
end
function c90392003.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ec=c:GetEquipTarget()
	return Duel.GetAttacker()==ec
end
function c90392003.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c90392003.atkop(e,tp,eg,ep,ev,re,r,rp)
	local lp=Duel.GetLP(1-tp)
	Duel.SetLP(1-tp,lp/2)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
		local atk=tc:GetAttack()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(math.ceil(atk/2))
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
function c90392003.econ(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ec=c:GetEquipTarget()
	return ec and ec:IsLocation(LOCATION_MZONE) and ec:IsFaceup() and not ec:IsStatus(STATUS_LEAVE_CONFIRMED)
end
function c90392003.efilter(e,te)
	return te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end