--Itchy&scratchy
function c33559923.initial_effect(c)
	c:EnableReviveLimit()	
	--special summon rule
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c33559923.spcon)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetCondition(c33559923.sdescon)
	e2:SetOperation(c33559923.sdesop)
	c:RegisterEffect(e2)
	--direct attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_DIRECT_ATTACK)
	e3:SetCondition(c33559923.dircon)
	c:RegisterEffect(e3)
	--draw
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(33559923,0))
	e4:SetCategory(CATEGORY_DRAW)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_BATTLE_DAMAGE)
	e4:SetCondition(c33559923.condition)
	e4:SetTarget(c33559923.target)
	e4:SetOperation(c33559923.operation)
	c:RegisterEffect(e4)
end
function c33559923.cfilter(c)
	return c:IsFaceup() and c:IsCode(15259703)
end
function c33559923.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c33559923.cfilter,tp,LOCATION_ONFIELD,0,1,nil) 
end
function c33559923.sfilter(c)
	return c:IsReason(REASON_DESTROY) and c:IsPreviousPosition(POS_FACEUP) and c:GetPreviousCodeOnField()==15259703 and c:IsPreviousLocation(LOCATION_ONFIELD)
end
function c33559923.sdescon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c33559923.sfilter,1,nil)
end
function c33559923.sdesop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
function c33559923.dirfilter1(c)
	return c:IsFaceup() and c:IsCode(15259703)
end
function c33559923.dirfilter2(c)
	return c:IsFaceup() and c:IsType(TYPE_TOON)
end
function c33559923.dircon(e)
	return Duel.IsExistingMatchingCard(c33559923.dirfilter1,e:GetHandlerPlayer(),LOCATION_ONFIELD,0,1,nil)
		and not Duel.IsExistingMatchingCard(c33559923.dirfilter2,e:GetHandlerPlayer(),0,LOCATION_MZONE,1,nil)
end
function c33559923.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c33559923.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c33559923.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
