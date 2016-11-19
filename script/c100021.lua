--Contract With Pinky
function c100021.initial_effect(c)
	--active
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c100021.target)
	e1:SetOperation(c100021.activate)
	c:RegisterEffect(e1)
	--banish
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(100021,3))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCountLimit(1,100021+EFFECT_COUNT_CODE_DUEL)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCondition(aux.exccon)
	e2:SetTarget(c100021.tg)
	e2:SetOperation(c100021.op)
	c:RegisterEffect(e2)
end
function c100021.exfilter(c,e,tp,mg)
	return c:IsAbleToRemove()
end
function c100021.filter(c,e,tp,mg)
	if not c:IsType(TYPE_RITUAL) or not c:IsSetCard(0x720) or not c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,false,true) then return false end
	mg=mg:Filter(Card.IsCanBeRitualMaterial,c,c)
	if c.mat_filter then
			mg=mg:Filter(c.mat_filter,nil)
	end
	local exmg=Duel.GetMatchingGroup(c100021.exfilter,tp,LOCATION_DECK,0,nil)
	exmg=exmg:Filter(Card.IsCanBeRitualMaterial,c,c)
	if c.mat_filter then
			exmg=exmg:Filter(c.mat_filter,nil)
	end
	return mg:CheckWithSumGreater(Card.GetRitualLevel,c:GetLevel(),c) or exmg:CheckWithSumEqual(Card.GetRitualLevel,c:GetLevel(),1,99,c)
end
function c100021.nfilter(c,e,tp,mg)
	if not c:IsType(TYPE_RITUAL) or not c:IsSetCard(0x720) or not c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,false,true) then return false end
	local mg=Duel.GetRitualMaterial(tp)
	mg=mg:Filter(Card.IsCanBeRitualMaterial,c,c)
	if c.mat_filter then
			mg=mg:Filter(c.mat_filter,nil)
	end
	local exmg=Duel.GetMatchingGroup(c100021.exfilter,tp,LOCATION_DECK,0,nil)
	exmg=exmg:Filter(Card.IsCanBeRitualMaterial,c,c)
	if c.mat_filter then
			exmg=exmg:Filter(c.mat_filter,nil)
	end
	return mg:CheckWithSumGreater(Card.GetRitualLevel,c:GetLevel(),c) and exmg:CheckWithSumEqual(Card.GetRitualLevel,c:GetLevel(),1,99,c)
end
function c100021.rfilter(c,e,tp,mg)
	if not c:IsType(TYPE_RITUAL) or not c:IsSetCard(0x720) or not c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,false,true) then return false end
	local mg=Duel.GetRitualMaterial(tp)
	mg=mg:Filter(Card.IsCanBeRitualMaterial,c,c)
	if c.mat_filter then
			mg=mg:Filter(c.mat_filter,nil)
	end
	local exmg=Duel.GetMatchingGroup(c100021.exfilter,tp,LOCATION_DECK,0,nil)
	if c.mat_filter then
			exmg=exmg:Filter(c.mat_filter,nil)
	end
	return exmg:CheckWithSumEqual(Card.GetRitualLevel,c:GetLevel(),1,99,c)
end
function c100021.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local mg=Duel.GetRitualMaterial(tp)
		return Duel.IsExistingMatchingCard(c100021.filter,tp,LOCATION_HAND,0,1,nil,e,tp,mg)
	end
	if Duel.IsExistingMatchingCard(c100021.nfilter,tp,LOCATION_HAND,0,1,nil,e,tp,mg) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.GetCurrentPhase()<=PHASE_MAIN1 then
		local opt=Duel.SelectOption(tp,aux.Stringid(100021,0),aux.Stringid(100021,1))
		e:SetLabel(opt)
	elseif Duel.IsExistingMatchingCard(c100021.rfilter,tp,LOCATION_HAND,0,1,nil,e,tp,mg) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.GetCurrentPhase()<=PHASE_MAIN1 then
		e:SetLabel(1)
	else
		e:SetLabel(0)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c100021.activate(e,tp,eg,ep,ev,re,r,rp)
	local opt=e:GetLabel()
	local mg=Duel.GetRitualMaterial(tp)
	local exmg=Duel.GetMatchingGroup(c100021.exfilter,tp,LOCATION_DECK,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tg=0
	if opt==0 then
		tg=Duel.SelectMatchingCard(tp,c100021.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp,mg)
	else
		tg=Duel.SelectMatchingCard(tp,c100021.rfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp,mg)
	end
	local tc=tg:GetFirst()
	if tc then
		mg=mg:Filter(Card.IsCanBeRitualMaterial,tc,tc)
		if tc.mat_filter then
			mg=mg:Filter(tc.mat_filter,nil)
		end
		exmg=exmg:Filter(Card.IsCanBeRitualMaterial,tc,tc)
		if tc.mat_filter then
			exmg=exmg:Filter(tc.mat_filter,nil)
		end
		local mat=nil
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
		if opt==0 then
			mat=mg:SelectWithSumGreater(tp,Card.GetRitualLevel,tc:GetLevel(),tc)
		else
			mat=exmg:SelectWithSumEqual(tp,Card.GetRitualLevel,tc:GetLevel(),1,99,tc)
		end
		tc:SetMaterial(mat)
		if opt==0 then
			Duel.SendtoGrave(mat,REASON_EFFECT+REASON_MATERIAL+REASON_RITUAL)
		else
			Duel.Remove(mat,POS_FACEUP,REASON_EFFECT+REASON_MATERIAL+REASON_RITUAL)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_FIELD)
			e1:SetCode(EFFECT_CANNOT_BP)
			e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
			e1:SetTargetRange(1,0)
			e1:SetReset(RESET_PHASE+PHASE_END)
			Duel.RegisterEffect(e1,tp)
		end
		Duel.BreakEffect()
		Duel.SpecialSummon(tc,SUMMON_TYPE_RITUAL,tp,tp,false,true,POS_FACEUP)
		tc:CompleteProcedure()
	end
end
function c100021.remfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToRemove() and c:IsPosition(POS_FACEUP)
end
function c100021.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c100021.remfilter,tp,0,LOCATION_ONFIELD,1,nil) end
	local count=Duel.GetMatchingGroupCount(c100021.remfilter,tp,0,LOCATION_ONFIELD,nil)
	local g=Duel.SelectTarget(tp,c100021.remfilter,tp,0,LOCATION_ONFIELD,count,count,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
end
function c100021.op(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT)
	local tc=tg:GetFirst()
	while tc do
		Duel.Remove(tc,0,REASON_TEMPORARY)
		tc=tg:GetNext()
	end
	local sg=tg:Filter(Card.IsLocation,nil,LOCATION_REMOVED)
	sg:KeepAlive()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetLabelObject(sg)
	e1:SetCountLimit(1)
	e1:SetOperation(c100021.retop)
	Duel.RegisterEffect(e1,tp)
end
function c100021.retop(e,tp,eg,ep,ev,re,r,rp)
	local tg=e:GetLabelObject()
	local tc=tg:GetFirst()
	while tc do
		Duel.ReturnToField(tc,POS_FACEUP_ATTACK)
		tc=tg:GetNext()
	end
	tg:DeleteGroup()
end