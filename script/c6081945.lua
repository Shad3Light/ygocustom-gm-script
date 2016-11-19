--Redeeming Purge
function c6081945.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c6081945.condition)
	e1:SetTarget(c6081945.target)
	e1:SetOperation(c6081945.activate)
	c:RegisterEffect(e1)
	--Destroy on remove
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_DRAW)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCondition(c6081945.descon)
	e2:SetTarget(c6081945.destg)
	e2:SetOperation(c6081945.desop)
	c:RegisterEffect(e2)
end
function c6081945.condition(e,tp,eg,ep,ev,re,r,rp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsHasProperty(EFFECT_FLAG_PLAYER_TARGET)
end
function c6081945.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local te=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_EFFECT)
		local ftg=te:GetTarget()
		return ftg==nil or ftg(e,tp,eg,ep,ev,re,r,rp,chk)
	end
end
function c6081945.activate(e,tp,eg,ep,ev,re,r,rp)
	--tgp=(e:GetHandler():GetControler())
	Duel.NegateActivation(ev)
	if Duel.GetLocationCount(1-tp,LOCATION_SZONE)>0 then
		Duel.MoveToField(e:GetHandler(),tp,1-tp,LOCATION_SZONE,POS_FACEDOWN,false)
	end
end
function c6081945.descon(e,tp,eg,ep,ev,re,r,rp)
	Debug.Message("descon called")
	local c=e:GetHandler()
	if c==nil then return true end
	Debug.Message(c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsLocation(LOCATION_REMOVED) and c:IsPosition(POS_FACEDOWN))
	return c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsLocation(LOCATION_REMOVED) and c:IsPosition(POS_FACEDOWN)
end
function c6081945.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	Debug.Message("destg called")
	--tgp=1-(e:GetHandler():GetControler())
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c6081945.desop(e,tp,eg,ep,ev,re,r,rp)
	Debug.Message("desop called")
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	local g=Duel.GetMatchingGroup(aux.TRUE,p,0,LOCATION_ONFIELD,nil)
	Debug.Message("Chain Info:")
	Debug.Message(p)
	Debug.Message(d)
	Duel.Destroy(g,REASON_EFFECT)
	Duel.Draw(p,d,REASON_EFFECT)
end
