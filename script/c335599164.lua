--One who hunts souls (DOR)
--scripted by GameMaster (GM)
function c335599164.initial_effect(c)
	--Banish monsters if destroyed in battle
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(335599164,1))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLED)
	e1:SetCondition(c335599164.rmcon)
	e1:SetTarget(c335599164.rmtg)
	e1:SetOperation(c335599164.rmop)
	c:RegisterEffect(e1)
end

function c335599164.rmcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	e:SetLabelObject(bc)
	return bc and bc:IsStatus(STATUS_BATTLE_DESTROYED) and c:IsStatus(STATUS_OPPO_BATTLE)
end
function c335599164.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,e:GetLabelObject(),1,0,0)
end
function c335599164.rmop(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetLabelObject()
	if bc:IsRelateToBattle() and bc:IsAbleToRemove() then
		Duel.Remove(bc,POS_FACEUP,REASON_EFFECT)
	end
end