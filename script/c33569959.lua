--Evil Majin Buu
--scripted by GameMaster (GM)
function c33569959.initial_effect(c)
	c:EnableReviveLimit()
	-- Cannot Banish 
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_CANNOT_REMOVE)
	e1:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e1)
	--control
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
	c:RegisterEffect(e2)
		--indes battle
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--indes
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e4:SetValue(1)
	c:RegisterEffect(e4)
		--battle dam 0
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e5:SetValue(1)
	c:RegisterEffect(e5)
	--destroy monster turn to chocolate
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(33569959,2))
	e6:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_IGNORE_IMMUNE)
	e6:SetCategory(CATEGORY_DESTROY)
	e6:SetType(EFFECT_TYPE_IGNITION)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCountLimit(1)
	e6:SetTarget(c33569959.destg)
	e6:SetOperation(c33569959.desop)
	c:RegisterEffect(e6)
	--tribute eff-eat candy
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(33569959,1))
	e7:SetType(EFFECT_TYPE_IGNITION)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCountLimit(1)
	e7:SetCost(c33569959.Pcost)
	e7:SetOperation(c33569959.operation2)
	c:RegisterEffect(e7)
	--negate
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e8:SetCode(EVENT_TO_GRAVE)
	e8:SetOperation(c33569959.desop)
	c:RegisterEffect(e8)
	-- Cannot Banish/disable/tohand/todeck/tograve
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_SINGLE)
	e9:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
	e9:SetRange(LOCATION_MZONE)
	e9:SetCode(EFFECT_CANNOT_TO_DECK)
	e9:SetValue(1)
	c:RegisterEffect(e9)
	local e10=e9:Clone()
	e10:SetCode(EFFECT_CANNOT_DISABLE)
	c:RegisterEffect(e10)
	local e11=e9:Clone()
	e11:SetCode(EFFECT_CANNOT_TO_GRAVE)
	c:RegisterEffect(e11)
	local e12=e9:Clone()
	e12:SetCode(EFFECT_CANNOT_TO_HAND)
	c:RegisterEffect(e12)
	--destroy&dealdamage
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e13:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e13:SetCode(EVENT_BATTLED)
	e13:SetOperation(c33569959.batop)
	c:RegisterEffect(e13)
	local e14=Effect.CreateEffect(c)
	e14:SetDescription(aux.Stringid(33569959,0))
	e14:SetCategory(CATEGORY_DAMAGE+CATEGORY_DESTROY)
	e14:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e14:SetCode(EVENT_DAMAGE_STEP_END)
	e14:SetTarget(c33569959.damtg)
	e14:SetOperation(c33569959.damop)
	e14:SetLabelObject(e13)
	c:RegisterEffect(e14)
end

c33569959.collection={  [11111127]=true; }

function c33569959.candyfilter(c)
	return c33569959.collection[c:GetCode()]
end

function c33569959.filter(c)
    return c:IsFaceup() and c:IsCode(33569959)
end

function c33569959.batop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if bc and c:IsAttackPos() then
		e:SetLabel(bc:GetAttack())
		e:SetLabelObject(bc)
	else
		e:SetLabelObject(nil)
	end
end

function c33569959.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local bc=e:GetLabelObject():GetLabelObject()
	if chk==0 then return bc end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,e:GetLabelObject():GetLabel())
	if bc:IsRelateToBattle() then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,bc,1,0,0)
	end
end
function c33569959.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Damage(1-tp,e:GetLabelObject():GetLabel(),REASON_EFFECT)
	local bc=e:GetLabelObject():GetLabelObject()
	if bc:IsRelateToBattle() then
		Duel.Destroy(bc,REASON_EFFECT)
	end
end

function c33569959.operation2(e,tp,eg,ep,ev,re,r,rp,chk)	
	local c=e:GetHandler()
    if c:IsRelateToEffect(e) and c33569959.filter(c) then
        local e1=Effect.CreateEffect(e:GetHandler())
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_UPDATE_ATTACK)
        e1:SetValue(2500)
        e1:SetReset(RESET_EVENT+0x1fe0000)
        c:RegisterEffect(e1)
        local e2=e1:Clone()
        e2:SetCode(EFFECT_UPDATE_DEFENSE)
        c:RegisterEffect(e2)
    end
end


function c33569959.Pcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c33569959.candyfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	local c = Duel.SelectMatchingCard(tp,c33569959.candyfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.Destroy(c,REASON_COST)
	Duel.RaiseEvent(e:GetHandler(),EVENT_CUSTOM+33569959,e,0,0,tp,0)
	end

function c33569959.filter2(c)
	return c:IsType(TYPE_MONSTER) and c:IsCode(33569915)
end


function c33569959.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c33569959.filter2(chkc) and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingTarget(c33569959.filter2,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c33569959.filter2,tp,LOCATION_MZONE,0,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	end
	
function c33569959.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x17a0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x17a0000)
		tc:RegisterEffect(e2)
		Duel.Destroy(tc,REASON_EFFECT)
	if Duel.Destroy(tc,REASON_EFFECT)>0  then
		return  Duel.GetLocationCount(1-tp,LOCATION_MZONE,tp)>0 and Duel.IsPlayerCanSpecialSummonMonster(tp,11111127,0,0x4011,2500,2500,7,RACE_FIEND,ATTRIBUTE_DARK,POS_FACEUP,1-tp) end
		local token=Duel.CreateToken(tp,11111127)
		Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
	end


