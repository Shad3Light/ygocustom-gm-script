--Harpie lady sisters
function c335599143.initial_effect(c)
	c:EnableReviveLimit()
	--Triple tribute
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_TRIPLE_TRIBUTE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
end
