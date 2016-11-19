--Helpoemer 
--scripted by GameMaster(GM)
function c335599144.initial_effect(c)
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SINGLE_RANGE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--reg
	local e2=Effect.CreateEffect(c)
    e2:SetCode(EFFECT_SEND_REPLACE)
    e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    e2:SetTarget(c335599144.reptg)
    e2:SetOperation(c335599144.repop)
    c:RegisterEffect(e2)
	--handes
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(335599144,0))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCategory(CATEGORY_HANDES)
	e3:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCountLimit(1)
	e3:SetCondition(c335599144.hdcon)
	e3:SetTarget(c335599144.hdtg)
	e3:SetOperation(c335599144.hdop)
	c:RegisterEffect(e3)
--send to opponents grave
end
function c335599144.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
    local c=e:GetHandler()
    if chk==0 then return c:GetDestination()==LOCATION_GRAVE and c:IsReason(REASON_BATTLE) end
    return true
end
function c335599144.repop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    Duel.SendtoGrave(c,c:GetReason(),1-c:GetOwner())
    c:RegisterFlagEffect(335599144,RESET_EVENT+0x17A0000,0,0)
end
function c335599144.hdcon(e,tp,eg,ep,ev,re,r,rp)
    return Duel.GetTurnPlayer()==tp and e:GetHandler():GetFlagEffect(335599144)~=0
end
function c335599144.hdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	e:GetHandler():ResetFlagEffect(335599144)
	Duel.SetOperationInfo(0,CATEGORY_HANDES,0,0,tp,1)
end
function c335599144.hdop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		e:GetHandler():RegisterFlagEffect(335599144,RESET_EVENT+0x1fe0000,0,0)
		local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
		if g:GetCount()==0 then return end
		local sg=g:RandomSelect(tp,1)
		Duel.SendtoGrave(sg,REASON_DISCARD+REASON_EFFECT)
	end
end
