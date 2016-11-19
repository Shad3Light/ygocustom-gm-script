--Shadow Ghoul (DOR)
--scripted by GameMaster (GM)
function c33569905.initial_effect(c)
--move to unoccupied zone
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c33569905.tg)
	e1:SetOperation(c33569905.op)
	e1:SetCountLimit(1)
	c:RegisterEffect(e1)
   local e2=Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(33569905,0))
    e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
    e2:SetRange(LOCATION_SZONE)
    e2:SetCode(EVENT_CHAIN_END)
    e2:SetCost(c33569905.spcost)
    e2:SetTarget(c33569905.sptg)
    e2:SetOperation(c33569905.spop)
    c:RegisterEffect(e2)
    --required
    local e3=Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    e3:SetCode(EVENT_ADJUST)
    e3:SetOperation(c33569905.regop)
    c:RegisterEffect(e3)

end
function c33569905.movefilter(c)
    return c:IsType(TYPE_MONSTER) and c:IsCode(30778711)
end
function c33569905.tg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c33569905.movefilter,tp,LOCATION_ONFIELD,0,1,nil) and
        (Duel.GetLocationCount(tp,LOCATION_MZONE)>0 or Duel.GetLocationCount(tp,LOCATION_SZONE)> 0 ) end
    local zone=LOCATION_ONFIELD
    if Duel.GetLocationCount(tp,LOCATION_MZONE)==0 then zone=LOCATION_MZONE end
    if Duel.GetLocationCount(tp,LOCATION_SZONE)==0 then zone=LOCATION_SZONE end
    local g=Duel.SelectTarget(tp,c33569905.movefilter,tp,zone,0,1,1,nil)
end
function c33569905.op(e,tp,eg,ep,ev,re,r,rp)
    local mon=Duel.GetFirstTarget()
    local dest=LOCATION_MZONE
    if mon:GetLocation()==LOCATION_MZONE then dest=LOCATION_SZONE end
    local pos=POS_FACEUP
    if mon:IsFacedown() then pos=POS_FACEDOWN_DEFENSE end
    Duel.MoveToField(mon,tp,tp,dest,pos,true)
    if mon:GetOwner()~=tp then 
        local e1=Effect.CreateEffect(e:GetHandler())
        e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_OWNER_RELATE)
        e1:SetRange(LOCATION_ONFIELD)
        e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_SET_CONTROL)
        e1:SetValue(tp)
        e1:SetReset(RESET_EVENT+0x1fc0000)
        mon:RegisterEffect(e1)
    end
end
---special summon wall shdow

function c33569905.regop(e,tp,eg,ep,ev,re,r,rp)
    e:GetHandler():RegisterFlagEffect(30778711,RESET_EVENT+0x1ec0000+RESET_PHASE+PHASE_END,0,1)
end


function c33569905.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
    Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c33569905.spfilter2(c,e,tp)
    return c:IsCode(63162310) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c33569905.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
        and Duel.IsExistingMatchingCard(c33569905.spfilter2,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c33569905.spop(e,tp,eg,ep,ev,re,r,rp)
    if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
    local g=Duel.SelectMatchingCard(tp,c33569905.spfilter2,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
    local tc=g:GetFirst()
    if tc then
        Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)
            tc:CompleteProcedure()
    end
end 