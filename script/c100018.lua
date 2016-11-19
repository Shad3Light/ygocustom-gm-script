--Rainbow Beast - Zaykrom
function c100018.initial_effect(c)
	c:EnableReviveLimit()
	--shuffle effect
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c100018.shcon)
	e1:SetTarget(c100018.shtg)
	e1:SetOperation(c100018.shop)
	c:RegisterEffect(e1)
	--guess banish
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_REMOVE+CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c100018.gbtg)
	e2:SetOperation(c100018.gbop)
	c:RegisterEffect(e2)
end
function c100018.shcon(e,tp,ep,ev,eg,re,r,rp)
	return bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_RITUAL)==SUMMON_TYPE_RITUAL
end
function c100018.shtg(e,tp,ep,ev,eg,re,r,rp,chk)
	if chk==0 then return true end
	local tg=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_REMOVED,LOCATION_REMOVED,nil)
	Duel.SetTargetCard(tg)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,tg,tg:GetCount(),0,0)
end
function c100018.shop(e,tp,ep,ev,eg,re,r,rp,chk)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tg1=tg:Filter(Card.IsControler,nil,tp)
	local tg2=tg:Filter(Card.IsControler,nil,1-tp)
	Duel.SendtoDeck(tg1,tp,0,REASON_EFFECT)
	Duel.SendtoDeck(tg2,1-tp,0,REASON_EFFECT)
end
function c100018.filter(c)
	return c:IsAbleToRemove() and c:IsType(TYPE_MONSTER) and c:IsFaceup()
end
function c100018.gbtg(e,tp,ep,ev,eg,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100018.filter,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,0,0,0)
end
function c100018.gbop(e,tp,ep,ev,eg,re,r,rp)
	local c=e:GetHandler()
	local opt=Duel.SelectOption(tp,70,71,72)
	local dtc=Duel.GetDecktopGroup(tp,1)
	local tc=dtc:GetFirst()
	if not tc then return end
	Duel.ConfirmDecktop(tp,1)
	if (opt==0 and tc:IsType(TYPE_MONSTER)) or (opt==1 and tc:IsType(TYPE_SPELL)) or (opt==2 and tc:IsType(TYPE_TRAP)) then
		local tg=Duel.SelectMatchingCard(tp,c100018.filter,tp,0,LOCATION_ONFIELD,1,1,nil)
		Duel.Remove(tg,POS_FACEUP,REASON_EFFECT)
		tg:GetFirst():RegisterFlagEffect(100018,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,0)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(tg:GetFirst():GetAttack())
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_FIELD)
		e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e2:SetCode(EVENT_PHASE+PHASE_END)
		e2:SetRange(LOCATION_REMOVED)
		e2:SetCountLimit(1)
		e2:SetTarget(c100018.sumtg)
		e2:SetOperation(c100018.sumop)
		tg:GetFirst():RegisterEffect(e2)
	else
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end
function c100018.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
   local c=e:GetHandler()
   if chk==0 then return Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0 and c:GetFlagEffect(100018)>0
	   and c:IsCanBeSpecialSummoned(e,0,1-tp,false,false) end
   Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c100018.sumop(e,tp,eg,ep,ev,re,r,rp)
   if e:GetHandler():IsRelateToEffect(e) then
	   Duel.SpecialSummon(e:GetHandler(),0,1-tp,tp,false,false,POS_FACEUP)
   end
end