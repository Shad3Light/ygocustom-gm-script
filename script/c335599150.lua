--Hourglass of LIfe (DOR)
--scripted by GameMaster (GM)
function c335599150.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(335599150,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c335599150.condition)
	e1:SetCost(c335599150.cost)
	e1:SetOperation(c335599150.operation)
	c:RegisterEffect(e1)
end

function c335599150.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c335599150.condition(e,tp,eg,ep,ev,re,r,rp)
 return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
end

function c335599150.filter(c,e,tp)
    return c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c335599150.target(e,tp,eg,ep,ev,re,r,rp,chk)
    local loc=Duel.GetLocationCount(tp,LOCATION_MZONE)
    if chk==0 then return loc>0 and Duel.IsExistingMatchingCard(c335599150.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,e:GetHandler(),e,tp) end
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,loc,tp,LOCATION_GRAVE)
end
function c335599150.operation(e,tp,eg,ep,ev,re,r,rp)
    local loc=Duel.GetLocationCount(tp,LOCATION_MZONE)
    if loc<1 then return end
    if loc>4 then loc=4 end
    local g=Duel.GetMatchingGroup(c335599150.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,e:GetHandler(),e,tp)
    local tg=Group.CreateGroup()
    while g:GetCount()>0 and tg:GetCount()<loc do
        local sg=g:GetMaxGroup(Card.GetAttack):Select(tp,loc-tg:GetCount(),loc-tg:GetCount(),nil)
        tg:Merge(sg)
        g:Sub(sg)
    end
    Duel.HintSelection(tg)
    Duel.SpecialSummon(tg,0,tp,tp,false,false,POS_FACEUP)
end