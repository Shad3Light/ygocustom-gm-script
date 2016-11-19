--White Veil (Anime)
function c400000025.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c400000025.target)
	e1:SetOperation(c400000025.operation)
	c:RegisterEffect(e1)	
	--Equip limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EQUIP_LIMIT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(1)
	c:RegisterEffect(e2)	
	--negate
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCategory(CATEGORY_NEGATE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetCondition(c400000025.descon)
	e3:SetOperation(c400000025.dsactivate)
	c:RegisterEffect(e3)	
	--destroy Spell&Traps
	local e5=e3:Clone()
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e5:SetCategory(CATEGORY_DESTROY)
	e5:SetTarget(c400000025.dstarget)
	e5:SetOperation(c400000025.dsactivate2)
	c:RegisterEffect(e5)
	--damage
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(511000024,0))
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCategory(CATEGORY_DAMAGE)
	e4:SetCode(EVENT_LEAVE_FIELD)
	e4:SetCondition(c400000025.damcon)
	e4:SetTarget(c400000025.damtg)
	e4:SetOperation(c400000025.damop)
	c:RegisterEffect(e4)
	
end
function c400000025.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c400000025.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end

function c400000025.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetEquipTarget()==Duel.GetAttacker()
end
function c400000025.aclimit(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c400000025.distg(e,c)
	return c~=e:GetHandler() and c:IsType(TYPE_TRAP+TYPE_SPELL)
end
function c400000025.dsfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsDestructable()
end
function c400000025.dstarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsOnField() and c400000025.dsfilter(chkc) end
	if chk==0 then return true end
	local sg=Duel.GetMatchingGroup(c400000025.dsfilter,tp,0,LOCATION_ONFIELD,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c400000025.dsactivate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(0,1)
	e1:SetValue(c400000025.aclimit)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
	--disable
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DISABLE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(0,LOCATION_ONFIELD)
	e2:SetTarget(c400000025.distg)
	e2:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e2,tp)
end
function c400000025.dsactivate2(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c400000025.dsfilter,tp,0,LOCATION_ONFIELD,e:GetHandler())
	Duel.Destroy(sg,REASON_EFFECT)
end

function c400000025.damcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ec=c:GetPreviousEquipTarget()
	if not ec then return end
	e:SetLabelObject(ec)
	e:SetLabel(ec:GetPreviousControler())
	return c:IsReason(REASON_LOST_TARGET) and ec:IsReason(REASON_DESTROY)
end
function c400000025.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local dam=e:GetLabelObject():GetAttack()
	if dam<0 then dam=0 end
	Duel.SetTargetPlayer(e:GetLabel())
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,e:GetLabel(),dam)
end
function c400000025.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end