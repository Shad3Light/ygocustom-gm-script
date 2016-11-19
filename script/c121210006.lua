--Valkyrie Crusader Hidden Forest
-- concept by Phikage
-- script By Shad3
--[[
Once per turn, when an opponent's monster declares an attack: You can Special Summon 1 "Valkyrie Crusader" monster face-up from your Extra Deck, and if you do, change the attack target to that monster. When this card is destroyed by a card effect, you can make all monsters you currently control gain 500 ATK. You can only control 1 "Valkyrie Crusader Hidden Forest".
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
	e1:SetDescription(aux.Stringid(s_id,0))
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetDescription(aux.Stringid(s_id,1))
	e2:SetTarget(scard.a_tg)
	e2:SetOperation(scard.a_op)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetCountLimit(1)
	e3:SetDescription(aux.Stringid(s_id,1))
	e3:SetCondition(scard.a_cd)
	e3:SetTarget(scard.a_tg)
	e3:SetOperation(scard.a_op)
	c:RegisterEffect(e3)
	--Increase ATK
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_DESTROYED)
	e4:SetCondition(scard.b_cd)
	e4:SetOperation(scard.b_op)
	c:RegisterEffect(e4)
end

function scard.a_fil(c,e,tp)
	return c:IsSetCard(sc_id) and c:IsFaceup() and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end

function scard.a_cd(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(s_id)==0
end

function scard.a_tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetAttacker():IsControler(1-tp) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(scard.a_fil,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	e:GetHandler():RegisterFlagEffect(s_id,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end

function scard.a_op(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<1 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sc=Duel.SelectMatchingCard(tp,scard.a_fil,tp,LOCATION_EXTRA,0,1,1,nil,e,tp):GetFirst()
	if not sc then return end
	local ac=Duel.GetAttacker()
	if Duel.SpecialSummon(sc,0,tp,tp,false,false,POS_FACEUP)~=0 and ac and sc:IsCanBeBattleTarget(ac) then
		Duel.ChangeAttackTarget(sc)
	end
end

function scard.b_fil(c)
	return c:IsSetCard(sc_id) and c:IsFaceup()
end

function scard.b_cd(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_EFFECT)~=0
end

function scard.b_op(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(scard.b_fil,tp,LOCATION_MZONE,0,nil)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(s_id,2)) then
		local c=g:GetFirst()
		while c do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			e1:SetValue(500)
			c:RegisterEffect(e1)
			c=g:GetNext()
		end
	end
end
