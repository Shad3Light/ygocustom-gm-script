--Hannibal Necromancer (DOR)
--scripted by GameMaster (GM)
function c33569929.initial_effect(c)
--all Zombies gain 300 atk/def
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetOperation(c33569929.operation)
	c:RegisterEffect(e1)
end
function c33569929.atktg(e,c)
return Duel.GetMatchingGroup(c33569929.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
end
function c33569929.filter(c)
    return c:IsType(TYPE_MONSTER) and (c:IsFaceup() and c:IsRace(RACE_ZOMBIE))
  end
function c33569929.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c33569929.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetTarget(c33569929.atktg)
		e1:SetValue(300)
		tc:RegisterEffect(e1)
		e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		tc:RegisterEffect(e2) 
		tc=g:GetNext()
	end
end