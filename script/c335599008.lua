--Holy Member- Elian
function c335599008.initial_effect(c)
	c:SetUniqueOnField(1,1,335599008)
	Duel.EnableGlobalFlag(GLOBALFLAG_DECK_REVERSE_CHECK)
	--Hand visable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_PUBLIC)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_HAND)
	c:RegisterEffect(e1)
   --add to hand
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c335599008.oppthtg)
	e2:SetOperation(c335599008.oppthop)
	c:RegisterEffect(e2)
	--Flip deck visable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_REVERSE_DECK)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,1)
	c:RegisterEffect(e3)
	-- Cannot Banish (Loyalty to controller)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetCode(EFFECT_CANNOT_REMOVE)
	e4:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e4)
	--control
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
	c:RegisterEffect(e5)
-- Cannot Disable effect
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e6:SetCode(EFFECT_CANNOT_DISABLE)
	e6:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e6)
	end
function c335599008.oppthfilter(c)
return c:IsAbleToHand()
end
function c335599008.oppthtg(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.IsExistingMatchingCard(c335599008.oppthfilter,tp,LOCATION_DECK,LOCATION_DECK,1,nil) end
Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c335599008.oppthop(e,tp,eg,ep,ev,re,r,rp)
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
local sg=Duel.GetMatchingGroup(c335599008.oppthfilter,tp,LOCATION_DECK,LOCATION_DECK,nil)
Duel.ConfirmCards(tp,sg)
local g=sg:Select(tp,1,1,nil)
if g:GetCount()>0 then
Duel.SendtoHand(g,tp,nil,REASON_EFFECT)
Duel.ConfirmCards(1-tp,g)
end
end
