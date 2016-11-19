--Sun Sister M 
--scripted by GameMaster (GM)
function c75233705.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_LEAVE_FIELD)
	e1:SetCondition(c75233705.sdescon)
	e1:SetOperation(c75233705.sdesop)
	c:RegisterEffect(e1)
	--Hand visable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_PUBLIC)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,LOCATION_HAND)
	e2:SetCondition(c75233705.con2)
	c:RegisterEffect(e2)
	--atk UP
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetTarget(c75233705.tg)
	e3:SetValue(1000)
	e3:SetCondition(c75233705.con)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e4)
end

function c75233705.tg(e,c)
	return c:IsRace(RACE_FAIRY)
end

function c75233705.filter3(c)
	return c:IsFaceup() and c:GetCode(75233708)
end
function c75233705.con2(e)
		local tp=e:GetHandlerPlayer()
	return Duel.IsExistingMatchingCard(c75233705.filter3,tp,LOCATION_SZONE,0,1,nil)
end

function c75233705.con(e,tp)
    local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil) --the same
    return g:IsExists(Card.IsCode,1,nil,75233705) and g:IsExists(Card.IsCode,1,nil,75233706) and g:IsExists(Card.IsCode,1,nil,75233707)
end

function c75233705.sfilter(c)
	return c:IsReason(REASON_DESTROY) and c:IsPreviousPosition(POS_FACEUP) and c:GetPreviousCodeOnField()==75233708 and c:IsPreviousLocation(LOCATION_ONFIELD)
end
function c75233705.sdescon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c75233705.sfilter,1,nil)
end
function c75233705.sdesop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end