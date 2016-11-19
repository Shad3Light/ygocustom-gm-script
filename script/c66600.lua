--The Winged Dragon of Ra
--Scrited by GameMaster(GM)
function c66600.initial_effect(c)
c:SetUniqueOnField(1,1,66600)
--Summon with 3 Tribute
local e1=Effect.CreateEffect(c)
e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_LIMIT_SUMMON_PROC)
e1:SetCondition(c66600.sumoncon)
e1:SetOperation(c66600.sumonop)
e1:SetValue(SUMMON_TYPE_ADVANCE)
c:RegisterEffect(e1)
local e2=Effect.CreateEffect(c)
e2:SetType(EFFECT_TYPE_SINGLE)
e2:SetCode(EFFECT_LIMIT_SET_PROC)
e2:SetCondition(c66600.setcon)
c:RegisterEffect(e2)
--destroy
local e4=Effect.CreateEffect(c)
e4:SetDescription(aux.Stringid(66600,6))
e4:SetCategory(CATEGORY_DESTROY)
e4:SetType(EFFECT_TYPE_QUICK_O)
e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
e4:SetRange(LOCATION_MZONE)
e4:SetCost(c66600.descost)
e4:SetTarget(c66600.destg)
e4:SetOperation(c66600.desop)
c:RegisterEffect(e4)
--negate
local e5=Effect.CreateEffect(c)
e5:SetDescription(aux.Stringid(66600,7))
e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
e5:SetCode(EVENT_BE_BATTLE_TARGET)
e5:SetCondition(c66600.negcon)
e5:SetOperation(c66600.negop)
c:RegisterEffect(e5)
--Original ATK/DEF
local e6=Effect.CreateEffect(c)
e6:SetType(EFFECT_TYPE_SINGLE)
e6:SetCode(EFFECT_MATERIAL_CHECK)
e6:SetValue(c66600.materialvalcheck)
c:RegisterEffect(e6)
local e7=Effect.CreateEffect(c)
e7:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
e7:SetCode(EVENT_SUMMON_SUCCESS)
e7:SetOperation(c66600.atkdefop)
c:RegisterEffect(e7)
--release limit
local e8=Effect.CreateEffect(c)
e8:SetType(EFFECT_TYPE_SINGLE)
e8:SetCode(EFFECT_UNRELEASABLE_SUM)
e8:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e8:SetRange(LOCATION_MZONE)
e8:SetValue(c66600.recon)
c:RegisterEffect(e8)
local e9=e8:Clone()
e9:SetCondition(c66600.recon2)
e9:SetCode(EFFECT_UNRELEASABLE_NONSUM)
c:RegisterEffect(e9)
--Cannot Switch Controller
local e10=Effect.CreateEffect(c)
e10:SetType(EFFECT_TYPE_SINGLE)
e10:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e10:SetRange(LOCATION_MZONE)
e10:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
c:RegisterEffect(e10)
--Spell cards only last till end phase
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e13:SetProperty(EFFECT_FLAG_REPEAT)
	e13:SetRange(LOCATION_MZONE)
	e13:SetCode(EVENT_PHASE+PHASE_END)
	e13:SetCountLimit(1)
	e13:SetOperation(c66600.atkdefresetop)
	c:RegisterEffect(e13)
