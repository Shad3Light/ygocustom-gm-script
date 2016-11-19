--Jowl of Dark Demise (DOR)
--scripted by GameMaster (GM)
function c335599170.initial_effect(c)
	--equipped while facedown
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(335599170,0))
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_CONFIRM)
	e1:SetCondition(c335599170.eqcon)
	e1:SetOperation(c335599170.eqop)
	c:RegisterEffect(e1)
	 --to grave
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
    e2:SetCode(EVENT_TO_GRAVE)
    e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e2:SetCondition(c335599170.condition5)
    e2:SetTarget(c335599170.sptg)
    e2:SetOperation(c335599170.spop)
    c:RegisterEffect(e2)
	--Crush Terrain
	local e3=Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    e3:SetCode(EVENT_TO_GRAVE)
    e3:SetCondition(tgcond)
    e3:SetOperation(tgop)
    c:RegisterEffect(e3)
    --cannot be target
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_SZONE)
	e4:SetValue(c335599170.tgfilter)
	c:RegisterEffect(e4)
	--immune effect
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)	
	e5:SetCode(EFFECT_IMMUNE_EFFECT)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_SZONE)
	e5:SetValue(c335599170.efilter)
	c:RegisterEffect(e5)
	-- Cannot Disable effect
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e6:SetCode(EFFECT_CANNOT_DISABLE)
	e6:SetRange(LOCATION_SZONE)
	c:RegisterEffect(e6)
end
     
c335599170.collection={ [511005597]=true; [7914843]=true; [5257687]=true; [75285069]=true; [39180960]=true; [70307656]=true; [2792265]=true; [4035199]=true; [78636495]=true; [44913552]=true; [31242786]=true;  }

function c335599170.efilter(e,te)
	return te:IsActiveType(TYPE_EFFECT) and te:GetOwner()~=e:GetOwner()
end
function c335599170.tgfilter(e,re)
	if not re or not re:IsActiveType(TYPE_SPELL+TYPE_TRAP) then return false end
	return re:IsHasCategory(CATEGORY_TOHAND+CATEGORY_DESTROY+CATEGORY_REMOVE+CATEGORY_TODECK+CATEGORY_RELEASE+CATEGORY_TOGRAVE)
end

function c335599170.eqcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()==e:GetHandler() and e:GetHandler():GetBattlePosition()==POS_FACEDOWN_DEFENSE
end
function c335599170.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsFaceup() end
	if chk==0 then return e:GetHandler():IsRelateToEffect(e) and e:GetHandler():IsFaceup()
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c335599170.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetAttacker()
	if not tc:IsRelateToBattle() or not c:IsRelateToBattle() then return end
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 or tc:IsFacedown() then
		Duel.Destroy(c,REASON_EFFECT)
		return
	end
	Duel.Equip(tp,c,tc)
	--Add equip limit
	local e1=Effect.CreateEffect(tc)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EQUIP_LIMIT)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e1:SetValue(c335599170.eqlimit)
	c:RegisterEffect(e1)
	--take control
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_SET_CONTROL)
	e2:SetValue(tp)
	e2:SetReset(RESET_EVENT+0x1fc0000)
	c:RegisterEffect(e2)
	--negate
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_DISABLE)
	c:RegisterEffect(e3)
end
function c335599170.eqlimit(e,c)
	return e:GetOwner()==c
end

function c335599170.condition5(e,tp)
if not e:GetHandler():IsReason(REASON_LOST_TARGET) then return false end
local tc=e:GetHandler():GetPreviousEquipTarget()
if tc and tc:IsReason(REASON_DESTROY) and tc:IsLocation(LOCATION_GRAVE) and tc:GetPreviousControler()==tp then
    e:SetLabel(tc:GetPreviousSequence())
    return true
end
return false
end

--block previous zone and special summon
function c335599170.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsReason(REASON_DESTROY) and bit.band(c:GetPreviousLocation(),LOCATION_SZONE)~=0 then
		--spsummon
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(335599170,0))
		e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
		e1:SetRange(LOCATION_GRAVE)
		e1:SetCode(EVENT_PHASE+PHASE_BATTLE)
		e1:SetCost(c335599170.spcost)
		e1:SetTarget(c335599170.sptg)
		e1:SetOperation(c335599170.spop)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
		c:RegisterEffect(e1)
	end
end
function c335599170.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:GetFlagEffect(335599170)==0 end
	c:RegisterFlagEffect(335599170,nil,0,1)
end
function c335599170.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
	local seq=bit.lshift(0x1,e:GetLabel())
	local ch=Duel.GetCurrentChain()
	 e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCode(EFFECT_DISABLE_FIELD)
	e1:SetReset(RESET_CHAIN)
	e1:SetOperation(function() if Duel.GetCurrentChain()==ch then return seq else return 0 end end)
	Duel.RegisterEffect(e1,tp)
end
function c335599170.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local seq=bit.lshift(0x1,e:GetLabel())
    if c:IsRelateToEffect(e) then 
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCode(EFFECT_DISABLE_FIELD)
	e1:SetValue(seq)
	e:GetHandler():RegisterEffect(e1)
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	e1:Reset()
	end
end

function c335599170.ct_check(c)
	return c:GetAttack()>=1500 and not c335599170.collection[c:GetCode()]
end


function c335599170.filter2(c)
return c and c:IsFaceup()
end

function tgcond(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    return bit.band(c:GetReason(),REASON_BATTLE+REASON_DESTROY)==REASON_BATTLE+REASON_DESTROY
end

function condition2(e)
  return
   not c335599170.filter2(Duel.GetFieldCard(0,LOCATION_SZONE,5)) and
   not c335599170.filter2(Duel.GetFieldCard(1,LOCATION_SZONE,5))
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
        if tc and c335599170.ct_check(tc) then g:AddCard(tc) end
    end
    if seq<4 then
        local tc=Duel.GetFieldCard(tp,LOCATION_MZONE,seq+1)
       if tc and c335599170.ct_check(tc) then g:AddCard(tc) end
    end
    local tc=Duel.GetFieldCard(1-tp,LOCATION_MZONE,4-seq)
   if tc and c335599170.ct_check(tc) then g:AddCard(tc) end
    if g:GetCount()>0 then Duel.Destroy(g,REASON_EFFECT)
end
end

--mirroring!
function desop2(e,tp,eg,ep,ev,re,r,rp)
    local seq=e:GetLabel()
    local g=Group.CreateGroup()
    if seq>0 then
        local tc=Duel.GetFieldCard(1-tp,LOCATION_MZONE,5-seq)
       if tc and c335599170.ct_check(tc) then g:AddCard(tc) end
    end
    if seq<4 then
        local tc=Duel.GetFieldCard(1-tp,LOCATION_MZONE,3-seq)
        if tc and c335599170.ct_check(tc) then g:AddCard(tc) end
    end
    local tc=Duel.GetFieldCard(tp,LOCATION_MZONE,seq)
   if tc and c335599170.ct_check(tc) then g:AddCard(tc) end
    if g:GetCount()>0 then Duel.Destroy(g,REASON_EFFECT)
end
end