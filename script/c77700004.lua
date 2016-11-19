--Rain Force - Manifestation
function c77700004.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--spsummon from hand
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetCondition(c77700004.hspcon)
	e1:SetOperation(c77700004.hspop)
	c:RegisterEffect(e1)
	--Place in Pend Zone
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(77700004,1))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetCountLimit(1,77700004)
	e2:SetCondition(c77700004.setcon)
	e2:SetTarget(c77700004.settg)
	e2:SetOperation(c77700004.setop)
	c:RegisterEffect(e2)
	--Draw when tribute
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCategory(CATEGORY_DRAW)
	e3:SetCode(EVENT_RELEASE)
	e3:SetRange(LOCATION_PZONE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCountLimit(1)
	e3:SetCondition(c77700004.dcon)
	e3:SetTarget(c77700004.dtg)
	e3:SetOperation(c77700004.dop)
	c:RegisterEffect(e3)  
end
--Effect 1
function c77700004.hspcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-1
		and Duel.GetMatchingGroupCount(c77700004.hspfilter,c:GetControler(),LOCATION_SZONE,0,nil)==2
end
function c77700004.hspop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectMatchingCard(tp,c77700004.hspfilter,tp,LOCATION_SZONE,0,2,2,nil)
	Duel.Destroy(g,REASON_COST)
	c:RegisterFlagEffect(0,RESET_EVENT+0x4fc0000,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(77700004,2))
end
function c77700004.hspfilter(c)
	return c:IsType(TYPE_PENDULUM) and c:IsLocation(LOCATION_SZONE) and c:GetSequence()>5
end
--Effect 2
function c77700004.setcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsLocation(LOCATION_EXTRA) and c:IsPosition(POS_FACEUP) and c:GetPreviousControler()==tp and c:IsPreviousLocation(LOCATION_ONFIELD)
		and not (Duel.GetMatchingGroup(c77700004.pendfil,tp,LOCATION_SZONE,0,nil):GetCount()>1)
end
function c77700004.pendfil(c)
	return c:IsType(TYPE_PENDULUM) and c:GetSequence()>5
end
function c77700004.cfilter(c)
	return c:IsSetCard(0x777) and c:IsType(TYPE_PENDULUM) and c:IsPosition(POS_FACEUP)
end
function c77700004.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c77700004.cfilter,tp,LOCATION_MZONE,0,1,nil) end
end
function c77700004.setop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectMatchingCard(tp,c77700004.cfilter,tp,LOCATION_MZONE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.MoveToField(g:GetFirst(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	end
end
--Effect 3
function c77700004.dcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsSetCard,1,nil,0x777)
end
function c77700004.dtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c77700004.dop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
