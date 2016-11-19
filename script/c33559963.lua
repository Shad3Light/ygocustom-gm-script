--Magnetmans' Attachment
function c33559963.initial_effect(c)
--activate
local e1=Effect.CreateEffect(c)	
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
e1:SetCode(EVENT_FREE_CHAIN)
c:RegisterEffect(e1)
--attach
local e2=Effect.CreateEffect(c)
e2:SetCategory(CATEGORY_HANDES)
e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
e2:SetCode(EVENT_SPSUMMON_SUCCESS)
e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
e2:SetRange(LOCATION_SZONE)
e2:SetCondition(c33559963.condition)
e2:SetTarget(c33559963.target)
e2:SetOperation(c33559963.op)
c:RegisterEffect(e2)
end
--attach
function c33559963.thfilter(c,tp)
return c:IsSetCard(0x51EEF) and c:IsControler(tp) and c:GetSummonType()==SUMMON_TYPE_XYZ
end
function c33559963.condition(e,tp,eg,ep,ev,re,r,rp)
return eg:IsExists(c33559963.thfilter,1,nil,tp)
end
function c33559963.matfilter(c)
return c:IsAbleToChangeControler()
end
function c33559963.target(e,tp,eg,ep,ev,re,r,rp,chk)
if chkc then return false end
if chk==0 then return Duel.IsExistingMatchingCard(nil,tp,LOCATION_MZONE,0,1,nil) end
local g1=Duel.SetTargetCard(eg)	Duel.SetOperationInfo(0,CATEGORY_SPSUMMON,eg,eg:GetCount(),0,0)
e:SetLabelObject(eg:GetFirst())
end
function c33559963.op(e,tp,eg,ep,ev,re,r,rp)
if not e:GetHandler():IsRelateToEffect(e) then return end
local tc=e:GetLabelObject()
if tc:IsFacedown() or not tc:IsRelateToEffect(e) or tc:IsImmuneToEffect(e) then return end
local g=Duel.GetFieldGroup(tp,0,LOCATION_DECK)
if g:GetCount()>0 then
local sg=g:RandomSelect(1-tp,1)
Duel.Overlay(tc,sg)
end	
end