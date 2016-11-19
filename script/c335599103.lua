--Homunculus-GLuTTONY
function c335599103.initial_effect(c)
	--material
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c335599103.target)
	e1:SetOperation(c335599103.operation)
	c:RegisterEffect(e1)
	--atk & def
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c335599103.atkval)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	e3:SetValue(c335599103.defval)
	c:RegisterEffect(e3)
	-- indes
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e4:SetCountLimit(2)
	e4:SetValue(c335599103.valcon)
	c:RegisterEffect(e4)	
	--destroy replace
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetCode(EFFECT_DESTROY_REPLACE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetTarget(c335599103.reptg)
	c:RegisterEffect(e5)
-- Cannot Disable effect
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e6:SetCode(EFFECT_CANNOT_DISABLE)
	e6:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e6)
	--effect gain LP
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(511000516,0))
	e7:SetType(EFFECT_TYPE_IGNITION)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCountLimit(1)
	e7:SetCost(c335599103.efcost)
	e7:SetTarget(c335599103.eftg)
	e7:SetOperation(c335599103.efop)
	c:RegisterEffect(e7)
	--release limit
local e8=Effect.CreateEffect(c)
e8:SetType(EFFECT_TYPE_SINGLE)
e8:SetCode(EFFECT_UNRELEASABLE_SUM)
e8:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e8:SetRange(LOCATION_MZONE)
e8:SetValue(c335599103.recon)
c:RegisterEffect(e8)
local e9=e8:Clone()
e9:SetCondition(c335599103.recon2)
e9:SetCode(EFFECT_UNRELEASABLE_NONSUM)
c:RegisterEffect(e9)
end

function c335599103.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE+REASON_EFFECT)~=0
end

function c335599103.recon(e,c)
	return c:GetControler()~=e:GetHandler():GetControler()
end
function c335599103.recon2(e)
	return Duel.GetTurnPlayer()~=e:GetOwnerPlayer()
end
function c335599103.filter(c)
	return not c:IsType(TYPE_TOKEN)	and c:IsAbleToChangeControler()
end
function c335599103.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingTarget(c335599103.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c335599103.filter,tp,0,LOCATION_MZONE,1,1,nil)
end
function c335599103.operation(e,tp,eg,ep,ev,re,r,rp)
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

function c335599103.atkval(e,c)
	return e:GetHandler():GetOverlayGroup():GetSum(Card.GetBaseAttack)
end
function c335599103.defval(e,c)
	return e:GetHandler():GetOverlayGroup():GetSum(Card.GetBaseDefense)
end


function c335599103.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReason(REASON_BATTLE) and e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_EFFECT) end
	if Duel.SelectYesNo(tp,aux.Stringid(77631175,0)) then
		local c=e:GetHandler()
		c:RemoveOverlayCard(tp,1,1,REASON_EFFECT)
		return true
	else return false end
end
function c335599103.efcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c335599103.eftg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local op=Duel.SelectOption(tp,aux.Stringid(335599103,0))
	e:SetLabel(op)
	end
	function c335599103.efop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabel()==0 then
		Duel.Recover(tp,1000,REASON_EFFECT)
		end
end