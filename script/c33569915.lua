--Majin Buu
--scripted by GameMaster (GM)
function c33569915.initial_effect(c)
	c:EnableReviveLimit()
	--turn monster to candy
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetOperation(c33569915.regop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(33569915,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e2:SetCountLimit(1)
	e2:SetCondition(c33569915.spcon)
	e2:SetTarget(c33569915.sptg)
	e2:SetOperation(c33569915.spop)
	c:RegisterEffect(e2)
	--revive
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCondition(c33569915.spcon2)
	e3:SetOperation(c33569915.spop2)
	c:RegisterEffect(e3)
	--prevent atk 1turn/pos-blubber rope
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(33569915,0))
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetTarget(c33569915.target)
	e4:SetOperation(c33569915.operation)
	c:RegisterEffect(e4)
	--tribute eff-eat candy
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(33569915,1))
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCountLimit(1)
	e5:SetCost(c33569915.Pcost)
	e5:SetOperation(c33569915.operation2)
	c:RegisterEffect(e5)
	--destroy monster turn to chocolate
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(33569915,2))
	e6:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_IGNORE_IMMUNE)
	e6:SetCategory(CATEGORY_DESTROY)
	e6:SetType(EFFECT_TYPE_IGNITION)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCountLimit(1)
	e6:SetTarget(c33569915.destg)
	e6:SetOperation(c33569915.desop)
	c:RegisterEffect(e6)
	--add leave field check
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e7:SetCode(EVENT_LEAVE_FIELD_P)
	e7:SetOperation(c33569915.evilop)
	e7:SetLabelObject(e3)
	c:RegisterFlagEffect(33569915,RESET_EVENT+0x1fe0000,0,1)
	c:RegisterEffect(e7)
	-- Cannot Banish/disable/tohand/todeck/tograve
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
	e8:SetRange(LOCATION_MZONE)
	e8:SetCode(EFFECT_CANNOT_REMOVE)
	e8:SetValue(1)
	c:RegisterEffect(e8)
	local e9=e8:Clone()
	e9:SetCode(EFFECT_CANNOT_DISABLE)
	c:RegisterEffect(e9)
	local e10=e8:Clone()
	e10:SetCode(EFFECT_CANNOT_TO_GRAVE)
	c:RegisterEffect(e10)
	local e11=e8:Clone()
	e11:SetCode(EFFECT_CANNOT_TO_HAND)
	c:RegisterEffect(e11)
	local e12=e8:Clone()
	e12:SetCode(EFFECT_CANNOT_TO_DECK)
	c:RegisterEffect(e12)
	--control
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_MZONE)
	e13:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
	c:RegisterEffect(e13)
end

function c33569915.filter2(c)
	return c:IsType(TYPE_MONSTER)
end


function c33569915.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c33569915.filter2(chkc) and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingTarget(c33569915.filter2,tp,0,LOCATION_MZONE,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c33569915.filter2,tp,0,LOCATION_MZONE,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c33569915.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	if Duel.Destroy(tc,REASON_EFFECT)>0  then
	return  Duel.GetLocationCount(1-tp,LOCATION_MZONE,tp)>0 and Duel.IsPlayerCanSpecialSummonMonster(tp,22222216,0,0x4011,2500,2500,7,RACE_FIEND,ATTRIBUTE_DARK,POS_FACEUP,1-tp) end
			local token=Duel.CreateToken(tp,22222216)
			Duel.SpecialSummon(token,0,tp,1-tp,false,false,POS_FACEUP_DEFENSE)
			end
end



c33569915.collection={ [22222215]=true; [22222216]=true; }

function c33569915.candyfilter(c)
	return c33569915.collection[c:GetCode()]
end

function c33569915.filter(c)
    return c:IsFaceup() and c:IsCode(33569915)
end

function c33569915.operation2(e,tp,eg,ep,ev,re,r,rp,chk)	
	local c=e:GetHandler()
    if c:IsRelateToEffect(e) and c33569915.filter(c) then
        local e1=Effect.CreateEffect(e:GetHandler())
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_UPDATE_ATTACK)
        e1:SetValue(700)
        e1:SetReset(RESET_EVENT+0x1fe0000)
        c:RegisterEffect(e1)
        local e2=e1:Clone()
        e2:SetCode(EFFECT_UPDATE_DEFENSE)
        c:RegisterEffect(e2)
    end
end


function c33569915.Pcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c33569915.candyfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	local c = Duel.SelectMatchingCard(tp,c33569915.candyfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.Destroy(c,REASON_COST)
end

function c33569915.regop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(33569915,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
function c33569915.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(33569915)~=0
end
function c33569915.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c33569915.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,22222215,0,0x4011,1200,0,4,RACE_INSECT,ATTRIBUTE_EARTH) then return end
	local token=Duel.CreateToken(tp,22222215)
	Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
end

function c33569915.spcon2(e,tp,eg,ep,ev,re,r,rp)
    return bit.band(r,REASON_DESTROY)~=0 and e:GetHandler():IsPreviousLocation(LOCATION_MZONE)
end
function c33569915.spop2(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
	if  c:IsRelateToEffect(e) then return end
    local n=e:GetLabel()
    if  n>=2 then
        if  Duel.IsPlayerCanSpecialSummonMonster(tp,33569959,0,0x4011,0,0,1,RACE_MACHINE,ATTRIBUTE_DARK) then
            local token=Duel.CreateToken(tp,33569959)
           Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP_ATTACK+POS_FACEDOWN_DEFENSE)
		   Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
            Duel.SpecialSummonComplete()
        end
    else
        local pos=c:GetPreviousPosition()
        if bit.band(pos,POS_FACEDOWN)~=0 then pos=bit.rshift(POS_FACEUP,1) end
        if Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)~=0 then
            n=n+1
            c:RegisterFlagEffect(33569915,RESET_EVENT+0x1fe0000,0,0,n)
            c:SetTurnCounter(n)
        end
    end
end


function c33569915.evilop(e,tp,eg,ep,ev,re,r,rp)
    --raise_single_event(pcard, 0, EVENT_LEAVE_FIELD_P, pcard->current.reason_effect, pcard->current.reason, pcard->current.reason_player, 0, 0);
        if bit.band(r,REASON_DESTROY)==REASON_DESTROY and e:GetHandler():GetFlagEffect(33569915)~=0 then
        e:GetLabelObject():SetLabel(e:GetHandler():GetFlagEffectLabel(33569915))
    else
        e:GetLabelObject():SetLabel(0)
    end
end

function c33569915.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(nil,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,nil,tp,0,LOCATION_MZONE,1,1,nil)
end
function c33569915.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e)  then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,2)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,2)
		tc:RegisterEffect(e2)
		end 
		local c=e:GetHandler()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_COPY_INHERIT)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-500)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_COPY_INHERIT)
		e2:SetReset(RESET_EVENT+0x1ff0000)
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		e2:SetValue(-500)
		c:RegisterEffect(e2)
	end
