--Dian Keto the Cure Master (DOR)
--scripted by GameMaster (GM)
function c33569913.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c33569913.condition)
	e1:SetOperation(c33569913.activate)
	c:RegisterEffect(e1)
end


function c33569913.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(tp)<4000
end

function c33569913.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetLP(tp,4000,REASON_EFFECT)
end