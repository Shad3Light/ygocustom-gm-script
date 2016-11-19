--Lunar phase beast: moon burst clearing
--SCRIPTED by GameMaster(GM)
function c33569994.initial_effect(c)
aux.EnablePendulumAttribute(c,true)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(33569994,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCost(c33569994.cost)
	e1:SetTarget(c33569994.target)
	e1:SetOperation(c33569994.operation)
	c:RegisterEffect(e1)
	--remove when tribute summoned
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(33569994,0))
	e2:SetCategory(CATEGORY_REMOVE+CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetCondition(c33569994.condition)
	e2:SetTarget(c33569994.target2)
	e2:SetOperation(c33569994.operation2)
	c:RegisterEffect(e2)
	--return a card to deck
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(33569994,1))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_PZONE)
	e3:SetCost(c33569994.cost2)
	e3:SetTarget(c33569994.target3)
	e3:SetOperation(c33569994.operation3)
	e3:SetCountLimit(1)
	c:RegisterEffect(e3)
end

function c33569994.filter2(c)
	return c:IsType(TYPE_MONSTER) and (c:IsAbleToDeckAsCost() and c:IsSetCard(0x36CC7))
end

function c33569994.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c33569994.filter2,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTODECK)
	local g=Duel.SelectTarget(tp,c33569994.filter2,tp,LOCATION_HAND,0,1,1,nil)
	 local c=g:GetFirst()
	if g and c:IsRelateToEffect(e) then
	Duel.SendtoDeck(g,nil,POS_FACEDOWN,REASON_EFFECT+REASON_COST)
	end
end

function c33569994.target3(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and chkc:IsAbleToDeck() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToDeck,tp,LOCATION_SZONE,LOCATION_SZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTODECK)
	local g=Duel.SelectTarget(tp,Card.IsAbleToDeck,tp,LOCATION_SZONE,LOCATION_SZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end

function c33569994.operation3(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoDeck(tc,nil,POS_FACEDOWN,REASON_EFFECT)
	end
end

function c33569994.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToGraveAsCost() and c:IsDiscardable() end
	Duel.SendtoGrave(c,REASON_COST+REASON_DISCARD)
end
function c33569994.filter(c)
	return c:IsCode(33569995) and c:IsAbleToHand()
end
function c33569994.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c33569994.filter,tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_EXTRA,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_EXTRA)
end
function c33569994.operation(e,tp,eg,ep,ev,re,r,rp,chk)
	local tg=Duel.GetFirstMatchingCard(c33569994.filter,tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_EXTRA,0,nil)
	if tg then
		Duel.SendtoHand(tg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tg)
	end
end
	
function c33569994.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_ADVANCE
end
function c33569994.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,nil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	local tc=g:GetFirst()
	if tc and tc:IsAbleToRemove() then
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,tc,1,0,0)
		if tc:IsFaceup() and tc:IsAttribute(ATTRIBUTE_DARK) then
			Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1000)
		end
	end
end
function c33569994.operation2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
		if tc:IsLocation(LOCATION_REMOVED) and tc:IsType(TYPE_MONSTER) and tc:IsAttribute(ATTRIBUTE_DARK) then
			Duel.Damage(1-tp,1000,REASON_EFFECT)
		end
	end
end
