--Clear Prism Color Eater
function c33559948.initial_effect(c)
	--attach
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ADJUST)
	e1:SetRange(LOCATION_MZONE)	
	e1:SetOperation(c33559948.operation)
	c:RegisterEffect(e1)
	--detach
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetOperation(c33559948.flipop)
	c:RegisterEffect(e2)
	--atk & def
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetValue(c33559948.atkval)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_UPDATE_DEFENSE)
	e4:SetValue(c33559948.defval)
	c:RegisterEffect(e4)
	--Summon Cannot be Negated
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_CANNOT_DISABLE_SUMMON)
	e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(e5)
	-- Cannot Banish (Loyalty to controller)
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e6:SetCode(EFFECT_CANNOT_REMOVE)
	e6:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e6)
	--indestructable
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e7:SetValue(c33559948.indval)
	c:RegisterEffect(e7)	
	--destroy replace
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e8:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e8:SetCode(EFFECT_DESTROY_REPLACE)
	e8:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e8)
	--effect gain LP
	local e9=Effect.CreateEffect(c)
	e9:SetDescription(aux.Stringid(511000516,0))
	e9:SetType(EFFECT_TYPE_IGNITION)
	e9:SetRange(LOCATION_MZONE)
	e9:SetCountLimit(1)
	e9:SetOperation(c33559948.efop)
	e9:SetCost(c33559948.efcost)
	c:RegisterEffect(e9)
end
function c33559948.condition(e,tp,eg,ep,ev,re,r,rp)
return not Duel.IsExistingMatchingCard(function(c,fid)return c:GetFieldID(33559948) end,tp,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler(),e:GetHandler():GetFieldID())
end
function c33559948.desfilter2(c)
	return c:GetFlagEffect(33559948)>0
end
function c33559948.filter(c)
return c:IsAttribute(0xf+0x10) and c:IsFaceup() and not (c:IsType(TYPE_TOKEN+TYPE_FLIP) or c:IsHasEffect(EFFECT_TYPE_TRIGGER_O))
end
function c33559948.atkval(e,c)
	return e:GetHandler():GetOverlayGroup():GetSum(Card.GetBaseAttack)
end
function c33559948.defval(e,c)
	return e:GetHandler():GetOverlayGroup():GetSum(Card.GetBaseDefense)
end
function c33559948.operation(e,tp,eg,ep,ev,re,r,rp)
   local wg=Duel.GetMatchingGroup(c33559948.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,e)
--where g is card group
local c=wg:GetFirst()
while c do
    --do your thing to c
    local og=c:GetOverlayGroup()
    if og:GetCount()>0 then Duel.SendtoGrave(og,REASON_RULE) end
    c=wg:GetNext()
end
Duel.Overlay(e:GetHandler(),wg)
end
function c33559948.flipop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local og=c:GetOverlayGroup()
	Duel.SendtoGrave(og,REASON_RULE)
	Duel.Release(og,REASON_RULE)
	Duel.Destroy(og,REASON_RULE)
	Duel.Remove(og,nil,REASON_RULE)
end
function c33559948.ovcon(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c33559948.ovtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c33559948.ovfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c33559948.ovfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c33559948.ovfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c33559948.ovop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and not tc:IsImmuneToEffect(e) then
		local og=tc:GetOverlayGroup()
		if og:GetCount()>0 then
			Duel.SendtoGrave(og,REASON_RULE)
		end
		Duel.Overlay(c,Group.FromCards(tc))
	end
end
function c33559948.detop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetOverlayGroup(tp,1,1)
	if g:GetCount()~=0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
function c33559948.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReason(REASON_BATTLE) and e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_EFFECT) end
	if Duel.SelectYesNo(tp,aux.Stringid(77631175,0)) then
		local c=e:GetHandler()
		c:RemoveOverlayCard(tp,1,1,REASON_EFFECT)
		return true
	else return false end
end
function c33559948.indval(e,c)
	return e:GetHandler():GetOverlayCount()>0
end
function c33559948.efcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c33559948.eftg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local op=Duel.SelectOption(tp,aux.Stringid(33559948,0))
	e:SetLabel(op)
	end
	function c33559948.efop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabel()==0 then
		Duel.Recover(tp,1000,REASON_EFFECT)
		end
end