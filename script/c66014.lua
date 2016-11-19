--Logicast Implica
function c66014.initial_effect(c)
  --Pendulum attr
  aux.EnablePendulumAttribute(c)
  --PendulumEffect1-ignite,banish,draw
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_IGNITION)
  e1:SetRange(LOCATION_PZONE)
  e1:SetDescription(aux.Stringid(66014,0))
  e1:SetCategory(CATEGORY_REMOVE+CATEGORY_DRAW)
  e1:SetCountLimit(1)
  e1:SetTarget(c66014.rm_tg)
  e1:SetOperation(c66014.rm_op)
  c:RegisterEffect(e1)
  --MonsterEffect1-normalsum,spsum
  local e2=Effect.CreateEffect(c)
  e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
  e2:SetCode(EVENT_SUMMON_SUCCESS)
  e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
  e2:SetDescription(aux.Stringid(66014,1))
  e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
  e2:SetTarget(c66014.sum_tg)
  e2:SetOperation(c66014.sum_op)
  c:RegisterEffect(e2)
  --MonsterEffect2-banished,banish
  local e3=Effect.CreateEffect(c)
  e3:SetDescription(aux.Stringid(66014,2))
  e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
  e3:SetCode(EVENT_REMOVE)
  e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
  e3:SetCategory(CATEGORY_REMOVE)
  e3:SetOperation(c66014.banfld_op)
  c:RegisterEffect(e3)
end

--PendulumEffect1

function c66014.rm_fil(c)
  return c:IsFaceup() and c:IsType(TYPE_PENDULUM) and c:IsAbleToRemove()
end

function c66014.rm_tg(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return Duel.IsExistingMatchingCard(c66014.rm_fil,tp,LOCATION_GRAVE+LOCATION_EXTRA,0,1,nil) end
  Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_GRAVE+LOCATION_EXTRA)
  Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end

function c66014.rm_op(e,tp,eg,ep,ev,re,r,rp)
  if not e:GetHandler():IsRelateToEffect(e) then return end
  Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(66014,0))
  local g=Duel.SelectMatchingCard(tp,c66014.rm_fil,tp,LOCATION_GRAVE+LOCATION_EXTRA,0,1,1,nil)
  if g:GetCount()>0 then
    if Duel.Remove(g,POS_FACEUP,REASON_EFFECT)~=0 then
      Duel.Draw(tp,1,REASON_EFFECT)
    end
  end
end

--MonsterEffect1

function c66014.sum_fil(c,e,tp)
  return c:IsFaceup() and c:IsSetCard(0x66B) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end

function c66014.sum_tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
  if chkc then return chkc:IsLocation(LOCATION_REMOVED) and chkc:IsControler(tp) and c66014.sum_fil(chkc,e,tp) end
  if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingTarget(c66014.sum_fil,tp,LOCATION_REMOVED,0,1,nil,e,tp) end
  Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(66014,1))
  local g=Duel.SelectTarget(tp,c66014.sum_fil,tp,LOCATION_REMOVED,0,1,1,nil,e,tp)
  Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,tp,LOCATION_REMOVED)
end

function c66014.sum_op(e,tp,eg,ep,ev,re,r,rp)
  local tc=Duel.GetFirstTarget()
  if tc:IsRelateToEffect(e) then Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP_ATTACK) end
end

--MonsterEffect2

function c66014.banfld_fil(c)
  return c:IsAbleToRemove()
end

function c66014.banfld_op(e,tp,eg,ep,ev,re,r,rp)
  if not Duel.IsExistingMatchingCard(c66014.banfld_fil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) then return end
  Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(66014,2))
  tc=Duel.SelectMatchingCard(tp,c66014.banfld_fil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
  Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
end