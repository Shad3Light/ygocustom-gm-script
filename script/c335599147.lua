--Cockroach queen
--scripted by GM
function c335599147.initial_effect(c)
--fusion material
c:EnableReviveLimit()
aux.AddFusionProcCode2(c,33559985,33559925,true,true)
	--cockroach at endphase
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(335599147,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(2)
	e1:SetCondition(c335599147.spcon)
	e1:SetTarget(c335599147.sptg)
	e1:SetOperation(c335599147.spop)
	c:RegisterEffect(e1)
	--remove
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_RANGE)
	e2:SetCode(EFFECT_TO_GRAVE_REDIRECT)
	e2:SetRange(LOCATION_MZONE+LOCATION_GRAVE)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsCode,33413638))
	e2:SetTargetRange(0xff,0xff)
	e2:SetValue(LOCATION_REMOVED)
	c:RegisterEffect(e2)
	--Return cards to deck
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(335599147,0))
	e3:SetCategory(CATEGORY_TODECK)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetTarget(c335599147.tdtg)
	e3:SetOperation(c335599147.tdop)
	c:RegisterEffect(e3)
	--tribute req/4attack
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_ATTACK_COST)
	e4:SetCost(c335599147.atcost)
	e4:SetOperation(c335599147.atop)
	c:RegisterEffect(e4)
	--cannot select battle target
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetRange(LOCATION_MZONE)
	e5:SetTargetRange(0,LOCATION_MZONE)
	e5:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e5:SetValue(c335599147.atlimit)
	c:RegisterEffect(e5)
	end

function c335599147.atlimit(e,c)
	return c==e:GetHandler() and c:IsFaceup() and c:IsCode(335599147)
	end
function c335599147.atcost(e,c,tp)
	return Duel.CheckReleaseGroup(tp,nil,1,e:GetHandler())
end
function c335599147.atop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectReleaseGroup(tp,nil,1,1,e:GetHandler())
	Duel.Release(g,REASON_COST)
end	
function c335599147.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c335599147.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c335599147.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,33413638,0,0x4011,200,200,1,RACE_MACHINE,ATTRIBUTE_EARTH) then return end
	local token=Duel.CreateToken(tp,33413638)
	Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
end

function c335599147.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,1-tp,LOCATION_REMOVED)
end
function c335599147.tdop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetFieldGroup(tp,LOCATION_REMOVED,0)
	Duel.SendtoDeck(g,1-tp,2,REASON_EFFECT)
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		end
end