--Happy Lover (DOR)
--scripted by GameMaster (GM)
function c33569945.initial_effect(c)
	--baseatk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetCondition(c33569945.basecon)
	e1:SetTarget(c33569945.basetg)
	e1:SetValue(c33569945.baseval)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e1)
end
function c33569945.basecon(e)
	local ph=Duel.GetCurrentPhase()
	return (ph==PHASE_DAMAGE or ph==PHASE_DAMAGE_CAL) and Duel.GetAttackTarget()~=nil
		and (Duel.GetAttacker()==e:GetHandler() or Duel.GetAttackTarget()==e:GetHandler())
end
function c33569945.basetg(e,c)
	return c==e:GetHandler():GetBattleTarget()
end
function c33569945.baseval(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler():GetBattleTarget()
	return c:GetBaseAttack()
end
