--Logicast Disjunctium
function c66013.initial_effect(c)
  --Pendulum summon enable
  aux.EnablePendulumAttribute(c)
  --PendulumEffect1
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
  e1:SetCode(EVENT_PHASE+PHASE_BATTLE_START)
  e1:SetRange(LOCATION_PZONE)
  e1:SetDescription(aux.Stringid(66013,0))
  e1:SetCategory(CATEGORY_ATKCHANGE)
  e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
  e1:SetCondition(c66013.turnpl_cond)
  e1:SetTarget(c66013.swp_tg)
  e1:SetOperation(c66013.swp_op)
  e1:SetCountLimit(1)
  c:RegisterEffect(e1)
  --PendulumEffect2
  local e2=Effect.CreateEffect(c)
  e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
  e2:SetCode(EVENT_PHASE+PHASE_END)
  e2:SetRange(LOCATION_PZONE)
  e2:SetDescription(aux.Stringid(66013,1))
  e2:SetCategory(CATEGORY_REMOVE)
  e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
  e2:SetCondition(c66013.turnpl_cond)
  e2:SetTarget(c66013.ban_tg)
  e2:SetOperation(c66013.ban_op)
  e2:SetCountLimit(1)
  c:RegisterEffect(e2)
  --MonsterEffect
  local e3=Effect.CreateEffect(c)
  e3:SetType(EFFECT_TYPE_FIELD)
  e3:SetCode(EFFECT_UPDATE_ATTACK)
  e3:SetRange(LOCATION_MZONE)
  e3:SetTargetRange(0,LOCATION_MZONE)
  e3:SetValue(c66013.debuff_val)
  c:RegisterEffect(e3)
end

--Common funcs

function c66013.turnpl_cond(e,tp,eg,ep,ev,re,r,rp)
  return Duel.GetTurnPlayer()==tp and Duel.GetCurrentChain()==0
end

--PendulumEffect1

function c66013.swp_fil(c)
  return c:IsFaceup()
end

function c66013.swp_tg(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return Duel.IsExistingTarget(c66013.swp_fil,tp,LOCATION_MZONE,LOCATION_MZONE,2,nil) end
  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
  Duel.SelectTarget(tp,c66013.swp_fil,tp,LOCATION_MZONE,LOCATION_MZONE,2,2,nil)
end

function c66013.swp_op(e,tp,eg,ep,ev,r,rp)
  local c=e:GetHandler()
  if not c:IsRelateToEffect(e) then return end
  local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
  local m1=g:GetFirst()
  local m2=g:GetNext()
  if m1:IsFaceup() and m2:IsFaceup() and m1:IsRelateToEffect(e) and m2:IsRelateToEffect(e) then
    local atk1=m1:GetBaseAttack()
    local atk2=m2:GetBaseAttack()
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_SET_BASE_ATTACK)
    e1:SetValue(atk2)
    e1:SetReset(RESET_EVENT+0x1fe0000)
    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
    m1:RegisterEffect(e1)
    local e2=e1:Clone()
    e2:SetValue(atk1)
    m2:RegisterEffect(e2)
  end
end

--PendulumEffect2

function c66013.ban_fil(c)
  return c:IsFaceup() and c:IsAbleToRemove()
end

function c66013.ban_tg(e,tp,eg,ep,ev,re,r,rp,chk)
  --if chkc then return chkc:IsController(tp) and chkc:IsLocation(LOCATION_MZONE) and c66013.ban_tg(chkc) end
  if chk==0 then return Duel.IsExistingTarget(c66013.ban_fil,tp,LOCATION_MZONE,0,1,nil) end
  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
  local g=Duel.SelectTarget(tp,c66013.ban_fil,tp,LOCATION_MZONE,0,1,1,nil)
  Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end

function c66013.ban_op(e,tp,eg,ep,ev,re,r,rp)
  local c=e:GetHandler()
  if not c:IsRelateToEffect(e) then return end
  local tc=Duel.GetFirstTarget()
  if tc:IsRelateToEffect(e) and Duel.Remove(tc,nil,REASON_EFFECT+REASON_TEMPORARY)~=0 then
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
    e1:SetRange(LOCATION_REMOVED)
    e1:SetLabel(Duel.GetTurnCount()+2)
    e1:SetReset(RESET_EVENT+0x1fe0000)
    e1:SetCondition(c66013.unban_cond)
    e1:SetOperation(c66013.unban_op)
    --e1:SetCountLimit(1)
    tc:RegisterEffect(e1)
  end
end

function c66013.unban_cond(e,tp,eg,ep,ev,re,r,rp)
  return Duel.GetTurnCount()==e:GetLabel()
end

function c66013.unban_op(e,tp,eg,ep,ev,re,r,rp)
  local c=e:GetHandler()
  if c:IsForbidden() then
    Duel.SendtoGrave(c,REASON_RULE)
  elseif Duel.ReturnToField(c) and c:IsFaceup() then
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_SET_BASE_ATTACK)
    e1:SetValue(2500)
    e1:SetReset(RESET_EVENT+0x1fe0000)
    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
    c:RegisterEffect(e1)
  end
  e:Reset()
end

--MonsterEffect

function c66013.debuff_fil(c)
  return c:IsFaceup() and c:IsSetCard(0x66B)
end

function c66013.debuff_val(e,c)
  return Duel.GetMatchingGroupCount(c66013.debuff_fil,e:GetHandlerPlayer(),LOCATION_REMOVED,0,nil)*-200
end