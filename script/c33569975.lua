--Cape of NO-Return
--scripted by GameMaster(GM)
function c33569975.initial_effect(c)
	c:SetUniqueOnField(1,1,33569975)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c33569975.target)
	e1:SetOperation(c33569975.operation)
	c:RegisterEffect(e1)
	--Monsters destroyed vanish from duel
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(33569975,1))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EVENT_BATTLED)
	e2:SetTarget(c33569975.rmtg)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c33569975.condition)
	e2:SetOperation(c33569975.rmop)
	c:RegisterEffect(e2)
	--Equip limit
    local e3=Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_SINGLE)
    e3:SetCode(EFFECT_EQUIP_LIMIT)
    e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
    e3:SetValue(c33569975.eqlimit)
    c:RegisterEffect(e3)
	-- Cannot Disable effect
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetCode(EFFECT_CANNOT_DISABLE)
	e4:SetRange(LOCATION_SZONE)
	c:RegisterEffect(e4)
	end
	
function c33569975.eqlimit(e,c)
	return c:IsCode(33569989)
end	
	
function c33569975.condition(e)
	local tc=e:GetHandler():GetEquipTarget()
return Duel.GetAttacker()==tc or Duel.GetAttackTarget()==tc
end	
	
function c33569975.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,e:GetLabelObject(),1,0,0)
end

function c33569975.filter(c)
	return c:IsFaceup() and c:IsCode(33569989)
end
	function c33569975.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c33569975.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c33569975.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c33569975.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c33569975.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end
	
function c33569975.rmop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler():GetEquipTarget()
	local bc=c:GetBattleTarget()
	if bc:IsRelateToBattle() and bc:IsAbleToRemove() then
	--redirect
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
	e1:SetValue(11,LOCATION_GRAVE)
	bc:RegisterEffect(e1)
	Duel.Remove(bc,POS_FACEUP,REASON_EFFECT)
	end
end

