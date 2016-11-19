--Star Sister H
--scripted by GameMaster (GM)
function c75233706.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_LEAVE_FIELD)
	e1:SetCondition(c75233706.sdescon)
	e1:SetOperation(c75233706.sdesop)
	c:RegisterEffect(e1)
	--add to hand
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c75233706.oppthtg)
	e2:SetOperation(c75233706.oppthop)
	e2:SetCondition(c75233706.con)
	c:RegisterEffect(e2)
	--direct attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_DIRECT_ATTACK)
	e3:SetCondition(c75233706.dircon)
	c:RegisterEffect(e3)
end


function c75233706.con(e,tp)
    local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil) --the same
    return g:IsExists(Card.IsCode,1,nil,75233705) and g:IsExists(Card.IsCode,1,nil,75233706) and g:IsExists(Card.IsCode,1,nil,75233707)
end

function c75233706atkfilter(c)
	return c:IsFaceup() and c:IsCode(75233708)
end
function c75233706.dircon(e)
	return  Duel.IsExistingMatchingCard(c75233706atkfilter,e:GetHandlerPlayer(),LOCATION_SZONE,0,1,nil)
end

function c75233706.oppthfilter(c)
return c:IsAbleToHand()
end
function c75233706.oppthtg(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.IsExistingMatchingCard(c75233706.oppthfilter,tp,LOCATION_DECK,0,1,nil) end
Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c75233706.oppthop(e,tp,eg,ep,ev,re,r,rp)
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
local sg=Duel.GetMatchingGroup(c75233706.oppthfilter,tp,LOCATION_DECK,0,nil)
Duel.ConfirmCards(tp,sg)
local g=sg:Select(tp,1,1,nil)
if g:GetCount()>0 then
Duel.SendtoHand(g,tp,nil,REASON_EFFECT)
Duel.ConfirmCards(1-tp,g)
end
end

function c75233706.sfilter(c)
	return c:IsReason(REASON_DESTROY) and c:IsPreviousPosition(POS_FACEUP) and c:GetPreviousCodeOnField()==75233708 and c:IsPreviousLocation(LOCATION_ONFIELD)
end
function c75233706.sdescon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c75233706.sfilter,1,nil)
end
function c75233706.sdesop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end