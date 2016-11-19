--Power of Greed
function c33559954.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetTarget(c33559954.target)
	e1:SetOperation(c33559954.activate)
	e1:SetCountLimit(1,33559954+EFFECT_COUNT_CODE_DUEL)
	e1:SetCondition(c33559954.condition)
	c:RegisterEffect(e1)
	--change code
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CHANGE_CODE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_IMMEDIATELY_APPLY)
	e2:SetRange(LOCATION_SZONE)
	e2:SetValue(55144522)
	c:RegisterEffect(e2)
	-- Cannot add to hand
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetRange(LOCATION_DECK)
	e3:SetCode(EFFECT_CANNOT_TO_HAND)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end

function c33559954.filter(c)
	return c:IsFaceup() and c:IsCode(335599101)
end

function c33559954.condition(e,tp)
    return  Duel.IsExistingMatchingCard(c33559954.filter,tp,LOCATION_ONFIELD,0,1,nil)
end

function c33559954.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,6) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(6)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,6)
end
function c33559954.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
