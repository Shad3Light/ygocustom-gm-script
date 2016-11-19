--Chiron the Mage (Anime)
function c33559921.initial_effect(c)
	--destroy spell/trap
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(33559921,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c33559921.destg)
	e1:SetOperation(c33559921.desop)
	c:RegisterEffect(e1)
end
function c33559921.cfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_MONSTER+TYPE_TRAP) and c:IsDiscardable()
end
function c33559921.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and (c:IsFacedown() and c:IsDestructable())
end
function c33559921.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and c33559921.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c33559921.filter,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c33559921.filter,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c33559921.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.ConfirmCards(tp,tc)
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
