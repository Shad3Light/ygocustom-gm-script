--クリアー・ウォール
function c30000000.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--selfdes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_ADJUST)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c30000000.sdcon)
	e2:SetOperation(c30000000.sdop)
	c:RegisterEffect(e2)
	--battle indestructable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetTarget(c30000000.indtg)
	e3:SetValue(1)
	c:RegisterEffect(e3)	
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(30000000,0))
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCode(EVENT_DAMAGE)
	e4:SetCondition(c30000000.dscon)
	e4:SetTarget(c30000000.dstg)
	e4:SetOperation(c30000000.dsop)
	c:RegisterEffect(e4)
	--
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e5:SetCondition(c30000000.condition2)
	e5:SetOperation(c30000000.activate)
	c:RegisterEffect(e5)
end
function c30000000.desfilter(c)
	return c:IsFaceup() and c:IsCode(33900648)
end
function c30000000.check()
	return Duel.IsExistingMatchingCard(c30000000.desfilter,0,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
		or Duel.IsEnvironment(33900648)
end
function c30000000.sdcon(e)
	return not c30000000.check()
end
function c30000000.sdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
function c30000000.indtg(e,c)
	return c:IsSetCard(0x306) and c:GetBattlePosition()==POS_FACEUP_ATTACK
end
function c30000000.dscon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_BATTLE)>0 and ep==tp
end
function c30000000.dstg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c30000000.dsop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.Destroy(e:GetHandler(),REASON_EFFECT)
	end
end
function c30000000.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer() and Duel.GetAttackTarget()==nil
end
function c30000000.condition2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetBattleDamage(e:GetHandler():GetControler())<=1000
end
function c30000000.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(e:GetHandler():GetControler(),0)
end