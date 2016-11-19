--Felix the toon cat, and his magic bag
--scripted by GameMaster (GM)
function c33569972.initial_effect(c)
	c:SetUniqueOnField(1,0,33569972)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCondition(c33569972.condtion)
	c:RegisterEffect(e1)
	--Magic bag
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(33569972,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1)
	e2:SetOperation(c33569972.op)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--summon hoppy kangaroo token
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(33569972,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1,33569972)
	e3:SetCondition(c33569972.spcon)
	e3:SetTarget(c33569972.sptg)
	e3:SetOperation(c33569972.spop)
	c:RegisterEffect(e3)
end

function c33569972.toonfilter1(c)
	return c:IsFaceup() and c:IsCode(15259703)
end

function c33569972.condtion(e,tp)
    return  Duel.IsExistingMatchingCard(c33569972.toonfilter1,tp,LOCATION_ONFIELD,0,1,nil)
end

function c33569972.spfilter(c)
return c:IsCode(22222218)
end

function c33569972.spcon(e,tp,eg,ep,ev,re,r,rp)
if Duel.IsExistingMatchingCard(c33569972.spfilter,tp,LOCATION_MZONE,0,1,nil) then return false
else return true end
end
function c33569972.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1
and Duel.IsPlayerCanSpecialSummonMonster(tp,22222218,0,0x4011,2000,0,2,RACE_SPELLCASTER,ATTRIBUTE_DARK) end
Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c33569972.spop(e,tp,eg,ep,ev,re,r,rp)
if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
if Duel.IsPlayerCanSpecialSummonMonster(tp,22222218,0,0x4011,2000,0,2,RACE_SPELLCASTER,ATTRIBUTE_DARK) then
local token=Duel.CreateToken(tp,22222218)
if Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP) then
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
			e2:SetCode(EVENT_PHASE+PHASE_BATTLE)
			e2:SetRange(LOCATION_MZONE)
			e2:SetCountLimit(1)
			e2:SetTarget(c33569972.destg)
			e2:SetOperation(c33569972.desop)
			e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
			token:RegisterEffect(e2,true)
			end
		Duel.SpecialSummonComplete()
	end
end

function c33569972.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c33569972.desop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.Destroy(e:GetHandler(),REASON_EFFECT)
	end
end


function c33569972.op(e,tp,eg,ep,ev,re,r,rp,chk)
if Duel.GetFlagEffect(tp,33569972)==0 then
		Duel.RegisterFlagEffect(tp,33569972,0,0,0)
		local c=e:GetHandler()
		Duel.Hint(HINT_CARD,0,33569972)
		Duel.ConfirmCards(tp,c)
		local sg=Duel.GetMatchingGroup(Card.IsCode,tp,0xff,0xff,nil,33569972)
		Duel.SendtoHand(sg,nil,2,REASON_EFFECT)
		while Duel.SelectYesNo(tp,aux.Stringid(999,0)) do
			Duel.Hint(HINT_SELECTMSG,tp,0)
			local ac=Duel.AnnounceCard(tp)
			local token=Duel.CreateToken(tp,ac)
			if token:IsType(TYPE_PENDULUM) then
				Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(76922029,0))
				local op=Duel.SelectOption(tp,aux.Stringid(999,1),aux.Stringid(999,2))
				if op==0 then
					Duel.SendtoHand(token,tp,2,REASON_EFFECT)
				else
					Duel.PSendtoExtra(token,tp,REASON_EFFECT)
				end
			else
				Duel.SendtoHand(token,tp,2,REASON_EFFECT)
			end
		end
		end
end
