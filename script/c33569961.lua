--Dark Plant (DOR)
--scripted by GameMaster (GM)
function c33569961.initial_effect(c)
	--Crush Terrain
	local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    e1:SetCode(EVENT_TO_GRAVE)
    e1:SetCondition(tgcond)
    e1:SetOperation(tgop)
    c:RegisterEffect(e1)
end
	
c33569961.collection={ [511005597]=true; [7914843]=true; [5257687]=true; [75285069]=true; [39180960]=true; [70307656]=true; [2792265]=true; [4035199]=true; [78636495]=true; [44913552]=true; [31242786]=true;  }

	
function c33569961.ct_check(c)
	return c:GetAttack()>=1500 and not c33569961.collection[c:GetCode()]
end


function c33569961.filter2(c)
return c and c:IsFaceup()
end

function tgcond(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    return bit.band(c:GetReason(),REASON_BATTLE+REASON_DESTROY)==REASON_BATTLE+REASON_DESTROY
end

function condition2(e)
  return
   not c33569961.filter2(Duel.GetFieldCard(0,LOCATION_SZONE,5)) and
   not c33569961.filter2(Duel.GetFieldCard(1,LOCATION_SZONE,5))
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
        if tc and c33569961.ct_check(tc) then g:AddCard(tc) end
    end
    if seq<4 then
        local tc=Duel.GetFieldCard(tp,LOCATION_MZONE,seq+1)
       if tc and c33569961.ct_check(tc) then g:AddCard(tc) end
    end
    local tc=Duel.GetFieldCard(1-tp,LOCATION_MZONE,4-seq)
   if tc and c33569961.ct_check(tc) then g:AddCard(tc) end
    if g:GetCount()>0 then Duel.Destroy(g,REASON_EFFECT)
end
end

--mirroring!
function desop2(e,tp,eg,ep,ev,re,r,rp)
    local seq=e:GetLabel()
    local g=Group.CreateGroup()
    if seq>0 then
        local tc=Duel.GetFieldCard(1-tp,LOCATION_MZONE,5-seq)
       if tc and c33569961.ct_check(tc) then g:AddCard(tc) end
    end
    if seq<4 then
        local tc=Duel.GetFieldCard(1-tp,LOCATION_MZONE,3-seq)
        if tc and c33569961.ct_check(tc) then g:AddCard(tc) end
    end
    local tc=Duel.GetFieldCard(tp,LOCATION_MZONE,seq)
   if tc and c33569961.ct_check(tc) then g:AddCard(tc) end
    if g:GetCount()>0 then Duel.Destroy(g,REASON_EFFECT)
end
end