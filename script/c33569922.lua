--Psycho puppet (DOR)
--scripted by GameMaster (GM)
function c33569922.initial_effect(c)
c:EnableReviveLimit()
--SUMMON CHANGE TO FACEDOWN
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
e1:SetCode(EVENT_SPSUMMON_SUCCESS)
e1:SetOperation(c33569922.op)
c:RegisterEffect(e1)
--ATK/DEF+1500 IF CONTROL MYSTERIOUS PUPPETER
local e2=Effect.CreateEffect(c)
e2:SetCategory(CATEGORY_ATKCHANGE)
e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
e2:SetCode(EVENT_FLIP)
e2:SetCondition(c33569922.con2)
e2:SetOperation(c33569922.atkop)
c:RegisterEffect(e2)
end

function c33569922.atkop(e,tp,eg,ep,ev,re,r,rp)
    local e1=Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_UPDATE_ATTACK)
    e1:SetValue(1500)
    e1:SetReset(RESET_EVENT+0x1ff0000)
    e:GetHandler():RegisterEffect(e1)
    local e2=e1:Clone()
    e2:SetCode(EFFECT_UPDATE_DEFENSE)
    e:GetHandler():RegisterEffect(e2)
end

function c33569922.filter(c)
	return c:IsFaceup() and c:IsCode(54098121)
end
function c33569922.con2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c33569922.filter,tp,LOCATION_ONFIELD,0,1,nil)
end

function c33569922.op(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
if bit.band(c:GetSummonType(),SUMMON_TYPE_RITUAL)==SUMMON_TYPE_RITUAL then
Duel.ChangePosition(c,POS_FACEDOWN_DEFENSE)
end
local e1=Effect.CreateEffect(c)
e1:SetCategory(CATEGORY_POSITION)
e1:SetType(EFFECT_TYPE_IGNITION)
e1:SetRange(LOCATION_MZONE)
e1:SetCondition(c33569922.con)
e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
e1:SetReset(RESET_PHASE+PHASE_END)
e1:SetOperation(c33569922.flipop)
c:RegisterEffect(e1)
end 

function c33569922.con(e)
	return e:GetHandler():IsFacedown()
end

function c33569922.flipop(e)
local c=e:GetHandler()
if c:IsRelateToEffect(e) and c:IsFacedown() then
Duel.ChangePosition(c,POS_FACEUP_ATTACK)
end
end