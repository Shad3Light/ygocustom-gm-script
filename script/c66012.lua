--Logicast Conjunctium
function c66012.initial_effect(c)
  --enable pendulum summon
  aux.EnablePendulumAttribute(c)
  --Pendulum effect
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_QUICK_O)
  e1:SetCode(EVENT_FREE_CHAIN)
  e1:SetRange(LOCATION_PZONE)
  e1:SetCountLimit(1,66012)
  e1:SetDescription(aux.Stringid(66012,0))
  e1:SetCost(c66012.set_cost)
  e1:SetTarget(c66012.set_tg)
  e1:SetOperation(c66012.set_op)
  c:RegisterEffect(e1)
  --Special Summon proc
  local e2=Effect.CreateEffect(c)
  e2:SetType(EFFECT_TYPE_FIELD)
  e2:SetCode(EFFECT_SPSUMMON_PROC)
  e2:SetRange(LOCATION_EXTRA)
  e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
  e2:SetCondition(c66012.spsum_cond)
  e2:SetOperation(c66012.spsum_op)
  c:RegisterEffect(e2)
  --Monster effect
  local e3=Effect.CreateEffect(c)
  e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
  e3:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
  e3:SetRange(LOCATION_MZONE)
  e3:SetCategory(CATEGORY_ATKCHANGE)
  e3:SetDescription(aux.Stringid(66012,1))
  e3:SetCondition(c66012.atk_cd)
  e3:SetOperation(c66012.atk_op)
  c:RegisterEffect(e3)
end

--Setting
function c66012.set_cost(e,tp,eg,ep,ev,re,r,rp,chk)
  chkc=Duel.GetFieldCard(tp,LOCATION_SZONE,13-e:GetHandler():GetSequence())
  if chk==0 then return chkc and chkc:IsAbleToRemoveAsCost() end
  Duel.Remove(chkc,POS_FACEUP,REASON_COST)
end

function c66012.set_fil(c)
  return c:IsFaceup() and c:IsType(TYPE_PENDULUM) and not c:IsForbidden()
end

function c66012.set_loc(tp)
  return Duel.CheckLocation(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7)
end

function c66012.set_tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
  if chkc then
    return chkc:IsLocation(LOCATION_REMOVED) and c66012.set_fil(chkc)
  end
  if chk==0 then
    return Duel.IsExistingTarget(c66012.set2_fil,tp,LOCATION_REMOVED,0,1,nil) and c66012.set_loc(1-tp)
  end
  Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(66012,0))
  Duel.SelectTarget(tp,c66012.set_fil,tp,LOCATION_REMOVED,0,1,1,nil)
end

function c66012.set_op(e,tp,eg,ep,ev,re,r,rp)
  if not e:GetHandler():IsRelateToEffect(e) then return end
  local tc=Duel.GetFirstTarget()
  if tc:IsRelateToEffect(e) and c66012.set_loc(1-tp) then
    Duel.MoveToField(tc,1-tp,1-tp,LOCATION_SZONE,POS_FACEUP,true)
  end
end

--SpSummon
function c66012.spsum_fil(c)
  return c:IsFaceup() and c:IsSetCard(1643) and c:IsAbleToRemoveAsCost()
end

function c66012.spsum_cond(e,c)
  if c==nil then return true end
  local tp=c:GetOwner()
  local lc=Duel.GetLocationCount(tp,LOCATION_MZONE)
  local mm=Duel.IsExistingMatchingCard(c66012.spsum_fil,tp,LOCATION_MZONE,0,1,nil)
  local mr=Duel.IsExistingMatchingCard(c66012.spsum_fil,tp,LOCATION_GRAVE,0,1,nil)
  return ((lc>-1 and mm) or (lc>0 and (mm or mr)))
end

function c66012.spsum_op(e,tp,eg,ep,ev,re,r,rp,c)
  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
  local g=nil
  if Duel.GetLocationCount(tp,LOCATION_MZONE)==0 then
    g=Duel.SelectMatchingCard(tp,c66012.spsum_fil,tp,LOCATION_MZONE,0,1,1,nil)
  else
    g=Duel.SelectMatchingCard(tp,c66012.spsum_fil,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,1,nil)
  end
  Duel.Remove(g,POS_FACEUP,REASON_COST)
end

--ATKUP
function c66012.atk_cd(e,tp,eg,ep,ev,re,r,rp)
  local a=Duel.GetAttacker()
  local d=Duel.GetAttackTarget()
  if not d then return false end
  if a:IsControler(1-tp) then a,d=d,a end
  return a==e:GetHandler() and a:IsRelateToBattle() and d:GetAttack()>0
end

function c66012.atk_op(e,tp,eg,ep,ev,re,r,rp)
  local a=Duel.GetAttacker()
  local d=Duel.GetAttackTarget()
  if a:IsControler(1-tp) then a,d=d,a end
	if not d:IsRelateToBattle() or d:IsFacedown() then return end
  local e1=Effect.CreateEffect(a)
  e1:SetType(EFFECT_TYPE_SINGLE)
  e1:SetCode(EFFECT_UPDATE_ATTACK)
  e1:SetRange(LOCATION_MZONE)
  e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
  e1:SetReset(RESET_EVENT+0x1fe0000)
  e1:SetValue(d:GetAttack()/2)
  a:RegisterEffect(e1)
  local e2=Effect.CreateEffect(a)
  e2:SetType(EFFECT_TYPE_SINGLE)
  e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
  e2:SetValue(1)
  e2:SetReset(RESET_PHASE+PHASE_DAMAGE)
  d:RegisterEffect(e2)
end