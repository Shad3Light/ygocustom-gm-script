--Ammit, Devourer of Souls
--scripted by GameMaster (GM)
function c33569965.initial_effect(c)
	c:EnableReviveLimit()
	c:SetUniqueOnField(1,1,33569965)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(33569965,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetRange(LOCATION_DECK+LOCATION_GRAVE+LOCATION_HAND)
	e1:SetProperty(EFFECT_FLAG_CHAIN_UNIQUE)
	e1:SetCode(EVENT_CUSTOM+33559916)
	e1:SetCondition(c33569965.spcon)
	e1:SetCost(c33569965.cost)
	e1:SetTarget(c33569965.sptg)
	e1:SetOperation(c33569965.spop)
	c:RegisterEffect(e1)
	-- Cannot Banish 
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_CANNOT_REMOVE)
	e2:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e2)
	--control cannot switch
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
	c:RegisterEffect(e3)
	--Add Race
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_ADD_RACE)
	e4:SetValue(RACE_BEAST)
	c:RegisterEffect(e4)
	-- end of anubis effect-graveyard effects 
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(EVENT_CHAIN_SOLVING)
	e5:SetCondition(c33569965.condition)
	e5:SetOperation(c33569965.operation)
	c:RegisterEffect(e5)
	--Monsters destroyed vanish from duel
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(33569965,1))
	e6:SetCategory(CATEGORY_REMOVE)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e6:SetCode(EVENT_BATTLED)
	e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
	e6:SetCondition(c33569965.rmcon)
	e6:SetTarget(c33569965.rmtg)
	e6:SetOperation(c33569965.rmop)
	c:RegisterEffect(e6)
	--cannot be attack target
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetCode(EFFECT_IGNORE_BATTLE_TARGET)
	e7:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
	e7:SetRange(LOCATION_MZONE,LOCATION_MZONE)
	e7:SetTarget(c33569965.filter5)
	c:RegisterEffect(e7)
	--cannot attack for 2 turns 
    local e8=Effect.CreateEffect(c)
    e8:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    e8:SetCode(EVENT_BATTLE_START)
    e8:SetRange(LOCATION_MZONE)
    e8:SetOperation(c33569965.operation5)
    c:RegisterEffect(e8)
	-- Cannot to hand
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_SINGLE)
	e9:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
	e9:SetRange(LOCATION_DECK)
	e9:SetCode(EFFECT_CANNOT_TO_HAND)
	e9:SetValue(1)
	c:RegisterEffect(e9)
	-- Cannot to deck
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_SINGLE)
	e10:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
	e10:SetRange(LOCATION_MZONE)
	e10:SetCode(EFFECT_CANNOT_TO_DECK)
	e10:SetValue(1)
	c:RegisterEffect(e10)
	-- Cannot Disable effect
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_SINGLE)
	e11:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e11:SetCode(EFFECT_CANNOT_DISABLE)
	e11:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e11)
end

function c33569965.filter5(e)
return c:IsFaceup() and c:IsCode(33569965)
end

function c33569965.operation5(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
if Duel.GetAttacker()~=c then return end
    local e1=Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
    e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN,3)
    c:RegisterEffect(e1)
end

function c33569965.rmcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	e:SetLabelObject(bc)
	return bc and bc:IsStatus(STATUS_BATTLE_DESTROYED) and c:IsStatus(STATUS_OPPO_BATTLE)
end

function c33569965.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,e:GetLabelObject(),1,0,0)
end

function c33569965.rmop(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetLabelObject()
	if bc:IsRelateToBattle() and bc:IsAbleToRemove() then
	--redirect
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
	e1:SetCondition(c33569965.recon)
	e1:SetValue(11,LOCATION_GRAVE)
	bc:RegisterEffect(e1)
	Duel.Remove(bc,POS_FACEUP,REASON_EFFECT)
	end
end

function c33569965.recon(e)
	return e:GetHandler():IsFaceup()
end

function c33569965.gfilter(c)
	return c:IsLocation(LOCATION_GRAVE)
end

function c33569965.condition(e,tp,eg,ep,ev,re,r,rp)
	local loc=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	if loc==LOCATION_GRAVE then return true end
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return g and g:IsExists(c33569965.gfilter,1,nil)
end
function c33569965.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
end


function c33569965.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsFaceup,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,Card.IsFaceup,1,1,nil)
	Duel.Release(g,REASON_COST)
end

function c33569965.spcon(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp
end

function c33569965.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,true,false) end
	if e:GetHandler():IsLocation(LOCATION_DECK+LOCATION_HAND+LOCATION_GRAVE) then
		Duel.ConfirmCards(1-tp,e:GetHandler())
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end

function c33569965.spop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) and Duel.SpecialSummon(e:GetHandler(),0,tp,tp,true,false,POS_FACEUP)>0 then
		e:GetHandler():CompleteProcedure()
	end
end
