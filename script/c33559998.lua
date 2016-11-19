--Shinato's Ark (Anime)
function c33559998.initial_effect(c)
c:SetUniqueOnField(1,0,33559998)
aux.EnablePendulumAttribute(c,false)
--Activate
local e0=Effect.CreateEffect(c)
e0:SetType(EFFECT_TYPE_ACTIVATE)
e0:SetCode(EVENT_FREE_CHAIN)
e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
e0:SetCost(c33559998.cost)
e0:SetCountLimit(1,33559998+EFFECT_COUNT_CODE_DUEL)
c:RegisterEffect(e0)
--immune
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_IMMUNE_EFFECT)
e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e1:SetRange(LOCATION_PZONE+LOCATION_MZONE)
e1:SetValue(c33559998.efilter)
c:RegisterEffect(e1)
-- Cannot Banish (Loyalty to controller)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_CANNOT_REMOVE)
	e2:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e2)
	--attach as material
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetRange(LOCATION_PZONE+LOCATION_MZONE)
	e3:SetOperation(c33559998.operation)
	c:RegisterEffect(e3)
	--special summon materials
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(60365591,1))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCountLimit(1)
	e4:SetCode(EVENT_ATTACK_ANNOUNCE)
	e4:SetRange(LOCATION_PZONE+LOCATION_MZONE)
	e4:SetCondition(c33559998.smcondition)
	e4:SetTarget(c33559998.smtarget)
	e4:SetOperation(c33559998.smoperation)
	c:RegisterEffect(e4)
	--Remove Ark Monsters
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(60365591,2))
	e5:SetCategory(CATEGORY_RECOVER)
	e5:SetType(EFFECT_TYPE_QUICK_O)
	e5:SetCountLimit(1)
	e5:SetCode(EVENT_FREE_CHAIN)
	e5:SetRange(LOCATION_PZONE+LOCATION_MZONE)
	e5:SetTarget(c33559998.lptarget)
	e5:SetOperation(c33559998.lpoperation)
	c:RegisterEffect(e5)
	--special summon Shinato
	local e6=Effect.CreateEffect(c)
	e6:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_DELAY)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCode(EVENT_BATTLE_DESTROYED)
	e6:SetTarget(c33559998.shtarget)
	e6:SetOperation(c33559998.shoperation)
	c:RegisterEffect(e6)
	--special summon Ark
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(60365591,0))
	e7:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e7:SetType(EFFECT_TYPE_QUICK_O)
	e7:SetCode(EVENT_FREE_CHAIN)
	e7:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e7:SetRange(LOCATION_PZONE)
	e7:SetCondition(c33559998.arkcondition)
	e7:SetOperation(c33559998.arkoperation)
	c:RegisterEffect(e7)
	-- Cannot Disable effect
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e8:SetCode(EFFECT_CANNOT_DISABLE)
	e8:SetRange(0xff)
	c:RegisterEffect(e8)
	--cannot be target
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_SINGLE)
	e9:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e9:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e9:SetRange(LOCATION_PZONE+LOCATION_MZONE)
	e9:SetValue(c33559998.tgfilter)
	c:RegisterEffect(e9)
	--immune effect
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_SINGLE)
	e10:SetCode(EFFECT_IMMUNE_EFFECT)
	e10:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e10:SetRange(LOCATION_PZONE+LOCATION_MZONE)
	e10:SetValue(c33559998.efilter1)
	c:RegisterEffect(e10)
	--indes
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_SINGLE)
	e11:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e11:SetRange(LOCATION_PZONE+LOCATION_MZONE)
	e11:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e11:SetValue(1)
	c:RegisterEffect(e11)
	--release limit
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_SINGLE)
	e12:SetCode(EFFECT_UNRELEASABLE_SUM)
	e12:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e12:SetRange(LOCATION_MZONE)
	e12:SetValue(c33559998.recon)
	c:RegisterEffect(e12)
	local e13=e12:Clone()
	e13:SetCondition(c33559998.recon2)
	e13:SetCode(EFFECT_UNRELEASABLE_NONSUM)
	c:RegisterEffect(e13)
	--cannot summon from hand
	local e14=Effect.CreateEffect(c)
	e14:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SINGLE_RANGE)
	e14:SetType(EFFECT_TYPE_SINGLE)
	e14:SetRange(LOCATION_HAND)
	e14:SetCode(EFFECT_CANNOT_SUMMON)
	c:RegisterEffect(e14)
	local e15=e14:Clone()
	e15:SetCode(EFFECT_CANNOT_MSET)
	c:RegisterEffect(e15)
	--put card into play
	local e16=Effect.CreateEffect(c)
	e16:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_DISABLE_CHAIN+EFFECT_FLAG_CARD_TARGET)
	e16:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_F)
	e16:SetCode(EVENT_CHAINING)
	e16:SetCountLimit(1,33559998+EFFECT_COUNT_CODE_DUEL)
	e16:SetRange(LOCATION_HAND+LOCATION_DECK)
	e16:SetOperation(c33559998.operation65)
	e16:SetCondition(c33559998.con359)
	c:RegisterEffect(e16)
	--add graveyard monster to shinato when giant flood is activated
	local e17=Effect.CreateEffect(c)
	e17:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e17:SetCode(EVENT_CUSTOM+33559998)
	e17:SetRange(LOCATION_PZONE)
	e17:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e17:SetCondition(c33559998.olcon)
	e17:SetOperation(c33559998.olop)
	c:RegisterEffect(e17)   
end

function c33559998.con359(e,tp,eg,ep,ev,re,r,rp)
	return  re:IsActiveType(TYPE_SPELL,810000082) and re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:GetHandler():GetCode()==810000082
end
 
 function c33559998.olcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsCode(33559998)
