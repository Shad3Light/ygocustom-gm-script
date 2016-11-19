--leech snail
--scripted by GameMaster (GM)
function c33569967.initial_effect(c)
aux.EnablePendulumAttribute(c,reg)
	--Parasite fusioner at ..
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(33569967,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(2)
	e1:SetCondition(c33569967.spcon)
	e1:SetTarget(c33569967.sptg)
	e1:SetOperation(c33569967.spop)
	e1:SetCost(c33569967.cost)
	c:RegisterEffect(e1)
	--summon 3 fusion when destoryed by battle
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(33569967,0))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_DESTROYED)
	e4:SetCondition(c33569967.condition)
	e4:SetTarget(c33569967.target)
	e4:SetOperation(c33569967.operation)
	c:RegisterEffect(e4)
end


function c33569967.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_EXTRA) and e:GetHandler():IsReason(REASON_BATTLE+REASON_EFFECT)
end
function c33569967.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,3,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,3,0,0)
end
function c33569967.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<3 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,511002961,0x13d,0x13d,0,0,3,RACE_AQUA,ATTRIBUTE_WATER) then return end
	for i=1,3 do
		local token=Duel.CreateToken(tp,511002961)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
	Duel.SpecialSummonComplete()
end

function Auxiliary.EnablePendulumAttribute(c,reg)
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetCode(EFFECT_SPSUMMON_PROC_G)
    e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
    e1:SetRange(LOCATION_PZONE)
    e1:SetCountLimit(1,10000000)
    e1:SetCondition(Auxiliary.PendCondition())
    e1:SetOperation(Auxiliary.PendOperation())
    e1:SetValue(SUMMON_TYPE_PENDULUM)
    c:RegisterEffect(e1)
    --register by default
    if reg==nil or reg then
        local e2=Effect.CreateEffect(c)
        e2:SetDescription(1160)
        e2:SetType(EFFECT_TYPE_ACTIVATE)
        e2:SetCode(EVENT_FREE_CHAIN)
        e2:SetRange(LOCATION_HAND)
        c:RegisterEffect(e2)
    end
end

function c33569967.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,400)
	else Duel.PayLPCost(tp,400)	end
end

function c33569967.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c33569967.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c33569967.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,511002961,0,0x4011,200,200,1,RACE_MACHINE,ATTRIBUTE_EARTH) then return end
	local token=Duel.CreateToken(tp,511002961)
	Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
end

