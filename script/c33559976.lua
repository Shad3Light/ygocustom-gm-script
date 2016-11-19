--Clear Prism Gemini Mirror
function c33559976.initial_effect(c)
c:SetUniqueOnField(1,1,33559976)
--spsummon
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
e1:SetCode(EVENT_BE_MATERIAL)
e1:SetCondition(c33559976.spcon1)
e1:SetOperation(c33559976.spop1)
c:RegisterEffect(e1)
--spsummon
local e2=Effect.CreateEffect(c)
e2:SetDescription(aux.Stringid(33559976,0))
e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
e2:SetRange(LOCATION_GRAVE)
e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
e2:SetCondition(c33559976.spcon)
e2:SetTarget(c33559976.sptg)
e2:SetOperation(c33559976.spop)
c:RegisterEffect(e2)
--token
local e3=Effect.CreateEffect(c)
e3:SetDescription(aux.Stringid(33559976,1))
e3:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
e3:SetType(EFFECT_TYPE_IGNITION)
e3:SetRange(LOCATION_MZONE)
e3:SetCountLimit(1,33559976)
e3:SetCondition(c33559976.spcon2)
e3:SetTarget(c33559976.sptg2)
e3:SetOperation(c33559976.spop2)
c:RegisterEffect(e3)
--draw
local e4=Effect.CreateEffect(c)
e4:SetDescription(aux.Stringid(33559976,2))
e4:SetCategory(CATEGORY_DRAW)
e4:SetType(EFFECT_TYPE_IGNITION)
e4:SetRange(LOCATION_MZONE)
e4:SetCountLimit(1,33559976)
e4:SetCost(c33559976.cost)
e4:SetTarget(c33559976.target)
e4:SetOperation(c33559976.activate)
c:RegisterEffect(e4)
--Recoveer
local e5=Effect.CreateEffect(c)
e5:SetDescription(aux.Stringid(33559976,3))
e5:SetCategory(CATEGORY_RECOVER)
e5:SetType(EFFECT_TYPE_IGNITION)
e5:SetRange(LOCATION_MZONE)
e5:SetCountLimit(1,33559976)
e5:SetTarget(c33559976.tg)
e5:SetOperation(c33559976.op)
c:RegisterEffect(e5)
--control
local e6=Effect.CreateEffect(c)
e6:SetType(EFFECT_TYPE_SINGLE)
e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e6:SetRange(LOCATION_MZONE)
e6:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
c:RegisterEffect(e6)
--battle indestructable
local e7=Effect.CreateEffect(c)
e7:SetType(EFFECT_TYPE_SINGLE)
e7:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
e7:SetValue(1)
c:RegisterEffect(e7)
--damage
local e8=Effect.CreateEffect(c)
e8:SetDescription(aux.Stringid(33559976,4))
e8:SetCategory(CATEGORY_DAMAGE)
e8:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e8:SetType(EFFECT_TYPE_IGNITION)
e8:SetRange(LOCATION_MZONE)
e8:SetCountLimit(1,33559976)
e8:SetCost(c33559976.damcost)
e8:SetTarget(c33559976.damtg)
e8:SetOperation(c33559976.damop)
c:RegisterEffect(e8)
--recover
local e9=Effect.CreateEffect(c)
e9:SetDescription(aux.Stringid(33559976,0))
e9:SetCategory(CATEGORY_RECOVER)
e9:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
e9:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e9:SetCode(EVENT_PHASE+PHASE_END)
e9:SetRange(LOCATION_MZONE)
e9:SetCountLimit(1)
e9:SetCondition(c33559976.condition)
e9:SetTarget(c33559976.target)
e9:SetOperation(c33559976.operation)
c:RegisterEffect(e9)
-- Cannot Banish (Loyalty to controller)
local e10=Effect.CreateEffect(c)
e10:SetType(EFFECT_TYPE_SINGLE)
e10:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e10:SetCode(EFFECT_CANNOT_REMOVE)
e10:SetRange(LOCATION_MZONE)
c:RegisterEffect(e10)
--reflect battle dam
local e11=Effect.CreateEffect(c)
e11:SetType(EFFECT_TYPE_SINGLE)
e11:SetCode(EFFECT_REFLECT_BATTLE_DAMAGE)
e11:SetValue(1)
c:RegisterEffect(e11)
--cannot attack
local e12=Effect.CreateEffect(c)
e12:SetType(EFFECT_TYPE_SINGLE)
e12:SetCode(EFFECT_CANNOT_ATTACK)
e12:SetRange(LOCATION_MZONE)
c:RegisterEffect(e12)
end
function c33559976.spcon1(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
return c:IsLocation(LOCATION_GRAVE) and r==REASON_SUMMON
end
function c33559976.spop1(e,tp,eg,ep,ev,re,r,rp)
e:GetHandler():RegisterFlagEffect(33559976,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN,0,1)
end
function c33559976.spcon(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
return c:GetTurnID()~=Duel.GetTurnCount() and tp==Duel.GetTurnPlayer() and c:GetFlagEffect(33559976)>0
end
function c33559976.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
local c=e:GetHandler()
Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
c:ResetFlagEffect(33559976)
end
function c33559976.spop(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
if c:IsRelateToEffect(e) then
Duel.SpecialSummon(c,1,tp,tp,false,false,POS_FACEUP)
end
end
function c33559976.spfilter(c)
return c:IsCode(22222220,22222221)
end
function c33559976.spcon2(e,tp,eg,ep,ev,re,r,rp)
if Duel.IsExistingMatchingCard(c33559976.spfilter,tp,LOCATION_MZONE,0,1,nil) then return false
else return true end
end
function c33559976.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1
and Duel.IsPlayerCanSpecialSummonMonster(tp,22222220,0,0x4011,2000,0,2,RACE_SPELLCASTER,ATTRIBUTE_DARK) end
Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,2,0,0)
Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
end
function c33559976.spop2(e,tp,eg,ep,ev,re,r,rp)
if Duel.GetLocationCount(tp,LOCATION_MZONE)<=1 then return end
if Duel.IsPlayerCanSpecialSummonMonster(tp,22222220,0,0x4011,2000,0,2,RACE_SPELLCASTER,ATTRIBUTE_DARK) then
local token1=Duel.CreateToken(tp,22222220)
Duel.SpecialSummonStep(token1,0,tp,tp,false,false,POS_FACEUP)
local token2=Duel.CreateToken(tp,22222221)
Duel.SpecialSummonStep(token2,0,tp,tp,false,false,POS_FACEUP)
Duel.SpecialSummonComplete()
end
end
function c33559976.drfilter(c)
return c:IsAttackBelow(2000) and c:IsAbleToRemove()
end
function c33559976.cost(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.IsExistingMatchingCard(c33559976.drfilter,tp,LOCATION_GRAVE,0,1,nil) end
local g=Duel.SelectMatchingCard(tp,c33559976.drfilter,tp,LOCATION_GRAVE,0,1,1,nil)
Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c33559976.target(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
Duel.SetTargetPlayer(tp)
Duel.SetTargetParam(1)
Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c33559976.activate(e,tp,eg,ep,ev,re,r,rp)
local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
Duel.Draw(p,d,REASON_EFFECT)
end
function c33559976.tg(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
local lp=Duel.GetMatchingGroup(Card.IsFaceup,e:GetHandler():GetControler(),LOCATION_MZONE,0,nil):GetSum(Card.GetLevel)*200
Duel.SetTargetPlayer(tp)
Duel.SetTargetParam(lp)
Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,lp)
end
function c33559976.op(e,tp,eg,ep,ev,re,r,rp)
local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
Duel.Recover(p,d,REASON_EFFECT)
end
function c33559976.damcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,nil,1,nil) end
	local sg=Duel.SelectReleaseGroup(tp,nil,1,1,nil)
	Duel.Release(sg,REASON_COST)
end
function c33559976.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(1000)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1000)
end
function c33559976.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c33559976.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c33559976.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1000)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,1000)
end
function c33559976.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		Duel.Recover(p,d,REASON_EFFECT)
	end
end