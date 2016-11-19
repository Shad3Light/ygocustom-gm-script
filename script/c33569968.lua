--brain eater bug
--scripted by GameMaster (GM)
function c33569968.initial_effect(c)
aux.EnablePendulumAttribute(c,reg)
--Retun parasite fusioner monsters to deck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511001039,0))
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCountLimit(1)
	e1:SetTarget(c33569968.target)
	e1:SetOperation(c33569968.operation)
	c:RegisterEffect(e1)
	--attach parasites
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_PZONE)
	e2:SetTarget(c33569968.target2)
	e2:SetOperation(c33569968.activate2)
	c:RegisterEffect(e2)
	end
	
	function Auxiliary.EnablePendulumAttribute(c,reg)
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetCode(EFFECT_SPSUMMON_PROC_G)
    e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
    e1:SetRange(LOCATION_PZONE)
    e1:SetCountLimit(1,10000000)
    e1:SetCondition(Auxiliary.PendCondition())
    e1:SetOperation(Auxiliary.PendOperation())
    e1:SetValue(SUMMON_TYPE_PENDULUM)
    c:RegisterEffect(e1)
    --register by default
    if reg==nil or reg then
        local e2=Effect.CreateEffect(c)
        e2:SetDescription(1160)
        e2:SetType(EFFECT_TYPE_ACTIVATE)
        e2:SetCode(EVENT_FREE_CHAIN)
        e2:SetRange(LOCATION_HAND)
        c:RegisterEffect(e2)
    end
end
		

function c33569968.filter(c,ft1,ft2,tp)
	local p=c:GetControler()
	if c:IsFacedown() then return false end
	local g1=Duel.GetMatchingGroupCount(Card.IsCode,tp,LOCATION_GRAVE,0,nil,6205579)
	local g2=Duel.GetMatchingGroupCount(Card.IsCode,tp,0,LOCATION_GRAVE,nil,6205579)
	local ft=0
	if Duel.GetLocationCount(p,LOCATION_SZONE)<=0 then return false end
	if g1>0 and ft1>0 then return true end
	if g2>0 and ft2>0 then return true end
	if g1>0 and g2>0 and ft1>0 and ft2>0 then return true end
	return false
end
function c33569968.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local ft1=Duel.GetLocationCount(tp,LOCATION_SZONE)
	local ft2=Duel.GetLocationCount(1-tp,LOCATION_SZONE)
	if e:GetHandler():IsLocation(LOCATION_HAND) then ft1=ft1-1 end
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c33569968.filter(chkc,ft1,ft2,tp) end
	if chk==0 then return Duel.IsExistingTarget(c33569968.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,ft1,ft2,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c33569968.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,ft1,ft2,tp)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,nil,1,tp,LOCATION_GRAVE)
end
function c33569968.activate2(e,tp,eg,ep,ev,re,r,rp)
	local ft1=Duel.GetLocationCount(tp,LOCATION_SZONE)
	local ft2=Duel.GetLocationCount(1-tp,LOCATION_SZONE)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) and c33569968.filter(tc,ft1,ft2,tp) then
		local p=tc:GetControler()
		if Duel.GetLocationCount(p,LOCATION_SZONE)<=0 then return end
		local g1=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_GRAVE,0,nil,6205579)
		local g2=Duel.GetMatchingGroup(Card.IsCode,tp,0,LOCATION_GRAVE,nil,6205579)
		local chk1=g1:GetCount()>0 and ft1>0
		local chk2=g2:GetCount()>0 and ft2>0
		local chk3=g2:GetCount()>0 and ft2>0 and g1:GetCount()>0 and ft1>0
		local eqg
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(12152769,2))
		if chk1 and chk2 and chk3 then
			g1:Merge(g2)
			eqg=g1:Select(tp,1,1,nil)
		elseif chk1 and not chk3 then
			eqg=g1:Select(tp,1,1,nil)
		elseif chk2 and not chk3 then
			eqg=g2:Select(tp,1,1,nil)
		else
			g1:Merge(g2)
			eqg=g1:Select(tp,1,1,nil)
			local tc=eqg:GetFirst()
			if tc:IsControler(tp) then ft1=ft1-1 else ft2=ft2-1 end
			if ft1<=0 then g1:Remove(Card.IsControler,nil,tp) end
			if ft2<=0 then g1:Remove(Card.IsControler,nil,1-tp) end
			Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(12152769,2))
			local sel=g1:Select(tp,1,1,tc)
			eqg:Merge(sel)
		end
		Duel.HintSelection(eqg)
		local eqc=eqg:GetFirst()
		while eqc do
			if Duel.Equip(eqc:GetControler(),eqc,tc) then
				local e1=Effect.CreateEffect(e:GetHandler())
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetProperty(EFFECT_FLAG_OWNER_RELATE)
				e1:SetCode(EFFECT_EQUIP_LIMIT)
				e1:SetReset(RESET_EVENT+0xfe0000)
				e1:SetValue(c33569968.eqlimit)
				e1:SetLabelObject(tc)
				eqc:RegisterEffect(e1)
				eqc:RegisterFlagEffect(33569968,RESET_EVENT+0xfe0000,0,0)
			end
			eqc=eqg:GetNext()
		end
		Duel.EquipComplete()
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_ADJUST)
		e2:SetRange(LOCATION_MZONE)
		e2:SetOperation(c33569968.ctop)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2)
	end
end	
function c33569968.eqlimit(e,c)
	return c==e:GetLabelObject()
end
function c33569968.ctfilter(c,tp)
	return c:GetFlagEffect(33569968)>0 and c:GetControler()~=tp
end
function c33569968.ctop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local p=c:GetControler()
	local g=c:GetEquipGroup():Filter(c33569968.ctfilter,nil,p)
	local tc=g:GetFirst()
	while tc do
		Duel.MoveToField(tc,p,p,LOCATION_SZONE,POS_FACEUP,true)
		Duel.Equip(p,tc,c)
		tc=g:GetNext()
	end
	Duel.EquipComplete()
end



function c33569968.filter4(c)
	return c:IsType(TYPE_MONSTER) and (c:GetCode(6205579) and c:IsAbleToDeck())
end
function c33569968.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c33569968.filter4,tp,LOCATION_GRAVE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c33569968.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c33569968.filter4,tp,LOCATION_GRAVE,0,nil)
	if g:GetCount()>0 then
		Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
	end
end