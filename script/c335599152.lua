--Toad Master (DOR)
--scripted by GameMaster (GM)
function c335599152.initial_effect(c)
	--Summon frog the jam when flipped
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(335599152,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_FLIP)
	e1:SetCountLimit(1)
	e1:SetTarget(c335599152.sptg)
	e1:SetOperation(c335599152.spop)
	c:RegisterEffect(e1)
end
function c335599152.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c335599152.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,33569934,0,0x4011,200,200,1,RACE_MACHINE,ATTRIBUTE_EARTH) then return end
	local token=Duel.CreateToken(tp,33569934)
	Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
end

