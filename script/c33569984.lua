--Naraku
--scripted by GameMaster (GM)
function c33569984.initial_effect(c)
c:SetUniqueOnField(1,1,33569984)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(33569984,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c33569984.target)
	e1:SetOperation(c33569984.operation)
	c:RegisterEffect(e1)
	--equip Nest
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(33569984,1))
	e2:SetCategory(CATEGORY_EQUIP)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetTarget(c33569984.eqtg)
	e2:SetOperation(c33569984.eqop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	local e4=e2:Clone()
	e4:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e4)
end

function c33569984.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c33569984.filter2(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c33569984.filter2,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c33569984.filter2,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end

function c33569984.filter2(c)
	return c:IsFaceup() and c:IsCode(33569984)
end
	
function c33569984.filter3(c)
	return c:IsCode(33569987) and not c:IsForbidden()
end
function c33569984.eqop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
		local g=Duel.SelectMatchingCard(tp,c33569984.filter3,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
		local eqc=g:GetFirst()
		if not eqc or not Duel.Equip(tp,eqc,tc,true) then return end
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(c33569984.eqlimit)
		e1:SetLabelObject(tc)
		eqc:RegisterEffect(e1)
		end
end
function c33569984.eqlimit(e,c)
	return c:IsCode(33569984)
end


function c33569984.filter(c)
	return c:IsFaceup()
end
function c33569984.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsOnField() and c33569984.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c33569984.filter,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c33569984.filter,tp,LOCATION_ONFIELD,0,1,1,nil)
end
function c33569984.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCountLimit(1)
		e1:SetValue(c33569984.valcon)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
function c33569984.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE+REASON_EFFECT)~=0
end