--Clear Dark stone

function c33559960.initial_effect(c)
	--destroyed
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetOperation(c33559960.desop)
	c:RegisterEffect(e1)
	--change dark monsters to light attribute
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
    e2:SetOperation(c33559960.operation)
    c:RegisterEffect(e2)
 end
 
 function c33559960.tg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAttribute,tp,0,LOCATION_MZONE,1,nil,ATTRIBUTE_DARK) end
end
function c33559960.operation(e,tp,eg,ep,ev,re,r,rp)
   local g=Duel.GetMatchingGroup(Card.IsAttribute,tp,0,LOCATION_MZONE,nil,ATTRIBUTE_DARK)
    local tc=g:GetFirst()
    while tc do
        local e1=Effect.CreateEffect(e:GetHandler())
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_CHANGE_ATTRIBUTE)
        e1:SetValue(ATTRIBUTE_LIGHT)
        e1:SetReset(RESET_EVENT+0x1ff0000)
        tc:RegisterEffect(e1,true)
        tc=g:GetNext()
    end
end
 
function c33559960.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if not bc:IsRelateToBattle() or bc:IsFacedown() then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e1:SetValue(-9999)
	bc:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	bc:RegisterEffect(e2)
end
