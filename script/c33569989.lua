--Shishiwakamaru
--scripted by GameMaster (GM)
function c33569989.initial_effect(c)
c:SetUniqueOnField(1,1,33569989)
	--equip Sword and Cape
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(33569989,1))
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c33569989.eqtg)
	e1:SetOperation(c33569989.eqop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e3)
	end
	
function c33569989.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c33569989.filter2(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c33569989.filter2,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c33569989.filter2,tp,LOCATION_MZONE,0,2,2,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,nil,2,tp,LOCATION_DECK+LOCATION_GRAVE)
end

function c33569989.filter2(c)
	return c:IsFaceup() and c:IsCode(33569989)
end
	
function c33569989.filter3(c)
	return c:IsCode(33569976,33569975) and not c:IsForbidden()
end
function c33569989.eqop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
		local g=Duel.SelectMatchingCard(tp,c33569989.filter3,tp,LOCATION_DECK+LOCATION_GRAVE,0,2,2,nil)
		local eqc=g:GetFirst()
		if not eqc or not Duel.Equip(tp,eqc,tc,true) then return end
		local g=Duel.SelectMatchingCard(tp,c33569989.filter3,tp,LOCATION_DECK+LOCATION_GRAVE,0,2,2,nil)
		local eqc=g:GetFirst()
		while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(c33569989.eqlimit)
		e1:SetLabelObject(tc)
		eqc:RegisterEffect(e1)
		tc=g:GetNext()
		local tc=Duel.GetFirstTarget()
		local eqc=g:GetFirst()
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_EQUIP_LIMIT)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		e2:SetValue(c33569989.eqlimit)
		e2:SetLabelObject(tc)
		eqc:RegisterEffect(e1)
		Duel.Equip(tp,eqc,tc,true)
		end
	end
end	
function c33569989.eqlimit(e,c)
	return c:IsCode(33569989)
end