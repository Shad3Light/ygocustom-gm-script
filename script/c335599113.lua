--Clear color changer
function c335599113.initial_effect(c)
	--attribute
	--attribute
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c335599113.atttg)
	e1:SetOperation(c335599113.attop)
	c:RegisterEffect(e1)
end
function c335599113.attfilter(c,att)
	return c:IsFaceup() and c:IsAttribute(att)
end
function c335599113.attcount(tp,loc1,loc2)
	local att=0
	if Duel.IsExistingMatchingCard(c335599113.attfilter,tp,loc1,loc2,1,nil,ATTRIBUTE_LIGHT) then att=att+1 end
	if Duel.IsExistingMatchingCard(c335599113.attfilter,tp,loc1,loc2,1,nil,ATTRIBUTE_DARK) then att=att+1 end
	if Duel.IsExistingMatchingCard(c335599113.attfilter,tp,loc1,loc2,1,nil,ATTRIBUTE_WATER) then att=att+1 end
	if Duel.IsExistingMatchingCard(c335599113.attfilter,tp,loc1,loc2,1,nil,ATTRIBUTE_FIRE) then att=att+1 end
	if Duel.IsExistingMatchingCard(c335599113.attfilter,tp,loc1,loc2,1,nil,ATTRIBUTE_EARTH) then att=att+1 end
	if Duel.IsExistingMatchingCard(c335599113.attfilter,tp,loc1,loc2,1,nil,ATTRIBUTE_WIND) then att=att+1 end
	if Duel.IsExistingMatchingCard(c335599113.attfilter,tp,loc1,loc2,1,nil,ATTRIBUTE_DEVINE) then att=att+1 end
	return att
end
function c335599113.atttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,tp,1)
end
function c335599113.attop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
		while tc do
			Duel.HintSelection(Group.FromCards(tc))
			Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(335599113,0))
			ac=Duel.AnnounceNumber(tp,1,2,3,4,5,6)
			local att=0
			local dice=Duel.TossDice(tp,1)
			if dice==1 then
				att=ATTRIBUTE_LIGHT
			elseif dice==2 then
				att=ATTRIBUTE_DARK
			elseif dice==3 then
				att=ATTRIBUTE_EARTH
			elseif dice==4 then
				att=ATTRIBUTE_WATER
			elseif dice==5 then
				att=ATTRIBUTE_FIRE
			else
				att=ATTRIBUTE_WIND
			end
			if dice==ac then
				local e1=Effect.CreateEffect(c)
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetProperty(EFFECT_FLAG_COPY_INHERIT)
				e1:SetCode(EFFECT_ADD_ATTRIBUTE)
				e1:SetValue(att)
				e1:SetReset(RESET_EVENT+0x1ff0000)
				tc:RegisterEffect(e1)				
			else
				local e1=Effect.CreateEffect(c)
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetProperty(EFFECT_FLAG_COPY_INHERIT)
				e1:SetCode(EFFECT_CHANGE_ATTRIBUTE)
				e1:SetValue(att)
				e1:SetReset(RESET_EVENT+0x1ff0000)
				tc:RegisterEffect(e1)
			end
			tc=g:GetNext()
		end
	end
end