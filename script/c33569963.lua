--Hinotama Soul (DOR)
--scripted by GameMaster (GM)
function c33569963.initial_effect(c)
--Destroy spells in colums
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
  e1:SetCode(EVENT_BATTLE_DESTROYED)
  e1:SetCategory(CATEGORY_DESTROY)
  e1:SetDescription(HINTMSG_DESTROY)
  e1:SetTarget(c33569963.target)
  e1:SetOperation(c33569963.operation)
  c:RegisterEffect(e1)
  end
  
  function c33569963.operation(e,tp,eg,ep,ev,re,r,rp)
  local seq=e:GetHandler():GetPreviousSequence()
  local g=Group.CreateGroup()
  local tc=Duel.GetFieldCard(1-tp,LOCATION_SZONE,4-seq)
  if tc then g:AddCard(tc) end
  local tc2=Duel.GetFieldCard(tp,LOCATION_SZONE,seq)
  if tc2 then g:AddCard(tc2) end
  if g:GetCount()>0 then Duel.Destroy(g,REASON_EFFECT) end
end

function c33569963.target(e,tp,eg,ep,ev,re,r,rp,chk)
  local seq=e:GetHandler():GetPreviousSequence()
  local tc=Duel.GetFieldCard(1-tp,LOCATION_SZONE,4-seq)
  local tc2=Duel.GetFieldCard(tp,LOCATION_SZONE,seq)
  if chk==0 then return tc or tc2 end
  local g=Group.CreateGroup()
  if tc then g:AddCard(tc) end
  if tc2 then g:AddCard(tc2) end
  Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end