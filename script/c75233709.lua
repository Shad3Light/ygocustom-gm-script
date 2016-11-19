--Orbital Dragon
--Scripted by GameMaster (GM)
function c75233709.initial_effect(c)
	--Is blue eye wD on field
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_CODE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_IMMEDIATELY_APPLY)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(89631139)
	c:RegisterEffect(e1)
	--add to spell to hand
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c75233709.oppthtg)
	e2:SetOperation(c75233709.oppthop)
	e2:SetCondition(c75233709.con)
	c:RegisterEffect(e2)
end
	
function c75233709.con(e,tp)
    local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil) --the same
    return g:IsExists(Card.IsCode,1,nil,75233705) and g:IsExists(Card.IsCode,1,nil,75233706) and g:IsExists(Card.IsCode,1,nil,75233707)
end


function c75233709.oppthfilter(c)
return c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end
function c75233709.oppthtg(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.IsExistingMatchingCard(c75233709.oppthfilter,tp,LOCATION_DECK,0,1,nil) end
Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c75233709.oppthop(e,tp,eg,ep,ev,re,r,rp)
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
local sg=Duel.GetMatchingGroup(c75233709.oppthfilter,tp,LOCATION_DECK,0,nil)
Duel.ConfirmCards(tp,sg)
local g=sg:Select(tp,1,1,nil)
if g:GetCount()>0 then
Duel.SendtoHand(g,tp,nil,REASON_EFFECT)
Duel.ConfirmCards(1-tp,g)
end
end