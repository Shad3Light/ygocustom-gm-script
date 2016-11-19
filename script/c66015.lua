--Logicast Equa
function c66015.initial_effect(c)
  --Pendulum Attr
  aux.EnablePendulumAttribute(c)
  --Pendulum Effect 1
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_IGNITION)
  e1:SetRange(LOCATION_PZONE)
  e1:SetDescription(aux.Stringid(66015,0))
  e1:SetCategory(CATEGORY_TOHAND)
  e1:SetCountLimit(1)
  e1:SetTarget(c66015.pfx1_tg)
  e1:SetOperation(c66015.pfx1_op)
  c:RegisterEffect(e1)
  --Pendulum Effect 2
  local e2=Effect.CreateEffect(c)
  e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
  e2:SetCode(EVENT_PHASE+PHASE_END)
  e2:SetRange(LOCATION_PZONE)
  e2:SetDescription(aux.Stringid(66015,1))
  e2:SetCategory(CATEGORY_REMOVE)
  e2:SetCondition(c66015.pfx2_cd)
  e2:SetOperation(c66015.pfx2_op)
  e2:SetCountLimit(1)
  c:RegisterEffect(e2)
  --Monster Effect 1
  local e3=Effect.CreateEffect(c)
  e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
  e3:SetCode(EVENT_SUMMON_SUCCESS)
  e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
  e3:SetDescription(aux.Stringid(66015,3))
  e3:SetCategory(CATEGORY_ATKCHANGE)
  e3:SetTarget(c66015.mfx1_tg)
  e3:SetOperation(c66015.mfx1_op)
  c:RegisterEffect(e3)
  local e4=e3:Clone()
  e4:SetCode(EVENT_SPSUMMON_SUCCESS)
  c:RegisterEffect(e4)
  local e5=e3:Clone()
  e5:SetCode(EVENT_FLIP)
  c:RegisterEffect(e5)
  --Monster Effect 2
  local e6=Effect.CreateEffect(c)
  e6:SetDescription(aux.Stringid(66015,4))
  e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
  e6:SetCode(EVENT_REMOVE)
  e6:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
  e6:SetTarget(c66015.mfx2_tg)
  e6:SetOperation(c66015.mfx2_op)
  c:RegisterEffect(e6)
end

--Pendulum Effect 1
--Target 1 banished lv5down pendulum, add to hand

function c66015.pfx1_fil(c)
  return c:IsFaceup() and c:GetLevel()<=5 and c:IsType(TYPE_PENDULUM) and c:IsAbleToHand()
end

function c66015.pfx1_tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
  if chkc then return chkc:IsLocation(LOCATION_REMOVED) and c66015.pfx1_fil(chkc) end
  if chk==0 then return Duel.IsExistingTarget(c66015.pfx1_fil,tp,LOCATION_REMOVED,0,1,nil) end
  Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(66015,0))
  local g=Duel.SelectTarget(tp,c66015.pfx1_fil,tp,LOCATION_REMOVED,0,1,1,nil)
  Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,tp,LOCATION_REMOVED)
end

function c66015.pfx1_op(e,tp,eg,ep,ev,re,r,rp)
  if not e:GetHandler():IsRelateToEffect(e) then return end
  local tc=Duel.GetFirstTarget()
  if tc:IsRelateToEffect(e) then Duel.SendtoHand(tc,tp,REASON_EFFECT) end
end

--Pendulum Effect 2
--Banish hand or this

function c66015.pfx2_cd(e,tp,eg,ep,ev,re,r,rp)
  return Duel.GetTurnPlayer()==tp
end

function c66015.pfx2_fil(c)
  return c:IsAbleToRemove()
end

function c66015.pfx2_op(e,tp,eg,ep,ev,re,r,rp)
  if not e:GetHandler():IsRelateToEffect(e) then return end
  if Duel.IsExistingMatchingCard(c66015.pfx2_fil,tp,LOCATION_HAND,0,1,nil) and Duel.SelectYesNo(tp,aux.Stringid(66015,2)) then
    Duel.Remove(Duel.SelectMatchingCard(tp,c66015.pfx2_fil,tp,LOCATION_HAND,0,1,1,nil),POS_FACEUP,REASON_EFFECT)
  else
    Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT)
  end
end

--Monster Effect 1
--Change ATK

function c66015.mfx1_fil(c)
  return c:IsFaceup()
end

function c66015.mfx1_tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
  if chkc then return chkc:IsLocation(LOCATION_MZONE) and c66015.mfx1_fil(chkc) end
  if chk==0 then return Duel.IsExistingTarget(c66015.mfx1_fil,tp,0,LOCATION_MZONE,1,nil) end
  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
  local g=Duel.SelectTarget(tp,c66015.mfx1_fil,tp,0,LOCATION_MZONE,1,1,nil)
  Duel.SetOperationInfo(0,CATEGORY_ATKCHANGE,g,1,tp,LOCATION_MZONE)
end

function c66015.mfx1_op(e,tp,eg,ep,ev,re,r,rp)
  local tc=Duel.GetFirstTarget()
  if tc:IsFacedown() or not tc:IsRelateToEffect(e) then return end
  local c=e:GetHandler()
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_SINGLE)
  e1:SetCode(EFFECT_SET_ATTACK_FINAL)
  e1:SetRange(LOCATION_MZONE)
  e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
  e1:SetValue(c:GetTextAttack())
  tc:RegisterEffect(e1)
end

--Monster Effect 2
--"Logicast" to deck top

function c66015.mfx2_fil(c)
  return c:IsSetCard(0x66B) and c:IsType(TYPE_MONSTER)
end

function c66015.mfx2_tg(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return Duel.IsExistingMatchingCard(c66015.mfx2_fil,tp,LOCATION_DECK,0,1,nil) end
end

function c66015.mfx2_op(e,tp,eg,ep,ev,re,r,rp)
  Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(66015,4))
  local tc=Duel.SelectMatchingCard(tp,c66015.mfx2_fil,tp,LOCATION_DECK,0,1,1,nil):GetFirst()
  if tc then
    Duel.ShuffleDeck(tp)
    Duel.MoveSequence(tc,0)
    Duel.ConfirmDecktop(tp,1)
  end
end