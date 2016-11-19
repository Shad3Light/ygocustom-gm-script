--Aqua Dragon (DOR)
--scripted by GameMaster (GM)
function c335599161.initial_effect(c)
	--field treated as wasteland
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLED)
	e1:SetOperation(c335599161.operation)
	c:RegisterEffect(e1)
end


function c335599161.filter(c)
    return c and c:IsCode(code) and c:IsFaceUp()
end
function c335599161.condition(e)
    return
      not c335599161.filter(Duel.GetFieldCard(0,LOCATION_SZONE,5)) and
      not c335599161.filter(Duel.GetFieldCard(1,LOCATION_SZONE,5))
end

function c335599161.atktg(e,c)
    return c:IsType(TYPE_MONSTER) and c:IsRace(RACE_FISH+RACE_AQUA+RACE_THUNDER+RACE_MACHINE+RACE_PYRO)
end

function c335599161.operation(e)
    local c=e:GetHandler()
    local g=Duel.GetFieldGroup(tp,LOCATION_MZONE,LOCATION_MZONE)
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetCode(EFFECT_UPDATE_ATTACK)
    e1:SetRange(LOCATION_MZONE)
    e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
    e1:SetTarget(c335599161.atktg)
    e1:SetCondition(c335599161.condition)
    e1:SetValue(c335599161.val)
    e1:SetLabel(fid)
    e1:SetReset(RESET_EVENT+0x1ff0000)
    c:RegisterEffect(e1)
    --Def
    local e2=e1:Clone()
    e2:SetCode(EFFECT_UPDATE_DEFENSE)
    e2:SetCondition(c335599161.condition)
    e2:SetLabelObject(e1)
    c:RegisterEffect(e2)
    --field
    local e3=Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_FIELD)
    e3:SetCondition(c335599161.condition)
    e3:SetRange(LOCATION_MZONE)
    e3:SetCode(EFFECT_CHANGE_ENVIRONMENT)
    e3:SetValue(22702055)
    c:RegisterEffect(e3)
   end


function c335599161.val(e,c)
  local r=c:GetRace()
  if bit.band(r,RACE_FISH+RACE_AQUA+RACE_THUNDER)>0 then return 200
  elseif bit.band(r,RACE_MACHINE+RACE_PYRO)>0 then return -200
  else return 0 end
end