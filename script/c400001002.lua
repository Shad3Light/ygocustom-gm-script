--The Seal of Orichalcos
function c400001002.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetTarget(c400001002.acttg)
	e1:SetOperation(c400001002.actop)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_FZONE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetValue(500)
	c:RegisterEffect(e2)
	--can't be removed from field
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e3:SetRange(LOCATION_FZONE)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_CANNOT_REMOVE)
	c:RegisterEffect(e4)
	local e5=e3:Clone()
	e5:SetCode(EFFECT_CANNOT_DISABLE)
	c:RegisterEffect(e5)
	local e6=e3:Clone()
	e6:SetCode(EFFECT_CANNOT_TO_GRAVE)
	c:RegisterEffect(e6)
	local e7=e3:Clone()
	e7:SetCode(EFFECT_CANNOT_TO_HAND)
	c:RegisterEffect(e7)
	local e8=e3:Clone()
	e8:SetCode(EFFECT_CANNOT_TO_DECK)
	c:RegisterEffect(e8)
	--move monsters
	local e9=Effect.CreateEffect(c)
	--e9:SetDescription(aux.Stringid(34358408,0))
	e9:SetType(EFFECT_TYPE_IGNITION)
	e9:SetRange(LOCATION_FZONE)
	e9:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CARD_TARGET)
	e9:SetCode(EVENT_FREE_CHAIN)
	e9:SetTarget(c400001002.target)
	e9:SetOperation(c400001002.operation)
	c:RegisterEffect(e9)
	--monsters in spell zone can't be destroyed
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e10:SetCode(EFFECT_DESTROY_REPLACE)
	e10:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e10:SetRange(LOCATION_FZONE)
	e10:SetTarget(c400001002.indtg)
	e10:SetValue(c400001002.indval)
	c:RegisterEffect(e10)
end
function c400001002.repval(e,c)
	return c==e:GetHandler()
end

function c400001002.desfilter(c)
	return c:IsType(TYPE_FUSION) and c:IsDestructable()
end
function c400001002.acttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c400001002.desfilter,tp,LOCATION_MZONE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetChainLimit(aux.FALSE)
end
function c400001002.matfilter(c,e,tp)
	return c:IsLocation(LOCATION_GRAVE) and c:GetOwner()==tp and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c400001002.actop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(c400001002.desfilter,tp,LOCATION_MZONE,0,nil)
	if g:GetCount()>0 then
		Duel.Destroy(g,REASON_EFFECT)
		g=g:Filter(Card.GetSummonType,nil,SUMMON_TYPE_FUSION)
		local f = g:GetFirst()
		local m = nil
		while f do
			local m2 = f:GetMaterial():Filter(c400001002.matfilter,nil,e,tp)
			if m==nil then
				m = m2
			else
				m:Merge(m2)	
			end
			f = g:GetNext()
		end
		local n = math.min(Duel.GetLocationCount(tp,LOCATION_MZONE),m:GetCount())
		if n>0 then
			local c = m:Select(tp,n,n,nil)
			Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
		end			
	end
end

function c400001002.movefilter(c)
	return c:IsType(TYPE_MONSTER)
end
function c400001002.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c400001002.movefilter,tp,LOCATION_ONFIELD,0,1,nil) and
		(Duel.GetLocationCount(tp,LOCATION_MZONE)>0 or Duel.GetLocationCount(tp,LOCATION_SZONE)> 0 ) end
	local zone=LOCATION_ONFIELD
	if Duel.GetLocationCount(tp,LOCATION_MZONE)==0 then zone=LOCATION_MZONE end
	if Duel.GetLocationCount(tp,LOCATION_SZONE)==0 then zone=LOCATION_SZONE end
	local g=Duel.SelectTarget(tp,c400001002.movefilter,tp,zone,0,1,1,nil)
end
function c400001002.operation(e,tp,eg,ep,ev,re,r,rp)
	local mon=Duel.GetFirstTarget()
	local dest=LOCATION_MZONE
	if mon:GetLocation()==LOCATION_MZONE then dest=LOCATION_SZONE end
	local pos=POS_FACEUP
	if mon:IsFacedown() then pos=POS_FACEDOWN_DEFENSE end
	
	if mon:IsType(TYPE_PENDULUM) and dest==LOCATION_SZONE then
		Duel.MoveToField(mon,tp,tp,dest,pos,true)
		local ind={2,1,3,0,5}
		local i = 1
		while not Duel.CheckLocation(tp,LOCATION_SZONE,ind[i]) do 
			i=i+1
		end
		Duel.MoveSequence(mon, ind[i])
	else
		Duel.MoveToField(mon,tp,tp,dest,pos,true)
	end
	
	if mon:GetOwner()~=tp then 
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_OWNER_RELATE)
		e1:SetRange(LOCATION_ONFIELD)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_CONTROL)
		e1:SetValue(tp)
		e1:SetReset(RESET_EVENT+0x1fc0000)
		mon:RegisterEffect(e1)
	end
end

function c400001002.indtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c400001002.movefilter,tp,LOCATION_MZONE,0,1,nil) end
	return true
end
function c400001002.indval(e,c)
	return c:GetLocation()==LOCATION_SZONE and c400001002.movefilter(c)
end