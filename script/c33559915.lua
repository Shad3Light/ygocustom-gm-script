--Hexadecimal Search
function c33559915.initial_effect(c)
	--can only activae if skuzzy on field
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetTarget(c33559915.target)
	e1:SetOperation(c33559915.activate)
	e1:SetCountLimit(1,33559915+EFFECT_COUNT_CODE_DUEL)
	e1:SetCondition(c33559915.condtion)
	c:RegisterEffect(e1)
	-- Cannot add to hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetRange(LOCATION_DECK)
	e2:SetCode(EFFECT_CANNOT_TO_HAND)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--cannot set from hand
	local e3=Effect.CreateEffect(c)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetRange(LOCATION_HAND)
	e3:SetCode(EFFECT_CANNOT_SSET)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--remain on field
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_REMAIN_FIELD)
	c:RegisterEffect(e4)
	--destroy
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCode(EVENT_LEAVE_FIELD)
	e5:SetCondition(c33559915.sdescon)
	e5:SetOperation(c33559915.sdesop)
	c:RegisterEffect(e5)
end

function c33559915.sfilter(c)
	return c:IsPreviousPosition(POS_FACEUP) and c:GetPreviousCodeOnField()==33569966 and c:IsPreviousLocation(LOCATION_ONFIELD)
end
function c33559915.sdescon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c33559915.sfilter,1,nil)
end
function c33559915.sdesop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end

function c33559915.toonfilter1(c)
	return c:IsFaceup() and c:IsCode(33569966)
end

function c33559915.condtion(e,tp)
    return  Duel.IsExistingMatchingCard(c33559915.toonfilter1,tp,LOCATION_MZONE,0,1,nil)
end

function c33559915.afilter(c)
	return c:IsType(TYPE_TRAP+TYPE_SPELL) and c:IsAbleToHand()
end
function c33559915.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c33559915.afilter,tp,LOCATION_DECK,0,2,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,2,tp,LOCATION_DECK)
end
function c33559915.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c33559915.afilter,tp,LOCATION_DECK,0,1,2,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(2-tp,g)
		end
end
