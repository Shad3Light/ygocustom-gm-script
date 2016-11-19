--ShatChi, The Toon Chewing Gum Seal   
function c33569999.initial_effect(c)
    c:EnableReviveLimit()
    c:SetUniqueOnField(1,1,33569999)
    --special summon
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(33569999,0))
    e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
    e1:SetRange(LOCATION_EXTRA)
    e1:SetProperty(EFFECT_FLAG_CHAIN_UNIQUE)
    e1:SetCode(EVENT_CUSTOM+33579900)
    e1:SetCondition(c33569999.spcon)
    e1:SetTarget(c33569999.sptg)
    e1:SetOperation(c33569999.spop)
    c:RegisterEffect(e1)
	--attach opponents monster
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(19310321,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c33569999.mttarget)
	e2:SetOperation(c33569999.mtoperation)
	c:RegisterEffect(e2)
	--Special Summon
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_FIELD)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c33569999.sscon)
	e3:SetOperation(c33569999.ssop)
	c:RegisterEffect(e3)
	--can attack again if atk is negated
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_ATTACK_DISABLED)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTarget(c33569999.tgatkneg)
	e4:SetOperation(c33569999.opatkneg)
	c:RegisterEffect(e4)
end

function c33569999.tgatkneg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:GetFirst():IsType(TYPE_TOON) and eg:GetFirst():IsControler(tp) end
end
function c33569999.opatkneg(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_BP_TWICE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	if Duel.GetTurnPlayer()~=tp and Duel.GetCurrentPhase()==PHASE_BATTLE then
		e1:SetLabel(Duel.GetTurnCount())
		e1:SetCondition(c33569999.bpcon)
		e1:SetReset(RESET_PHASE+PHASE_BATTLE+RESET_OPPO_TURN,2)
	else
		e1:SetReset(RESET_PHASE+PHASE_BATTLE+RESET_OPPO_TURN,1)
	end
	Duel.RegisterEffect(e1,tp)
end
function c33569999.bpcon(e)
	return Duel.GetTurnCount()~=e:GetLabel()
end

function c33569999.sscon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer() and e:GetHandler():GetOverlayCount()>0
end
function c33569999.ssop(e,tp,eg,ep,ev,re,r,rp)
	local n=Duel.GetLocationCount(1-tp,LOCATION_MZONE)
	if n>0 then
		local g=e:GetHandler():GetOverlayGroup():Select(tp,n,n,nil)
		Duel.SpecialSummon(g,nil,1-tp,1-tp,true,false,POS_FACEUP)
		local tc=g:GetFirst()
	if tc then 
	local atk=tc:GetAttack()	
	local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(0)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		Duel.HintSelection(g)
		local atk=tc:GetAttack()
		local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
			local atk=tc:GetTextAttack()
			if atk<=0 then return end
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_UPDATE_ATTACK)
			e2:SetValue(atk)
			c:RegisterEffect(e2)
			end
		end
		Duel.SendtoGrave(e:GetHandler():GetOverlayGroup(),REASON_EFFECT)
	end
end

function c33569999.mttarget(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return e:GetHandler()
		and Duel.IsExistingTarget(Card.IsType,tp,0,LOCATION_MZONE,1,nil,TYPE_MONSTER) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,Card.IsType,tp,0,LOCATION_MZONE,1,1,nil,TYPE_MONSTER)
end
function c33569999.mtoperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	local atk=tc:GetAttack()
	if atk<=0 then return end
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) then
		Duel.Overlay(c,tc)
	end
end
	
function c33569999.spcon(e,tp,eg,ep,ev,re,r,rp)
    return ep==tp
end

function c33569999.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
        and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,true,false) end
    if e:GetHandler():IsLocation(LOCATION_DECK+LOCATION_HAND+LOCATION_GRAVE) then
        Duel.ConfirmCards(1-tp,e:GetHandler())
    end
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end

function c33569999.spop(e,tp,eg,ep,ev,re,r,rp)
    if e:GetHandler():IsRelateToEffect(e) and Duel.SpecialSummon(e:GetHandler(),0,tp,tp,true,false,POS_FACEUP)>0 then
        e:GetHandler():CompleteProcedure()
    end
end