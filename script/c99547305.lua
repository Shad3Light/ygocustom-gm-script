--99547305
function c99547305.initial_effect(c)
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e1:SetRange(LOCATION_MZONE)
    e1:SetCode(EFFECT_ADD_RACE)
    e1:SetValue(RACE_ZOMBIE)
    c:RegisterEffect(e1)
end