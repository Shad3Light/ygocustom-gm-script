--Patrol Robo (DOR)
--scripted by GameMaster (GM)
function c335599198.initial_effect(c)
--fLIP SPELLS FACEup
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_FLIP)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetOperation(c335599198.operation)
	c:RegisterEffect(e1)
end

function c335599198.tg(e,c)
return Duel.GetMatchingGroup(c335599198.filter,tp,0,LOCATION_SZONE,nil)
end

function c335599198.filter(c)
    return c:IsType(TYPE_SPELL) and c:IsFacedown()
  end

function c335599198.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c335599198.filter,tp,0,LOCATION_SZONE,nil)
	if g:GetCount()>0 then
		Duel.ChangePosition(g,POS_FACEUP)
	end
end

