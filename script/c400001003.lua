--Orichalcos Deuteros
function c400001003.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCondition(c400001003.atcon)
	e1:SetTarget(c400001003.acttg)
	e1:SetOperation(c400001003.sdop)
	c:RegisterEffect(e1)
	--gain LP
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_RECOVER)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCountLimit(1)	
	e2:SetCondition(c400001003.reccon)
	e2:SetOperation(c400001003.recop)
	c:RegisterEffect(e2)
	--negate attack
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetRange(LOCATION_FZONE)
	e3:SetCondition(c400001003.condition)
	e3:SetCost(c400001003.cost)
	e3:SetTarget(c400001003.atktg)
	e3:SetOperation(c400001003.atkop)
	c:RegisterEffect(e3)
end
function c400001003.atcon(e)
	local tc=Duel.GetFieldCard(e:GetHandler():GetControler(),LOCATION_SZONE,5)	
	return tc~=nil and tc:IsFaceup() and tc:GetCode()==48179391
end
function c400001003.acttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetChainLimit(aux.FALSE)
end
function c400001003.sdop(e,tp,eg,ep,ev,re,r,rp)	
	e:GetHandler():CopyEffect(400001002,RESET_EVENT+0x1fe0000)
end

function c400001003.movefilter(c)
	return c:IsType(TYPE_MONSTER)
end

function c400001003.reccon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer() and Duel.GetMatchingGroupCount(c400001003.movefilter,tp,LOCATION_ONFIELD,0,nil)>0
end
function c400001003.recop(e,tp,eg,ep,ev,re,r,rp)
	local rec=Duel.GetMatchingGroupCount(c400001003.movefilter,tp,LOCATION_ONFIELD,0,nil)*500
	Duel.Recover(tp,rec,REASON_EFFECT)
end

function c400001003.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c400001003.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroupCount(c400001003.movefilter,tp,LOCATION_ONFIELD,0,nil)>0 end
	local g=Duel.SelectMatchingCard(tp,c400001003.movefilter,tp,LOCATION_ONFIELD,0,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c400001003.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tg=Duel.GetAttacker()
	if chkc then return chkc==tg end
	if chk==0 then return tg:IsOnField() and tg:IsDestructable() and tg:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tg)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tg,1,0,0)
end
function c400001003.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	if tc:IsRelateToEffect(e) and Duel.NegateAttack() then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end