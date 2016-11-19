--Ambition of Naraku
--scripted by GameMaster(GM)
function c33569988.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c33569988.target)
	e1:SetOperation(c33569988.activate)
	e1:SetCondition(c33569988.con)
	c:RegisterEffect(e1)
end

function c33569988.filter2(c)
	return c:IsFaceup() and c:IsCode(33569984)
end

function c33569988.con(e,tp)
    return  Duel.IsExistingMatchingCard(c33569988.filter2,tp,LOCATION_ONFIELD,0,1,nil)
end


function c33569988.filter(c,e,tp,eg,ep,ev,re,r,rp)
	return c:GetCode()==33559949 
end
function c33569988.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
end

function c33569988.activate(e,tp,eg,ep,ev,re,r,rp)
		local acg=Duel.GetMatchingGroup(c33569988.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,nil,e,tp,eg,ep,ev,re,r,rp)
		if acg:GetCount()>0  then
			local tc=acg:Select(tp,1,1,nil):GetFirst()
			local tpe=tc:GetCode(33559949)
			Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
			Duel.Hint(HINT_CARD,0,tc:GetCode())
			if tc:IsRelateToEffect(e) then	
			tc:CancelToGrave(false)
		end
	end
end	