--クリア-・フュージョン
function c300000004.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,300000004+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c300000004.target)
	e1:SetOperation(c300000004.activate)
	c:RegisterEffect(e1)
end
function c300000004.filter0(c)
	return c:IsCanBeFusionMaterial() and c:IsAbleToGrave()
end
function c300000004.filter1(c,e)
	return c:IsCanBeFusionMaterial() and c:IsAbleToGrave() and not c:IsImmuneToEffect(e)
end
function c300000004.filter2(c,e,tp,m,f,chkf)
	return c:IsType(TYPE_FUSION) and c:IsSetCard(0x9d) and (not f or f(c))
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) and c:CheckFusionMaterial(m,nil,chkf)
end
function c300000004.lightfilter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_LIGHT)
end
function c300000004.darkfilter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_DARK)
end
function c300000004.waterfilter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WATER)
end
function c300000004.firefilter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_FIRE)
end
function c300000004.earthfilter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_EARTH)
end
function c300000004.windfilter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WIND)
end
function c300000004.divinefilter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_DIVINE)
end
function c300000004.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
		local loc=LOCATION_HAND+LOCATION_MZONE
		local lgt=Duel.GetMatchingGroup(c300000004.lightfilter,e:GetHandlerPlayer(),0,LOCATION_MZONE,nil)
		local drk=Duel.GetMatchingGroup(c300000004.darkfilter,e:GetHandlerPlayer(),0,LOCATION_MZONE,nil)
		local wtr=Duel.GetMatchingGroup(c300000004.waterfilter,e:GetHandlerPlayer(),0,LOCATION_MZONE,nil)
		local fir=Duel.GetMatchingGroup(c300000004.firefilter,e:GetHandlerPlayer(),0,LOCATION_MZONE,nil)
		local ert=Duel.GetMatchingGroup(c300000004.earthfilter,e:GetHandlerPlayer(),0,LOCATION_MZONE,nil)
		local wnd=Duel.GetMatchingGroup(c300000004.windfilter,e:GetHandlerPlayer(),0,LOCATION_MZONE,nil)
		local div=Duel.GetMatchingGroup(c300000004.divinefilter,e:GetHandlerPlayer(),0,LOCATION_MZONE,nil)
		if lgt~=0 then lgt=1 end
		if drk~=0 then drk=1 end
		if wtr~=0 then wtr=1 end
		if fir~=0 then fir=1 end
		if ert~=0 then ert=1 end
		if wnd~=0 then wnd=1 end
		if div~=0 then div=1 end
		local attr=lgt+drk+wtr+fir+ert+wnd+div
		if attr>=2 then
			loc=loc+LOCATION_DECK
		end
		local mg1=Duel.GetMatchingGroup(c300000004.filter0,tp,loc,0,nil)
		local res=Duel.IsExistingMatchingCard(c300000004.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg1,nil,chkf)
		if not res then
			local ce=Duel.GetChainMaterial(tp)
			if ce~=nil then
				local fgroup=ce:GetTarget()
				local mg2=fgroup(ce,e,tp)
				local mf=ce:GetValue()
				res=Duel.IsExistingMatchingCard(c300000004.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg2,mf,chkf)
			end
		end
		return res
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c300000004.activate(e,tp,eg,ep,ev,re,r,rp)
	local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
	local loc=LOCATION_HAND+LOCATION_MZONE
	local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
	local loc=LOCATION_HAND+LOCATION_MZONE
	local lgt=Duel.GetMatchingGroup(c300000004.lightfilter,e:GetHandlerPlayer(),0,LOCATION_MZONE,nil)
	local drk=Duel.GetMatchingGroup(c300000004.darkfilter,e:GetHandlerPlayer(),0,LOCATION_MZONE,nil)
	local wtr=Duel.GetMatchingGroup(c300000004.waterfilter,e:GetHandlerPlayer(),0,LOCATION_MZONE,nil)
	local fir=Duel.GetMatchingGroup(c300000004.firefilter,e:GetHandlerPlayer(),0,LOCATION_MZONE,nil)
	local ert=Duel.GetMatchingGroup(c300000004.earthfilter,e:GetHandlerPlayer(),0,LOCATION_MZONE,nil)
	local wnd=Duel.GetMatchingGroup(c300000004.windfilter,e:GetHandlerPlayer(),0,LOCATION_MZONE,nil)
	local div=Duel.GetMatchingGroup(c300000004.divinefilter,e:GetHandlerPlayer(),0,LOCATION_MZONE,nil)
	if lgt~=0 then lgt=1 end
	if drk~=0 then drk=1 end
	if wtr~=0 then wtr=1 end
	if fir~=0 then fir=1 end
	if ert~=0 then ert=1 end
	if wnd~=0 then wnd=1 end
	if div~=0 then div=1 end
	local attr=lgt+drk+wtr+fir+ert+wnd+div
	if attr>=2 then
		loc=loc+LOCATION_DECK
	end
	local mg1=Duel.GetMatchingGroup(c300000004.filter1,tp,loc,0,nil,e)
	local sg1=Duel.GetMatchingGroup(c300000004.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg1,nil,chkf)
	local mg2=nil
	local sg2=nil
	local ce=Duel.GetChainMaterial(tp)
	if ce~=nil then
		local fgroup=ce:GetTarget()
		mg2=fgroup(ce,e,tp)
		local mf=ce:GetValue()
		sg2=Duel.GetMatchingGroup(c300000004.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg2,mf,chkf)
	end
	if sg1:GetCount()>0 or (sg2~=nil and sg2:GetCount()>0) then
		local sg=sg1:Clone()
		if sg2 then sg:Merge(sg2) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tg=sg:Select(tp,1,1,nil)
		local tc=tg:GetFirst()
		if sg1:IsContains(tc) and (sg2==nil or not sg2:IsContains(tc) or not Duel.SelectYesNo(tp,ce:GetDescription())) then
			local mat1=Duel.SelectFusionMaterial(tp,tc,mg1,nil,chkf)
			tc:SetMaterial(mat1)
			Duel.SendtoGrave(mat1,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
			Duel.BreakEffect()
			Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
		else
			local mat2=Duel.SelectFusionMaterial(tp,tc,mg2,nil,chkf)
			local fop=ce:GetOperation()
			fop(ce,e,tp,tc,mat2)
		end
		tc:CompleteProcedure()
	else
		local cg1=Duel.GetFieldGroup(tp,LOCATION_HAND+LOCATION_MZONE,0)
		local cg2=Duel.GetFieldGroup(tp,LOCATION_DECK,0)
		local cg3=Duel.GetFieldGroup(tp,LOCATION_EXTRA,0)
		if cg1:GetCount()>1 and cg3:IsExists(Card.IsFacedown,1,nil) and Duel.IsPlayerCanSpecialSummon(tp) 
				and not Duel.IsPlayerAffectedByEffect(tp,27581098) then
			Duel.ConfirmCards(1-tp,cg1)
			if bit.band(loc,LOCATION_DECK)==LOCATION_DECK and not Duel.IsPlayerAffectedByEffect(tp,EFFECT_CANNOT_DISCARD_DECK) then
				Duel.ConfirmCards(1-tp,cg2)
				Duel.ShuffleDeck(tp)
			end
			Duel.ConfirmCards(1-tp,cg3)
			Duel.ShuffleHand(tp)
		end
	end
end