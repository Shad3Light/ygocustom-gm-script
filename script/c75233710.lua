--SisterHood Bond
--scripted by GameMaster(GM)
function c75233710.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c75233710.target)
	e1:SetOperation(c75233710.activate)
	c:RegisterEffect(e1)
end

function c75233710.filter2(c,mc)
    return c:GetCode()==mc:GetCode()
end


function c75233710.afilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c75233710.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c75233710.afilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c75233710.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c75233710.afilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	if Duel.GetMatchingGroupCount(filter2,tp,LOCATION_MZONE,0,nil,c)>=2 then
	Duel.Draw(tp,2,REASON_EFFECT)
		end
	end
end
