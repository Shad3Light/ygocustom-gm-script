--Logicast Negato
function c66011.initial_effect(c)
  --enable pendulum summon
  aux.EnablePendulumAttribute(c)
  --Pendulum: negate
  local e1=Effect.CreateEffect(c)
  e1:SetDescription(aux.Stringid(66011,0))
  e1:SetType(EFFECT_TYPE_QUICK_O)
  e1:SetCode(EVENT_FREE_CHAIN)
  e1:SetRange(LOCATION_PZONE)
  e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
  e1:SetHintTiming(0,TIMING_MAIN_END)
  e1:SetCountLimit(1)
  e1:SetCondition(c66011.neg_cond)
  e1:SetTarget(c66011.neg_tg)
  e1:SetOperation(c66011.neg_op)
  c:RegisterEffect(e1)
  --change p-scale
  local e2=Effect.CreateEffect(c)
  e2:SetDescription(aux.Stringid(66011,1))
  e2:SetType(EFFECT_TYPE_IGNITION)
  e2:SetRange(LOCATION_PZONE)
  e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
  e2:SetCountLimit(1)
  e2:SetTarget(c66011.cscale_tg)
  e2:SetOperation(c66011.cscale_op)
  c:RegisterEffect(e2)
  --Banished, draw
  local e3=Effect.CreateEffect(c)
  e3:SetDescription(aux.Stringid(66011,2))
  e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
  e3:SetCode(EVENT_REMOVE)
  e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
  e3:SetCategory(CATEGORY_HANDES+CATEGORY_DRAW)
  e3:SetTarget(c66011.draw_tg)
  e3:SetOperation(c66011.draw_op)
  c:RegisterEffect(e3)
end

function c66011.neg_cond(e,tp,eg,ep,ev,re,r,rp)
  local ph=Duel.GetCurrentPhase()
  return ph==PHASE_MAIN1 or ph==PHASE_MAIN2
end

function c66011.neg_fil(c)
  return c:IsFaceup() and not c:IsDisabled()
end

function c66011.neg_tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
  if chkc then return chkc:IsOnField() and c66011.neg_fil(chkc) end
  if chk==0 then return Duel.IsExistingTarget(c66011.neg_fil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
  Duel.SelectTarget(tp,c66011.neg_fil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,e:GetHandler())
  Duel.SetOperationInfo(0,CATEGORY_DISABLE,g,1,0,0)
end

function c66011.neg_op(e,tp,eg,ep,ev,re,r,rp)
  local c=e:GetHandler()
  if not c:IsRelateToEffect(e) then return end
  local tc=Duel.GetFirstTarget()
  if (c66011.neg_fil(tc) or tc:IsType(TYPE_TRAPMONSTER)) and tc:IsRelateToEffect(e) then
    Duel.NegateRelatedChain(tc,RESET_TURN_SET)
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
    e1:SetCode(EFFECT_DISABLE)
    e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
    tc:RegisterEffect(e1)
    local e2=e1:Clone()
    e2:SetCode(EFFECT_DISABLE_EFFECT)
    e2:SetValue(RESET_TURN_SET)
    tc:RegisterEffect(e2)
    if tc:IsType(TYPE_TRAPMONSTER) then
      local e3=e1:Clone()
      e3:SetCode(EFFECT_DISABLE_TRAPMONSTER)
      tc:RegisterEffect(e3)
    end
    Duel.Destroy(c,REASON_EFFECT)
  end
end

function c66011.cscale_fil(c)
  return c:IsFaceup() and (c:GetSequence()==6 or c:GetSequence()==7)
end

function c66011.cscale_tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
  if chkc then return c66011.cscale_fil(chkc) end
  if chk==0 then return Duel.IsExistingTarget(c66011.cscale_fil,tp,0,LOCATION_SZONE,1,nil) end
  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
  Duel.SelectTarget(tp,c66011.cscale_fil,tp,0,LOCATION_SZONE,1,1,nil)
end

function c66011.cscale_op(e,tp,eg,ep,ev,re,r,rp)
  local c=e:GetHandler()
  if not c:IsRelateToEffect(e) then return end
  local tc=Duel.GetFirstTarget()
  if c66011.cscale_fil(tc) and tc:IsRelateToEffect(e) then
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_CHANGE_LSCALE)
    e1:SetValue(tc:GetLeftScale())
    e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
    c:RegisterEffect(e1)
    local e2=e1:Clone()
    e2:SetCode(EFFECT_CHANGE_RSCALE)
    e2:SetValue(tc:GetRightScale())
    c:RegisterEffect(e2)
  end
end

function c66011.draw_tg(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return Duel.IsPlayerCanDraw(tp) and Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_HAND,0,2,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,tp,LOCATION_HAND)
end

function c66011.draw_op(e,tp,eg,ep,ev,re,r,rp)
  if Duel.DiscardHand(tp,nil,1,1,REASON_EFFECT+REASON_DISCARD)==0 then return end
  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
  local g=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,63,nil)
  --local i=g:GetCount()
  Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
  Duel.ShuffleDeck(tp)
  Duel.BreakEffect()
  Duel.Draw(tp,g:GetCount()+1,REASON_EFFECT)
end