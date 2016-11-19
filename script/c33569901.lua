--Yamadron (DOR)
--scripted by GameMaster (GM)
function c33569901.initial_effect(c)
	--Flip destroy field cards
	local e0=Effect.CreateEffect(c)
	e0:SetCategory(CATEGORY_DESTROY)
	e0:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e0:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e0:SetOperation(c33569901.operation)
	c:RegisterEffect(e0)
	--turn field back to normal/no field spells-destroy
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ANNOUNCE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLED)
	e1:SetOperation(c33569901.operation)
	c:RegisterEffect(e1)
end

function c33569901.filter(c) return c:GetSequence()==5 end


function c33569901.operation(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c33569901.filter,tp,LOCATION_SZONE,LOCATION_SZONE,e:GetHandler())
	Duel.Destroy(sg,REASON_EFFECT)
end
