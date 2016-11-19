--Paralyzing Potion (DOR)
--scripted by GameMaster (GM)
function c335599157.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c335599157.target)
	e1:SetOperation(c335599157.activate)
	c:RegisterEffect(e1)
end

function c335599157.filter(c)
	return c:IsType(TYPE_MONSTER) and not c:IsRace(RACE_MACHINE)
end

function c335599157.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e)  then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_ATTACK)
		e1:SetReset(RESET_EVENT+0x00040000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
		e2:SetReset(RESET_EVENT+0x00040000)
		tc:RegisterEffect(e2)
		end
end

function c335599157.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tc=Duel.GetFirstTarget()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c335599157.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c335599157.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,tc) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c335599157.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,tc)
end

function c335599157.aclimit(e,re,tp)
	return re:IsActiveType(TYPE_MONSTER)
end
