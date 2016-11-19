--Rain Force - Procastrination
function c77700007.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_WATER),5,4)
	c:EnableReviveLimit()
	--destroy lvl>5
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetDescription(aux.Stringid(77700007,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c77700007.condition)
	e1:SetCost(c77700007.cost)
	e1:SetOperation(c77700007.operation)
	c:RegisterEffect(e1)
	--return card from grave
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(77700007,1))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCondition(c77700007.rescon)
	e2:SetTarget(c77700007.restg)
	e2:SetOperation(c77700007.resop)
	c:RegisterEffect(e2)
	--to deck
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(77700007,2))
	e3:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCost(c77700007.tdcost)
	e3:SetOperation(c77700007.tdop)
	c:RegisterEffect(e3)
end
--Effect 1
function c77700007.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,2,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,2,2,REASON_COST)
end
function c77700007.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c77700007.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
end
function c77700007.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c77700007.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
	Duel.Destroy(g,REASON_EFFECT)
end
function c77700007.filter(c)
	return c:IsType(TYPE_MONSTER) and c:GetLevel()>5
end
--Effect 2
function c77700007.cfilter(c,tp)
	return c:IsFaceup() and c:IsType(TYPE_FUSION) and c:GetSummonPlayer()==tp
end
function c77700007.rescon(e,tp,eg,ep,ev,re,r,rp)
	return not eg:IsContains(e:GetHandler()) and eg:IsExists(c77700007.cfilter,1,nil,tp)
end
function c77700007.restg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and chkc:IsAbleToHand() end
	if chk==0 then return Duel.IsExistingTarget(c77700007.resfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c77700007.resfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c77700007.resop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
function c77700007.resfilter(c)
	return c:IsType(TYPE_PENDULUM) and c:IsAbleToHand()
end
--Effect 3
function c77700007.costfil(c)
	return c:IsSetCard(0x777) and c:IsLocation(LOCATION_MZONE) and c:IsPosition(POS_FACEUP)
end
function c77700007.tdcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroupEx(tp,c77700007.costfil,1,nil) end
	local g=Duel.SelectReleaseGroupEx(tp,c77700007.costfil,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c77700007.tdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoDeck(e:GetHandler(),nil,2,REASON_EFFECT)
	Duel.Draw(tp,1,REASON_EFFECT)
end