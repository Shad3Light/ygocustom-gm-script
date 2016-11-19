--Princess Abi
--scripted by GameMaster (GM)
function c33569981.initial_effect(c)
	c:SetUniqueOnField(1,1,33569981)
	--equip trident
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c33569981.eqtg)
	e1:SetOperation(c33569981.eqop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--token
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(33569981,1))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetCondition(c33569981.spcon)
	e4:SetTarget(c33569981.sptg)
	e4:SetOperation(c33569981.spop)
	c:RegisterEffect(e4)
end

function c33569981.eqcon2(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c33569981.eqtg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsFaceup() end 
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c33569981.eqlimit2(e,c)
	return e:GetOwner()==c
end
function c33569981.eqop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		if tc:IsFaceup() and tc:IsRelateToEffect(e) then
			Duel.Equip(tp,c,tc,true)
			--Add Equip limit
			local e1=Effect.CreateEffect(tc)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_EQUIP_LIMIT)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			e1:SetValue(c33569981.eqlimit2)
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
			--atkdown
			local e4=Effect.CreateEffect(c)
			e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e4:SetCode(EVENT_PHASE+PHASE_END)
			e4:SetRange(LOCATION_SZONE)
			e4:SetCountLimit(1)
			e4:SetCondition(c33569981.atkcon)
			e4:SetOperation(c33569981.atkop)
			c:RegisterEffect(e4)
		else
			Duel.SendtoGrave(c,REASON_EFFECT)
		end
	end
end
function c33569981.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c33569981.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetFlagEffect(33569981)==0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_EQUIP)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-500)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		c:RegisterEffect(e2)
		c:RegisterFlagEffect(33569981,RESET_EVENT+0x1fe0000,0,0)
		e:SetLabelObject(e1)
		e:SetLabel(2)
	else
		local pe=e:GetLabelObject()
		local ct=e:GetLabel()
		e:SetLabel(ct+1)
		pe:SetValue(ct*-500)
	end
	Duel.Recover(tp,250,REASON_EFFECT)
end


function c33569981.spfilter(c)
return c:IsCode(22222210)
end
function c33569981.spcon(e,tp,eg,ep,ev,re,r,rp)
if Duel.IsExistingMatchingCard(c33569981.spfilter,tp,LOCATION_MZONE,0,1,nil) then return false
else return true end
end
function c33569981.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1
and Duel.IsPlayerCanSpecialSummonMonster(tp,22222210,0,0x4011,500,100,2,RACE_SPELLCASTER,ATTRIBUTE_DARK) end
Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,2,0,0)
Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
end
function c33569981.spop(e,tp,eg,ep,ev,re,r,rp)
if Duel.GetLocationCount(tp,LOCATION_MZONE)<=1 then return end
if Duel.IsPlayerCanSpecialSummonMonster(tp,22222210,0,0x4011,500,100,2,RACE_SPELLCASTER,ATTRIBUTE_DARK) then
for i=1,2 do
local token1=Duel.CreateToken(tp,22222210)
if Duel.SpecialSummonStep(token1,0,tp,tp,false,false,POS_FACEUP_ATTACK) then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetValue(1)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			token1:RegisterEffect(e1,true)
			--equip bird for drain
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetDescription(aux.Stringid(33569981,0))
			e2:SetCategory(CATEGORY_EQUIP)
			e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
			e2:SetType(EFFECT_TYPE_QUICK_O)
			e2:SetCode(EVENT_FREE_CHAIN)
			e2:SetRange(LOCATION_MZONE)
			e2:SetCondition(c33569981.eqcon2)
			e2:SetTarget(c33569981.eqtg2)
			e2:SetOperation(c33569981.eqop2)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			token1:RegisterEffect(e2,true)
			end
		Duel.SpecialSummonComplete()
		end
	end
end

function c33569981.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c33569981.filter2(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c33569981.filter2,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c33569981.filter2,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end

function c33569981.filter2(c)
	return c:IsFaceup() and c:IsCode(33569981)
end
	
function c33569981.filter(c)
	return c:IsCode(33569977) and not c:IsForbidden()
end
function c33569981.eqop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
		local g=Duel.SelectMatchingCard(tp,c33569981.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
		local eqc=g:GetFirst()
		if not eqc or not Duel.Equip(tp,eqc,tc,true) then return end
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(c33569981.eqlimit)
		e1:SetLabelObject(tc)
		eqc:RegisterEffect(e1)
		end
end
function c33569981.eqlimit(e,c)
	return c:IsCode(33569981)
end