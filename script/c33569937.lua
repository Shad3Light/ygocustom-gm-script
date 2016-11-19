--yELLOW lUSTER sHIELD (DOR)
--scripted by GameMaster (GM)
function c33569937.initial_effect(c)
 --All your faceup monsters gain 900 DEF
 local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_FREE_CHAIN)
  e1:SetCategory(CATEGORY_ATKCHANGE)
  e1:SetTarget(c33569937.act_tg)
  e1:SetOperation(c33569937.act_op)
  c:RegisterEffect(e1)
end

function c33569937.act_fil(c)
  return c:IsFaceup() and c:IsType(TYPE_MONSTER)
end

function c33569937.act_tg(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return Duel.IsExistingMatchingCard(c33569937.act_fil,tp,LOCATION_MZONE,0,1,nil) end
  Duel.SetOperationInfo(0,CATEGORY_ATKCHANGE,nil,0,0,0)
end

function c33569937.act_op(e,tp,eg,ep,ev,re,r,rp)
  local tg=Duel.GetMatchingGroup(c33569937.act_fil,tp,LOCATION_MZONE,0,nil)
  if tg:GetCount()>0 then
    local tc=tg:GetFirst()
    local c=e:GetHandler()
    while tc do
     local e1=Effect.CreateEffect(e:GetHandler())
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_UPDATE_DEFENSE)
        e1:SetValue(900)
        e1:SetReset(RESET_EVENT+0x1fe0000)
        tc:RegisterEffect(e1)
        tc=tg:GetNext()
    end
  end
end