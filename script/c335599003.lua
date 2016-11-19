--The Great Leviathin
function c335599003.initial_effect(c)
c:EnableReviveLimit()
--cannot special summon
local e0=Effect.CreateEffect(c)
e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
e0:SetType(EFFECT_TYPE_SINGLE)
e0:SetCode(EFFECT_SPSUMMON_CONDITION)
c:RegisterEffect(e0)
--special summon
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_FIELD)
e1:SetCode(EFFECT_SPSUMMON_PROC)
e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
e1:SetRange(LOCATION_HAND)
e1:SetCondition(c335599003.spcon)
e1:SetOperation(c335599003.spop)
c:RegisterEffect(e1)
--Cannot Lose
local e2=Effect.CreateEffect(c)
e2:SetType(EFFECT_TYPE_FIELD)
e2:SetCode(EFFECT_DRAW_COUNT)
e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e2:SetRange(LOCATION_MZONE) 
e2:SetTargetRange(1,0)
e2:SetValue(c335599003.dc)
c:RegisterEffect(e2)
local e3=Effect.CreateEffect(c)
e3:SetType(EFFECT_TYPE_FIELD)
e3:SetCode(EFFECT_CHANGE_DAMAGE)
e3:SetRange(LOCATION_MZONE)
e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
e3:SetTargetRange(1,0)
e3:SetCondition(c335599003.rcon1)
e3:SetValue(c335599003.val)
c:RegisterEffect(e3)
local e4=e3:Clone()
e4:SetCondition(c335599003.rcon2)
c:RegisterEffect(e4)
--attack cost
local e5=Effect.CreateEffect(c)
e5:SetType(EFFECT_TYPE_SINGLE)
e5:SetCode(EFFECT_ATTACK_COST)
e5:SetCost(c335599003.atcost)
e5:SetOperation(c335599003.atop)
c:RegisterEffect(e5)
--indes
local e6=Effect.CreateEffect(c)
e6:SetType(EFFECT_TYPE_SINGLE)
e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e6:SetRange(LOCATION_MZONE)
e6:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
e6:SetValue(1)
c:RegisterEffect(e6)
--pierce
local e7=Effect.CreateEffect(c)
e7:SetType(EFFECT_TYPE_SINGLE)
e7:SetCode(EFFECT_PIERCE)
c:RegisterEffect(e7)
--atk
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetCode(EFFECT_UPDATE_ATTACK)
	e8:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e8:SetRange(LOCATION_MZONE)
	e8:SetValue(9999999)
	c:RegisterEffect(e8)
	local e9=e8:Clone()
	e9:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e9)
	-- Cannot Disable effect
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_SINGLE)
	e10:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e10:SetCode(EFFECT_CANNOT_DISABLE)
	e10:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e10)
--cannot be target
local e11=Effect.CreateEffect(c)
e11:SetType(EFFECT_TYPE_SINGLE)
e11:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
e11:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e11:SetRange(LOCATION_MZONE)
e11:SetValue(c335599003.tgfilter)
c:RegisterEffect(e11)
--immune effect
local e12=Effect.CreateEffect(c)
e12:SetType(EFFECT_TYPE_SINGLE)
e12:SetCode(EFFECT_IMMUNE_EFFECT)
e12:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e12:SetRange(LOCATION_MZONE)
e12:SetValue(c335599003.efilter)
c:RegisterEffect(e12)
	--destroy trap/damage
	local e13=Effect.CreateEffect(c)
	e13:SetDescription(aux.Stringid(33559997,0))
	e13:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e13:SetType(EFFECT_TYPE_IGNITION)
	e13:SetRange(LOCATION_MZONE)
	e13:SetCountLimit(1,335599004+EFFECT_COUNT_CODE_DUEL)
	e13:SetTarget(c335599003.destg)
	e13:SetOperation(c335599003.desop)
	c:RegisterEffect(e13)
	--tribute eff/return card
	local e14=Effect.CreateEffect(c)
	e14:SetDescription(aux.Stringid(33559997,1))
	e14:SetType(EFFECT_TYPE_IGNITION)
	e14:SetRange(LOCATION_ONFIELD)
	e14:SetCountLimit(1,335599003+EFFECT_COUNT_CODE_DUEL)
	e14:SetCost(c335599003.Pcost)
	e14:SetCondition(c335599003.condition)
	e14:SetOperation(c335599003.operation)
	c:RegisterEffect(e14)
	--Destroy 1 card on each side of field
	local e15=Effect.CreateEffect(c)
	e15:SetDescription(aux.Stringid(33559997,2))
	e15:SetType(EFFECT_TYPE_IGNITION)
	e15:SetCountLimit(1,335599005+EFFECT_COUNT_CODE_DUEL)
	e15:SetRange(LOCATION_MZONE)
	e15:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e15:SetCategory(CATEGORY_DESTROY)
	e15:SetTarget(c335599003.destg1)
	e15:SetOperation(c335599003.desop1)
	c:RegisterEffect(e15)
	--control
	local e16=Effect.CreateEffect(c)
	e16:SetType(EFFECT_TYPE_SINGLE)
	e16:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e16:SetRange(LOCATION_MZONE)
	e16:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
	c:RegisterEffect(e16)
	--cannot release
	local e17=Effect.CreateEffect(c)
	e17:SetType(EFFECT_TYPE_SINGLE)
	e17:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
	e17:SetRange(LOCATION_MZONE)
	e17:SetCode(EFFECT_UNRELEASABLE_SUM)
	e17:SetValue(1)
	c:RegisterEffect(e17)
	local e18=e17:Clone()
	e18:SetCode(EFFECT_UNRELEASABLE_NONSUM)
	c:RegisterEffect(e18)
