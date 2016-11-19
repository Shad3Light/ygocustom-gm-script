--Sister Circle
--scripted by GameMaster(GM)
function c75233708.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c75233708.target)
	e1:SetOperation(c75233708.activate)
	c:RegisterEffect(e1)
	--remain on field
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_REMAIN_FIELD)
	c:RegisterEffect(e2)
	--indestructable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_ONFIELD,LOCATION_ONFIELD)
	e3:SetCondition(c75233708.incon)
	e3:SetTarget(c75233708.infilter)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--cannot be target
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_CANNOT_SELECT_EFFECT_TARGET)
	e4:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IMMEDIATELY_APPLY)
	e4:SetRange(LOCATION_SZONE)
	e4:SetTargetRange(0,0xff)
	e4:SetValue(c75233708.etarget)
	c:RegisterEffect(e4)
end

c75233708.collection={ [75233705]=true; [75233706]=true; [75233707]=true; }

function c75233708.cfilter(c,code)
	return c:IsFaceup() and c75233708.collection
end


function c75233708.incon(e)
	return Duel.IsExistingMatchingCard(c75233708.cfilter,e:GetHandlerPlayer(),LOCATION_ONFIELD,0,1,nil,75233708)
end
function c75233708.infilter(e,c)
	return c75233708.collection[c:GetCode()]
end


function c75233708.etarget(e,re,c)
	return c:IsFaceup() and c:IsControler(e:GetHandlerPlayer()) and c:IsLocation(LOCATION_MZONE) and c75233708.collection[c:GetCode()]
end

function c75233708.filter(c,e,tp)
	return c75233708.collection[c:GetCode()] and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c75233708.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c75233708.filter,tp,LOCATION_DECK+LOCATION_HAND,0,3,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,3,tp,LOCATION_DECK+LOCATION_HAND)
end
function c75233708.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c75233708.filter,tp,LOCATION_DECK+LOCATION_HAND,0,3,3,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
