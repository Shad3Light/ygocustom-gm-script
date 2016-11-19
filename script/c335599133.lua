--Ice Strike!
function c335599133.initial_effect(c)
    --Activate
    local e1=Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_HANDES)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetTarget(c335599133.target)
    e1:SetOperation(c335599133.activate)
    c:RegisterEffect(e1)
  end

function c335599133.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 end
    Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,1-tp,2)
    Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(2000)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,2000)
end

function c335599133.activate(e,tp,eg,ep,ev,re,r,rp)
    local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
    local g=Duel.GetFieldGroup(p,LOCATION_HAND,0)
    local c=e:GetHandler()
    if g:GetCount()>0 then
        local sg=g:RandomSelect(p,1)
        Duel.SendtoGrave(sg,REASON_EFFECT+REASON_DISCARD)
        g:RemoveCard(sg:GetFirst())
        Duel.BreakEffect()
        if g:GetCount()>0 then
            Duel.Hint(HINT_SELECTMSG,p,HINTMSG_DISCARD)
            sg=g:Select(1-p,1,1,nil)
            Duel.SendtoGrave(sg,REASON_EFFECT+REASON_DISCARD)
            Duel.BreakEffect()
        end
    end
    Duel.Damage(p,d,REASON_EFFECT)
    if c:IsRelateToEffect(e) then
        c:CancelToGrave()
        Duel.SendtoDeck(c,nil,2,REASON_EFFECT)
    end
end