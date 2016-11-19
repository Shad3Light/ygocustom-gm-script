--32083024
function c32083024.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c32083024.cost)
	e1:SetTarget(c32083024.target)
	e1:SetOperation(c32083024.activate)
	c:RegisterEffect(e1)
end
function c32083024.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,nil,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,nil,1,1,nil)
    Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c32083024.filter(c,e,tp)
    return c:IsCanBeSpecialSummoned(e,0,tp,false,false)and c:IsSetCard(0x7D53)
end

function c32083024.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chkc then return chkc:IsLocation(LOCATION_REMOVED) and c32083024.filter(chkc,e,tp) end
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
        and Duel.IsExistingTarget(c32083024.filter,tp,LOCATION_REMOVED,LOCATION_REMOVE,1,e:GetHandler(),e,tp) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
   local g=Duel.SelectTarget(tp,c32083024.filter,tp,LOCATION_REMOVED,LOCATION_REMOVE,1,1,e:GetHandler(),e,tp)
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end

function c32083024.activate(e,tp,eg,ep,ev,re,r,rp)
    local tc=Duel.GetFirstTarget()
    if tc:IsRelateToEffect(e) then
        Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
    end
end