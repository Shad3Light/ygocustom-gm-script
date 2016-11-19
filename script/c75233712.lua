--Blue-Eyes Toon Ultimate dragon
--scripted by GameMaster(GM)
function c75233712.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeRep(c,53183600,3,true,true)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_LEAVE_FIELD)
	e1:SetCondition(c75233712.sdescon)
	e1:SetOperation(c75233712.sdesop)
	c:RegisterEffect(e1)
	--direct attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DIRECT_ATTACK)
	e2:SetCondition(c75233712.dircon)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e3:SetCondition(c75233712.atcon)
	e3:SetValue(c75233712.atlimit)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	e4:SetCondition(c75233712.atcon)
	c:RegisterEffect(e4)
	--cannot attack
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_SPSUMMON_SUCCESS)
	e5:SetOperation(c75233712.atklimit)
	c:RegisterEffect(e5)
	--special summon condition
	local e6=Effect.CreateEffect(c)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_SPSUMMON_CONDITION)
	e6:SetValue(c75233712.spcon)
	c:RegisterEffect(e6)
end

function c75233712.cfilter(c)
	return c:IsFaceup() and c:IsCode(15259703)
end

function c75233712.spcon(e)
    return Duel.IsExistingMatchingCard(c75233712.cfilter,e:GetHandler():GetControler(),LOCATION_ONFIELD,0,1,nil)
end

function c75233712.sfilter(c)
	return c:IsReason(REASON_DESTROY) and c:IsPreviousPosition(POS_FACEUP) and c:GetPreviousCodeOnField()==15259703 and c:IsPreviousLocation(LOCATION_ONFIELD)
end

function c75233712.sdescon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c75233712.sfilter,1,nil)
end
function c75233712.sdesop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end


function c75233712.atkfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_TOON)
end


function c75233712.dircon(e)
	return not Duel.IsExistingMatchingCard(c75233712.atkfilter,e:GetHandlerPlayer(),0,LOCATION_MZONE,1,nil)
end

function c75233712.atcon(e)
	return Duel.IsExistingMatchingCard(c75233712.atkfilter,e:GetHandlerPlayer(),0,LOCATION_MZONE,1,nil)
end
function c75233712.atlimit(e,c)
	return not c:IsType(TYPE_TOON) or c:IsFacedown()
end
function c75233712.atklimit(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e:GetHandler():RegisterEffect(e1)
end


