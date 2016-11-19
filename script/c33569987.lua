--Demon Insects of Naraku
--scripted by GameMaster(GM)
function c33569987.initial_effect(c)
	c:SetUniqueOnField(1,1,33569987)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c33569987.target)
	e1:SetOperation(c33569987.operation)
	c:RegisterEffect(e1)
	--Equip limit
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_SINGLE)
    e2:SetCode(EFFECT_EQUIP_LIMIT)
    e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(c33569987.eqlimit)
    e2:SetValue(1)
    c:RegisterEffect(e2)
	--token
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(33569987,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetCountLimit(1)
	e3:SetCondition(c33569987.spcon)
	e3:SetTarget(c33569987.sptg)
	e3:SetOperation(c33569987.spop)
	c:RegisterEffect(e3)
	-- Cannot Disable effect
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetCode(EFFECT_CANNOT_DISABLE)
	e4:SetRange(LOCATION_SZONE)
	c:RegisterEffect(e4)
	end
	
function c33569987.eqlimit(e,c)
	return c:IsFaceup() and c33569987.collection[c:GetCode()]
end
	
	
function c33569987.eqcon2(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c33569987.eqtg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_ONFIELD) and chkc:IsControler(1-tp) and chkc:IsFaceup() end 
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	g=Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,g,1,0,0)
end
function c33569987.eqlimit2(e,c)
	return e:GetOwner()==c
end
function c33569987.eqop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		c:SetCardTarget(tc)
		if tc:IsFaceup() and tc:IsRelateToEffect(e) then
			Duel.Equip(tp,c,tc,true)
			--Add Equip limit
			local e1=Effect.CreateEffect(tc)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_EQUIP_LIMIT)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			e1:SetValue(c33569987.eqlimit2)
			c:RegisterEffect(e1)
			local e2=Effect.CreateEffect(tc)
			e2:SetType(EFFECT_TYPE_EQUIP)
			e2:SetCode(EFFECT_UNRELEASABLE_SUM)
			e2:SetValue(1)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			c:RegisterEffect(e2)
			local e3=e2:Clone()
			e3:SetCode(EFFECT_UNRELEASABLE_NONSUM)
			c:RegisterEffect(e3)
			local e4=Effect.CreateEffect(c)
			e4:SetType(EFFECT_TYPE_SINGLE)
			e4:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE)
			e4:SetCode(EFFECT_DISABLE)
			e4:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e4)
			local e5=Effect.CreateEffect(c)
			e5:SetType(EFFECT_TYPE_SINGLE)
			e5:SetCode(EFFECT_DISABLE_EFFECT)
			e5:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE)
			e5:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e5)
			if tc:IsType(TYPE_TRAPMONSTER) then
			local e6=Effect.CreateEffect(c)
			e6:SetType(EFFECT_TYPE_SINGLE)
			e6:SetCode(EFFECT_DISABLE_TRAPMONSTER)
			e6:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e6)
		else
			Duel.SendtoGrave(c,REASON_EFFECT)
		end
	end
end
end	
	
	
function c33569987.spfilter(c)
return c:IsCode(22222211)
end
function c33569987.spcon(e,tp,eg,ep,ev,re,r,rp)
if Duel.IsExistingMatchingCard(c33569987.spfilter,tp,LOCATION_MZONE,0,1,nil) then return false
else return true end
end
function c33569987.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1
and Duel.IsPlayerCanSpecialSummonMonster(tp,22222211,0,0x4011,500,100,2,RACE_SPELLCASTER,ATTRIBUTE_DARK) end
Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,2,0,0)
Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
end
function c33569987.spop(e,tp,eg,ep,ev,re,r,rp)
if Duel.GetLocationCount(tp,LOCATION_MZONE)<=1 then return end
if Duel.IsPlayerCanSpecialSummonMonster(tp,22222211,0,0x4011,500,100,2,RACE_SPELLCASTER,ATTRIBUTE_DARK) then
for i=1,2 do
local token1=Duel.CreateToken(tp,22222211)
if Duel.SpecialSummonStep(token1,0,tp,tp,false,false,POS_FACEUP_ATTACK) then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetValue(1)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			token1:RegisterEffect(e1,true)
			--equip bee for negate
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetDescription(aux.Stringid(33569987,0))
			e2:SetCategory(CATEGORY_EQUIP)
			e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
			e2:SetType(EFFECT_TYPE_QUICK_O)
			e2:SetCode(EVENT_FREE_CHAIN)
			e2:SetRange(LOCATION_MZONE)
			e2:SetCondition(c33569987.eqcon2)
			e2:SetTarget(c33569987.eqtg2)
			e2:SetOperation(c33569987.eqop2)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			token1:RegisterEffect(e2,true)
			--negate
			local e3=Effect.CreateEffect(e:GetHandler())
			e3:SetType(EFFECT_TYPE_EQUIP)
			e3:SetCode(EFFECT_DISABLE)
			token1:RegisterEffect(e3,true)
			end
		Duel.SpecialSummonComplete()
		end
	end
end

	
c33569987.collection={ [33569978]=true; [33569979]=true; [33569980]=true; [33569981]=true; [33569984]=true; }	
	
function c33569987.filter(c)
	return c:IsFaceup() and c33569987.collection[c:GetCode()]
end
	function c33569987.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c33569987.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c33569987.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c33569987.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c33569987.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end

