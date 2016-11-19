--unknown name monster
function c335599004.initial_effect(c)
	c:EnableCounterPermit(0x2000)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(33559900,2))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c335599004.atktg)
	e1:SetOperation(c335599004.atkop)
	c:RegisterEffect(e1)
	--add counter
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(335599004,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BATTLE_DESTROYING)
	e2:SetCondition(c335599004.condition)
	e2:SetOperation(c335599004.operation)
	c:RegisterEffect(e2)
	--attackup
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetValue(c335599004.attackup)
	c:RegisterEffect(e3)
	--equip
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(335599004,0))
	e4:SetCategory(CATEGORY_EQUIP)
	e4:SetCode(EVENT_BATTLE_DESTROYING)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCondition(c335599004.eqcon)
	e4:SetTarget(c335599004.eqtg)
	e4:SetOperation(c335599004.eqop)
	c:RegisterEffect(e4)
	--Gain lp
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(33559900,3))
	e5:SetCategory(CATEGORY_DESTROY+CATEGORY_RECOVER)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_MZONE)
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_PLAYER_TARGET)
	e5:SetCountLimit(1)
	e5:SetTarget(c335599004.rctg)
	e5:SetOperation(c335599004.rcop)
	c:RegisterEffect(e5)
end
function c335599004.atkupfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER)
end
function c335599004.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c335599004.atkupfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c335599004.atkupfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c335599004.atkupfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c335599004.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(500)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		tc:RegisterEffect(e2)
	end
end
function c335599004.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsRelateToBattle() and c:GetBattleTarget():IsType(TYPE_MONSTER)
end
function c335599004.operation(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():AddCounter(0x1000,1)
end
function c335599004.attackup(e,c)
	return c:GetCounter(0x1000)*300
end
function c335599004.eqcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetBattleTarget()
	e:SetLabelObject(tc)
	return aux.bdogcon(e,tp,eg,ep,ev,re,r,rp)
end
function c335599004.eqtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
	local tc=e:GetLabelObject()
	Duel.SetTargetCard(tc)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,tc,1,0,0)
end
function c335599004.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and c:IsFaceup() and tc:IsRelateToEffect(e) then
		if not Duel.Equip(tp,tc,c,false) then return end
		--Add Equip limit
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_COPY_INHERIT+EFFECT_FLAG_OWNER_RELATE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(c335599004.eqlimit)
		tc:RegisterEffect(e1)
	end
end
function c335599004.eqlimit(e,c)
	return e:GetOwner()==c
end

function c335599004.rcfil(c,eg)
  return eg and eg:IsContains(c) and c:IsDestructable()
end
function c335599004.rctg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
  local qg=e:GetHandler():GetEquipGroup()
  if chkc then return chkc:IsLocation(LOCATION_SZONE) and chkc:IsControler(tp) and qg and c335599004.rcfil(chkc,qg) end
  if chk==0 then return Duel.IsExistingTarget(c335599004.rcfil,tp,LOCATION_SZONE,0,1,nil,qg) end
  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
  local g=Duel.SelectTarget(tp,c335599004.rcfil,tp,LOCATION_SZONE,0,1,1,nil,qg)
  Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
  local rc=g:GetFirst():GetBaseAttack()
  Duel.SetTargetPlayer(tp)
  Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,rc)
end
function c335599004.rcop(e,tp,eg,ep,ev,re,r,rp)
  local tc=Duel.GetFirstTarget()
  if tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)>0 then
	local atk=tc:GetBaseAttack()
	Duel.Recover(tp,atk,REASON_EFFECT)
  end
end