end

function c33559998.filter22(c)
return c:IsType(TYPE_MONSTER) and c:IsFaceup() 
end

function c33559998.olop(e,tp,eg,ep,ev,re,r,rp)
   local wg=Duel.GetMatchingGroup(c33559998.filter22,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil,e)
--where g is card group
local c=wg:GetFirst()
while c do
	--do your thing to c
	local og=c:GetOverlayGroup()
	if og:GetCount()>0 then Duel.SendtoGrave(og,REASON_RULE) end
	c=wg:GetNext()
end
Duel.Overlay(e:GetHandler(),wg)
end
 
 
 
 function c33559998.operation65(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
 if chk==0 then return true end
 if re:GetHandler():IsRelateToEffect(re) then
Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
Duel.RaiseEvent(e:GetHandler(),EVENT_CUSTOM+33559998,e,0,0,tp,0) 
end
end


 --add procedure to Pendulum monster, also allows registeration of activation effect
function Auxiliary.EnablePendulumAttribute(c,reg)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC_G)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1,10000000)
	e1:SetCondition(Auxiliary.PendCondition())
	e1:SetOperation(Auxiliary.PendOperation())
	e1:SetValue(SUMMON_TYPE_PENDULUM)
	c:RegisterEffect(e1)
	--register by default
	if reg==nil or reg then
		local e2=Effect.CreateEffect(c)
		e2:SetDescription(1160)
		e2:SetType(EFFECT_TYPE_ACTIVATE)
		e2:SetCode(EVENT_FREE_CHAIN)
		e2:SetRange(LOCATION_HAND)
		c:RegisterEffect(e2)
	end
end

----Activate
function c33559998.cost(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
local c=e:GetHandler()
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_IMMUNE_EFFECT)
e1:SetValue(c33559998.imfilter)
e1:SetReset(RESET_CHAIN)
Duel.RegisterEffect(e1,tp)
end
function c33559998.imfilter(e,re)
return re:IsActiveType(TYPE_SPELL+TYPE_TRAP) and re:GetOwner()~=e:GetOwner()
end
----Immune
function c33559998.efilter(e,te)
return te:GetOwner()~=e:GetOwner() and te:IsActiveType(TYPE_SPELL+TYPE_TRAP)
end
function c33559998.efilter1(e,te)
	return te:IsActiveType(TYPE_EFFECT) and te:GetOwner()~=e:GetOwner()
end
function c33559998.tgfilter(e,re)
	if not re or not re:IsActiveType(TYPE_SPELL+TYPE_TRAP) then return false end
	return re:IsHasCategory(CATEGORY_TOHAND+CATEGORY_DESTROY+CATEGORY_REMOVE+CATEGORY_TODECK+CATEGORY_RELEASE+CATEGORY_TOGRAVE)
end
function c33559998.filter(c)
	return c:IsType(TYPE_MONSTER)
end
function c33559998.antifilter(c)
	return not c33559998.filter(c)
end
function c33559998.filter2(c)
	return c33559998.filter(c) and c:IsPosition(POS_FACEUP_ATTACK)
end
function c33559998.recon(e,c)
	return c:GetControler()~=e:GetHandler():GetControler()
end
function c33559998.recon2(e)
	return Duel.GetTurnPlayer()~=e:GetOwnerPlayer()
end
function c33559998.operation(e,tp,eg,ep,ev,re,r,rp)
	local g = eg:Filter(c33559998.filter,nil)
	local c = g:GetFirst()
	while c do
		if c:GetOverlayCount()>0 then 
			local og=c:GetOverlayGroup()
			Duel.SendtoGrave(og:Filter(c33559998.antifilter,nil),REASON_RULE)
			Duel.Overlay(e:GetHandler(),og:Filter(c33559998.filter,nil)) 
		end
		c = g:GetNext()
	end
	Duel.Overlay(e:GetHandler(),g)
end

function c33559998.smcondition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and Duel.GetMatchingGroupCount(c33559998.filter,tp,LOCATION_MZONE,0,e:GetHandler())==0
end
function c33559998.smtarget(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local oppmonNum = Duel.GetMatchingGroupCount(c33559998.filter2,tp,0,LOCATION_MZONE,nil)
	local s1=math.min(oppmonNum,Duel.GetLocationCount(tp,LOCATION_MZONE))
	local s2=math.min(e:GetHandler():GetOverlayCount(),s1)
	if chk==0 then return s2>0 end
	
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=e:GetHandler():GetOverlayGroup()
	local c=g:Select(tp,1,s2,nil) 
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,c:GetCount(),0,0)
end
function c33559998.smoperation(e,tp,eg,ep,ev,re,r,rp)
	local ex1,g=Duel.GetOperationInfo(0,CATEGORY_SPECIAL_SUMMON)
	Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP_DEFENSE)
end

function c33559998.lptarget(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return e:GetHandler():GetOverlayCount()>0 end	
	local g=e:GetHandler():GetOverlayGroup()
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
end
function c33559998.lpoperation(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetHandler():GetOverlayGroup()
	local n=Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	Duel.Recover(tp,n*500,REASON_EFFECT)
end

function c33559998.shfilter(c,e,tp)
	return c:IsCode(86327225) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c33559998.shtarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c33559998.shfilter,tp,
LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,
LOCATION_EXTRA)
end
function c33559998.shoperation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c33559998.shfilter,tp,
LOCATION_EXTRA,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
	end
end

function c33559998.arkcondition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
end
function c33559998.arkoperation(e,tp,eg,ep,ev,re,r,rp)
	Duel.SpecialSummon(e:GetHandler(),0,tp,tp,true,false,POS_FACEUP)
end
function c33559998.unval(e,te)
	return te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
