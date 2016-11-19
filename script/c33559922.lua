--Toon Conductor
function c33559922.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)   
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE)
	e1:SetCondition(c33559922.spcon)
	e1:SetOperation(c33559922.spop)
	c:RegisterEffect(e1)
	--summon eff 
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCondition(c33559922.condition)
	e2:SetOperation(c33559922.operation)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	local e4=e2:Clone()
	e4:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e4)
	--tribute eff
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_ONFIELD)
	e5:SetCountLimit(1)
	e5:SetCost(c33559922.Pcost)
	e5:SetCondition(c33559922.condition)
	e5:SetOperation(c33559922.operation)
	c:RegisterEffect(e5)
end
function c33559922.spfilter(c)
	return c:IsCode(33559923) --and c:IsReleaseable()
end
function c33559922.spcon(e,c)
	if c==nil then return true end
	local f=Duel.GetFieldCard(c:GetControler(),LOCATION_SZONE,5)
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c33559922.spfilter,c:GetControler(),LOCATION_ONFIELD,0,1,nil)
		and f and f:IsSetCard(0x62)
end
function c33559922.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local tc=Duel.SelectMatchingCard(tp,c33559922.spfilter,tp,LOCATION_ONFIELD,0,1,1,nil)
	Duel.Release(tc,REASON_COST)
end

function c33559922.condition(e,c)
	return Duel.IsExistingMatchingCard(Card.IsSetCard,e:GetHandler():GetControler(),LOCATION_DECK+LOCATION_GRAVE,0,1,nil,0x62)
end
function c33559922.operation(e,tp,eg,ep,ev,re,r,rp,chk)	
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOHAND)
	local g=Duel.SelectMatchingCard(tp,Card.IsSetCard,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,0x62)
	Duel.SendtoHand(g,tp,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,g)
end

function c33559922.Pcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDestructable,tp,LOCATION_ONFIELD,0,1,nil) end
	local c = Duel.SelectMatchingCard(tp,Card.IsDestructable,tp,LOCATION_ONFIELD,0,1,1,nil)
	Duel.Destroy(c,REASON_COST)
end