--Emissary of the Three Gods
function c33559966.initial_effect(c)
c:SetUniqueOnField(1,0,33559966)
--spsummon
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
e1:SetCode(EVENT_BE_MATERIAL)
e1:SetCondition(c33559966.spcon1)
e1:SetOperation(c33559966.spop1)
c:RegisterEffect(e1)
--spsummon
local e2=Effect.CreateEffect(c)
e2:SetDescription(aux.Stringid(33559966,0))
e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
e2:SetRange(LOCATION_GRAVE)
e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
e2:SetCondition(c33559966.spcon)
e2:SetTarget(c33559966.sptg)
e2:SetOperation(c33559966.spop)
c:RegisterEffect(e2)
--token
local e3=Effect.CreateEffect(c)
e3:SetDescription(aux.Stringid(33559966,1))
e3:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
e3:SetType(EFFECT_TYPE_IGNITION)
e3:SetRange(LOCATION_MZONE)
e3:SetCountLimit(1,33559966)
e3:SetCondition(c33559966.spcon2)
e3:SetTarget(c33559966.sptg2)
e3:SetOperation(c33559966.spop2)
c:RegisterEffect(e3)
--draw
local e4=Effect.CreateEffect(c)
e4:SetDescription(aux.Stringid(33559966,2))
e4:SetCategory(CATEGORY_DRAW)
e4:SetType(EFFECT_TYPE_IGNITION)
e4:SetRange(LOCATION_MZONE)
e4:SetCountLimit(1,33559966)
e4:SetCost(c33559966.cost)
e4:SetTarget(c33559966.target)
e4:SetOperation(c33559966.activate)
c:RegisterEffect(e4)
--Recoveer
local e5=Effect.CreateEffect(c)
e5:SetDescription(aux.Stringid(33559966,3))
e5:SetCategory(CATEGORY_RECOVER)
e5:SetType(EFFECT_TYPE_IGNITION)
e5:SetRange(LOCATION_MZONE)
e5:SetCountLimit(1,33559966)
e5:SetTarget(c33559966.tg)
e5:SetOperation(c33559966.op)
c:RegisterEffect(e5)
end
function c33559966.spcon1(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
return c:IsLocation(LOCATION_GRAVE) and r==REASON_SUMMON
end
function c33559966.spop1(e,tp,eg,ep,ev,re,r,rp)
e:GetHandler():RegisterFlagEffect(33559966,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN,0,1)
end
function c33559966.spcon(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
return c:GetTurnID()~=Duel.GetTurnCount() and tp==Duel.GetTurnPlayer() and c:GetFlagEffect(33559966)>0
end
function c33559966.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
local c=e:GetHandler()
Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
c:ResetFlagEffect(33559966)
end
function c33559966.spop(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
if c:IsRelateToEffect(e) then
Duel.SpecialSummon(c,1,tp,tp,false,false,POS_FACEUP)
end
end
function c33559966.spfilter(c)
return c:IsCode(11111112)
end
function c33559966.spcon2(e,tp,eg,ep,ev,re,r,rp)
if Duel.IsExistingMatchingCard(c33559966.spfilter,tp,LOCATION_MZONE,0,1,nil) then return false
else return true end
end
function c33559966.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1
and Duel.IsPlayerCanSpecialSummonMonster(tp,11111112,0,0x4011,500,100,2,RACE_SPELLCASTER,ATTRIBUTE_DARK) end
Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,2,0,0)
Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
end
function c33559966.spop2(e,tp,eg,ep,ev,re,r,rp)
if Duel.GetLocationCount(tp,LOCATION_MZONE)<=1 then return end
if Duel.IsPlayerCanSpecialSummonMonster(tp,11111112,0,0x4011,500,100,2,RACE_SPELLCASTER,ATTRIBUTE_DARK) then
local token1=Duel.CreateToken(tp,11111112)
Duel.SpecialSummonStep(token1,0,tp,tp,false,false,POS_FACEUP)
local token2=Duel.CreateToken(tp,11111112)
Duel.SpecialSummonStep(token2,0,tp,tp,false,false,POS_FACEUP)
Duel.SpecialSummonComplete()
end
end
function c33559966.drfilter(c)
return c:IsAttackBelow(2000) and c:IsAbleToRemove()
end
function c33559966.cost(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.IsExistingMatchingCard(c33559966.drfilter,tp,LOCATION_GRAVE,0,1,nil) end
local g=Duel.SelectMatchingCard(tp,c33559966.drfilter,tp,LOCATION_GRAVE,0,1,1,nil)
Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c33559966.target(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
Duel.SetTargetPlayer(tp)
Duel.SetTargetParam(1)
Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c33559966.activate(e,tp,eg,ep,ev,re,r,rp)
local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
Duel.Draw(p,d,REASON_EFFECT)
end
function c33559966.tg(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
local lp=Duel.GetMatchingGroup(Card.IsFaceup,e:GetHandler():GetControler(),LOCATION_MZONE,0,nil):GetSum(Card.GetLevel)*100
Duel.SetTargetPlayer(tp)
Duel.SetTargetParam(lp)
Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,lp)
end
function c33559966.op(e,tp,eg,ep,ev,re,r,rp)
local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
Duel.Recover(p,d,REASON_EFFECT)
end