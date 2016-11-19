--Dark eye illusionist
--scripted by GameMaster(GM)
function c33559941.initial_effect(c)
      --negate attack
    local e2=Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(511000867,0))
    e2:SetType( EFFECT_TYPE_SINGLE+EFFECT_TYPE_QUICK_F)
    e2:SetRange(LOCATION_MZONE)
    e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
    e2:SetCode(EVENT_BE_BATTLE_TARGET)
    e2:SetLabel(0)
    e2:SetCondition(c33559941.condition)
    e2:SetOperation(c33559941.activate)
    c:RegisterEffect(e2)
end

function c33559941.filter(c)
    return c:IsFaceup() and c:IsCode(33559941)
end
function c33559941.condition(e,tp,eg,ep,ev,re,r,rp)
    local ct=Duel.GetMatchingGroupCount(c33559941.filter,tp,LOCATION_MZONE,0,nil)
    return not e:GetHandler():IsStatus(STATUS_CHAINING) and tp~=Duel.GetTurnPlayer()
end
function c33559941.activate(e,tp,eg,ep,ev,re,r,rp)
    Duel.NegateAttack()
    local c=e:GetHandler()
    local bc=c:GetBattleTarget()
    if bc and bc==Duel.GetAttacker() then
        Duel.Hint(HINT_CARD,0,33559941)
        local e1=Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_CANNOT_ATTACK)
        e1:SetReset(RESET_EVENT+0x1fe0000)
        bc:RegisterEffect(e1)
        local e2=Effect.CreateEffect(c)
        e2:SetType(EFFECT_TYPE_SINGLE)
        e2:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
        e2:SetReset(RESET_EVENT+0x1fe0000)
        bc:RegisterEffect(e2)
end
end