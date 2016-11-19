--prisman (DOR)
--scripted by GameMaster (GM)
function c335599182.initial_effect(c)
--fLIP SPELLS FACEDOWN
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_FLIP)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetOperation(c335599182.operation)
	c:RegisterEffect(e1)
end

function c335599182.tg(e,c)
return Duel.GetMatchingGroup(c335599182.filter,tp,LOCATION_SZONE,0,c)

end

function c335599182.filter(c)
    return c:IsType(TYPE_SPELL) and c:IsFaceup()
  end

function c335599182.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c335599182.filter,tp,LOCATION_SZONE,0,c)
	if g:GetCount()>0 then
		Duel.ChangePosition(g,POS_FACEDOWN)
	end
end

	