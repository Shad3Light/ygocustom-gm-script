--Myotismon
function c33559983.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetOperation(c33559983.spr)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(33559983,4))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetCondition(c33559983.spcon)
	e2:SetTarget(c33559983.sptg)
	e2:SetOperation(c33559983.spop)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
	--to grave
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(33559983,0))
	e3:SetCategory(CATEGORY_TOGRAVE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_BATTLE_DAMAGE)
	e3:SetCondition(c33559983.tgcon)
	e3:SetTarget(c33559983.tgtg)
	e3:SetOperation(c33559983.tgop)
	c:RegisterEffect(e3)
	--reborn preparation
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(33559983,0))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_BATTLE_DESTROYED)
	e4:SetCondition(c33559983.spcon2)
	e4:SetOperation(c33559983.spop2)
	c:RegisterEffect(e4)
	--reborn
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e5:SetRange(LOCATION_GRAVE)
	e5:SetCountLimit(1)
	e5:SetCondition(c33559983.spcon3)
	e5:SetOperation(c33559983.spop3)
	c:RegisterEffect(e5)
end
function c33559983.spr(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if bit.band(r,0x41)~=0x41 or rp==tp or c:GetPreviousControler()~=tp then return end
	if Duel.GetTurnPlayer()==tp and Duel.GetCurrentPhase()==PHASE_STANDBY then
		e:SetLabel(Duel.GetTurnCount())
		c:RegisterFlagEffect(33559983,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN,0,2)
	else
		e:SetLabel(0)
		c:RegisterFlagEffect(33559983,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN,0,1)
	end
end
function c33559983.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return e:GetLabelObject():GetLabel()~=Duel.GetTurnCount() and tp==Duel.GetTurnPlayer() and c:GetFlagEffect(33559983)>0
end
function c33559983.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local c=e:GetHandler()
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
	c:ResetFlagEffect(33559983)
end
function c33559983.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c33559983.tgcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c33559983.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(33559983,5))
	local op=Duel.SelectOption(tp,aux.Stringid(33559983,1),aux.Stringid(33559983,2),aux.Stringid(33559983,3))
	e:SetLabel(op)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,1-tp,LOCATION_DECK)
end
function c33559983.tgfilter(c,ty)
	return c:IsType(ty) and c:IsAbleToGrave()
end
function c33559983.tgop(e,tp,eg,ep,ev,re,r,rp)
	local g=nil
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TOGRAVE)
	if e:GetLabel()==0 then g=Duel.SelectMatchingCard(1-tp,c33559983.tgfilter,1-tp,LOCATION_DECK,0,1,1,nil,TYPE_MONSTER)
	elseif e:GetLabel()==1 then g=Duel.SelectMatchingCard(1-tp,c33559983.tgfilter,1-tp,LOCATION_DECK,0,1,1,nil,TYPE_SPELL)
	else g=Duel.SelectMatchingCard(1-tp,c33559983.tgfilter,1-tp,LOCATION_DECK,0,1,1,nil,TYPE_TRAP) end
	Duel.SendtoGrave(g,REASON_EFFECT)
end
function c33559983.spcon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
end
function c33559983.spop2(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(33559983,RESET_EVENT+0x1fe0000,0,0)
end
function c33559983.spcon3(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer() and e:GetHandler():GetFlagEffect(33559983)>0
end
function c33559983.spop3(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	c:ResetFlagEffect(33559983)
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
end
