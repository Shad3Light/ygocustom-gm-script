--Rainbom Beast - Zeyfrom
function c100020.initial_effect(c)
	c:EnableUnsummonable()
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c100020.splimit)
	c:RegisterEffect(e1)
	--banish effect
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c100020.remcon)
	e2:SetTarget(c100020.remtg)
	e2:SetOperation(c100020.remop)
	c:RegisterEffect(e2)
	--mutiple direct attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e3:SetCondition(c100020.rdcon)
	e3:SetOperation(c100020.rdop)
	c:RegisterEffect(e3)
	--direct attack
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_DIRECT_ATTACK)
	e4:SetCondition(c100020.dircon)
	c:RegisterEffect(e4)
	--update attack
	local e5=Effect.CreateEffect(c)
	e5:SetProperty(CATEGORY_ATKCHANGE)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e5:SetCode(EVENT_ATTACK_ANNOUNCE)
	e5:SetCondition(c100020.atkcon)
	e5:SetOperation(c100020.atkop)
	c:RegisterEffect(e5)
	--self banish effect
	local e6=Effect.CreateEffect(c)
	e6:SetCategory(CATEGORY_REMOVE)
	e6:SetType(EFFECT_TYPE_QUICK_O)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCode(EVENT_BECOME_TARGET)
	e6:SetCondition(c100020.sbcon)
	e6:SetTarget(c100020.sbtg)
	e6:SetOperation(c100020.sbop)
	c:RegisterEffect(e6)
	--revive
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_FIELD)
	e7:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e7:SetCode(EVENT_PHASE+PHASE_END)
	e7:SetRange(LOCATION_REMOVED)
	e7:SetCountLimit(1)
	e7:SetTarget(c100020.sumtg)
	e7:SetOperation(c100020.sumop)
	c:RegisterEffect(e7)
end
function c100020.splimit(e,se,sp,st)
	return (bit.band(st,SUMMON_TYPE_RITUAL)==SUMMON_TYPE_RITUAL and se:GetHandler():IsCode(100021)) or se:GetHandler()==e:GetHandler()
end
function c100020.remcon(e,tp,ep,ev,eg,re,r,rp)
	return bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_RITUAL)==SUMMON_TYPE_RITUAL
end
function c100020.remfilter(c)
	return c:IsAbleToRemove() and (c:IsType(TYPE_TRAP) or c:IsType(TYPE_SPELL))
end
function c100020.remtg(e,tp,ep,ev,eg,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	local tg=Duel.GetMatchingGroup(c100020.remfilter,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetTargetCard(tg)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,tg,tg:GetCount(),0,0)
end
function c100020.remop(e,tp,ev,eg,ep,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if tg:GetCount()>0 then
		Duel.Remove(tg,POS_FACEUP,REASON_EFFECT)
	end
end
function c100020.rdcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return ep~=tp and c==Duel.GetAttacker() and Duel.GetAttackTarget()==nil and c:GetFlagEffect(100020)<c:GetMaterialCount()
end
function c100020.rdop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	c:RegisterFlagEffect(100020,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetValue(c100020.val)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e1)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e5:SetRange(LOCATION_MZONE)
	e5:SetTargetRange(0,LOCATION_MZONE)
	e5:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e5:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e5:SetCondition(c100020.ocon1)
	e5:SetTarget(c100020.tg)
	e5:SetValue(1)
	c:RegisterEffect(e5)
end
function c100020.val(e,c)
	return c:GetMaterialCount()-1
end
function c100020.ocon1(e)
	local c=e:GetHandler()
	return Duel.GetAttacker()==c
end
function c100020.tg(e,c)
	return c:IsType(TYPE_MONSTER)
end
function c100020.dircon(e)
	local c=e:GetHandler()
	return c:GetFlagEffect(100020)<c:GetMaterialCount()
end
function c100020.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c==Duel.GetAttacker() and Duel.GetAttackTarget()==nil
end
function c100020.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_COPY_INHERIT)
		e1:SetValue(-1000)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		c:RegisterEffect(e1)
	end
end
function c100020.sbcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsContains(e:GetHandler())
end
function c100020.sbtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,0,0,0)
end
function c100020.sbop(e,tp,eg,ep,ev,re,r,rp)
   Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT)
   e:GetHandler():RegisterFlagEffect(100020,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,0)
end
function c100020.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
   local c=e:GetHandler()
   if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and c:GetFlagEffect(100020)>0
	   and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
   Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c100020.sumop(e,tp,eg,ep,ev,re,r,rp)
   if e:GetHandler():IsRelateToEffect(e) then
	   Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
   end
end