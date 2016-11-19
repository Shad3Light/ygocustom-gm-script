--Soul Eater (DOR)
--scripted by GameMaster (GM)
function c335599158.initial_effect(c)
	--Activate/banish>ATK/DEF x 200 banished monsters
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
   	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
   	e1:SetCode(EVENT_PREDRAW)
    e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c335599158.condition)
	e1:SetTarget(c335599158.target)
	e1:SetOperation(c335599158.activate)
	c:RegisterEffect(e1)
	--Crush Terrain
	local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    e2:SetCode(EVENT_TO_GRAVE)
    e2:SetCondition(tgcond)
    e2:SetOperation(tgop)
    c:RegisterEffect(e2)
end

c335599158.collection={ [511005597]=true; [7914843]=true; [5257687]=true; [75285069]=true; [39180960]=true; [70307656]=true; [2792265]=true; [4035199]=true; [78636495]=true; [44913552]=true; [31242786]=true;  }


function c335599158.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsDefensePos() and  tp==Duel.GetTurnPlayer()
end

function c335599158.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c335599158.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil) end
	local sg=Duel.GetMatchingGroup(c335599158.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,sg,sg:GetCount(),0,0)
end

function c335599158.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToRemove()
end

function c335599158.activate(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    local sg=Duel.GetMatchingGroup(c335599158.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil)
    local val=Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
    if val>0 then
        local e2=Effect.CreateEffect(c)
        e2:SetType(EFFECT_TYPE_SINGLE)
        e2:SetCode(EFFECT_UPDATE_ATTACK)
        e2:SetValue(val*200)
        e2:SetReset(RESET_EVENT+0x1fe0000)
        c:RegisterEffect(e2)
        local e3=e2:Clone()
        e3:SetCode(EFFECT_UPDATE_DEFENSE)
        c:RegisterEffect(e3)
    end
end

function c335599158.ct_check(c)
	return c:GetAttack()>=1500 and not c335599158.collection[c:GetCode()]
end


function c335599158.filter2(c)
return c and c:IsFaceup()
end

function tgcond(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    return bit.band(c:GetReason(),REASON_BATTLE+REASON_DESTROY)==REASON_BATTLE+REASON_DESTROY
end

function condition2(e)
  return
   not c335599158.filter2(Duel.GetFieldCard(0,LOCATION_SZONE,5)) and
   not c335599158.filter2(Duel.GetFieldCard(1,LOCATION_SZONE,5))
end

function tgop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e1:SetCode(EVENT_ADJUST)
    e1:SetCondition(condition2)
    e1:SetRange(LOCATION_GRAVE)
    e1:SetReset(RESET_EVENT+0x1fe0000)
    e1:SetLabel(c:GetPreviousSequence())
    if tp==c:GetPreviousControler() then
        e1:SetOperation(desop)
    else
        e1:SetOperation(desop2)
    end
    c:RegisterEffect(e1)
end

function desop(e,tp,eg,ep,ev,re,r,rp)
    local seq=e:GetLabel()
    local g=Group.CreateGroup()
    if seq>0 then
        local tc=Duel.GetFieldCard(tp,LOCATION_MZONE,seq-1)
        if tc and c335599158.ct_check(tc) then g:AddCard(tc) end
    end
    if seq<4 then
        local tc=Duel.GetFieldCard(tp,LOCATION_MZONE,seq+1)
       if tc and c335599158.ct_check(tc) then g:AddCard(tc) end
    end
    local tc=Duel.GetFieldCard(1-tp,LOCATION_MZONE,4-seq)
   if tc and c335599158.ct_check(tc) then g:AddCard(tc) end
    if g:GetCount()>0 then Duel.Destroy(g,REASON_EFFECT)
end
end

--mirroring!
function desop2(e,tp,eg,ep,ev,re,r,rp)
    local seq=e:GetLabel()
    local g=Group.CreateGroup()
    if seq>0 then
        local tc=Duel.GetFieldCard(1-tp,LOCATION_MZONE,5-seq)
       if tc and c335599158.ct_check(tc) then g:AddCard(tc) end
    end
    if seq<4 then
        local tc=Duel.GetFieldCard(1-tp,LOCATION_MZONE,3-seq)
        if tc and c335599158.ct_check(tc) then g:AddCard(tc) end
    end
    local tc=Duel.GetFieldCard(tp,LOCATION_MZONE,seq)
   if tc and c335599158.ct_check(tc) then g:AddCard(tc) end
    if g:GetCount()>0 then Duel.Destroy(g,REASON_EFFECT)
end
end