--Gift from Naraku, Abis' Trident
--scripted by GameMaster(GM)
function c33569977.initial_effect(c)
	c:SetUniqueOnField(1,1,33569977)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c33569977.target)
	e1:SetOperation(c33569977.operation)
	c:RegisterEffect(e1)
	--Equip limit
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_SINGLE)
    e2:SetCode(EFFECT_EQUIP_LIMIT)
    e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(c33569977.eqlimit)
    e2:SetValue(1)
    c:RegisterEffect(e2)
	--Indes monster
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_INDESTRUCTABLE)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--no damage involving monster
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_EQUIP)
	e4:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e4:SetValue(1)
	c:RegisterEffect(e4)
	--cannot negate monster
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_EQUIP)
	e5:SetCode(EFFECT_CANNOT_DISABLE)
	e5:SetValue(1)
	c:RegisterEffect(e5)
	--cannot remove monster
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_EQUIP)
	e6:SetCode(EFFECT_CANNOT_REMOVE)
	e6:SetValue(1)
	c:RegisterEffect(e6)
	-- Cannot Banish eqip card
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e7:SetCode(EFFECT_CANNOT_REMOVE)
	e7:SetRange(LOCATION_SZONE)
	c:RegisterEffect(e7)
	-- Cannot Disable effect of equip
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e8:SetCode(EFFECT_CANNOT_DISABLE)
	e8:SetRange(LOCATION_SZONE)
	c:RegisterEffect(e8)
	--trident indestructable
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_SINGLE)
	e9:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e9:SetRange(LOCATION_SZONE)
	e9:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e9:SetValue(1)
	c:RegisterEffect(e9)
	--change target 
	local e10=Effect.CreateEffect(c)
	e10:SetDescription(aux.Stringid(33569977,0))
	e10:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e10:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e10:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetHintTiming(0,TIMING_BATTLE_START)
	e10:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e10:SetRange(LOCATION_SZONE)
	e10:SetCondition(c33569977.atkcon)
	e10:SetTarget(c33569977.atktg2)
	e10:SetOperation(c33569977.atkop)
	c:RegisterEffect(e10)
end

function c33569977.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer() and Duel.GetAttackTarget()~=nil
end
function c33569977.filter2(c,atg)
	return c:IsFaceup() and c:IsCode(33569981) and atg:IsContains(c)
end

function c33569977.atktg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local atg=Duel.GetAttacker():GetAttackableTarget()
	local at=Duel.GetAttackTarget()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc~=at and c33569977.filter2(chkc,atg) end
	if chk==0 then return Duel.IsExistingTarget(c33569977.filter2,tp,LOCATION_MZONE,0,1,at,atg) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c33569977.filter2,tp,LOCATION_MZONE,0,1,1,at,atg)
end
function c33569977.atkop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) and not Duel.GetAttacker():IsImmuneToEffect(e) then
		Duel.ChangeAttackTarget(tc)
	end
end

function c33569977.eqlimit(e,c)
	return c:IsCode(33569981)
end

	
function c33569977.filter(c)
	return c:IsFaceup() and c:IsCode(33569981)
end
function c33569977.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c33569977.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c33569977.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c33569977.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c33569977.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end