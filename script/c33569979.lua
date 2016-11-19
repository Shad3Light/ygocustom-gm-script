--Kanna of the Void
--scripted by GameMaster (GM)
function c33569979.initial_effect(c)
c:SetUniqueOnField(1,1,33569979)
	--reflect battle dam
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_REFLECT_BATTLE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--battle indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--cannot attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_CANNOT_ATTACK)
	e3:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e3)
	--Mirror to other player
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_CHAINING)
	e4:SetRange(LOCATION_MZONE)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetCondition(c33569979.condition)
	e4:SetTarget(c33569979.target)
	e4:SetOperation(c33569979.operation)
	c:RegisterEffect(e4)
	-- Cannot Disable effect
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetCode(EFFECT_CANNOT_DISABLE)
	e5:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e5)
	--Reduce monster ATK/DEF take control
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(33569979,0))
	e6:SetType(EFFECT_TYPE_IGNITION)
	e6:SetRange(LOCATION_MZONE)
	e6:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e6:SetCode(EVENT_FREE_CHAIN)
	e6:SetTarget(c33569979.sumtg)
	e6:SetOperation(c33569979.sumop)
	e6:SetCountLimit(1)
	c:RegisterEffect(e6)
	-- Cannot Disable effect
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e7:SetCode(EFFECT_CANNOT_DISABLE)
	e7:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e7)
	--equip Nest
	local e8=Effect.CreateEffect(c)
	e8:SetDescription(aux.Stringid(33569979,1))
	e8:SetCategory(CATEGORY_EQUIP)
	e8:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e8:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e8:SetCode(EVENT_SUMMON_SUCCESS)
	e8:SetTarget(c33569979.eqtg)
	e8:SetOperation(c33569979.eqop)
	c:RegisterEffect(e8)
	local e9=e8:Clone()
	e9:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e9)
	local e10=e8:Clone()
	e10:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e10)
	--Mirror Demon
	local e11=Effect.CreateEffect(c)
	e11:SetDescription(aux.Stringid(33569979,2))
	e11:SetCategory(CATEGORY_EQUIP+CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e11:SetType(EFFECT_TYPE_IGNITION)
	e11:SetCode(EVENT_FREE_CHAIN)
	e11:SetRange(LOCATION_MZONE)
	e11:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e11:SetCondition(c33569979.spcon)
	e11:SetTarget(c33569979.target2)
	e11:SetOperation(c33569979.operation2)
	c:RegisterEffect(e11)
end

function c33569979.filter6(c)
return c:IsCode(22222213)
end
function c33569979.spcon(e,tp,eg,ep,ev,re,r,rp)
if Duel.IsExistingMatchingCard(c33569979.filter6,tp,LOCATION_MZONE,0,1,nil) then return false
else return true end
end

function c33569979.filter5(c,tp)
	return c:IsFaceup() 
		and Duel.IsPlayerCanSpecialSummonMonster(tp,22222213,0,0x4011,c:GetAttack(),c:GetDefense(),c:GetLevel(),c:GetRace(),c:GetAttribute())
end
function c33569979.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c33569979.filter5(chkc,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingTarget(c33569979.filter5,tp,0,LOCATION_MZONE,1,nil,tp) end
		Duel.SelectTarget(tp,c33569979.filter5,tp,0,LOCATION_MZONE,1,1,nil,tp)
		Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c33569979.operation2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
			if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 
			or not Duel.IsPlayerCanSpecialSummonMonster(tp,22222213,0,0x4011,tc:GetAttack(),tc:GetDefense(),
			tc:GetLevel(),tc:GetRace(),tc:GetAttribute()) then return end
		local token=Duel.CreateToken(tp,22222213)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK)
		e1:SetValue(tc:GetAttack())
		e1:SetReset(RESET_EVENT+0x1fe0000)
		token:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_SET_DEFENSE)
		e2:SetValue(tc:GetDefense())
		token:RegisterEffect(e2)
		local e3=e1:Clone()
		e3:SetCode(EFFECT_CHANGE_LEVEL)
		e3:SetValue(tc:GetLevel())
		token:RegisterEffect(e3)
		local e4=e1:Clone()
		e4:SetCode(EFFECT_CHANGE_RACE)
		e4:SetValue(tc:GetRace())
		token:RegisterEffect(e4)
		local e5=e1:Clone()
		e5:SetCode(EFFECT_CHANGE_ATTRIBUTE)
		e5:SetValue(tc:GetAttribute())
		token:RegisterEffect(e5)
		token:CopyEffect(tc:GetOriginalCode(),RESET_EVENT+0x1fe0000,1)
		Duel.SpecialSummonComplete()
		c:SetCardTarget(token)
	end
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		c:SetCardTarget(tc)
		if tc:IsFaceup() and tc:IsRelateToEffect(e) then
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
			end
	end
end	
function c33569979.checkop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsDisabled() then
		e:SetLabel(1)
	else e:SetLabel(0) end
end
function c33569979.desop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabelObject():GetLabel()~=0 then return end
	local g=e:GetHandler():GetCardTarget()
	local tc=g:Filter(aux.TRUE,e:GetHandler():GetEquipTarget()):GetFirst()
	if tc and tc:IsLocation(LOCATION_MZONE) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end




function c33569979.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c33569979.filter2(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c33569979.filter2,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c33569979.filter2,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end

function c33569979.filter2(c)
	return c:IsFaceup() and c:IsCode(33569979)
end
	
function c33569979.filter3(c)
	return c:IsCode(33569987) and not c:IsForbidden()
end
function c33569979.eqop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
		local g=Duel.SelectMatchingCard(tp,c33569979.filter3,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
		local eqc=g:GetFirst()
		if not eqc or not Duel.Equip(tp,eqc,tc,true) then return end
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(c33569979.eqlimit)
		e1:SetLabelObject(tc)
		eqc:RegisterEffect(e1)
		end
end
function c33569979.eqlimit(e,c)
	return c:IsCode(33569979)
end

function c33569979.filter(c)
	return c:IsType(TYPE_MONSTER) and (c:IsFaceup()  and c:GetAttack()>0 and c:IsControlerCanBeChanged())
end
function c33569979.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c33569979.filter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c33569979.filter,tp,0,LOCATION_MZONE,nil)
	Duel.SelectTarget(tp,c33569979.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c33569979.sumop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectMatchingCard(tp,c33569979.filter,tp,0,LOCATION_MZONE,1,1,nil)
	local tc=g:GetFirst()
	if tc then
	local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(tc:GetAttack()/2)
		tc:RegisterEffect(e1)
		Duel.HintSelection(g)
		if tc:IsFaceup() and tc:IsRelateToEffect(e) then
			if not Duel.GetControl(tc,tp) then
				if not tc:IsImmuneToEffect(e) and tc:IsAbleToChangeControler() then
					Duel.Destroy(tc,REASON_EFFECT)
				end
			end
		end
		Duel.Recover(tp,900,REASON_EFFECT)
	end
end


function c33569979.condition(e,tp,eg,ep,ev,re,r,rp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_SPELL+TYPE_TRAP) and re:IsHasProperty(EFFECT_FLAG_PLAYER_TARGET)
end
function c33569979.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local te=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_EFFECT)
		local ftg=te:GetTarget()
		return ftg==nil or ftg(e,tp,eg,ep,ev,re,r,rp,chk)
	end
end
function c33569979.operation(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(ev,CHAININFO_TARGET_PLAYER)
	Duel.ChangeTargetPlayer(ev,1-p)
end
