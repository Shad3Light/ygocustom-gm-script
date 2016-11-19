--Remove Trap
--scripted by GameMaster (GM)
function c335599142.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c335599142.target)
	e1:SetOperation(c335599142.activate)
	c:RegisterEffect(e1)
--activate turn set
local e2=Effect.CreateEffect(c)
e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
e2:SetCode(EVENT_SSET)
e2:SetOperation(c335599142.op) 
Duel.RegisterEffect(e2,0)
end
function c335599142.filter(c)
return c:IsFaceup() and c:IsDestructable() and c:IsType(TYPE_TRAP)
end
function c335599142.target(e,tp,eg,ep,ev,re,r,rp,chk)
if chkc then return chkc:IsOnField() and c335599142.filter(chkc) end
if chk==0 then return Duel.IsExistingTarget(c335599142.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
local g=Duel.SelectTarget(tp,c335599142.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,e:GetHandler())
Duel.SetOperationInfo(0,CATEGORY_DESTROY+CATEGORY_NEGATE,g,1,0,0)
end
function c335599142.activate(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    local tc=Duel.GetFirstTarget()
    Duel.NegateRelatedChain(tc,RESET_TURN_SET)
        local e1=Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
        e1:SetCode(EFFECT_DISABLE)
        e1:SetReset(RESET_EVENT+0x1fe0000)
        tc:RegisterEffect(e1)
        local e2=Effect.CreateEffect(c)
        e2:SetType(EFFECT_TYPE_SINGLE)
        e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
        e2:SetCode(EFFECT_DISABLE_EFFECT)
        e2:SetValue(RESET_TURN_SET)
        e2:SetReset(RESET_EVENT+0x1fe0000)
        tc:RegisterEffect(e2)
    Duel.Destroy(tc,REASON_EFFECT)
end
function c335599142.op(e,tp,eg,ep,ev,re,r,rp)
local c=eg:GetFirst()
while c do
    if c:GetOriginalCode()==335599142 then c:SetStatus(STATUS_SET_TURN,false) end
    c=eg:GetNext()
	end
end
