--Korogashi (DOR)
--scripted by GameMaster (GM)
function c33569900.initial_effect(c)
	----Reduce ATK! DEF!= -300
	local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    e1:SetCode(EVENT_TO_GRAVE)
    e1:SetCondition(tgcond)
    e1:SetOperation(tgop)
    c:RegisterEffect(e1)
end


function tgcond(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    return bit.band(c:GetReason(),REASON_BATTLE+REASON_DESTROY)==REASON_BATTLE+REASON_DESTROY
end

function tgop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
local p=c:GetPreviousControler()
local s=c:GetPreviousSequence()
local tg=Duel.GetMatchingGroup(Card.IsFaceup,p,LOCATION_MZONE,0,nil)
local tc=Duel.GetFieldCard(1-p,LOCATION_MZONE,4-s)
if tc then tg:AddCard(tc) end
local c=tg:GetFirst()
while c do
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e1:SetValue(-300)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e2)
        c=tg:GetNext()
	end
end