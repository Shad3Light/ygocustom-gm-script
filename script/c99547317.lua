function c99547317.initial_effect(c)  
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
   --atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c99547317.target)
	e2:SetValue(c99547317.val1)
	c:RegisterEffect(e2)
	--defup
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetTarget(c99547317.target)
	e3:SetValue(c99547317.val2)
	c:RegisterEffect(e3)
	--10% increase each standby
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(99547317,0))
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)	
	e4:SetCategory(CATEGORY_ATKCHANGE)
	e4:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCountLimit(1)
	e4:SetProperty(EFFECT_FLAG_REPEAT)
	e4:SetCondition(c99547317.atkcon)
	e4:SetOperation(c99547317.atkop)
	c:RegisterEffect(e4)
		--Unaffected by Opponent Card Effects
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCode(EFFECT_IMMUNE_EFFECT)
	e5:SetValue(c99547317.unval)
	c:RegisterEffect(e5)
end
function c99547317.target(e,c)
	return c:IsRace(RACE_ZOMBIE) and  c~=e:GetHandler()
end
function c99547317.unval(e,te)
	return te:GetHandlerPlayer()~=e:GetHandlerPlayer()
end
function c99547317.val1(e,c)
	return c:GetBaseAttack()*0.2
end
function c99547317.val2(e,c)
	return c:GetBaseDefense()*0.2
end
function c99547317.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c99547317.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
    for i=0,4 do
		local tc=Duel.GetFieldCard(tp,LOCATION_MZONE,i)
		if tc and tc:IsRace(RACE_ZOMBIE) and tc:IsFaceup() then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_OWNER_RELATE)
			e1:SetRange(LOCATION_MZONE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(tc:GetBaseAttack()*0.2)
			tc:RegisterEffect(e1,true)
	    	local e2=e1:Clone()
			e2:SetCode(EFFECT_UPDATE_DEFENSE)
			e2:SetValue(tc:GetBaseDefense()*0.2)
			tc:RegisterEffect(e2,true)
		end
	end
	for i=0,4 do
		local tc=Duel.GetFieldCard(1-tp,LOCATION_MZONE,i)
		if tc and tc:IsRace(RACE_ZOMBIE) and tc:IsFaceup() then
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_OWNER_RELATE)
			e2:SetRange(LOCATION_MZONE)
			e2:SetCode(EFFECT_UPDATE_ATTACK)
			e2:SetValue(tc:GetBaseAttack()*0.2)
			tc:RegisterEffect(e2,true)
			local e3=e2:Clone()
			e3:SetCode(EFFECT_UPDATE_DEFENSE)
			e3:SetValue(tc:GetBaseDefense()*0.2)
			tc:RegisterEffect(e3,true)
		end
	end
end
