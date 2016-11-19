--3 WEIRD SISTERS
--scripted by GameMaster(GM)
function c335599120.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c335599120.target)
	e1:SetOperation(c335599120.activate)
	c:RegisterEffect(e1)
end


function c335599120.filter(c,e,tp,eg,ep,ev,re,r,rp)
	return c:IsType(TYPE_PENDULUM)
end
function c335599120.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
end

function c335599120.activate(e,tp,eg,ep,ev,re,r,rp)
		local acg=Duel.GetMatchingGroup(c335599120.filter,tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_REMOVED,0,nil,e,tp,eg,ep,ev,re,r,rp)
		if acg:GetCount()>0  then
			local tc=acg:Select(tp,1,1,nil):GetFirst()
			local tpe=tc:GetType(TYPE_PENDULUM)
			Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
			Duel.Hint(HINT_CARD,0,tc:GetType())
			if tc:IsRelateToEffect(e) then	
			tc:CancelToGrave(false)
		end
	end
end	