--Change Battle Position in Turn that is Normal Summoned
local e18=Effect.CreateEffect(c)
e18:SetDescription(aux.Stringid(66600,0))
e18:SetCategory(CATEGORY_POSITION)
e18:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e18:SetType(EFFECT_TYPE_IGNITION)
e18:SetRange(LOCATION_MZONE)
e18:SetCountLimit(1)
e18:SetCost(c66600.changebattlepositioncost)
e18:SetOperation(c66600.changebattlepositionop)
c:RegisterEffect(e18)
--
local e19=Effect.CreateEffect(c)
e19:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
e19:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
e19:SetCode(EVENT_SUMMON_SUCCESS)
e19:SetOperation(c66600.changebattlepositionop2)
c:RegisterEffect(e19)
--If Special Summoned from Grave: Return it
local e20=Effect.CreateEffect(c)
e20:SetDescription(aux.Stringid(66600,0))
e20:SetCategory(CATEGORY_TOGRAVE)
e20:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
e20:SetRange(LOCATION_MZONE)
e20:SetProperty(EFFECT_FLAG_REPEAT+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
e20:SetCountLimit(1)
e20:SetCode(EVENT_PHASE+PHASE_END)
e20:SetCondition(c66600.specialsumtogravecon)
e20:SetTarget(c66600.specialsumtogravetg)
e20:SetOperation(c66600.specialsumtograveop)
c:RegisterEffect(e20)
--Change Battle Target when Special Summoned in Defense Position
local e21=Effect.CreateEffect(c)
e21:SetDescription(aux.Stringid(66600,0))
e21:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
e21:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
e21:SetCode(EVENT_BE_BATTLE_TARGET)
e21:SetRange(LOCATION_MZONE)
e21:SetCountLimit(1)
e21:SetCondition(c66600.changebattletargetcon)
e21:SetOperation(c66600.changebattletargetop)
c:RegisterEffect(e21)
--Point-to-Point Transfer
local e22=Effect.CreateEffect(c)
e22:SetDescription(aux.Stringid(66600,1))
e22:SetCategory(CATEGORY_ATKCHANGE)
e22:SetType(EFFECT_TYPE_QUICK_O)
e22:SetCode(EVENT_FREE_CHAIN)
e22:SetHintTiming(TIMING_DAMAGE_STEP)
e22:SetRange(LOCATION_MZONE)
e22:SetCost(c66600.pointtopointcost)
e22:SetOperation(c66600.pointtopointop)
c:RegisterEffect(e22)
--Tribute-to-Point Transfer
local e23=Effect.CreateEffect(c)
e23:SetDescription(aux.Stringid(66600,2))
e23:SetCategory(CATEGORY_ATKCHANGE)
e23:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
e23:SetCode(EVENT_FREE_CHAIN)
e23:SetHintTiming(TIMING_DAMAGE_STEP)
e23:SetRange(LOCATION_MZONE)
e23:SetCost(c66600.tributetopointcost)
e23:SetOperation(c66600.tributetopointop)
c:RegisterEffect(e23)
--Instant Attack
local e24=Effect.CreateEffect(c)
e24:SetDescription(aux.Stringid(66600,3))
e24:SetType(EFFECT_TYPE_QUICK_O)
e24:SetCode(EVENT_FREE_CHAIN)
e24:SetHintTiming(TIMING_BATTLE_PHASE)
e24:SetRange(LOCATION_MZONE)
e24:SetCountLimit(1)
e24:SetCost(c66600.iacost)
e24:SetOperation(c66600.iaop)
c:RegisterEffect(e24)
--"De-Fusion" Point-to-Point Transfer reverse
local e25=Effect.CreateEffect(c)
e25:SetDescription(aux.Stringid(66600,4))
e25:SetCategory(CATEGORY_RECOVER+CATEGORY_ATKCHANGE)
e25:SetType(EFFECT_TYPE_QUICK_O)
e25:SetCode(EVENT_FREE_CHAIN)
e25:SetHintTiming(TIMING_DAMAGE_STEP)
e25:SetRange(LOCATION_MZONE)
e25:SetCost(c66600.defusioncost)
e25:SetOperation(c66600.defusionop)
c:RegisterEffect(e25)
--Egyptian God Phoenix
local e26=Effect.CreateEffect(c)
e26:SetDescription(aux.Stringid(66600,5))
e26:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
e26:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
e26:SetCode(EVENT_SPSUMMON_SUCCESS)
e26:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
e26:SetCondition(c66600.egpcon)
e26:SetOperation(c66600.egpop)
c:RegisterEffect(e26)
--Summon Cannot be Negated
local e27=Effect.CreateEffect(c)
e27:SetType(EFFECT_TYPE_SINGLE)
e27:SetCode(EFFECT_CANNOT_DISABLE_SUMMON)
e27:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
c:RegisterEffect(e27)
--cannot be target
local e28=Effect.CreateEffect(c)
e28:SetType(EFFECT_TYPE_SINGLE)
e28:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
e28:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e28:SetRange(LOCATION_MZONE)
e28:SetValue(c66600.tgfilter)
c:RegisterEffect(e28)
--immune effect
local e29=Effect.CreateEffect(c)
e29:SetType(EFFECT_TYPE_SINGLE)
e29:SetCode(EFFECT_IMMUNE_EFFECT)
e29:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e29:SetRange(LOCATION_MZONE)
e29:SetValue(c66600.efilter)
c:RegisterEffect(e29)
-- Cannot Disable effect
local e30=Effect.CreateEffect(c)
e30:SetType(EFFECT_TYPE_SINGLE)
e30:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e30:SetCode(EFFECT_CANNOT_DISABLE)
e30:SetRange(LOCATION_MZONE)
c:RegisterEffect(e30)
end


function c66600.setcon(e,c)
	if not c then return true end
	return false
end
function c66600.materialvalcheck(e,c)
local g=c:GetMaterial()
Original_ATK=g:GetSum(Card.GetAttack)
Original_DEF=g:GetSum(Card.GetDefense)
end
function c66600.atkdefop(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
if c:GetMaterialCount()==0 then return end
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_SET_BASE_ATTACK)
e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e1:SetRange(LOCATION_MZONE)
e1:SetValue(Original_ATK)
e1:SetReset(RESET_EVENT+0x1fe0000)
c:RegisterEffect(e1)
local e2=e1:Clone()
e2:SetCode(EFFECT_SET_BASE_DEFENSE)
e2:SetValue(Original_DEF)
c:RegisterEffect(e2)
end
function c66600.sumoncon(e,c)
if c==nil then return true end
return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-3 and Duel.GetTributeCount(c)>=3
end
function c66600.sumonop(e,tp,eg,ep,ev,re,r,rp,c)
local g=Duel.SelectTribute(tp,c,3,3)
c:SetMaterial(g)
Duel.Release(g,REASON_SUMMON+REASON_MATERIAL)
end

function c66600.tgg(c,card)
	return c:GetCardTarget() and c:GetCardTarget():IsContains(card)
end
function c66600.atkdefresetop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetValue(c:GetBaseAttack())
	e1:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
	e2:SetValue(c:GetBaseDefense())
	e2:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e2)
	local eqg=c:GetEquipGroup()
	local tgg=Duel.GetMatchingGroup(c66600.tgg,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil,c)
	eqg:Merge(tgg)
	if eqg:GetCount()>0 then
		Duel.Destroy(eqg,REASON_EFFECT)
	end
