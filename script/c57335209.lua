--Red-Eyes Darkflare Dragon
function c57335209.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,88264978,30079770,true,true)
c57335209.material_setcode=0x3b
	--Unaffected by Opponent Card Effects
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetValue(c57335209.unval)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(57335209,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(2)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c57335209.sptg)
	e2:SetOperation(c57335209.spop)
	c:RegisterEffect(e2)
	--atk
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE+LOCATION_GRAVE)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetValue(c57335209.atkval)
	c:RegisterEffect(e3)
		local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e4:SetValue(1)
	c:RegisterEffect(e4)
end
function c57335209.unval(e,te)
	return te:GetHandlerPlayer()~=e:GetHandlerPlayer()
end
	function c57335209.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c57335209.filter,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE+LOCATION_HAND)
end
function c57335209.filter(c,e,tp)
    return c:IsRace(RACE_DRAGON) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c57335209.spop(e,tp,eg,ep,ev,re,r,rp)
    if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
    local g=Duel.SelectMatchingCard(tp,c57335209.filter,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,1,nil,e,tp)
    if g:GetCount()>0 and not g:GetFirst():IsHasEffect(EFFECT_NECRO_VALLEY) then
        Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
    end
end
function c57335209.val(e,c) 
return Duel.GetMatchingGroupCount(Card.IsRace,e:GetHandlerPlayer(),LOCATION_FIELD+LOCATION_GRAVE,LOCATION_FIELD+LOCATION_GRAVE,nil,RACE_DRAGON)*300
end
function c57335209.atkfilter(c)
    return c:IsRace(RACE_DRAGON) and c:IsFaceup()
end
function c57335209.atkval(e,c)
    return Duel.GetMatchingGroupCount(c57335209.atkfilter,c:GetControler(),LOCATION_MZONE+LOCATION_GRAVE,0,c)*300
end