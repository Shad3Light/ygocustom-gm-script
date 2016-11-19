--Black Dragon Sigil
--57335213
function c57335213.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c57335213.condition)
	e1:SetTarget(c57335213.target)
	e1:SetOperation(c57335213.activate)
	c:RegisterEffect(e1)
end
c57335213.card_code_list={57335202}
function c57335213.cfilter(c)
	return c:IsFaceup() and c:IsCode(57335202)
end
function c57335213.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c57335213.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c57335213.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c57335213.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c57335213.filter,tp,0,LOCATION_ONFIELD,1,c) end
	local sg=Duel.GetMatchingGroup(c57335213.filter,tp,0,LOCATION_ONFIELD,c)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c57335213.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c57335213.filter,tp,0,LOCATION_ONFIELD,e:GetHandler())
	Duel.Destroy(sg,REASON_EFFECT)
end