end
function c66600.changebattlepositioncost(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return e:GetHandler():GetFlagEffect(66600)==1 and bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_NORMAL)==SUMMON_TYPE_NORMAL 
and e:GetHandler():GetAttackAnnouncedCount()==0 end
end
function c66600.changebattlepositionop(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
Duel.ChangePosition(c,POS_FACEUP_DEFENSE,0,POS_FACEUP_ATTACK,0)
end
function c66600.changebattlepositionop2(e,tp,eg,ep,ev,re,r,rp)
e:GetHandler():RegisterFlagEffect(66600,RESET_EVENT+0xfc0000+RESET_PHASE+PHASE_END,0,1)
end
function c66600.specialsumtogravecon(e,tp,eg,ep,ev,re,r,rp)
return bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL and e:GetHandler():GetPreviousLocation()==LOCATION_GRAVE
end
function c66600.specialsumtogravetg(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,e:GetHandler(),1,0,0)
end
function c66600.specialsumtograveop(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
if c:IsRelateToEffect(e) and c:IsFaceup() then
Duel.SendtoGrave(c,REASON_EFFECT)
end
end
function c66600.changebattletargetcon(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
local bt=Duel.GetAttackTarget()
return c~=bt and bt:IsControler(tp) and bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL and e:GetHandler():IsDefensePos()
end
function c66600.changebattletargetop(e,tp,eg,ep,ev,re,r,rp)
Duel.ChangeAttackTarget(e:GetHandler())
end
function c66600.pointtopointcost(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.GetFlagEffect(tp,10000014)==0 and Duel.GetLP(tp)>1 
end
Duel.RegisterFlagEffect(tp,10000012,RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN,0,1)
end
function c66600.pointtopointop(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
local LP=Duel.GetLP(tp)
Duel.SetLP(tp,1)
ATK=LP-1
DEF=LP-1
if c:IsFaceup() and c:IsRelateToEffect(e) then
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e1:SetRange(LOCATION_MZONE)
e1:SetCode(EFFECT_SET_BASE_ATTACK)
e1:SetValue(ATK+c:GetAttack())
e1:SetReset(RESET_EVENT+0x1ff0000)
c:RegisterEffect(e1)
local e2=e1:Clone()
e2:SetCode(EFFECT_SET_BASE_DEFENSE)
e2:SetValue(DEF+c:GetDefense())
c:RegisterEffect(e2)
end
end
function c66600.tributetopointcost(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.CheckReleaseGroup(tp,nil,1,e:GetHandler()) 
end
end
function c66600.tributetopointop(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
local g=Duel.GetMatchingGroup(Card.IsReleaseable,tp,LOCATION_MZONE,0,e:GetHandler())
local ATK=g:GetSum(Card.GetAttack)
local DEF=g:GetSum(Card.GetDefense)
Duel.Release(g,REASON_COST)
if c:IsFaceup() and c:IsRelateToEffect(e) then
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_SET_BASE_ATTACK)
e1:SetValue(ATK+c:GetAttack())
e1:SetReset(RESET_EVENT+0x1ff0000)
c:RegisterEffect(e1)
local e2=e1:Clone()
e2:SetCode(EFFECT_SET_BASE_DEFENSE)
e2:SetValue(DEF+c:GetDefense())
c:RegisterEffect(e2)
end
end
function c66600.costfilter(c)
return c:IsCode(95286165) and c:IsAbleToGraveAsCost()
end
function c66600.defusioncost(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.IsExistingMatchingCard(c66600.costfilter,tp,LOCATION_HAND+LOCATION_SZONE,0,1,e:GetHandler()) and Duel.GetFlagEffect(tp,10000012)==1 
and e:GetHandler():GetAttack()>0 end
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
local g=Duel.SelectMatchingCard(tp,c66600.costfilter,tp,LOCATION_HAND+LOCATION_SZONE,0,1,1,nil)
Duel.SendtoGrave(g,REASON_COST)
end
function c66600.defusionop(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
if c:IsFaceup() and c:IsRelateToEffect(e) then
local ATK=c:GetAttack()
local DEF=c:GetDEFENSE()
Duel.Recover(tp,ATK,REASON_EFFECT)
local e1=Effect.CreateEffect(e:GetHandler())
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetReset(RESET_EVENT+0x1fe0000)
e1:SetCode(EFFECT_SET_BASE_ATTACK)
e1:SetValue(-ATK)
c:RegisterEffect(e1)
local e2=e1:Clone()
e2:SetCode(EFFECT_SET_BASE_DEFENSE)
e2:SetValue(-DEF)
c:RegisterEffect(e2)
end
if Duel.GetAttacker()==e:GetHandler() then
Duel.NegateAttack()
end
end
function c66600.iacost(e,tp,eg,ep,ev,re,r,rp,chk)
local c=e:GetHandler()
if chk==0 then return e:GetHandler():GetAttackAnnouncedCount()==0 and Duel.GetFlagEffect(tp,10000012)==1 and Duel.GetFlagEffect(tp,10000013)==0 
and bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL and e:GetHandler():IsPreviousLocation(LOCATION_GRAVE) end
Duel.RegisterFlagEffect(tp,10000013,RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN,0,1)
end
function c66600.iaop(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_EXTRA_ATTACK)
e1:SetReset(RESET_EVENT+0x1ff0000)
e1:SetValue(99)
c:RegisterEffect(e1)
local e2=e1:Clone()
e2:SetCode(EFFECT_CANNOT_ATTACK)
e2:SetCondition(c66600.atkcon)
c:RegisterEffect(e2)
local e3=Effect.CreateEffect(c)
e3:SetType(EFFECT_TYPE_SINGLE)
e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e3:SetRange(LOCATION_MZONE)
e3:SetCode(EFFECT_IMMUNE_EFFECT)
e3:SetReset(RESET_EVENT+0x1ff0000)
e3:SetValue(c66600.unaffectedval)
c:RegisterEffect(e3)
if Duel.GetTurnPlayer()~=tp then
local e4=Effect.CreateEffect(c)
e4:SetType(EFFECT_TYPE_SINGLE)
e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e4:SetRange(LOCATION_MZONE)
e4:SetCode(EFFECT_CANNOT_TRIGGER)
e4:SetTarget(c66600.iatrig)
e4:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END)
c:RegisterEffect(e4)
local e5=Effect.CreateEffect(c)
e5:SetType(EFFECT_TYPE_FIELD)
e5:SetRange(LOCATION_MZONE)
e5:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
e5:SetTargetRange(LOCATION_MZONE,0)
e5:SetTarget(c66600.notattackannouce)
e5:SetReset(RESET_EVENT+0x1ff0000)
c:RegisterEffect(e5)
local e6=Effect.CreateEffect(c)
e6:SetType(EFFECT_TYPE_FIELD)
e6:SetCode(EFFECT_CANNOT_M2)
e6:SetRange(LOCATION_MZONE)
e6:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
e6:SetTargetRange(1,0)
e6:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN)
Duel.RegisterEffect(e6,tp)
if Duel.GetTurnPlayer()~=tp and Duel.GetCurrentPhase()==PHASE_DRAW or Duel.GetTurnPlayer()~=tp and Duel.GetCurrentPhase()==PHASE_STANDBY then
Duel.SkipPhase(1-tp,PHASE_DRAW,RESET_PHASE+PHASE_END+RESET_OPPO_TURN,2)
Duel.SkipPhase(1-tp,PHASE_STANDBY,RESET_PHASE+PHASE_END,1)
Duel.SkipPhase(1-tp,PHASE_MAIN1,RESET_PHASE+PHASE_END,1)
Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_END,1)
Duel.SkipPhase(1-tp,PHASE_MAIN2,RESET_PHASE+PHASE_END,1)
Duel.SkipPhase(tp,PHASE_DRAW,RESET_PHASE+PHASE_END,1)
Duel.SkipPhase(tp,PHASE_STANDBY,RESET_PHASE+PHASE_END,1)
Duel.SkipPhase(tp,PHASE_MAIN1,RESET_PHASE+PHASE_END,1)
end
if Duel.GetTurnPlayer()~=tp and Duel.GetCurrentPhase()==PHASE_MAIN1 then
Duel.SkipPhase(1-tp,PHASE_DRAW,RESET_PHASE+PHASE_END+RESET_OPPO_TURN,2)
Duel.SkipPhase(1-tp,PHASE_STANDBY,RESET_PHASE+PHASE_END+RESET_OPPO_TURN,2)
Duel.SkipPhase(1-tp,PHASE_MAIN1,RESET_PHASE+PHASE_END,1)
Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_END,1)
Duel.SkipPhase(1-tp,PHASE_MAIN2,RESET_PHASE+PHASE_END,1)
Duel.SkipPhase(tp,PHASE_DRAW,RESET_PHASE+PHASE_END,1)
Duel.SkipPhase(tp,PHASE_STANDBY,RESET_PHASE+PHASE_END,1)
Duel.SkipPhase(tp,PHASE_MAIN1,RESET_PHASE+PHASE_END,1)
end
if Duel.GetTurnPlayer()~=tp and Duel.GetCurrentPhase()==PHASE_BATTLE then
Duel.SkipPhase(1-tp,PHASE_DRAW,RESET_PHASE+PHASE_END+RESET_OPPO_TURN,2)
Duel.SkipPhase(1-tp,PHASE_STANDBY,RESET_PHASE+PHASE_END+RESET_OPPO_TURN,2)
Duel.SkipPhase(1-tp,PHASE_MAIN1,RESET_PHASE+PHASE_END+RESET_OPPO_TURN,2)
Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_END,1)
Duel.SkipPhase(1-tp,PHASE_MAIN2,RESET_PHASE+PHASE_END,1)
Duel.SkipPhase(tp,PHASE_DRAW,RESET_PHASE+PHASE_END,1)
Duel.SkipPhase(tp,PHASE_STANDBY,RESET_PHASE+PHASE_END,1)
Duel.SkipPhase(tp,PHASE_MAIN1,RESET_PHASE+PHASE_END,1)
end
if Duel.GetTurnPlayer()~=tp and Duel.GetCurrentPhase()==PHASE_MAIN2 then
Duel.SkipPhase(1-tp,PHASE_DRAW,RESET_PHASE+PHASE_END+RESET_OPPO_TURN,2)
Duel.SkipPhase(1-tp,PHASE_STANDBY,RESET_PHASE+PHASE_END+RESET_OPPO_TURN,2)
Duel.SkipPhase(1-tp,PHASE_MAIN1,RESET_PHASE+PHASE_END+RESET_OPPO_TURN,2)
Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_END+RESET_OPPO_TURN,2)
Duel.SkipPhase(1-tp,PHASE_MAIN2,RESET_PHASE+PHASE_END,1)
Duel.SkipPhase(tp,PHASE_DRAW,RESET_PHASE+PHASE_END,1)
Duel.SkipPhase(tp,PHASE_STANDBY,RESET_PHASE+PHASE_END,1)
Duel.SkipPhase(tp,PHASE_MAIN1,RESET_PHASE+PHASE_END,1)
end
end
end
function c66600.atkcon(e)
return e:GetHandler():IsDirectAttacked()
end
function c66600.unaffectedval(e,te)
return te:GetOwner()~=e:GetOwner()
end
function c66600.iatrig(e,c)
return e:GetHandler()
end
function c66600.notattackannouce(e,c)
return c~=e:GetHandler()
end
function c66600.egpcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_GRAVE)
end
function c66600.egpop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() then
		local e0=Effect.CreateEffect(c)
		e0:SetType(EFFECT_TYPE_SINGLE)
		e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE)
		e0:SetReset(RESET_EVENT+0x1fe0000)
		e0:SetCode(EFFECT_CHANGE_CODE)
		e0:SetValue(511000237)
		c:RegisterEffect(e0)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
		e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_INDESTRUCTABLE)
		e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e2:SetValue(1)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetDescription(aux.Stringid(66600,6))
		e3:SetCategory(CATEGORY_DESTROY)
		e3:SetType(EFFECT_TYPE_QUICK_O)
		e3:SetCode(EVENT_FREE_CHAIN)
		e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_IGNORE_IMMUNE)
		e3:SetRange(LOCATION_MZONE)
		e3:SetCost(c66600.descost)
		e3:SetTarget(c66600.destg)
		e3:SetOperation(c66600.desop)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e3)
	end
end
function c66600.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c66600.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDestructable,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c66600.desop(e,tp,eg,ep,ev,re,r,rp)
local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
	local ct=Duel.SendtoGrave(g,REASON_EFFECT+REASON_DESTROY)
end


function c66600.efilter(e,te)
	return te:IsActiveType(TYPE_EFFECT) and te:GetOwner()~=e:GetOwner()
end
function c66600.tgfilter(e,re)
	if not re or not re:IsActiveType(TYPE_SPELL+TYPE_TRAP) then return false end
	return re:IsHasCategory(CATEGORY_TOHAND+CATEGORY_DESTROY+CATEGORY_REMOVE+CATEGORY_TODECK+CATEGORY_RELEASE+CATEGORY_TOGRAVE)
end
function c66600.recon(e,c)
	return c:GetControler()~=e:GetHandler():GetControler()
end
function c66600.recon2(e)
	return Duel.GetTurnPlayer()~=e:GetOwnerPlayer()
end
function c66600.negcon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	return a:IsControler(1-tp) and a:IsFaceup() and a:IsAttribute(ATTRIBUTE_DEVINE) and a:IsRace(RACE_DEVINE) 
		and not a:IsCode(10000011) and not a:IsCode(21208154)
end
function c66600.negop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end