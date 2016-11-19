--Dragon-Z Galaxy Life
function c17904.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--instant
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(17904,1))
	e2:SetCategory(CATEGORY_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCost(c17904.cost)
	e2:SetTarget(c17904.target1)
	e2:SetOperation(c17904.activate1)
	c:RegisterEffect(e2)
	--Add
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(17904,2))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_TODECK)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetCost(c17904.cost)
	e3:SetTarget(c17904.target2)
	e3:SetOperation(c17904.operation2)
	c:RegisterEffect(e3)
	--Draw
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(17904,3))
	e4:SetCategory(CATEGORY_HANDES+CATEGORY_DRAW)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetCost(c17904.cost)
	e4:SetTarget(c17904.target3)
	e4:SetOperation(c17904.operation3)
	c:RegisterEffect(e4)
end
function c17904.filter(c)
	return  c:IsSetCard(0x91) and (c:IsSummonable(true,nil) or c:IsMSetable(true,nil))
end
function c17904.efilter(c,e,tp,eg,ep,ev,re,r,rp,chk)
	return c:IsSetCard(0x91) and c:IsAbleToRemove() 
end
function c17904.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c17904.efilter,tp,LOCATION_GRAVE,0,2,nil)
	else g1=Duel.SelectMatchingCard(tp,c17904.efilter,tp,LOCATION_GRAVE,0,2,2,nil,e,tp) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.Remove(g1,POS_FACEUP,REASON_EFFECT)
end
function c17904.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if not e:GetHandler():IsStatus(STATUS_CHAINING) then
			local ct=Duel.GetMatchingGroupCount(c17904.filter,tp,LOCATION_HAND+LOCATION_MZONE,0,nil)
			e:SetLabel(ct)
			return ct>0
		else return e:GetLabel()>0 end
	end
	e:SetLabel(e:GetLabel()-1)
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,nil,1,0,0)
end
function c17904.activate1(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
	local g=Duel.SelectMatchingCard(tp,c17904.filter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		local s1=tc:IsSummonable(true,nil)
		local s2=tc:IsMSetable(true,nil)
		if (s1 and s2 and Duel.SelectPosition(tp,tc,POS_FACEUP_ATTACK+POS_FACEDOWN_DEFENCE)==POS_FACEUP_ATTACK) or not s2 then
			Duel.Summon(tp,tc,true,nil)
		else
			Duel.MSet(tp,tc,true,nil)
		end
	end
end
function c17904.afilter(c,e,tp)
	return c:IsSetCard(0x91) and c:IsAbleToDeck()
end
function c17904.thfilter(c)
	return c:IsSetCard(0x91) and c:IsAbleToHand()
end
function c17904.rfilter(c)
	return c:IsAbleToRemove()
end
function c17904.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c17904.afilter,tp,LOCATION_HAND,0,1,nil)
		and Duel.IsExistingMatchingCard(c17904.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c17904.afilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.ConfirmCards(1-tp,g)
	Duel.SendtoDeck(g,nil,1,REASON_EFFECT)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c17904.operation2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c17904.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c17904.target3(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c17904.operation3(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
	Duel.BreakEffect()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c17904.rfilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
end