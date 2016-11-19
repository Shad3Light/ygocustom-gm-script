--The Stern Mystic (DOR)
--scripted by GameMaster (GM)
function c335599199.initial_effect(c)
	--fLIP cards FACEup
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_FLIP)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetOperation(c335599199.operation)
	c:RegisterEffect(e1)
end

function c335599199.tg(e,c)
return Duel.GetMatchingGroup(c335599199.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nill)

end

function c335599199.filter(c)
    return c:IsType(0xff) and c:IsFacedown()
  end

function c335599199.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c335599199.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nill)
	if g:GetCount()>0 then
		Duel.ChangePosition(g,POS_FACEUP)
	end
end

