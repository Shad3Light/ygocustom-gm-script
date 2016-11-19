--Valmars claws- Grudging Claw
function c33559943.initial_effect(c)
    --Activate
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
    e1:SetCode(EVENT_FREE_CHAIN)
    c:RegisterEffect(e1)
    --pos
    local e2=Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(33559943,0))
    e2:SetCategory(CATEGORY_POSITION)
    e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
    e2:SetCode(EVENT_SUMMON_SUCCESS)
    e2:SetRange(LOCATION_SZONE)
    e2:SetTarget(c33559943.target)
    e2:SetOperation(c33559943.operation)
    c:RegisterEffect(e2)
    local e3=e2:Clone()
    e3:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
    c:RegisterEffect(e3)
    local e4=e2:Clone()
    e4:SetCode(EVENT_SPSUMMON_SUCCESS)
    c:RegisterEffect(e4)
    -- Cannot Disable effect
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetCode(EFFECT_CANNOT_DISABLE)
	e5:SetRange(LOCATION_SZONE)
	c:RegisterEffect(e5)
	-- Cannot Banish 
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e6:SetCode(EFFECT_CANNOT_REMOVE)
	e6:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e6)
end
function c33559943.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then
        local ec=eg:GetFirst()
        while ec do
            if ec:IsControler(tp) then return false end
            ec=eg:GetNext()
        end
        return e:GetHandler():IsRelateToEffect(e)
    end
    Duel.SetTargetCard(eg)
    Duel.SetOperationInfo(0,CATEGORY_POSITION,eg,eg:GetCount(),0,0)
end
function c33559943.filter(c,e)
    return c:IsFaceup() and c:IsAttackPos() and c:IsRelateToEffect(e)
end
function c33559943.operation(e,tp,eg,ep,ev,re,r,rp)
    if not e:GetHandler():IsRelateToEffect(e) then return end
    local g=eg:Filter(c33559943.filter,nil,e)
    Duel.ChangePosition(g,POS_FACEUP_DEFENSE)
end