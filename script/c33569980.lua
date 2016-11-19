--Goshinki
--scripted by GameMaster (GM)
function c33569980.initial_effect(c)
c:SetUniqueOnField(1,1,33569980)
Duel.EnableGlobalFlag(GLOBALFLAG_DECK_REVERSE_CHECK)
--Hand visable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_PUBLIC)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_HAND)
	c:RegisterEffect(e1)
	--Flip deck visable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_REVERSE_DECK)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,1)
	c:RegisterEffect(e2)
	--destroy equip cards
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(33569980,0))
	e3:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_IGNORE_IMMUNE)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetCountLimit(1)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTarget(c33569980.target)
	e3:SetOperation(c33569980.operation)
	c:RegisterEffect(e3)
	--equip Nest
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(33569980,1))
	e4:SetCategory(CATEGORY_EQUIP)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_SUMMON_SUCCESS)
	e4:SetTarget(c33569980.eqtg)
	e4:SetOperation(c33569980.eqop)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e5)
	local e6=e4:Clone()
	e6:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e6)
end

function c33569980.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c33569980.filter2(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c33569980.filter2,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c33569980.filter2,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end

function c33569980.filter2(c)
	return c:IsFaceup() and c:IsCode(33569980)
end
	
function c33569980.filter3(c)
	return c:IsCode(33569987) and not c:IsForbidden()
end
function c33569980.eqop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
		local g=Duel.SelectMatchingCard(tp,c33569980.filter3,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
		local eqc=g:GetFirst()
		if not eqc or not Duel.Equip(tp,eqc,tc,true) then return end
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(c33569980.eqlimit)
		e1:SetLabelObject(tc)
		eqc:RegisterEffect(e1)
		end
end
function c33569980.eqlimit(e,c)
	return c:IsCode(33569980)
end


function c33569980.filter(c)
	return c:GetEquipCount()>0
end
function c33569980.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and c33569980.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c33569980.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_OPPO)
	local g=Duel.SelectTarget(tp,c33569980.filter,tp,0,LOCATION_MZONE,1,1,nil)
	local eqg=g:GetFirst():GetEquipGroup()
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eqg,eqg:GetCount(),0,0)
end
function c33569980.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		local eqg=tc:GetEquipGroup()
		if eqg:GetCount()>0 then
			local des=Duel.Destroy(eqg,REASON_EFFECT)
			end
	end
end
