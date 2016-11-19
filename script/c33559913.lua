--Magical Neutralizing ForceField
function c33559913.initial_effect(c)
    --Activate
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(33559913,0))
    e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DISABLE+CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
    e1:SetCondition(c33559913.condition)
    e1:SetTarget(c33559913.target)
    e1:SetOperation(c33559913.activate)
    c:RegisterEffect(e1)
    local e2=Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(33559913,1))
    e2:SetCategory(CATEGORY_DESTROY+CATEGORY_DISABLE+CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE+CATEGORY_NEGATE)
    e2:SetType(EFFECT_TYPE_ACTIVATE)
    e2:SetCode(EVENT_CHAINING)
    e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
    e2:SetCondition(c33559913.condition2)
    e2:SetTarget(c33559913.target2)
    e2:SetOperation(c33559913.activate2)
    c:RegisterEffect(e2)
    end
    
    
----Activate
function c33559913.condition(e,tp,eg,ep,ev,re,r,rp)
    return true
end
function c33559913.filter1(c)
    return c:IsFaceup() and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c33559913.filter2(c)
    return c:IsFaceup()
end
function c33559913.target(e,tp,eg,ep,ev,re,r,rp,chk)
 if chk==0 then return true end
    local dg=Duel.GetMatchingGroup(c33559913.filter1,tp,0,LOCATION_ONFIELD,nil)
    local mg=Duel.GetMatchingGroup(c33559913.filter2,tp,0,LOCATION_MZONE,nil)
    Duel.SetOperationInfo(0,CATEGORY_DESTROY,dg,dg:GetCount(),0,0)
    Duel.SetOperationInfo(0,CATEGORY_DISABLE,dg,dg:GetCount(),0,0)
    Duel.SetOperationInfo(0,CATEGORY_ATKCHANGE,mg,mg:GetCount(),0,0)
    Duel.SetOperationInfo(0,CATEGORY_DEFCHANGE,mg,mg:GetCount(),0,0)
end
function c33559913.activate(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.SelectYesNo(tp,aux.Stringid(33559913,2)) then
	tp=1-tp
	Duel.MoveToField(e:GetHandler(),tp,1-tp,LOCATION_SZONE,POS_FACEUP,true)
end
    local c=e:GetHandler()
    local dg=Duel.GetMatchingGroup(c33559913.filter1,tp,0,LOCATION_ONFIELD,nil)
    local tc=dg:GetFirst()
    while tc do
        local e1=Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_DISABLE)
        e1:SetReset(RESET_EVENT+0x1fe0000)
        tc:RegisterEffect(e1)
        local e2=Effect.CreateEffect(c)
        e2:SetType(EFFECT_TYPE_SINGLE)
        e2:SetCode(EFFECT_DISABLE_EFFECT)
        e2:SetReset(RESET_EVENT+0x1fe0000)
        tc:RegisterEffect(e2)
        tc=dg:GetNext()
        Duel.Destroy(dg,REASON_EFFECT)
    end
    Duel.BreakEffect()
    local mg=Duel.GetMatchingGroup(c33559913.filter2,tp,0,LOCATION_MZONE,nil)
    local tm=mg:GetFirst()
    while tm do
        local atk=tm:GetBaseAttack()
        local def=tm:GetBaseDefense()
        local e1=Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_SET_ATTACK_FINAL)
        e1:SetValue(atk)
        e1:SetReset(RESET_EVENT+0x1fe0000)
        tm:RegisterEffect(e1)
        local e2=Effect.CreateEffect(c)
        e2:SetType(EFFECT_TYPE_SINGLE)
        e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
        e2:SetValue(def)
        e2:SetReset(RESET_EVENT+0x1fe0000)
        tm:RegisterEffect(e2)
        tm=mg:GetNext()
    end
end
function c33559913.condition2(e,tp,eg,ep,ev,re,r,rp)
    return re:IsActiveType(TYPE_SPELL+TYPE_TRAP) and rp~=tp and Duel.IsChainNegatable(ev)
end
function c33559913.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=e:GetHandlerPlayer()
	if not Duel.SelectYesNo(tp,aux.Stringid(33559913,2)) then
	local tp=1-tp
	Duel.MoveToField(e:GetHandler(),tp,1-tp,LOCATION_SZONE,POS_FACEUP,true)
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
    local dg=Duel.GetMatchingGroup(c33559913.filter1,tp,0,LOCATION_ONFIELD,nil)
    local mg=Duel.GetMatchingGroup(c33559913.filter2,tp,0,LOCATION_MZONE,nil)
    Duel.SetOperationInfo(0,CATEGORY_DESTROY,dg,dg:GetCount(),0,0)
    Duel.SetOperationInfo(0,CATEGORY_DISABLE,dg,dg:GetCount(),0,0)
    Duel.SetOperationInfo(0,CATEGORY_ATKCHANGE,mg,mg:GetCount(),0,0)
    Duel.SetOperationInfo(0,CATEGORY_DEFCHANGE,mg,mg:GetCount(),0,0)
    if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
        Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
    end
end
function c33559913.activate2(e,tp,eg,ep,ev,re,r,rp)
    Duel.NegateActivation(ev)
    if re:GetHandler():IsRelateToEffect(re) then Duel.Destroy(re:GetHandler(),REASON_EFFECT) end
    local c=e:GetHandler()
    local dg=Duel.GetMatchingGroup(c33559913.filter1,tp,0,LOCATION_ONFIELD,nil)
    local tc=dg:GetFirst()
    while tc do
        local e1=Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_DISABLE)
        e1:SetReset(RESET_EVENT+0x1fe0000)
        tc:RegisterEffect(e1)
        local e2=Effect.CreateEffect(c)
        e2:SetType(EFFECT_TYPE_SINGLE)
        e2:SetCode(EFFECT_DISABLE_EFFECT)
        e2:SetReset(RESET_EVENT+0x1fe0000)
        tc:RegisterEffect(e2)
        tc=dg:GetNext()
        Duel.Destroy(dg,REASON_EFFECT)
    end
    Duel.BreakEffect()
    local mg=Duel.GetMatchingGroup(c33559913.filter2,tp,0,LOCATION_MZONE,nil)
    local tm=mg:GetFirst()
    while tm do
        local atk=tm:GetBaseAttack()
        local def=tm:GetBaseDefense()
        local e1=Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_SET_ATTACK_FINAL)
        e1:SetValue(atk)
        e1:SetReset(RESET_EVENT+0x1fe0000)
        tm:RegisterEffect(e1)
        local e2=Effect.CreateEffect(c)
        e2:SetType(EFFECT_TYPE_SINGLE)
        e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
        e2:SetValue(def)
        e2:SetReset(RESET_EVENT+0x1fe0000)
        tm:RegisterEffect(e2)
        tm=mg:GetNext()
    end
end
----Activate
function c33559913.cost(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
local c=e:GetHandler()
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_IMMUNE_EFFECT)
e1:SetValue(c33559913.imfilter)
e1:SetReset(RESET_CHAIN)
Duel.RegisterEffect(e1,tp)
end
function c33559913.imfilter(e,re)
return re:IsActiveType(TYPE_SPELL+TYPE_TRAP+TYPE_MONSTER) and re:GetOwner()~=e:GetOwner()
end