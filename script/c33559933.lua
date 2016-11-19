--Twin Dark Priestesses
function c33559933.initial_effect(c)  
   --atk up
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetTarget(c33559933.target)
	e1:SetValue(c33559933.val1)
	c:RegisterEffect(e1)
	--defup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c33559933.target)
	e2:SetValue(c33559933.val2)
	c:RegisterEffect(e2)
	--10% increase each standby
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(33559933,0))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)	
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetProperty(EFFECT_FLAG_REPEAT)
	e3:SetCondition(c33559933.atkcon)
	e3:SetOperation(c33559933.atkop)
	c:RegisterEffect(e3)
end
function c33559933.target(e,c)
	return c:IsType(TYPE_SPIRIT) and  c~=e:GetHandler()
end
function c33559933.val1(e,c)
	return c:GetBaseAttack()*0.3
end
function c33559933.val2(e,c)
	return c:GetBaseDefense()*0.3
end
function c33559933.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c33559933.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
    for i=0,4 do
		local tc=Duel.GetFieldCard(tp,LOCATION_MZONE,i)
		if tc and tc:IsType(TYPE_SPIRIT) and tc:IsFaceup() then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_OWNER_RELATE)
			e1:SetRange(LOCATION_MZONE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(tc:GetBaseAttack()*0.3)
			tc:RegisterEffect(e1,true)
	    	local e2=e1:Clone()
			e2:SetCode(EFFECT_UPDATE_DEFENSE)
			e2:SetValue(tc:GetBaseDefense()*0.3)
			tc:RegisterEffect(e2,true)
		end
	end
	for i=0,4 do
		local tc=Duel.GetFieldCard(1-tp,LOCATION_MZONE,i)
		if tc and tc:IsType(TYPE_SPIRIT) and tc:IsFaceup() then
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_OWNER_RELATE)
			e2:SetRange(LOCATION_MZONE)
			e2:SetCode(EFFECT_UPDATE_ATTACK)
			e2:SetValue(tc:GetBaseAttack()*0.3)
			tc:RegisterEffect(e2,true)
			local e3=e2:Clone()
			e3:SetCode(EFFECT_UPDATE_DEFENSE)
			e3:SetValue(tc:GetBaseDefense()*0.3)
			tc:RegisterEffect(e3,true)
		end
	end
end
