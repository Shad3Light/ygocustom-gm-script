--Orichalcos Kyutora
function c400001008.initial_effect(c)
	c:EnableUnsummonable()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c400001008.spcon)
	e1:SetOperation(c400001008.spcost)
	c:RegisterEffect(e1)
	--avoid battle damage
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_ONFIELD)
	e2:SetCondition(c400001008.rdcon1)
	e2:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e2:SetOperation(c400001008.rdop)
	c:RegisterEffect(e2)
	local e4=e2:Clone()
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCondition(c400001008.rdcon2)
	c:RegisterEffect(e4)
	--special summon Shunoros
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetTarget(c400001008.target)
	e3:SetOperation(c400001008.operation)
	c:RegisterEffect(e3)
end
local damage=0

function c400001008.spcon(e,c)
	return Duel.GetLocationCount(e:GetHandler():GetControler(),LOCATION_MZONE)>0 and Duel.CheckLPCost(tp,500)
end
function c400001008.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	Duel.PayLPCost(tp,500)
end

function c400001008.rdcon1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()~=e:GetHandler()
end
function c400001008.rdcon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()==e:GetHandler()
end
function c400001008.rdop(e,tp,eg,ep,ev,re,r,rp)
	damage = damage + Duel.GetBattleDamage(tp)
	Duel.ChangeBattleDamage(tp,0)
end

function c400001008.filter(c,e,tp)
	return c:IsCode(7634581) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c400001008.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c400001008.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_HAND)
end
function c400001008.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local ct=Duel.SelectMatchingCard(tp,c400001008.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,e,tp):GetFirst()
	if ct then
		if Duel.SpecialSummon(ct,0,tp,tp,true,false,POS_FACEUP)==1 then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SET_BASE_ATTACK)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			e1:SetValue(damage)
			ct:RegisterEffect(e1)
		end
	end
end