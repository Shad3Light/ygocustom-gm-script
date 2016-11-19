--Shapesnatch (DOR)
--scripted by GameMaster (GM)
function c335599175.initial_effect(c)
--atk
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e1:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_REPEAT+EFFECT_FLAG_DELAY)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c335599175.condition)
	e1:SetOperation(c335599175.op)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
	e2:SetOperation(c335599175.op)
	c:RegisterEffect(e2)
	--Crush Terrain
	local e3=Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    e3:SetCode(EVENT_TO_GRAVE)
    e3:SetCondition(tgcond)
    e3:SetOperation(tgop)
    c:RegisterEffect(e3)
end


function c335599175.filter(c)
	return c:IsFaceup() and c:GetCode()~=335599175
end
function c335599175.condition(e)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return bc and bc:IsType(TYPE_MONSTER)
end

function c335599175.condef(e)
	return e:GetHandler():IsDefensePos()
end

function c335599175.conatk(e)
	return e:GetHandler():IsAttackPos()
end

function c335599175.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
		e1:SetValue(c335599175.adval)
		e1:SetCondition(c335599175.conatk)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		e2:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
		e2:SetCondition(c335599175.condef)
		e2:SetValue(c335599175.adval2)
		c:RegisterEffect(e2)
		end
end



function c335599175.adval(e,c)
	local g=Duel.GetMatchingGroup(c335599175.filter,tp,LOCATION_MZONE,0,nil)
	if g:GetCount()==0 then 
		return 1200
	else
		local tg,val=g:GetMaxGroup(Card.GetAttack)
		return val-1200
		end
	end
	
	function c335599175.adval2(e,c)
	local g=Duel.GetFieldGroup(Card.IsFaceup,tp,LOCATION_MZONE,0,c)
	if g:GetCount()==0 then 
		return 1700
	else
		local tg,val=g:GetMaxGroup(Card.GetDefense)
		return val-1700
		end
	end

c335599175.collection={ [511005597]=true; [7914843]=true; [5257687]=true; [75285069]=true; [39180960]=true; [70307656]=true; [2792265]=true; [4035199]=true; [78636495]=true; [44913552]=true; [31242786]=true;  }

function c335599175.ct_check(c)
	return c:GetAttack()>=1500 and not c335599175.collection[c:GetCode()]
end


function c335599175.filter2(c)
return c and c:IsFaceup()
end

function tgcond(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    return bit.band(c:GetReason(),REASON_BATTLE+REASON_DESTROY)==REASON_BATTLE+REASON_DESTROY
end

function condition2(e)
  return
   not c335599175.filter2(Duel.GetFieldCard(0,LOCATION_SZONE,5)) and
   not c335599175.filter2(Duel.GetFieldCard(1,LOCATION_SZONE,5))
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
        if tc and c335599175.ct_check(tc) then g:AddCard(tc) end
    end
    if seq<4 then
        local tc=Duel.GetFieldCard(tp,LOCATION_MZONE,seq+1)
       if tc and c335599175.ct_check(tc) then g:AddCard(tc) end
    end
    local tc=Duel.GetFieldCard(1-tp,LOCATION_MZONE,4-seq)
   if tc and c335599175.ct_check(tc) then g:AddCard(tc) end
    if g:GetCount()>0 then Duel.Destroy(g,REASON_EFFECT)
end
end

--mirroring!
function desop2(e,tp,eg,ep,ev,re,r,rp)
    local seq=e:GetLabel()
    local g=Group.CreateGroup()
    if seq>0 then
        local tc=Duel.GetFieldCard(1-tp,LOCATION_MZONE,5-seq)
       if tc and c335599175.ct_check(tc) then g:AddCard(tc) end
    end
    if seq<4 then
        local tc=Duel.GetFieldCard(1-tp,LOCATION_MZONE,3-seq)
        if tc and c335599175.ct_check(tc) then g:AddCard(tc) end
    end
    local tc=Duel.GetFieldCard(tp,LOCATION_MZONE,seq)
   if tc and c335599175.ct_check(tc) then g:AddCard(tc) end
    if g:GetCount()>0 then Duel.Destroy(g,REASON_EFFECT)
end
end