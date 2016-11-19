--Valkyrie Crusader Recalling
-- concept by Phikage
-- script By Shad3
--[[
Once per turn: You can destroy 1 "Valkyrie Crusader" Pendulum Monster in your Pendulum Zone and add 1 "Valkyrie Crusader" Pendulum Monster, except the destroyed card, from your Extra Deck to your hand. If this card is destroyed by a card effect and sent to the Graveyard, you can target 1 card on the field, destroy it. You can only control 1 "Valkyrie Crusader Recalling".
]]

local function getID()
	local str=string.match(debug.getinfo(2,'S')['source'],"c%d+%.lua")
	str=string.sub(str,1,string.len(str)-4)
	local scard=_G[str]
	local s_id=tonumber(string.sub(str,2))
	return scard,s_id
end

local scard,s_id=getID()
local sc_id=0x7c1

function scard.initial_effect(c)
	--unique
	c:SetUniqueOnField(1,0,s_id)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Destroyscale
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_TOHAND)
	e2:SetCountLimit(1)
	e2:SetDescription(aux.Stringid(s_id,0))
	e2:SetTarget(scard.a_tg)
	e2:SetOperation(scard.a_op)
	c:RegisterEffect(e2)
	--Destroying
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetDescription(aux.Stringid(s_id,1))
	e3:SetTarget(scard.b_tg)
	e3:SetOperation(scard.b_op)
	c:RegisterEffect(e3)
end

function scard.a_fil(c)
	return c:IsSetCard(sc_id) and c:IsFaceup() and c:IsAbleToHand()
end

function scard.a_pfil(c)
	return c:IsSetCard(sc_id) and c:GetSequence()==6 or c:GetSequence()==7
end

function scard.a_tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.a_fil,tp,LOCATION_EXTRA,0,1,nil) and Duel.IsExistingMatchingCard(scard.a_pfil,tp,LOCATION_SZONE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,nil,1,tp,LOCATION_PZONE)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_EXTRA)
end

function scard.a_op(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local tc=Duel.SelectMatchingCard(tp,scard.a_pfil,tp,LOCATION_SZONE,0,1,1,nil):GetFirst()
	if tc and Duel.Destroy(tc,REASON_EFFECT)~=0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,scard.a_fil,tp,LOCATION_EXTRA,0,1,1,tc)
		if g:GetCount()>0 and Duel.SendtoHand(g,nil,REASON_EFFECT)~=0 then Duel.ConfirmCards(1-tp,g) end
	end
end

function scard.b_tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,tp,0)
end

function scard.b_op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then Duel.Destroy(tc,REASON_EFFECT) end
end
