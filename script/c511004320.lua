-- Skull Guardian (DOR)
--scripted by GameMaster (GM)
function c511004320.initial_effect(c)
	c:EnableReviveLimit()
	--gain 900 ATK/DEF when battling Fiends
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetOperation(c511004320.operation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetCondition(c511004320.condtion)
	e2:SetValue(900)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e3)
	--SUMMON CHANGE TO FACEDOWN
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	e4:SetOperation(c511004320.op)
	c:RegisterEffect(e4)
	end

function c511004320.potg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return e:GetHandler():IsAttackPos() end
	Duel.SetOperationInfo(0,CATEGORY_POSITION,e:GetHandler(),1,0,0)
end
function c511004320.poop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsAttackPos() and c:IsRelateToEffect(e) then
	c:SetTurnCounter(0)
		Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
	end
end

function c511004320.op(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
Duel.ChangePosition(c,POS_FACEDOWN_DEFENSE)
local e1=Effect.CreateEffect(c)
e1:SetCategory(CATEGORY_POSITION)
e1:SetType(EFFECT_TYPE_IGNITION)
e1:SetRange(LOCATION_MZONE)
e1:SetCondition(c511004320.con)
e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
e1:SetReset(RESET_PHASE+PHASE_END)
e1:SetOperation(c511004320.flipop)
c:RegisterEffect(e1)
--to defense
local e2=Effect.CreateEffect(c)
e2:SetDescription(aux.Stringid(511004320,0))
e2:SetCategory(CATEGORY_POSITION)
e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
e2:SetCode(EVENT_FLIP)
e2:SetTarget(c511004320.potg)
e2:SetOperation(c511004320.poop)
e2:SetReset(RESET_PHASE+PHASE_END)
c:RegisterEffect(e2)
end 

function c511004320.con(e)
	return e:GetHandler():IsFacedown()
end

function c511004320.flipop(e)
local c=e:GetHandler()
if c:IsRelateToEffect(e) and c:IsFacedown() then
Duel.ChangePosition(c,POS_FACEUP_ATTACK)
end
end

function c511004320.condtion(e)
	local ph=Duel.GetCurrentPhase()
	if not (ph==PHASE_DAMAGE or ph==PHASE_DAMAGE_CAL) or not e:GetHandler():IsRelateToBattle() then return false end
	local bc=e:GetHandler():GetBattleTarget()
	return bc and bc:IsFaceup() and bc:IsRace(RACE_FIEND)
end
function c511004320.atktg(e,c)
	return c:GetFieldID()<=e:GetLabel() and c:IsAttribute(ATTRIBUTE_LIGHT)
end
function c511004320.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local g=Duel.GetFieldGroup(tp,LOCATION_MZONE,LOCATION_MZONE)
		local mg,fid=g:GetMaxGroup(Card.GetFieldID)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetRange(LOCATION_MZONE)
		e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
		e1:SetTarget(c511004320.atktg)
		e1:SetValue(300)
		e1:SetLabel(fid)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		c:RegisterEffect(e2)
	end
end



