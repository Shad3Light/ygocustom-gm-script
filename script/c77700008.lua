--Rain Force - Perception
function c77700006.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x777),3,false)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--destroy and draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(77700006,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c77700006.sumcon)
	e1:SetTarget(c77700006.sumtg)
	e1:SetOperation(c77700006.sumop)
	c:RegisterEffect(e1)

	--remove facedown
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(77700006,1))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c77700006.descost)
	e2:SetTarget(c77700006.destg)
	e2:SetOperation(c77700006.desop)
	c:RegisterEffect(e2)
	--Place in Pend Zone
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(77700006,2))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetCountLimit(1,77700006)
	e3:SetCondition(c77700006.setcon)
	e3:SetTarget(c77700006.settg)
	e3:SetOperation(c77700006.setop)
	c:RegisterEffect(e3)
	--pend eff ssummon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(77700006,3))
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetRange(LOCATION_PZONE)
	e4:SetCountLimit(1)
	e4:SetCost(c77700006.descost)
	e4:SetTarget(c77700006.pentg)
	e4:SetOperation(c77700006.penop)
	c:RegisterEffect(e4)
end
--Effect 1
function c77700006.sumcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_FUSION
end
function c77700006.sumfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x777) and c:IsType(TYPE_MONSTER) and c:GetCode()~=77700006
end
function c77700006.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c77700006.sumfilter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,g:GetCount())
end
function c77700006.sumop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c77700006.sumfilter,tp,LOCATION_MZONE,0,nil)
	local ct=Duel.Destroy(g,REASON_EFFECT)
	Duel.Draw(tp,ct,REASON_EFFECT)
end
--Effect 2
function c77700006.costfil(c)
	return c:IsSetCard(0x777) and c:IsLocation(LOCATION_MZONE) and c:IsPosition(POS_FACEUP)
end
function c77700006.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroupEx(tp,c77700006.costfil,1,nil) end
	local g=Duel.SelectReleaseGroupEx(tp,c77700006.costfil,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c77700006.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_ONFIELD) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c77700006.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Remove(tc,POS_FACEDOWN,REASON_EFFECT)
	end
end
--Effect 3
function c77700006.despendfil(c)
	return c:IsType(TYPE_PENDULUM) and c:GetSequence()>5 and c:IsDestructable()
end
function c77700006.setcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsLocation(LOCATION_EXTRA) and c:IsPosition(POS_FACEUP) and c:GetPreviousControler()==tp and c:IsPreviousLocation(LOCATION_ONFIELD)
end

function c77700006.cfilter(c)
	return c:IsSetCard(0x777) and c:IsType(TYPE_PENDULUM) and c:IsPosition(POS_FACEUP)
end
function c77700006.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c77700006.cfilter,tp,LOCATION_EXTRA,0,2,nil) end
end
function c77700006.setop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c77700006.despendfil,tp,LOCATION_SZONE,LOCATION_SZONE,nil)
	Duel.Destroy(sg,REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectMatchingCard(tp,c77700006.cfilter,tp,LOCATION_EXTRA,0,2,2,nil)
	if g:GetCount()>1 then
		Duel.MoveToField(g:GetFirst(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		Duel.MoveToField(g:GetNext(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	end
end
--Effect 4
function c77700006.filter(c,e,sp)
	return c:IsSetCard(0x777) and c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,sp,false,false)
end
function c77700006.pentg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c77700006.filter,tp,LOCATION_DECK,0,1,nil,e,tp)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>=0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c77700006.penop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c77700006.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
