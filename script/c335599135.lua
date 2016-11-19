--Sacrifice's Blast
--  By Shad3

local self=c335599135
local s_id=335599135

function self.initial_effect(c)
  --Globals
  if not self.gl_reg then
    self.gl_reg=true
    self.cardstr={}
    self.atstr={}
    local ge1=Effect.CreateEffect(c)
    ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    ge1:SetCode(EVENT_SSET)
    ge1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
    ge1:SetCondition(self.gtg_cd)
    ge1:SetOperation(self.gtg_op)
    Duel.RegisterEffect(ge1,0)
    local ge2=Effect.CreateEffect(c)
    ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    ge2:SetCode(EVENT_SUMMON_SUCCESS)
    ge2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
    ge2:SetCode(EVENT_SUMMON_SUCCESS)
    ge2:SetOperation(self.sum_op)
    Duel.RegisterEffect(ge2,0)
    local ge3=Effect.CreateEffect(c)
    ge3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    ge3:SetCode(EVENT_LEAVE_FIELD)
    ge3:SetOperation(self.clr_op)
    Duel.RegisterEffect(ge3,0)
  end
  --Activate
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_ATTACK_ANNOUNCE)
  e1:SetTarget(self.tg)
  e1:SetOperation(self.op)
  c:RegisterEffect(e1)
end

function self.gtg_cd(e,tp,eg,ep,ev,re,r,rp)
  return eg:IsExists(Card.IsCode,1,nil,s_id)
end

function self.gtg_op(e,tp,eg,ep,ev,re,r,rp)
  local g=eg:Filter(Card.IsCode,nil,s_id)
  local tc=g:GetFirst()
  while tc do
    local p=tc:GetControler()
    if Duel.GetFieldGroupCount(p,LOCATION_MZONE,LOCATION_MZONE)>0 then
      Duel.Hint(HINT_SELECTMSG,p,HINTMSG_TARGET)
      local tec=Duel.GetFieldGroup(p,LOCATION_MZONE,LOCATION_MZONE):Select(p,1,1,nil):GetFirst()
      local fid=tc:GetFieldID()
      self.cardstr[fid]=tc
      tec:RegisterFlagEffect(s_id,RESET_EVENT,0,0,fid)
    end
    tc=g:GetNext()
  end
end

function self.sum_op(e,tp,eg,ep,ev,re,r,rp)
  local tc=eg:GetFirst()
  if bit.band(tc:GetSummonType(),SUMMON_TYPE_ADVANCE)==SUMMON_TYPE_ADVANCE then
    local sactg={}
    local g=tc:GetMaterial()
    g:ForEach(function(etc)
      if etc:GetFlagEffect(s_id)~=0 then
        sactg[etc:GetFlagEffectLabel(s_id)]=true
        etc:ResetFlagEffect(s_id)
      end
    end)
    for _,sc in pairs(self.cardstr) do
      local fid=sc:GetFieldID()
      if sactg[fid] then
        self.atstr[fid]=tc
        local e1=Effect.CreateEffect(tc)
        e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
        e1:SetCode(s_id)
        e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
        e1:SetRange(LOCATION_MZONE)
        e1:SetOperation(self.des_op)
        e1:SetReset(RESET_EVENT+0x1fe0000)
        e1:SetLabelObject(sc)
        tc:RegisterEffect(e1,true)
      end
    end
  end
end

function self.des_op(e,tp,eg,ep,ev,re,r,rp)
  local c=e:GetHandler()
  if Duel.Destroy(c,REASON_EFFECT)~=0 then
    Duel.Damage(c:GetPreviousControler(),c:GetPreviousAttackOnField(),REASON_EFFECT)
  end
end

function self.clr_op(e,tp,eg,ep,ev,re,r,rp)
  eg:ForEach(function(tc)
    if self.cardstr[tc:GetFieldID()] then
      table.remove(self.cardstr,tc:GetFieldID())
      table.remove(self.atstr,tc:GetFieldID())
    end
    if bit.band(r,REASON_RELEASE)==0 then
      tc:ResetFlagEffect(s_id)
    end
  end)
end

function self.tg(e,tp,eg,ep,ev,re,r,rp,chk)
  local ac=Duel.GetAttacker()
  if chk==0 then 
    return ac:GetControler()~=tp and self.atstr[e:GetHandler():GetFieldID()]==ac
  end
  e:GetHandler():SetCardTarget(ac)
end

function self.op(e,tp,eg,ep,ev,re,r,rp)
  local ac=e:GetHandler():GetFirstCardTarget()
  if ac then
    Duel.RaiseEvent(Group.FromCards(ac),s_id,e,REASON_EFFECT,tp,tp,e:GetHandler():GetFieldID())
  end
end