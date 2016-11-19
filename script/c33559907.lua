--Shadow Duel 
--scripted by GameMaster(GM)
function c33559907.initial_effect(c)
--draw card if this card is drawn
local e1=Effect.CreateEffect(c)
e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_DISABLE_CHAIN)
e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
e1:SetCode(EVENT_PHASE_START+PHASE_DRAW)
e1:SetCountLimit(1)
e1:SetRange(LOCATION_HAND+LOCATION_DECK)
e1:SetTarget(c33559907.target)
e1:SetOperation(c33559907.operation)
c:RegisterEffect(e1)
--set monsters in faceup defense
local e2=Effect.CreateEffect(c)
e2:SetType(EFFECT_TYPE_FIELD)
e2:SetRange(LOCATION_REMOVED)
e2:SetCode(EFFECT_DEVINE_LIGHT)
e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e2:SetTargetRange(1,1)
c:RegisterEffect(e2)
end
function c33559907.target(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
Duel.SetTargetPlayer(tp)
Duel.SetTargetParam(1)
Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c33559907.operation(e,tp,eg,ep,ev,re,r,rp)
if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
if e:GetHandler():IsPreviousLocation(LOCATION_HAND) then
local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
Duel.Draw(p,d,REASON_EFFECT)
end
end