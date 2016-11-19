--Hundred Year Soldier
--Part of St. Joan Take 2 Project by Amaroq
--
function c49188003.initial_effect(c)
	--To Hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(49188003,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetRange(LOCATION_MZONE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(2)
	e1:SetCost(c49188003.thcost)
	e1:SetTarget(c49188003.thtg)
	e1:SetOperation(c49188003.thop)
	c:RegisterEffect(e1)
	--Cannot Xyz
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
function c49188003.cfilter(c)
	return not c:IsStatus(STATUS_BATTLE_DESTROYED)
end
function c49188003.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c49188003.cfilter,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,c49188003.cfilter,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c49188003.filter(c)
	return (c:IsCode(57579381) or c:IsCode(84080938)) and c:IsAbleToHand()
end
function c49188003.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c49188003.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c49188003.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c49188003.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end