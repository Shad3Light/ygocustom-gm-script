--Dark-Piercing light (DOR)
--scripted by GameMaster (GM)
function c33569928.initial_effect(c)
--fLIP cards FACEup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c33569928.operation)
	c:RegisterEffect(e1)
end

function c33569928.tg(e,c)
return Duel.GetMatchingGroup(c33569928.filter,tp,0,LOCATION_ONFIELD,nill)

end

function c33569928.filter(c)
    return c:IsType(0xff) and c:IsFacedown()
  end

function c33569928.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c33569928.filter,tp,0,LOCATION_ONFIELD,nill)
	if g:GetCount()>0 then
		Duel.ChangePosition(g,POS_FACEUP)
	end
end

