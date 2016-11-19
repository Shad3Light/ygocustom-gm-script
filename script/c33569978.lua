--Sorceress Kagura of the wind
--scripted by GameMaster (GM)
function c33569978.initial_effect(c)
c:SetUniqueOnField(1,1,33569978)
	--return spells/traps/pendulums
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetOperation(c33569978.operation)
	e1:SetTarget(c33569978.target)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--Return cards to opponents deck
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(33569978,0))
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_IGNORE_IMMUNE)
	e4:SetCategory(CATEGORY_TODECK)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetTarget(c33569978.returntg)
	e4:SetOperation(c33569978.returnop)
	c:RegisterEffect(e4)
	--Return to deck if destroyed
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_DESTROY_REPLACE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetTarget(c33569978.desreptg)
	c:RegisterEffect(e5)
	--Dance of the dead
	local e7=Effect.CreateEffect(c)
	e7:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e7:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e7:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCountLimit(1)
	e7:SetCondition(c33569978.spcon)
	e7:SetTarget(c33569978.sptg)
	e7:SetOperation(c33569978.spop)
	c:RegisterEffect(e7)
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e8:SetCode(EVENT_BATTLE_DESTROYING)
	e8:SetOperation(c33569978.regop)
	c:RegisterEffect(e8)
	--return a card to hand
	local e9=Effect.CreateEffect(c)
	e9:SetDescription(aux.Stringid(33569978,1))
	e9:SetCategory(CATEGORY_TOHAND)
	e9:SetType(EFFECT_TYPE_IGNITION)
	e9:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e9:SetCode(EVENT_FREE_CHAIN)
	e9:SetRange(LOCATION_MZONE)
	e9:SetTarget(c33569978.target2)
	e9:SetOperation(c33569978.operation2)
	e9:SetCountLimit(1)
	c:RegisterEffect(e9)
end


function c33569978.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsAbleToHand() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToHand,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,Card.IsAbleToHand,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end

function c33569978.operation2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.Damage(1-tp,100,REASON_EFFECT)
		Duel.Damage(1-tp,100,REASON_EFFECT)
		Duel.Damage(1-tp,100,REASON_EFFECT)
	end
end



function c33569978.regop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(33569978,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE,0,1)
end
function c33569978.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(33569978)~=0
end
function c33569978.filter3(c,e,tp,rc,tid)
	return c:IsReason(REASON_BATTLE) and c:GetReasonCard()==rc and c:GetTurnID()==tid
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c33569978.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c33569978.filter3,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,e,tp,e:GetHandler(),Duel.GetTurnCount()) end
	local g=Duel.GetMatchingGroup(c33569978.filter3,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil,e,tp,e:GetHandler(),Duel.GetTurnCount())
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c33569978.spop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,c33569978.filter3,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,ft,nil,e,tp,e:GetHandler(),Duel.GetTurnCount())
	Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
end


function c33569978.desreptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsReason(REASON_BATTLE) and c:IsFaceup()  end
		Duel.SendtoDeck(c,tp,2,REASON_EFFECT)
		Duel.ShuffleDeck(tp)
 end

function c33569978.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP+TYPE_PENDULUM) and c:IsAbleToHand()
end
function c33569978.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c33569978.filter,tp,LOCATION_ONFIELD,0,1,c) end
	local sg=Duel.GetMatchingGroup(c33569978.filter,tp,LOCATION_ONFIELD,0,c)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,sg,sg:GetCount(),0,0)
end
function c33569978.operation(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c33569978.filter,tp,LOCATION_ONFIELD,0,e:GetHandler())
	Duel.SendtoHand(sg,nil,REASON_EFFECT)
end

function c33569978.filter2(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP+TYPE_PENDULUM) and c:IsAbleToDeck()
end

function c33569978.returntg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c33569978.filter2,tp,0,LOCATION_ONFIELD,1,c) end
	local sg=Duel.GetMatchingGroup(c33569978.filter2,tp,0,LOCATION_ONFIELD,c)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,sg,sg:GetCount(),0,0)
end
function c33569978.returnop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c33569978.filter2,tp,0,LOCATION_ONFIELD,e:GetHandler())
	Duel.SendtoDeck(sg,nil,1-tp,REASON_EFFECT)
	Duel.ShuffleDeck(1-tp)
end

