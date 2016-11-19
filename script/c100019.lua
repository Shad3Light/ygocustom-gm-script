--Rainbow Beast - Brokwoilord
function c100019.initial_effect(c)
	c:EnableReviveLimit()
	--shuffle effect
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c100019.shcon)
	e1:SetTarget(c100019.shtg)
	e1:SetOperation(c100019.shop)
	c:RegisterEffect(e1)
	--guess banish
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c100019.gbtg)
	e2:SetOperation(c100019.gbop)
	c:RegisterEffect(e2)
end
function c100019.shcon(e,tp,ep,ev,eg,re,r,rp)
	return bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_RITUAL)==SUMMON_TYPE_RITUAL
end
function c100019.shtg(e,tp,ep,ev,eg,re,r,rp,chk)
	if chk==0 then return true end
	local tg=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_HAND,LOCATION_HAND,nil)
	Duel.SetTargetCard(tg)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,tg,tg:GetCount(),0,0)
end
function c100019.shop(e,tp,ep,ev,eg,re,r,rp,chk)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tg1=tg:Filter(Card.IsControler,nil,tp)
	local tg2=tg:Filter(Card.IsControler,nil,1-tp)
	Duel.SendtoDeck(tg1,tp,0,REASON_EFFECT)
	Duel.SendtoDeck(tg2,1-tp,0,REASON_EFFECT)
	if Duel.IsPlayerCanDraw(tp,tg1:GetCount()) then
		Duel.Draw(tp,tg1:GetCount(),REASON_EFFECT)
	end
	if Duel.IsPlayerCanDraw(1-tp,tg2:GetCount()) then
		Duel.Draw(1-tp,tg2:GetCount(),REASON_EFFECT)
	end
end
function c100019.filter(c)
	return c:IsAbleToRemove() and (c:IsType(TYPE_SPELL) or c:IsType(TYPE_TRAP)) and c:IsFacedown()
end
function c100019.gbtg(e,tp,ep,ev,eg,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100019.filter,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,0,0,0)
end
function c100019.gbop(e,tp,ep,ev,eg,re,r,rp)
	local opt=Duel.SelectOption(tp,70,71,72)
	local dtc=Duel.GetDecktopGroup(tp,1)
	local tc=dtc:GetFirst()
	if not tc then return end
	Duel.ConfirmDecktop(tp,1)
	if (opt==0 and tc:IsType(TYPE_MONSTER)) or (opt==1 and tc:IsType(TYPE_SPELL)) or (opt==2 and tc:IsType(TYPE_TRAP)) then
		local tg=Duel.SelectMatchingCard(tp,c100019.filter,tp,0,LOCATION_ONFIELD,1,1,nil)
		Duel.Remove(tg,POS_FACEUP,REASON_EFFECT)
	else
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end