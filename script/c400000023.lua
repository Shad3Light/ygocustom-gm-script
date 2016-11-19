--Thousand-Eyes Restrict (Anime)
function c400000023.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,64631466,27125110,true,true)		
	--copy Relinquished (anime)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ADJUST)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c400000023.sdcon2)
	e1:SetOperation(c400000023.sdop)
	c:RegisterEffect(e1)
	--cannot attack announce
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetTarget(c400000023.antarget)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
	e4:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	c:RegisterEffect(e4)
end
function c400000023.sdcon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(400000023)==0
end
function c400000023.sdop(e,tp,eg,ep,ev,re,r,rp)	
	e:GetHandler():CopyEffect(400000022,RESET_EVENT+0x1fe0000)
	e:GetHandler():RegisterFlagEffect(400000023,RESET_EVENT+0x1fe0000,0,1)
end

function c400000023.antarget(e,c)
	return c~=e:GetHandler()
end