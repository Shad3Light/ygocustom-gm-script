--Darkness Approaches
--scripted by GameMaster (GM)
function c335599190.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c335599190.op)
	e1:SetTarget(c335599190.tg)
	c:RegisterEffect(e1)
end

function c335599190.tg(e,c)
return Duel.GetMatchingGroup(c335599190.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
end

function c335599190.filter1(c)
    return c:IsType(TYPE_SPELL+TYPE_PENDULUM+TYPE_TRAP) and c:IsFaceup()
  end


  
function c335599190.op(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c335599190.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)																												
		if g:GetCount()>0 then
		Duel.ChangePosition(g,POS_FACEDOWN)
	local g=Duel.GetFirstTarget()
	if g:IsRelateToEffect(e) and c:IsType(TYPE_MONSTER) then
		Duel.ChangePosition(g,POS_FACEDOWN_DEFENSE,0)
	end
end
end
