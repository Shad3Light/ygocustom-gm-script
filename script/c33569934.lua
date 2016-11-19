--Frog the Jam (DOR)
--scripted by GameMaster (GM)
function c33569934.initial_effect(c)
	--double lp recovery
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e1:SetCode(EVENT_RECOVER)
    e1:SetRange(LOCATION_MZONE)
    e1:SetCondition(c33569934.con)
    e1:SetOperation(c33569934.op)
    c:RegisterEffect(e1)
 end

function c33569934.con(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():IsPosition(POS_FACEUP_DEFENSE) and re:GetHandler():GetCode()~=e:GetHandler():GetCode()
end

function c33569934.op(e,tp,eg,ep,ev,re,r,rp)
    local val=ev
    Duel.Recover(ep,val,REASON_EFFECT)
end


