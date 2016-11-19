--Clear prism Noa Mask
--scripted by GameMaster(GM)
function c335599134.initial_effect(c)	
	--PUT clear world into play
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetOperation(c335599134.op)
	e1:SetCondition(c335599134.con)
	c:RegisterEffect(e1)
	--while in grave clear world indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetProperty(EFFECT_FLAG_IGNORE_RANGE+EFFECT_FLAG_SET_AVAILABLE)
	e2:SetTarget(c335599134.infilter)
	c:RegisterEffect(e2)
	--while in grave cannot activate new field spells
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_ACTIVATE)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetTargetRange(1,1)
	e3:SetValue(c335599134.filter)
	c:RegisterEffect(e3)
	--cannot set field spells
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_CANNOT_SSET)
	e4:SetRange(LOCATION_GRAVE)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetTargetRange(1,1)
	e4:SetTarget(c335599134.sfilter)
	c:RegisterEffect(e4)
	-- Cannot Banish (Loyalty to controller)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetCode(EFFECT_CANNOT_REMOVE)
	e5:SetRange(LOCATION_GRAVE)
	c:RegisterEffect(e5)
	-- Cannot Disable effect in grave
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e6:SetCode(EFFECT_CANNOT_DISABLE)
	e6:SetRange(LOCATION_GRAVE)
	c:RegisterEffect(e6)
	--special summon rule- if masked doll on field-deck
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_FIELD)
	e7:SetCode(EFFECT_SPSUMMON_PROC)
	e7:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CARD_TARGET)
	e7:SetRange(LOCATION_DECK)
	e7:SetCondition(c335599134.spcon)
	c:RegisterEffect(e7)
	local e8=Effect.CreateEffect(c)
	e8:SetDescription(aux.Stringid(335599134,0))
	e8:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e8:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e8:SetCode(EVENT_DESTROYED)
	e8:SetCondition(c335599134.condition)
	e8:SetTarget(c335599134.target)
	e8:SetOperation(c335599134.operation)
	c:RegisterEffect(e8)
	--battle dam 0
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_SINGLE)
	e9:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e9:SetValue(1)
	c:RegisterEffect(e9)
	--atkup for your clear monsters
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_FIELD)
	e10:SetCode(EFFECT_UPDATE_ATTACK)
	e10:SetRange(LOCATION_GRAVE)
	e10:SetTargetRange(LOCATION_MZONE,0)
	e10:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x306))
	e10:SetValue(450)
	c:RegisterEffect(e10)
	--Retun clear monsters to deck
	local e11=Effect.CreateEffect(c)
	e11:SetDescription(aux.Stringid(511001039,0))
	e11:SetCategory(CATEGORY_TODECK)
	e11:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e11:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e11:SetCode(EVENT_SUMMON_SUCCESS)
	e11:SetTarget(c335599134.target1)
	e11:SetOperation(c335599134.operation1)
	c:RegisterEffect(e11)
	local e12=e11:Clone()
	e12:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e12)	
	--removed required
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e13:SetCode(EVENT_REMOVE)
	e13:SetOperation(c335599134.rmop)
	c:RegisterEffect(e13)
	--special summon from bansied zone
	local e14=Effect.CreateEffect(c)
	e14:SetDescription(aux.Stringid(335599134,0))
	e14:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e14:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e14:SetCode(EVENT_PHASE+PHASE_END)
	e14:SetRange(LOCATION_REMOVED)
	e14:SetCondition(c335599134.con653)
	e14:SetTarget(c335599134.tg653)
	e14:SetOperation(c335599134.op653)
	c:RegisterEffect(e14)
end
function c335599134.rmop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsFacedown() then return end
	e:GetHandler():RegisterFlagEffect(335599134,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
function c335599134.con653(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(335599134)~=0
end
function c335599134.tg653(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(3773197)==0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
	e:GetHandler():RegisterFlagEffect(3773197,RESET_EVENT+0x4760000+RESET_PHASE+PHASE_END,0,1)
end
function c335599134.op653(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then
			Duel.SendtoGrave(e:GetHandler(),REASON_EFFECT)
			return
		end
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP_ATTACK)
	end
end



function c335599134.filter4(c)
	return c:IsSetCard(0x306) and c:IsType(TYPE_MONSTER) and c:IsAbleToDeck()
end
function c335599134.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c335599134.filter4,tp,LOCATION_GRAVE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c335599134.operation1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c335599134.filter4,tp,LOCATION_GRAVE,0,nil)
	if g:GetCount()>0 then
		Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
	end
end

function c335599134.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) 
end
function c335599134.filter3(c,e,tp)
	return c:IsCode(33559948)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c335599134.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c335599134.filter3,tp,LOCATION_DECK,0,1,nil,e,tp)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c335599134.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c335599134.filter3,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end


function c335599134.cfilter(c)
	return c:IsFaceup() and c:IsCode(511005591)
end
function c335599134.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	and Duel.IsExistingMatchingCard(c335599134.cfilter,tp,LOCATION_ONFIELD,0,1,nil) 
end

function c335599134.filter2(c)
	return c:IsCode(33900648)
end
function c335599134.con(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	return e:GetHandler():GetLocation()==LOCATION_GRAVE
end

function c335599134.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingMatchingCard(c335599127.filter2,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil) 
	and Duel.CheckLocation(e:GetHandlerPlayer(),LOCATION_SZONE,5) end
end


function c335599134.op(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.CheckLocation(e:GetHandlerPlayer(),LOCATION_SZONE,5) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local g=Duel.SelectMatchingCard(tp,c335599134.filter2,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		local te=tc:GetActivateEffect()
		local tp=tc:GetControler()
		local cost=te:GetCost()
		if cost then cost(te,tep,eg,ep,ev,re,r,rp,1) end
		Duel.RaiseEvent(tc,EVENT_CHAIN_SOLVED,tc:GetActivateEffect(),0,tp,tp,Duel.GetCurrentChain())
	end
end
function c335599134.infilter(e,c)
	return c:IsType(TYPE_FIELD) and c:IsCode(33900648)
end
function c335599134.filter(e,re,tp)
	return re:GetHandler():IsType(TYPE_FIELD) and re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c335599134.sfilter(e,c,tp)
	return c:IsType(TYPE_FIELD) and Duel.GetFieldCard(tp,LOCATION_SZONE,5)~=nil
end
