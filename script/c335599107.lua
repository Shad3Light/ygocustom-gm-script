--homunculus envy
function c335599107.initial_effect(c)
	--pull spells to monster zone
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetOperation(c335599107.atkop)
	c:RegisterEffect(e1)
	--copy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(335599107,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c335599107.target)
	e2:SetOperation(c335599107.operation)
	c:RegisterEffect(e2)
	--indestuctable battle/effects up to 4
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e3:SetCountLimit(4)
	e3:SetValue(c335599107.valcon)
	c:RegisterEffect(e3)
end

function c335599107.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE+REASON_EFFECT)~=0
end

function c335599107.filter(c)
	return c:IsType(TYPE_MONSTER) and not c:IsForbidden()
end
function c335599107.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE+LOCATION_ONFIELD) and chkc:IsControler(tp) and c335599107.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c335599107.filter,tp,LOCATION_GRAVE+LOCATION_ONFIELD,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c335599107.filter,tp,LOCATION_GRAVE+LOCATION_ONFIELD,0,1,1,nil)
end
function c335599107.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and c:IsFaceup() and tc and tc:IsRelateToEffect(e) then
		local code=tc:GetOriginalCode()
		local ba=tc:GetBaseAttack()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetCode(EFFECT_CHANGE_CODE)
		e1:SetValue(code)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e2:SetLabelObject(e1)
		e2:SetCode(EFFECT_UPDATE_ATTACK)
		e2:SetValue(ba)
		c:RegisterEffect(e2)
		local cid=c:CopyEffect(code,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,1)
		local e3=Effect.CreateEffect(c)
		e3:SetDescription(aux.Stringid(335599107,1))
		e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e3:SetCode(EVENT_PHASE+PHASE_END)
		e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e3:SetCountLimit(1)
		e3:SetRange(LOCATION_MZONE)
		e3:SetLabel(cid)
		e3:SetLabelObject(e2)
		e3:SetOperation(c335599107.rstop)
		c:RegisterEffect(e3)
	end
end
function c335599107.rstop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local cid=e:GetLabel()
	local e1=e:GetLabelObject()
	local e2=e:GetLabelObject()
	e1:Reset()
	e2:Reset()
	c:ResetEffect(cid,RESET_COPY)
	Duel.HintSelection(Group.FromCards(c))
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end

function c335599107.atkop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(nil,tp,LOCATION_SZONE,LOCATION_SZONE,nil)
	if Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0 and g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(23603403,0)) then
		Duel.Hint(HINT_CARD,0,335599107)
		local sc=g:Select(tp,1,1,nil):GetFirst()
		Duel.MoveToField(sc,sc:GetControler(),sc:GetControler(),LOCATION_MZONE,POS_FACEDOWN_DEFENSE,true)
		Duel.BreakEffect()
		if sc:IsControler(tp) then
			Duel.GetControl(sc,1-tp,PHASE_END)
		end
		Duel.ChangeAttackTarget(sc)
	end
end
