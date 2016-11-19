--Stuffed Animal (DOR)
--scripted by GameMaster (GM)
function c33569947.initial_effect(c)
	--500 ATK/DEF boost if toon world on field
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetCondition(c33569947.condtion)
	e1:SetValue(c33569947.val)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e2)
end

function c33569947.filter(c,e)
	return c:IsFaceup() and c:IsCode(15259703)
end

function c33569947.condtion(e,c)
	if c==nil then return true end
 	local c=e:GetHandler()
	return  Duel.IsExistingMatchingCard(c33569947.filter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c33569947.val(e,c)
 local tp=c:GetControler()
  if Duel.IsExistingMatchingCard(c33569947.filter,tp,LOCATION_ONFIELD,0,1,nil) then return 500 
   else return 0 end
end
