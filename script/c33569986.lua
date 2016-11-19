--Narakus' Demon Puppet
--scripted by GameMaster(GM)
function c33569986.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--remain on field
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_REMAIN_FIELD)
	c:RegisterEffect(e2)
	--token
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(33569986,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetCountLimit(1)
	e3:SetCondition(c33569986.spcon)
	e3:SetTarget(c33569986.sptg)
	e3:SetOperation(c33569986.spop)
	c:RegisterEffect(e3)
	--Special Summon naraku when destroyed
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_TO_GRAVE)
	e4:SetRange(LOCATION_GRAVE)
	e4:SetCountLimit(1,33569986)
	e4:SetCondition(c33569986.spcon2)
	e4:SetTarget(c33569986.sptg2)
	e4:SetOperation(c33569986.spop2)
	c:RegisterEffect(e4)
end

function c33569986.spcon2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_DESTROY)
end
function c33569986.filter(c,e,tp)
	return c:IsCode(33569984) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) 
end
function c33569986.sptg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_DECK+LOCATION_HAND+LOCATION_GRAVE) and chkc:IsControler(tp) and c33569986.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c33569986.filter,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c33569986.filter,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c33569986.spop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end

function c33569986.spfilter(c)
return c:IsCode(22222212)
end

function c33569986.spcon(e,tp,eg,ep,ev,re,r,rp)
if Duel.IsExistingMatchingCard(c33569986.spfilter,tp,LOCATION_MZONE,0,1,nil) then return false
else return true end
end

function c33569986.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1
and Duel.IsPlayerCanSpecialSummonMonster(tp,22222212,0,0x4011,500,100,2,RACE_SPELLCASTER,ATTRIBUTE_DARK) end
Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end

function c33569986.spop(e,tp,eg,ep,ev,re,r,rp)
if Duel.GetLocationCount(tp,LOCATION_MZONE)<=1 then return end
if Duel.IsPlayerCanSpecialSummonMonster(tp,22222212,0,0x4011,500,100,2,RACE_SPELLCASTER,ATTRIBUTE_DARK) then
for i=1,1 do
local token1=Duel.CreateToken(tp,22222212)
if Duel.SpecialSummonStep(token1,0,tp,tp,false,false,POS_FACEUP_ATTACK) then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetValue(1)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			token1:RegisterEffect(e1,true)
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e2:SetCode(EVENT_DESTROYED)
			e2:SetLabelObject(token1)
			e2:SetCondition(c33569986.damcon)
			e2:SetOperation(c33569986.damop)
			Duel.RegisterEffect(e2,tp)
			end
		Duel.SpecialSummonComplete()
			end		
	end
end

function c33569986.damcon(e,tp,eg,ep,ev,re,r,rp)
	local tok=e:GetLabelObject()
	if eg:IsContains(tok) then
		return true
	else
		if not tok:IsLocation(LOCATION_MZONE) then e:Reset() end
		return false
	end
end
function c33569986.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Damage(1-tp,800,REASON_EFFECT)
end




