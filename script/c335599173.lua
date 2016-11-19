--Slate Warrior (DOR)
--scripted by GameMaster (GM)
function c335599173.initial_effect(c)
--immortal type gain 500/atk/Def
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetOperation(c335599173.operation)
	c:RegisterEffect(e1)
	--Crush Terrain
	local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    e2:SetCode(EVENT_TO_GRAVE)
    e2:SetCondition(tgcond)
    e2:SetOperation(tgop)
    c:RegisterEffect(e2)
end

c335599173.collection={ [511005597]=true; [7914843]=true; [5257687]=true; [75285069]=true; [39180960]=true; [70307656]=true; [2792265]=true; [4035199]=true; [78636495]=true; [44913552]=true; [31242786]=true;  }

function c335599173.atktg(e,c)
return Duel.GetMatchingGroup(c335599173.filter,tp,LOCATION_MZONE,0,nil)
end

function c335599173.filter(c)
	return c:IsFaceup() and c335599173.collection[c:GetCode()]
end

function c335599173.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c335599173.filter,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetTarget(c335599173.atktg)
		e1:SetValue(500)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		tc:RegisterEffect(e2)
		tc=g:GetNext()
	end
end

function c335599173.ct_check(c)
	return c:GetAttack()>=1500 and not c335599173.collection[c:GetCode()]
end


function c335599173.filter2(c)
return c and c:IsFaceup()
end

function tgcond(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    return bit.band(c:GetReason(),REASON_BATTLE+REASON_DESTROY)==REASON_BATTLE+REASON_DESTROY
end

function condition2(e)
  return
   not c335599173.filter2(Duel.GetFieldCard(0,LOCATION_SZONE,5)) and
   not c335599173.filter2(Duel.GetFieldCard(1,LOCATION_SZONE,5))
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
        if tc and c335599173.ct_check(tc) then g:AddCard(tc) end
    end
    if seq<4 then
        local tc=Duel.GetFieldCard(tp,LOCATION_MZONE,seq+1)
       if tc and c335599173.ct_check(tc) then g:AddCard(tc) end
    end
    local tc=Duel.GetFieldCard(1-tp,LOCATION_MZONE,4-seq)
   if tc and c335599173.ct_check(tc) then g:AddCard(tc) end
    if g:GetCount()>0 then Duel.Destroy(g,REASON_EFFECT)
end
end

--mirroring!
function desop2(e,tp,eg,ep,ev,re,r,rp)
    local seq=e:GetLabel()
    local g=Group.CreateGroup()
    if seq>0 then
        local tc=Duel.GetFieldCard(1-tp,LOCATION_MZONE,5-seq)
       if tc and c335599173.ct_check(tc) then g:AddCard(tc) end
    end
    if seq<4 then
        local tc=Duel.GetFieldCard(1-tp,LOCATION_MZONE,3-seq)
        if tc and c335599173.ct_check(tc) then g:AddCard(tc) end
    end
    local tc=Duel.GetFieldCard(tp,LOCATION_MZONE,seq)
   if tc and c335599173.ct_check(tc) then g:AddCard(tc) end
    if g:GetCount()>0 then Duel.Destroy(g,REASON_EFFECT)
end
end
