--Niwatori (DOR)
--scripted by GameMaster (GM)
function c33569911.initial_effect(c)
	--double lp recovery
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e1:SetCode(EVENT_RECOVER)
    e1:SetRange(LOCATION_MZONE)
    e1:SetCondition(c33569911.con)
    e1:SetOperation(c33569911.op)
    c:RegisterEffect(e1)
    --500 ATK/DEF boost if toon world on field
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetCondition(c33569911.condtion1)
	e2:SetValue(c33569911.val2)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e3)
end

function c33569911.con(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():IsPosition(POS_FACEUP_DEFENSE) and re:GetHandler():GetCode()~=e:GetHandler():GetCode()
end

function c33569911.op(e,tp,eg,ep,ev,re,r,rp)
    local val=ev
    Duel.Recover(ep,val,REASON_EFFECT)
end

function c33569911.filter(c,e)
	return c:IsFaceup() and c:IsCode(15259703)
end

function c33569911.condtion1(e,c)
	if c==nil then return true end
 	local c=e:GetHandler()
	return  Duel.IsExistingMatchingCard(c33569911.filter,tp,LOCATION_ONFIELD,0,1,nil)
end

function c33569911.val2(e,c)
 local tp=c:GetControler()
  if Duel.IsExistingMatchingCard(c33569911.filter,tp,LOCATION_ONFIELD,0,1,nil) then return 500 
   else return 0 end
end