--Mix-Up Jar
function c17.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetOperation(c17.operation)
	c:RegisterEffect(e1)
end

function c17.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetFieldGroup(tp,LOCATION_ONFIELD+LOCATION_HAND,0)
	local g2=Duel.GetFieldGroup(1-tp,LOCATION_ONFIELD+LOCATION_HAND,0)
	Duel.SendtoDeck(g,tp,2,REASON_EFFECT)
	Duel.SendtoDeck(g2,1-tp,2,REASON_EFFECT)

	d=Duel.GetFieldGroup(tp,LOCATION_DECK,LOCATION_DECK)

   
	local d2 = d:RandomSelect(tp,math.ceil(d:GetCount()/2))
	
	d2:ForEach(function (tc)
	if d:IsContains(tc) then d:RemoveCard(tc) end
  end)

	Duel.SendtoDeck(d2,tp,2,REASON_EFFECT)
	Duel.SendtoDeck(d,1-tp,2,REASON_EFFECT)
	Duel.ShuffleDeck(tp)
	Duel.ShuffleDeck(1-tp)
	Duel.Draw(tp,5,REASON_EFFECT)
	Duel.Draw(1-tp,5,REASON_EFFECT)
end
