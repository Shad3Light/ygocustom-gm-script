--32083021
function c32083021.initial_effect(c)
    --Activate
    local e1=Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCondition(c32083021.condition)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetTarget(c32083021.target)
    e1:SetOperation(c32083021.activate)
    c:RegisterEffect(e1)
end

function c32083021.filter(c,e,tp)
    return c:IsCanBeSpecialSummoned(e,0,tp,false,false)and c:IsSetCard(0x7D53)
end
function c32083021.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>1
		and Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
end
function c32083021.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chkc then return chkc:IsLocation(LOCATION_REMOVED) and c32083021.filter(chkc,e,tp) end
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
        and Duel.IsExistingTarget(c32083021.filter,tp,LOCATION_REMOVED,LOCATION_REMOVE,1,nil,e,tp) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
   local g=Duel.SelectTarget(tp,c32083021.filter,tp,LOCATION_REMOVED,LOCATION_REMOVE,1,1,nil,e,tp)
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end

function c32083021.activate(e,tp,eg,ep,ev,re,r,rp)
    local tc=Duel.GetFirstTarget()
    if tc:IsRelateToEffect(e) then
        Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
    end
end