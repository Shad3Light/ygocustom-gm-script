--Toxic Waste Cleanup
function c1039.initial_effect(c)
	--Draw/Recover
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE+CATEGORY_DRAW+CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c1039.target)
	e1:SetOperation(c1039.operation)
	c:RegisterEffect(e1)
end
function c1039.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x14) and c:GetSequence()<5
end
function c1039.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp)
		and Duel.IsExistingMatchingCard(c1039.filter,tp,LOCATION_SZONE,0,1,e:GetHandler()) end
	local g=Duel.GetMatchingGroup(c1039.filter,tp,LOCATION_SZONE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,g:GetCount())
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,g:GetCount()*500)
end
function c1039.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c1039.filter,tp,LOCATION_SZONE,0,e:GetHandler())
	local ct1=Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	if ct1==0 then return end
	local ct2=Duel.Draw(tp,ct1,REASON_EFFECT)
	Duel.BreakEffect()
	Duel.Recover(tp,ct2*500,REASON_EFFECT)
end