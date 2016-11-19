--Hungry Burger (DOR)
--scripted by GameMaster (GM)
function c335599165.initial_effect(c)
	c:EnableReviveLimit()
	--destroy warrior race
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_START)
	e1:SetTarget(c335599165.destg)
	e1:SetOperation(c335599165.desop)
	c:RegisterEffect(e1)
	--500 ATK/DEF boost if toon world on field
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetCondition(c335599165.condtion)
	e2:SetValue(c335599165.val)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e3)
end
function c335599165.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if chk==0 then return bc and bc:IsFaceup() and bc:IsRace(RACE_BEAST) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,bc,1,0,0)
end
function c335599165.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if bc:IsRelateToBattle() then
		Duel.Destroy(bc,REASON_EFFECT)
	end
end
function c335599165.filter(c,e)
	return c:IsFaceup() and c:IsCode(15259703)
end

function c335599165.condtion(e,c)
	if c==nil then return true end
 	local c=e:GetHandler()
	return  Duel.IsExistingMatchingCard(c335599165.filter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c335599165.val(e,c)
 local tp=c:GetControler()
  if Duel.IsExistingMatchingCard(c335599165.filter,tp,LOCATION_ONFIELD,0,1,nil) then return 500 
   else return 0 end
end
