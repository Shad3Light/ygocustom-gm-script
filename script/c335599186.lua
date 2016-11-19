--Ray & Tempreature (DOR)
--scripted by GameMaster (GM)
function c335599186.initial_effect(c)
	--baseatk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetCondition(c335599186.basecon)
	e1:SetTarget(c335599186.basetg)
	e1:SetValue(c335599186.baseval)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e1)
end
function c335599186.basecon(e)
	local ph=Duel.GetCurrentPhase()
	return (ph==PHASE_DAMAGE or ph==PHASE_DAMAGE_CAL) and Duel.GetAttackTarget()~=nil
		and (Duel.GetAttacker()==e:GetHandler() or Duel.GetAttackTarget()==e:GetHandler())
end
function c335599186.basetg(e,c)
	return c==e:GetHandler():GetBattleTarget()
end
function c335599186.baseval(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler():GetBattleTarget()
	return c:GetBaseAttack()
end
