--Multiply (DOR) 
--scripted by GameMaster (GM)
function c33569953.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c33569953.target)
	e1:SetOperation(c33569953.activate)
	c:RegisterEffect(e1)
end

function c33569953.filter(c)
	return c:IsCode(40640057)
end

function c33569953.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tc=Duel.GetFirstTarget()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c33569953.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c33569953.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,tc) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c33569953.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,tc)
end


function c33569953.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e)  then
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
    e1:SetCode(EVENT_TO_GRAVE)
    e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e1:SetCondition(c33569953.con)
    e1:SetTarget(c33569953.sptg)
    e1:SetOperation(c33569953.spop)
	tc:RegisterEffect(e1)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetDescription(aux.Stringid(33569953,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e2:SetTarget(c33569953.sptg2)
	e2:SetOperation(c33569953.spop2)
	tc:RegisterEffect(e2)
	end
end

	

function c33569953.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c33569953.spop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,33569956,0,0x4011,1200,1200,3,RACE_REPTILE,ATTRIBUTE_EARTH) then return end
	local token=Duel.CreateToken(tp,33569956)
	 Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEDOWN)
	Duel.SendtoHand(token,tp,REASON_RULE)
    Duel.MSet(tp,token,true,e)
	Duel.SpecialSummonComplete()
end



function c33569953.con(e,tp)
local tc=e:GetHandler()
if tc and tc:IsReason(REASON_DESTROY) and tc:IsLocation(LOCATION_GRAVE) and tc:GetPreviousControler()==tp then
    e:SetLabel(tc:GetPreviousSequence())
    return true
end
return false
end

--block previous zone and special summon
function c33569953.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsReason(REASON_DESTROY) and bit.band(c:GetPreviousLocation(),LOCATION_SZONE)~=0 then
		--spsummon
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(33569953,0))
		e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
		e1:SetRange(LOCATION_GRAVE)
		e1:SetCode(EVENT_PHASE+PHASE_BATTLE)
		e1:SetCost(c33569953.spcost)
		e1:SetTarget(c33569953.sptg)
		e1:SetOperation(c33569953.spop)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
		c:RegisterEffect(e1)
	end
end
function c33569953.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:GetFlagEffect(33569953)==0 end
	c:RegisterFlagEffect(33569953,nil,0,1)
end
function c33569953.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
	local seq=bit.lshift(0x1,e:GetLabel())
	local ch=Duel.GetCurrentChain()
	 e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCode(EFFECT_DISABLE_FIELD)
	e1:SetReset(RESET_CHAIN)
	e1:SetOperation(function() if Duel.GetCurrentChain()==ch then return seq else return 0 end end)
	Duel.RegisterEffect(e1,tp)
end
function c33569953.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local seq=bit.lshift(0x1,e:GetLabel())
    if c:IsRelateToEffect(e) then 
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCode(EFFECT_DISABLE_FIELD)
	e1:SetValue(seq)
	e:GetHandler():RegisterEffect(e1)
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	e1:Reset()
	end
end