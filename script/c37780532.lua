--Earthshakers The Living Gauntlet from another Dimension
function c37780532.initial_effect(c)
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
	e4:SetDescription(aux.Stringid(37780532,0))
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetCategory(CATEGORY_EQUIP)
	e4:SetRange(LOCATION_HAND)
	e4:SetTarget(c37780532.eqtg)
	e4:SetOperation(c37780532.eqop)
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
	e5:SetValue(4500)
	c:RegisterEffect(e5)
	--No Damage
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD)
	e6:SetCode(EFFECT_CHANGE_DAMAGE)
	e6:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e6:SetRange(LOCATION_SZONE)
	e6:SetTargetRange(1,0)
	e6:SetCondition(c37780532.econ)
	e6:SetValue(c37780532.damval)
	c:RegisterEffect(e6)
	local e7=e6:Clone()
	e7:SetCode(EFFECT_NO_EFFECT_DAMAGE)
	c:RegisterEffect(e7)
	--Unaffected
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e8:SetCode(EFFECT_IMMUNE_EFFECT)
	e8:SetRange(LOCATION_SZONE)
	e8:SetCondition(c37780532.econ)
	e8:SetValue(c37780532.efilter)
	e8:SetOwnerPlayer(tp)
	c:RegisterEffect(e8)
	--Damage
	local e9=Effect.CreateEffect(c)
	e9:SetDescription(aux.Stringid(37780532,0))
	e9:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e9:SetRange(LOCATION_SZONE)
	e9:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e9:SetCode(EVENT_BATTLE_DESTROYING)
	e9:SetCountLimit(1)
	e9:SetCondition(c37780532.damcon)
	e9:SetTarget(c37780532.damtg)
	e9:SetOperation(c37780532.damop)
	c:RegisterEffect(e9)
end
function c37780532.filter(c)
	return c:IsFaceup() and c:IsCode(92216322)
end
function c37780532.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c37780532.filter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c37780532.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c37780532.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c37780532.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 or tc:IsFacedown() or not tc:IsRelateToEffect(e) or not tc:IsControler(tp) then
		Duel.SendtoGrave(c,REASON_EFFECT)
		return
	end
	Duel.Equip(tp,c,tc,true)
end
function c37780532.damval(e,re,val,r,rp,rc)
	if bit.band(r,REASON_EFFECT)~=0 then return 0 end
	return val
end
function c37780532.econ(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ec=c:GetEquipTarget()
	return ec and ec:IsLocation(LOCATION_MZONE) and ec:IsFaceup() and not ec:IsStatus(STATUS_LEAVE_CONFIRMED)
end
function c37780532.efilter(e,te)
	return te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
function c37780532.damcon(e,tp,eg,ep,ev,re,r,rp)
	local ec=eg:GetFirst()
	local bc=ec:GetBattleTarget()
	return ec==e:GetHandler():GetEquipTarget() and bc:IsReason(REASON_BATTLE)
end
function c37780532.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local ec=eg:GetFirst()
	local bc=ec:GetBattleTarget()
	local dam=bc:GetAttack()
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c37780532.damop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end