-- Machine duplication
-- scripted by GameMaster(GM)
function c335599141.initial_effect(c)
	-- Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c335599141.target)
	e1:SetOperation(c335599141.activate)
  c:RegisterEffect(e1)
  --remain field
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_REMAIN_FIELD)
	c:RegisterEffect(e2)
 end
function c335599141.filter(c,e,tp)
	if c:IsFacedown() then return false end
	if c:IsAttackBelow(500) and c:IsRace(RACE_MACHINE) then
		return Duel.IsPlayerCanSpecialSummonMonster(tp,c:GetOriginalCode(),0,c:GetType(),c:GetAttack(),c:GetDefense(),c:GetLevel(),c:GetRace(),c:GetAttribute()) 
			and Duel.GetLocationCount(tp,LOCATION_MZONE)>1
	else return false 
	end
end
function c335599141.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c335599141.filter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c335599141.filter,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c335599141.filter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
		Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,2,0,0)
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
end

function c335599141.activate(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler() --this one
    if not c:IsRelateToEffect(e) then return end --look
    local tc=Duel.GetFirstTarget()
    local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
    if not tc or tc:IsFacedown() or not tc:IsRelateToEffect(e) then return end
    local sg=Group.CreateGroup()
    local fid=tc:GetFieldID()  --retrieve fieldid from target card
    for i=1,2 do
        local token=Duel.CreateToken(tp,tc:GetOriginalCode())
        Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
         local e1=Effect.CreateEffect(e:GetHandler())
            e1:SetType(EFFECT_TYPE_SINGLE)
            e1:SetCode(EFFECT_SET_BASE_ATTACK)
            e1:SetValue(tc:GetAttack())
            e1:SetReset(RESET_EVENT+0x1fe0000)
            token:RegisterEffect(e1)
            local e2=e1:Clone()
            e2:SetCode(EFFECT_SET_BASE_DEFENSE)
            e2:SetValue(tc:GetDefense())
            token:RegisterEffect(e2)
            local e3=e1:Clone()
            e3:SetCode(EFFECT_CHANGE_LEVEL)
            e3:SetValue(tc:GetLevel())
            token:RegisterEffect(e3)
            local e4=e1:Clone()
            e4:SetCode(EFFECT_CHANGE_RACE)
            e4:SetValue(tc:GetRace())
            token:RegisterEffect(e4)
            local e5=e1:Clone()
            e5:SetCode(EFFECT_CHANGE_ATTRIBUTE)
            e5:SetValue(tc:GetAttribute())
            token:RegisterEffect(e5)
            local e6=Effect.CreateEffect(e:GetHandler())
            e6:SetType(EFFECT_TYPE_SINGLE)
            e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
            e6:SetReset(RESET_EVENT+0x1fe0000)
            e6:SetCode(EFFECT_CHANGE_CODE)
            e6:SetValue(tc:GetOriginalCode())
            token:RegisterEffect(e6)
        sg:AddCard(token)   -- <== this
        token:RegisterFlagEffect(335599141,RESET_EVENT+0x1fe0000,0,0,fid)
    end
    Duel.SpecialSummonComplete()
    sg:AddCard(c) --Add the spell to the group
    c:RegisterFlagEffect(335599141,RESET_EVENT+0x1fe0000,0,0,fid)
    sg:KeepAlive()  --makes the group persist even after the operation is over
    --destroy monster & this card over 500 ATk
    local e1=Effect.CreateEffect(c) 
    e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e1:SetCode(EVENT_ADJUST)
    e1:SetRange(LOCATION_SZONE)
    e1:SetLabel(fid)
    e1:SetLabelObject(sg)
    e1:SetCondition(c335599141.descon)
    e1:SetOperation(c335599141.desop)
    e1:SetReset(RESET_EVENT+0x1fe0000)
    c:RegisterEffect(e1)
    c:SetCardTarget(tc) -- sets tc as target of card c
end
 function c335599141.desfilter(c,fid)
    return c:GetFlagEffectLabel(335599141)==fid
end
function c335599141.descon(e,tp,eg,ep,ev,re,r,rp)
    local g=e:GetLabelObject()
    if not g:IsExists(c335599141.desfilter,1,nil,e:GetLabel()) then
        g:DeleteGroup()
        e:Reset()
        return false
    else 
        local tc=e:GetHandler():GetFirstCardTarget() --this
      if tc then 
            return tc:GetAttack()>500 --yeah
        else
            g:DeleteGroup()
            e:Reset()
            return false
        end
    end
end
function c335599141.desop(e,tp,eg,ep,ev,re,r,rp)
    local g=e:GetLabelObject()
    local tg=g:Filter(c335599141.desfilter,nil,e:GetLabel())
    Duel.Destroy(tg,REASON_EFFECT)
end