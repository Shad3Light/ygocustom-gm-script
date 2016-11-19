--Valkyrie Crusader Burst Strike
-- concept by Phikage
-- script By Shad3
--[[
You can activate this card when a "Valkyrie Crusader" monster you control is sent to the Extra Deck face-up. Special Summon up to 2 "Valkyrie Crusader monsters from your hand and/or face-up from your Extra Deck. They are sent to the Extra Deck face-up during the End Phase. (Effects are not activated at this time.) You can only activate 1 "Valkyrie Crusader Burst Strike" per turn.
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
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_TO_DECK)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCountLimit(1,s_id+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(scard.a_cd)
	e1:SetTarget(scard.a_tg)
	e1:SetOperation(scard.a_op)
	c:RegisterEffect(e1)
end

function scard.a_fil(c,tp)
	return c:IsSetCard(sc_id) and c:IsFaceup() and c:IsPreviousLocation(LOCATION_ONFIELD) and c:GetPreviousControler()==tp
end

function scard.a_sfil(c,e,tp)
	return c:IsSetCard(sc_id) and (c:IsLocation(LOCATION_HAND) or c:IsFaceup()) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end

function scard.a_cd(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(scard.a_fil,1,nil,tp)
end

function scard.a_tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.a_sfil,tp,LOCATION_HAND+LOCATION_EXTRA,0,1,nil,e,tp) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0)
end

function scard.a_op(e,tp,eg,ep,ev,re,r,rp)
	local loc=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if loc<1 then return end
	if loc>2 then loc=2 end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then loc=1 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,scard.a_sfil,tp,LOCATION_HAND+LOCATION_EXTRA,0,1,loc,nil,e,tp)
	if g:GetCount()>0 and Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)~=0 then
		local fid=e:GetHandler():GetFieldID()
		local c=g:GetFirst()
		while c do
			c:RegisterFlagEffect(s_id,RESET_EVENT+0x1fe0000,0,1,fid)
			c=g:GetNext()
		end
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetCountLimit(1)
		e1:SetReset(RESET_PHASE+PHASE_END)
		e1:SetCondition(scard.a_retcd)
		e1:SetOperation(scard.a_retop)
		Duel.RegisterEffect(e1,tp)
		g:KeepAlive()
		e1:SetLabelObject(g)
		e1:SetLabel(fid)
	end
end

function scard.a_retfil(c,fid)
	return c:GetFlagEffectLabel(s_id)==fid
end

function scard.a_retcd(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	if not g:IsExists(scard.a_retfil,1,nil,e:GetLabel()) then
		g:DeleteGroup()
		e:Reset()
		return false
	else return true end
end

function scard.a_retop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local tg=g:Filter(scard.a_retfil,nil,e:GetLabel())
	Duel.SendtoExtraP(tg,nil,REASON_EFFECT)
	Duel.BreakEffect()
end
