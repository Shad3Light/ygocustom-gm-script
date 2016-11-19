--Valkyrie Crusader Passage
-- concept by Phikage
-- script By Shad3
--[[
You can only Special Summon "Valkyrie Crusader" monsters. Once per turn: You can send any number of "Valkyrie Crusader" Pendulum Monsters from your Extra Deck to the Deck, then gain Life Points equal to the number of sent cards x 1000. When this card is destroyed: You can add 1 "Valkyrie Crusader" Spell/Trap Card from your Graveyard to your hand, except "Valkyrie Crusader Passage". You can only control 1 "Valkyrie Crusader" Passage".
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
	--SummonLimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,0)
	e2:SetTarget(scard.a_tg)
	c:RegisterEffect(e2)
	--Gain LP
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_SZONE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCategory(CATEGORY_TODECK+CATEGORY_RECOVER)
	e3:SetCountLimit(1)
	e3:SetDescription(aux.Stringid(s_id,0))
	e3:SetTarget(scard.b_tg)
	e3:SetOperation(scard.b_op)
	c:RegisterEffect(e3)
	--destroyed
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_DESTROYED)
	e4:SetCategory(CATEGORY_TOHAND)
	e4:SetDescription(aux.Stringid(s_id,1))
	e4:SetTarget(scard.c_tg)
	e4:SetOperation(scard.c_op)
	c:RegisterEffect(e4)
end

function scard.a_tg(e,c,sump,sumtype,sumpos,targetp,re)
	return bit.band(sumtype,SUMMON_TYPE_SPECIAL)~=0 and not c:IsSetCard(sc_id)
end

function scard.b_fil(c)
	return c:IsSetCard(sc_id) and c:IsFaceup() and c:IsAbleToDeck()
end

function scard.b_tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.b_fil,tp,LOCATION_EXTRA,0,1,nil) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1000)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,1000)
end

function scard.b_op(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local g=Duel.GetMatchingGroup(scard.b_fil,p,LOCATION_EXTRA,0,nil)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local sg=g:Select(tp,1,g:GetCount(),nil)
	local val=Duel.SendtoDeck(sg,nil,2,REASON_EFFECT)
	if val>0 then
		Duel.BreakEffect()
		Duel.Recover(p,val*1000,REASON_EFFECT)
	end
end

function scard.c_fil(c)
	return c:IsSetCard(sc_id) and c:IsType(TYPE_SPELL+TYPE_TRAP) and not c:IsCode(s_id) and c:IsAbleToHand()
end

function scard.c_tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.c_fil,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE)
end

function scard.c_op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,scard.c_fil,tp,LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 and Duel.SendtoHand(g,nil,REASON_EFFECT)~=0 then Duel.ConfirmCards(1-tp,g) end
end
