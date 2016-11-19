--Midnight Fiend (DOR)
--scripted by GameMaster (GM)
function c33569917.initial_effect(c)
--damage + 100
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e1:SetCode(EVENT_DAMAGE)
    e1:SetRange(LOCATION_MZONE)
    e1:SetCondition(c33569917.con)
    e1:SetOperation(c33569917.op)
    c:RegisterEffect(e1)
   end


function c33569917.con(e,tp,eg,ep,ev,re,r,rp)
   return e:GetHandler():IsPosition(POS_FACEUP_DEFENSE) and
(bit.band(r,REASON_BATTLE)==REASON_BATTLE or (bit.band(r,REASON_EFFECT)==REASON_EFFECT and re:GetHandler():GetCode()~=e:GetHandler():GetCode()))
end


function c33569917.op(e,tp,eg,ep,ev,re,r,rp)
      local val=ev
      Duel.Damage(ep,100,REASON_EFFECT)
   end