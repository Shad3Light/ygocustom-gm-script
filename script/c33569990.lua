--Kisenan Blossom
--scripted by GameMaster (GM)
function c33569990.initial_effect(c)
	c:SetUniqueOnField(1,1,33569990)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c33569990.target)
	e1:SetOperation(c33569990.operation)
	c:RegisterEffect(e1)
	--recover
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(33569990,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCategory(CATEGORY_RECOVER)
	e2:SetCode(EVENT_BATTLE_DESTROYING)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c33569990.recon)
	e2:SetTarget(c33569990.retg)
	e2:SetOperation(c33569990.reop)
	c:RegisterEffect(e2)
	--Equip limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_EQUIP_LIMIT)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetValue(c33569990.eqlimit)
	c:RegisterEffect(e3)
	--once per turn take control monster
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_CONTROL)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCountLimit(1)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetCondition(c33569990.ctcon)
	e4:SetTarget(c33569990.cttg)
	e4:SetValue(1)
	e4:SetOperation(c33569990.ctop)
	c:RegisterEffect(e4)
	--switch monsters
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_CONTROL)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCode(EVENT_SUMMON_SUCCESS)
	e5:SetCountLimit(1)
	e5:SetTarget(c33569990.swtg)
	e5:SetOperation(c33569990.swop)
	c:RegisterEffect(e5)
	local e6=e5:Clone()
	e6:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e6)
	local e7=e5:Clone()
	e7:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e7)
	--tograve replace
	local e8=Effect.CreateEffect(c)
	e8:SetDescription(aux.Stringid(33569990,0))
	e8:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e8:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e8:SetRange(LOCATION_SZONE)
	e8:SetCode(EFFECT_SEND_REPLACE)
	e8:SetTarget(c33569990.reptg)
	e8:SetOperation(c33569990.repop)
	c:RegisterEffect(e8)
end


function c33569990.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local eq=e:GetHandler():GetEquipTarget()
	if chk==0 then return c:GetDestination()==LOCATION_GRAVE 
		and Duel.IsExistingMatchingCard(c33569990.filter,tp,LOCATION_MZONE,0,1,eq) end
	if Duel.SelectYesNo(tp,aux.Stringid(33569990,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
		local g=Duel.SelectMatchingCard(tp,c33569990.filter,tp,LOCATION_MZONE,0,1,1,eq)
		e:SetLabelObject(g:GetFirst())
		Duel.HintSelection(g)
		return true
	else return false end
end
function c33569990.repop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	Duel.Equip(tp,e:GetHandler(),tc)
end


function comp(c,ec)
    return c~=ec
end

function c33569990.ctcon(e,tp,eg,ep,ev,re,r,rp)
    return not e:GetHandler():GetCardTarget():SearchCard(comp,e:GetHandler():GetEquipTarget())
end

function c33569990.cttg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToChangeControler,tp,0,LOCATION_MZONE,1,nil) end
    Duel.SetOperationInfo(0,CATEGORY_CONTROL,nil,1,1-tp,0)
end

function c33569990.ctop(e,tp,eg,ep,ev,re,r,rp)
    local tc=Duel.SelectMatchingCard(tp,Card.IsAbleToChangeControler,tp,0,LOCATION_MZONE,1,1,nil):GetFirst()
    if tc and Duel.GetControl(tc,tp) then
   		--change to plant race
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_OWNER_RELATE)
		e1:SetCode(EFFECT_CHANGE_RACE)
		e1:SetCondition(c33569990.indcon)
		e1:SetValue(RACE_PLANT)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		e:GetHandler():SetCardTarget(tc)
    end
end

function c33569990.indcon(e)
	return e:GetOwner():IsHasCardTarget(e:GetHandler())
end
--switch

function c33569990.filter2(c,val)
    return c:IsFaceup() and c:GetAttack()>val
end

function c33569990.swtg(e,tp,eg,ep,ev,re,r,rp)
    local tc=e:GetHandler():GetCardTarget():SearchCard(comp,e:GetHandler():GetEquipTarget())
    return tc and tc:IsFaceup() and eg:IsExists(c33569990.filter2,1,nil,tc:GetAttack())
end

function c33569990.swop(e,tp,eg,ep,ev,re,r,rp)
    local tc=e:GetHandler():GetCardTarget():SearchCard(comp,e:GetHandler():GetEquipTarget())
    if not tc then return end
    local sc
    if eg:GetCount()==1 then
        sc=eg:GetFirst()
    else
        sc=eg:FilterSelect(tp,c33569990.filter2,1,nil,tc:GetAttack())
    end
    if Duel.SwapControl(tc,sc) then
        e:GetHandler():CancelCardTarget(tc)
        e:GetHandler():SetCardTarget(sc)
		--change to plant race
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_OWNER_RELATE)
		e1:SetCode(EFFECT_CHANGE_RACE)
		e1:SetCondition(c33569990.indcon)
		e1:SetValue(RACE_PLANT)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		sc:RegisterEffect(e1)
    end
end

function c33569990.eqlimit(e,c)
	return c:IsType(TYPE_MONSTER)
end
function c33569990.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER)
end
function c33569990.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c33569990.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c33569990.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c33569990.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c33569990.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,c,tc)
	end
end
function c33569990.recon(e,tp,eg,ep,ev,re,r,rp)
	local ec=eg:GetFirst()
	local bc=ec:GetBattleTarget()
	e:SetLabelObject(bc)
	return e:GetHandler():GetEquipTarget()==eg:GetFirst() and ec:IsControler(tp)
		and bc:IsLocation(LOCATION_GRAVE) and bc:IsType(TYPE_MONSTER) and bc:IsReason(REASON_BATTLE) 
end
function c33569990.retg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local v=e:GetLabelObject():GetBaseAttack()
	if v<0 then v=0 end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(v)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,v)
end
function c33569990.reop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Recover(p,d,REASON_EFFECT)
end
