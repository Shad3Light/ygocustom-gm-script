--Cows' Wish for a Friend
function c33579900.initial_effect(c)
  local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c33579900.cost)
	e1:SetRange(LOCATION_HAND)
	c:RegisterEffect(e1)
	
end

function c33579900.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1)
	else Duel.PayLPCost(tp,1)
Duel.RaiseEvent(e:GetHandler(),EVENT_CUSTOM+33579900,e,0,0,tp,0)
	end
end	
