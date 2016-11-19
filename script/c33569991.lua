--Anit-Matter MothMan
--scripted by GameMaster (GM)
function c33569991.initial_effect(c)
	c:EnableReviveLimit()
	-- disable opponent field
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c33569991.condition)
	e1:SetCountLimit(1)
	e1:SetOperation(c33569991.dsop2)
	c:RegisterEffect(e1)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(33569991,0))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetHintTiming(0,TIMING_BATTLE_PHASE)
	e2:SetCondition(c33569991.atkcon)
	e2:SetOperation(c33569991.atkop)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_SPSUMMON_PROC)
	e3:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e3:SetRange(LOCATION_HAND)
	e3:SetCondition(c33569991.spcon)
	e3:SetOperation(c33569991.spop)
	c:RegisterEffect(e3)
end
function c33569991.filter2(c)
	return c:IsType(TYPE_FIELD) and c:IsCode(33900648)
end



function c33569991.spcon(e,c)
	if c==nil then return true end
	local g=Duel.GetReleaseGroup(c:GetControler())
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-1
		and g:GetCount()>0 and g:IsExists(Card.IsCode,1,nil,33559956)
end
function c33569991.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.GetReleaseGroup(tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local sg1=g:FilterSelect(tp,Card.IsCode,1,1,nil,33559956)
	g:RemoveCard(sg1:GetFirst())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local sg2=Duel.SelectMatchingCard(tp,c33569991.filter2,tp,LOCATION_ONFIELD,0,1,1,nil)
	sg1:Merge(sg2)
	Duel.Release(sg1,REASON_COST)
end

function c33569991.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentChain()==0 and e:GetHandler()==Duel.GetAttacker() and Duel.GetAttackTarget() and Duel.GetAttackTarget():IsDefensePos()
end
function c33569991.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(-400)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_PIERCE)
		c:RegisterEffect(e2)
	end
end


function c33569991.filter(c,tp)
	return c:IsType(TYPE_MONSTER) and c:GetControler()==1-tp
end

function c33569991.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c33569991.filter,1,nil,tp)
end


function c33569991.dsop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(1-tp,LOCATION_MZONE)<=0 then return end
	local dis1=Duel.SelectDisableField(1-tp,1,LOCATION_MZONE,0,0)
	--disable field
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_DISABLE_FIELD)
	e1:SetOperation(c33569991.disop2)
	e1:SetReset(RESET_EVENT+0x1ff0000)
	e:GetHandler():RegisterEffect(e1)
end


function c33569991.disop2(e,tp)
	local dis1=Duel.SelectDisableField(tp,1,LOCATION_MZONE,0,0)
	local seq=0
	if dis1==1 then seq=0 end
	if dis1==2 then seq=1 end
	if dis1==4 then seq=2 end
	if dis1==8 then seq=3 end
	if dis1==16 then seq=4 end
	return bit.lshift(0x1,16+seq)
end