--UnderWorld Spirit
function c33559981.initial_effect(c)
--xyz summon
aux.AddXyzProcedure(c,nil,4,2)
c:EnableReviveLimit()
--cannot change control
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e1:SetRange(LOCATION_MZONE)
e1:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
c:RegisterEffect(e1)
--topdeck and to hand
local e2=Effect.CreateEffect(c)
e2:SetType(EFFECT_TYPE_IGNITION)
e2:SetRange(LOCATION_MZONE)
e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
e2:SetCountLimit(1)
e2:SetCost(c33559981.tdthcost)
e2:SetTarget(c33559981.tdthtg)
e2:SetOperation(c33559981.tdthop)
c:RegisterEffect(e2)
--destroyed
local e3=Effect.CreateEffect(c)
e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
e3:SetCode(EVENT_DESTROYED)
e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
e3:SetCountLimit(1,33559981)
e3:SetCondition(c33559981.spcon)
e3:SetTarget(c33559981.sptg)
e3:SetOperation(c33559981.spop)
c:RegisterEffect(e3)
--treatead as spirit
local e4=Effect.CreateEffect(c)
e4:SetType(EFFECT_TYPE_FIELD)
e4:SetRange(LOCATION_MZONE)
e4:SetTargetRange(LOCATION_MZONE,0)
e4:SetCode(EFFECT_ADD_TYPE)
e4:SetValue(TYPE_SPIRIT)
c:RegisterEffect(e4)
end
function c33559981.tdthcost(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c33559981.tdthtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
local c=e:GetHandler()
if chkc then return chkc:IsOnField() and chkc:IsAbleToDeck() and chkc~=c end
if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToDeck,tp,0,LOCATION_ONFIELD,1,c) end
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
local g=Duel.SelectTarget(tp,Card.IsAbleToDeck,tp,0,LOCATION_ONFIELD,1,1,c)
Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c33559981.tdthop(e,tp)
local tc=Duel.GetFirstTarget()
if tc and tc:IsRelateToEffect(e) then
if Duel.SendtoDeck(tc,nil,0,REASON_EFFECT) then
local g=Duel.GetMatchingGroup(Card.IsAbleToHand,tp,0,LOCATION_ONFIELD,nil)
Duel.SendtoHand(g,nil,REASON_EFFECT)
end
end
end
function c33559981.spcon(e,tp,eg,ep,ev,re,r,rp)
return e:GetHandler():IsReason(REASON_DESTROY)
end
function c33559981.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c33559981.spfilter(c,e)
return (c:IsLocation(LOCATION_HAND) or c:IsLocation(LOCATION_EXTRA)) and not c:IsImmuneToEffect(e)
end
function c33559981.spop(e,tp,eg,ep,ev,re,r,rp)
if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end	
if e:GetHandler() then
if Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP) then
local g=Duel.SelectMatchingCard(tp,c33559981.spfilter,tp,0,LOCATION_HAND+LOCATION_EXTRA,1,1,nil,e)
local c=e:GetHandler()
if g:GetCount()>0 then
Duel.Overlay(c,g)
end
end
end
end
