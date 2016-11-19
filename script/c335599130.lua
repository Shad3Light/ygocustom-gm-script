--Toon Lancer
--Scripter by GameMaster(GM)
function c335599130.initial_effect(c)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetTarget(c335599130.adhtarget)
	e1:SetOperation(c335599130.adhoperation)
	c:RegisterEffect(e1)
	--cannot attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetOperation(c335599130.atklimit)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e4)
	--destroy
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(EVENT_LEAVE_FIELD)
	e5:SetOperation(c335599130.sdesop)
	c:RegisterEffect(e5)
	--direct attack
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_DIRECT_ATTACK)
	e6:SetCondition(c335599130.dircon)
	c:RegisterEffect(e6)
	--summon with no tribute
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(11111112,1))
	e7:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetCode(EFFECT_SUMMON_PROC)
	e7:SetCondition(c335599130.ntcon)
	e7:SetOperation(c335599130.ntop)
	c:RegisterEffect(e7)
end

function c335599130.filter(c,e,tp)
    return c:IsAbleToHand() and c:IsFacedown()
end
function c335599130.adhtarget(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c335599130.filter,tp,LOCATION_REMOVED,0,3,nil) end
    Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,3,tp,LOCATION_REMOVED)
end


function c335599130.adhoperation(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
    local g=Duel.GetMatchingGroup(Card.IsFacedown,tp,LOCATION_REMOVED,LOCATION_REMOVED,nil)
	if g:GetCount()<3 then return end
	local sg=g:RandomSelect(tp,3)
        Duel.SendtoHand(g,nil,3,REASON_EFFECT)
        Duel.ConfirmCards(1-tp,g)
    end


function c335599130.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and c:GetLevel()>4 and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c335599130.ntop(e,tp,eg,ep,ev,re,r,rp,c)
	--to grave
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(335599130,1))
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetCondition(c335599130.tgcon)
	e2:SetTarget(c335599130.tgtg)
	e2:SetOperation(c335599130.tgop)
	e2:SetReset(RESET_EVENT+0xee0000)
	c:RegisterEffect(e2)
end
function c335599130.tgcon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c335599130.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,e:GetHandler(),1,0,0)
end
function c335599130.tgop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		Duel.SendtoGrave(c,REASON_EFFECT)
	end
end
function c335599130.atklimit(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e:GetHandler():RegisterEffect(e1)
end
function c335599130.sfilter(c)
	return c:IsReason(REASON_DESTROY) and c:IsPreviousPosition(POS_FACEUP) and c:GetPreviousCodeOnField()==15259703 and c:IsPreviousLocation(LOCATION_ONFIELD)
end
function c335599130.sdescon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c335599130.sfilter,1,nil)
end
function c335599130.sdesop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
function c335599130.dirfilter1(c)
	return c:IsFaceup() and c:IsCode(15259703)
end
function c335599130.dirfilter2(c)
	return c:IsFaceup() and c:IsType(TYPE_TOON)
end
function c335599130.dircon(e)
	return Duel.IsExistingMatchingCard(c335599130.dirfilter1,e:GetHandlerPlayer(),LOCATION_ONFIELD,0,1,nil)
		and not Duel.IsExistingMatchingCard(c335599130.dirfilter2,e:GetHandlerPlayer(),0,LOCATION_MZONE,1,nil)
end