end
function c335599003.spfilter(c)
return c:GetCode()==170000170 or c:GetCode()==6132
end
function c335599003.spcon(e,c)
if c==nil then return true end
local tp=c:GetControler()
return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
and Duel.CheckReleaseGroup(tp,c335599003.spfilter,1,nil)
end
function c335599003.spop(e,tp,eg,ep,ev,re,r,rp,c)
local g1=Duel.SelectReleaseGroup(tp,c335599003.spfilter,1,1,nil)
Duel.Release(g1,REASON_COST)
if Duel.GetLP(e:GetHandlerPlayer())==0 then
Duel.SetLP(e:GetHandlerPlayer(),1)
end
end
function c335599003.dc(e)
local tp=e:GetHandler():GetControler()
if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 then
return 1
else
return 0
end
end
function c335599003.rcon1(e,tp,eg,ep,ev,re,r,rp)
local ex,cg,ct,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_DAMAGE)
if not ex then
ex,cg,ct,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_RECOVER)
if not ex or not Duel.IsPlayerAffectedByEffect(tp,EFFECT_REVERSE_RECOVER) then return false end
if (cp==tp or cp==PLAYER_ALL) and cv>=Duel.GetLP(tp) then return true end
else return (cp==tp or cp==PLAYER_ALL) and cv>=Duel.GetLP(tp)
end
return false
end
function c335599003.rcon2(e,tp,eg,ep,ev,re,r,rp)
return Duel.GetBattleDamage(tp)>=Duel.GetLP(tp)
end
function c335599003.val(tp)
if Duel.GetLP(tp)>1 then
return Duel.GetLP(tp)-1
else
return 0
end
end
function c335599003.atcost(e,c,tp)
return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>=10
end
function c335599003.atop(e,tp,eg,ep,ev,re,r,rp)
Duel.DiscardDeck(tp,10,REASON_COST)
end
function c335599003.efilter(e,te)
	return te:IsActiveType(TYPE_EFFECT) and te:GetOwner()~=e:GetOwner()
end
function c335599003.tgfilter(e,re)
	if not re or not re:IsActiveType(TYPE_SPELL+TYPE_TRAP) then return false end
	return re:IsHasCategory(CATEGORY_TOHAND+CATEGORY_DESTROY+CATEGORY_REMOVE+CATEGORY_TODECK+CATEGORY_RELEASE+CATEGORY_TOGRAVE)
end
function c335599003.desfilter(c)
	return c:IsType(TYPE_TRAP) and c:IsDestructable()
end
function c335599003.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c335599003.desfilter,tp,0,LOCATION_SZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c335599003.desfilter,tp,0,LOCATION_SZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1000)
end
function c335599003.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,c335599003.desfilter,tp,0,LOCATION_SZONE,1,1,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.Destroy(g,REASON_EFFECT)
		Duel.BreakEffect()
		Duel.Damage(1-tp,1000,REASON_EFFECT)
	end
end
function c335599003.tribfilter(c)
	return c:IsType(TYPE_MONSTER) and (c:IsDestructable() and c:GetCode()~=335599003)
end
function c335599003.tglfilter(c)
	return c:IsType(TYPE_MONSTER+TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
end
function c335599003.condition(e,c)
	return Duel.IsExistingMatchingCard(c335599003.tglfilter,e:GetHandler():GetControler(),LOCATION_GRAVE,0,1,nil)
end
function c335599003.operation(e,tp,eg,ep,ev,re,r,rp,chk)	
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOHAND)
	local g=Duel.SelectMatchingCard(tp,c335599003.tglfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SendtoHand(g,tp,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,g)
end

function c335599003.Pcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c335599003.tribfilter,tp,LOCATION_MZONE,0,1,nil) end
	local c = Duel.SelectMatchingCard(tp,c335599003.tribfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.Destroy(c,REASON_COST)
end
function c335599003.destg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c335599003.tribfilter,tp,LOCATION_ONFIELD,0,1,nil)
		and Duel.IsExistingTarget(c335599003.tribfilter,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g1=Duel.SelectTarget(tp,c335599003.tribfilter,tp,LOCATION_ONFIELD,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g2=Duel.SelectTarget(tp,c335599003.tribfilter,tp,0,LOCATION_ONFIELD,1,1,nil)
	g1:Merge(g2)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g1,2,0,0)
end
function c335599003.desop1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tg=g:Filter(Card.IsRelateToEffect,nil,e)
	if tg:GetCount()>0 then
		Duel.Destroy(tg,REASON_EFFECT)
	end
end