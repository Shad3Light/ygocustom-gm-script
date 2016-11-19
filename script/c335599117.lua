--Toon World (Anime)
function c335599117.initial_effect(c)
	c:SetUniqueOnField(1,0,335599117)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--treatead as Toon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCode(EFFECT_ADD_TYPE)
	e2:SetValue(TYPE_TOON)
	c:RegisterEffect(e2)
	--direct attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetCode(EFFECT_DIRECT_ATTACK)
	e3:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_TOON))
	e3:SetCondition(c335599117.dircon)
	c:RegisterEffect(e3)
	--battle indestructable
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e4:SetRange(LOCATION_SZONE)
	e4:SetTargetRange(LOCATION_MZONE,0)
	e4:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_TOON))
	e4:SetValue(1)
	c:RegisterEffect(e4)
	--attach monsters to card
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_FIELD)
	e5:SetCode(EVENT_PHASE+PHASE_END)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCountLimit(1)
	e5:SetCondition(c335599117.ovcon)
	e5:SetOperation(c335599117.ovop)
	c:RegisterEffect(e5)
	--Special Summon
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_FIELD)
	e6:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e6:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e6:SetRange(LOCATION_SZONE)
	e6:SetCountLimit(1)
	e6:SetCondition(c335599117.sscon)
	e6:SetOperation(c335599117.ssop)
	c:RegisterEffect(e6)
	--indestructable
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e7:SetValue(c335599117.indval)
	c:RegisterEffect(e7)
	-- Cannot Disable effect
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
	e8:SetCode(EFFECT_CANNOT_DISABLE)
	e8:SetRange(LOCATION_SZONE)
	c:RegisterEffect(e8)
end
function c335599117.indval(e,c)
	return e:GetHandler():GetOverlayCount()>0
end
function c335599117.dirfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_TOON)
end
function c335599117.dircon(e)
	return not Duel.IsExistingMatchingCard(c335599117.dirfilter,e:GetHandlerPlayer(),0,LOCATION_MZONE,1,nil)
end

function c335599117.ovcon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer() and Duel.IsExistingMatchingCard(c335599117.dirfilter,tp,LOCATION_MZONE,0,1,nil) 
end
function c335599117.ovop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsExistingMatchingCard(c335599117.dirfilter,tp,LOCATION_MZONE,0,1,nil) then
		local g=Duel.SelectMatchingCard(tp,c335599117.dirfilter,tp,LOCATION_MZONE,0,1,5,nil)
		Duel.Overlay(e:GetHandler(),g)
	end
end

function c335599117.sscon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer() and e:GetHandler():GetOverlayCount()>0
end
function c335599117.ssop(e,tp,eg,ep,ev,re,r,rp)
	local n=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if n>0 then
		local g=e:GetHandler():GetOverlayGroup():Select(tp,n,n,nil)
		Duel.SpecialSummon(g,nil,tp,tp,true,false,POS_FACEUP)
	end
	Duel.SendtoGrave(e:GetHandler():GetOverlayGroup(),REASON_EFFECT)
end