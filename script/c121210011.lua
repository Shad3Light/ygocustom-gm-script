--Valkyrie Crusader Shensaga
-- concept by Phikage
-- script By Shad3
--[[
Pendulum Scale = 6
[ Pendulum Effect ]
When this card is activated: You can destroy all other cards you control and in your hand, then place 1 "Valkyrie Crusader" Pendulum Monster Card from your Deck in your other Pendulum Zone. Your opponent cannot activate cards or effects in response to the activation of this effect.
----------------------------------------
[ Monster Effect ]
When this card is Special Summoned: You can send all "Valkyrie Crusader" Pendulum Monsters in your Graveyard to your Extra Deck face-up, and if you do, destroy this card. When this card destroys an opponent's monster by battle: You can pay 1000 Life Points; send this card to the Extra Deck face-up, then Special Summon 1 "Valkyrie Crusader" monsters from your Deck or face-up from your Extra Deck. You can only use each monster effect of "Valkyrie Crusader Shensaga" once per turn.
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
	--pendulum
	aux.EnablePendulumAttribute(c,false)
	--Pendulum act
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(1160)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND)
	e1:SetTarget(scard.a_tg)
	c:RegisterEffect(e1)
	--Spsum trigger
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetCountLimit(1,s_id)
	e2:SetDescription(aux.Stringid(s_id,1))
	e2:SetTarget(scard.b_tg)
	e2:SetOperation(scard.b_op)
	c:RegisterEffect(e2)
	--Spsum 2
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_DESTROYING)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetCountLimit(1,s_id+1)
	e3:SetDescription(aux.Stringid(s_id,2))
	e3:SetCondition(aux.bdocon)
	e3:SetCost(scard.c_cs)
	e3:SetTarget(scard.c_tg)
	e3:SetOperation(scard.c_op)
	c:RegisterEffect(e3)
end

function scard.a_fil(c)
	return c:IsSetCard(sc_id) and c:IsType(TYPE_PENDULUM) and c:IsType(TYPE_MONSTER)
end

function scard.a_clim(e,ep,tp)
	return tp==ep
end

function scard.a_tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,e:GetHandler()) and Duel.IsExistingMatchingCard(scard.a_fil,tp,LOCATION_DECK,0,1,nil) and Duel.SelectYesNo(tp,aux.Stringid(s_id,0)) then
		e:SetCategory(CATEGORY_DESTROY)
		e:SetOperation(scard.a_op)
		local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_HAND+LOCATION_ONFIELD,0,e:GetHandler())
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),tp,0)
		Duel.SetChainLimit(scard.a_clim)
	else
		e:SetCategory(0)
		e:SetOperation(nil)
	end
end

function scard.a_op(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_HAND+LOCATION_ONFIELD,0,e:GetHandler())
	if g:GetCount()>0 and Duel.Destroy(g,REASON_EFFECT)~=0 and not Duel.GetFieldCard(tp,LOCATION_SZONE,13-e:GetHandler():GetSequence()) then
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(s_id,3))
		local tc=Duel.SelectMatchingCard(tp,scard.a_fil,tp,LOCATION_DECK,0,1,1,nil):GetFirst()
		if tc then
			Duel.BreakEffect()
			Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		end
	end
end

function scard.b_fil(c)
	return c:IsSetCard(sc_id) and c:IsType(TYPE_MONSTER) and c:IsType(TYPE_PENDULUM) and c:IsAbleToExtra()
end

function scard.b_tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.b_fil,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,tp,0)
end
	
function scard.b_op(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(scard.b_fil,tp,LOCATION_GRAVE,0,nil)
	if g:GetCount()>0 and Duel.SendtoExtraP(g,nil,REASON_EFFECT)~=0 and e:GetHandler():IsRelateToEffect(e) then Duel.Destroy(e:GetHandler(),REASON_EFFECT) end
end

function scard.c_fil(c,e,tp)
	return c:IsSetCard(sc_id) and (c:IsLocation(LOCATION_DECK) or c:IsFaceup()) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end

function scard.c_cs(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end

function scard.c_tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToExtra() and Duel.IsExistingMatchingCard(scard.c_fil,tp,LOCATION_DECK+LOCATION_EXTRA,0,1,nil,e,tp) and Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0)
end

function scard.c_op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or Duel.SendtoExtraP(c,nil,REASON_EFFECT)==0 then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<1 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,scard.c_fil,tp,LOCATION_DECK+LOCATION_EXTRA,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.BreakEffect()
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
