--Disonic power
--scripted by GameMaster (GM)
function c33569983.initial_effect(c)
--Activate
local e1=Effect.CreateEffect(c)
e1:SetCategory(CATEGORY_DISABLE)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetOperation(c33569983.activate)
e1:SetTarget(c33569983.copytg)
c:RegisterEffect(e1)
end

function c33569983.filter2(c)
	return c:IsType(TYPE_MONSTER) and c:IsFaceup()
end

function c33569983.copytg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
    if chk==0 then return Duel.IsExistingTarget(c33569983.filter1,tp,LOCATION_MZONE,0,1,nil) and Duel.IsExistingTarget(c33569983.filter2,tp,0,LOCATION_MZONE,1,nil) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
    local g1=Duel.SelectTarget(tp,c33569983.filter1,tp,LOCATION_MZONE,0,1,1,nil) --first target
    local g2=Duel.SelectTarget(tp,c33569983.filter2,tp,0,LOCATION_MZONE,1,1,nil) --second target
    Duel.SetOperationInfo(0,CATEGORY_ANNOUNCE,g1,1,tp,0)
    Duel.SetOperationInfo(0,CATEGORY_DISABLE,g2,1,tp,0)
end
	
function c33569983.filter1(c)
	return c:IsFaceup() and not c:IsDisabled() and c:IsType(TYPE_MONSTER)
end

function c33569983.activate(e,tp,eg,ep,ev,re,r,rp)
	local gg,g1=Duel.GetOperationInfo(0,CATEGORY_ANNOUNCE)
    local gg,g2=Duel.GetOperationInfo(0,CATEGORY_DISABLE)
    local tc1=g1:GetFirst()
    local tc2=g2:GetFirst()
	if tc1 and tc1:IsRelateToEffect(e) and tc2 and tc2:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCode(EFFECT_CHANGE_CODE)
		e1:SetValue(tc2:GetOriginalCode())
		tc1:RegisterEffect(e1)
		local cid=tc1:CopyEffect(tc2:GetOriginalCode(),RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetDescription(aux.Stringid(33569983,1))
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_PHASE+PHASE_END)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e2:SetCountLimit(1)
		e2:SetRange(LOCATION_MZONE)
		e2:SetLabel(cid)
		e2:SetLabelObject(e1)
		e2:SetOperation(c33569983.rstop)
		tc1:RegisterEffect(e2)
		local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE)
		e3:SetCode(EFFECT_DISABLE)
		tc2:RegisterEffect(e3)
		local e4=Effect.CreateEffect(e:GetHandler())
		e4:SetType(EFFECT_TYPE_SINGLE)
		e4:SetCode(EFFECT_DISABLE_EFFECT)
		e4:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE)
		tc2:RegisterEffect(e4)
		end
end

function c33569983.rstop(e,tp,eg,ep,ev,re,r,rp)
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
