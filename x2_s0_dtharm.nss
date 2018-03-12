//::///////////////////////////////////////////////
//:: Death Armor
//:: X2_S0_DthArm
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You are surrounded with a magical aura that injures
    creatures that contact it. Any creature striking
    you with its body or handheld weapon takes 1d4 points
    of damage +1 point per 2 caster levels (maximum +5).
*/
//:://////////////////////////////////////////////
//:: Created By: Andrew Nobbs
//:: Created On: Jan 6, 2003
//:://////////////////////////////////////////////
//:: Last Updated By: Andrew Nobbs, 02/06/2003
//:: 2003-07-07: Stacking Spell Pass, Georg Zoeller

//:: modified by mr_bumpkin Dec 4, 2003 for prc stuff
#include "spinc_common"

#include "x2_inc_spellhook"
#include "x0_i0_spells"

void main()
{
DeleteLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR");
SetLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR", SPELL_SCHOOL_NECROMANCY);
    /*
      Spellcast Hook Code
      Added 2003-07-07 by Georg Zoeller
      If you want to make changes to all spells,
      check x2_inc_spellhook.nss to find out more

    */

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

    // End of Spell Cast Hook
    object oTarget = GetSpellTargetObject();

    int nDuration = PRCGetCasterLevel(oTarget);
    int nCasterLvl = nDuration/2;
    if(nCasterLvl > 5)
    {
        nCasterLvl = 5;
    }
    int nMetaMagic = GetMetaMagicFeat();

    effect eShield = EffectDamageShield(nCasterLvl, DAMAGE_BONUS_1d4, DAMAGE_TYPE_MAGICAL);
    effect eDur = EffectVisualEffect(463);

    //Link effects
    effect eLink = EffectLinkEffects(eShield, eDur);

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

    //Enter Metamagic conditions
    if (CheckMetaMagic(nMetaMagic, METAMAGIC_EXTEND))
    {
        nDuration = nDuration *2; //Duration is +100%
    }

    //Stacking Spellpass, 2003-07-07, Georg
    RemoveEffectsFromSpell(oTarget, GetSpellId());

    SPApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));


DeleteLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR");
// Erasing the variable used to store the spell's spell school
}

