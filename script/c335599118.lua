--Gorgon's Eye (Anime)
--scripted by GameMaster (GM)
function c335599118.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c335599118.target)
	e1:SetOperation(c335599118.activate)
	c:RegisterEffect(e1)
	--cannot change pos and negate
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTarget(c335599118.rcon)
	e2:SetTargetRange(0,LOCATION_MZONE)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_DISABLE)
	c:RegisterEffect(e3)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_CANNOT_FLIP_SUMMON)
	e5:SetRange(LOCATION_SZONE)
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e5:SetTargetRange(0,1)
	c:RegisterEffect(e5)
	--damage LP
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_DAMAGE)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetCode(EVENT_BATTLE_DESTROYED)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCondition(c335599118.condition)
	e4:SetTarget(c335599118.target1)
	e4:SetOperation(c335599118.activate1)
	c:RegisterEffect(e4)
--pos
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(335599118,0))
	e6:SetCategory(CATEGORY_POSITION)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e6:SetCode(EVENT_MSET)
	e6:SetRange(LOCATION_SZONE)
	e6:SetTarget(c335599118.target2)
	e6:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e6:SetTargetRange(0,1)
	e6:SetCondition(c335599118.condition2)
	e6:SetOperation(c335599118.operation2)
	c:RegisterEffect(e6)
end
function c335599118.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFacedown,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(Card.IsFacedown,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end
function c335599118.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFacedown,tp,0,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		Duel.ChangePosition(g,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK,POS_FACEUP_DEFENSE,POS_FACEUP_DEFENSE)
	end
end
function c335599118.cfilter(c)
	return c:IsFacedown() and c:IsDefensePos()
end
function c335599118.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c335599118.cfilter,1,nil) end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,eg,eg:GetCount(),0,0)
end
function c335599118.filter(c,e)
	return c:IsFacedown() and c:IsRelateToEffect(e)
end
function c335599118.operation2(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=eg:Filter(c335599118.filter,nil,e)
	Duel.ChangePosition(g,POS_FACEUP_DEFENSE)
end
function c335599118.rcon(e,c)
	return c:IsDefensePos()
end
function c335599118.condition2(e,tp,eg,ep,ev,re,r,rp)
return tp~=eg:GetFirst():GetControler()
end

function c335599118.condition(e,tp,eg,ep,ev,re,r,rp)
	local bc=eg:GetFirst()
	return bc:GetPreviousControler()==1-tp and bc:GetPreviousPosition()==POS_FACEUP_DEFENSE
end
function c335599118.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	local def=eg:GetFirst():GetDefense()/2
	if def<0 then def=0 end
	Duel.SetTargetParam(def)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,def)
end
function c335599118.activate1(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end