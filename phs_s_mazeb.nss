/*:://////////////////////////////////////////////
//:: Spell Name Maze : Exit area
//:: Spell FileName PHS_S_MazeB
//:://////////////////////////////////////////////
//:: Spell Effects Applied / Notes
//:://////////////////////////////////////////////
    On Exit area

    - Turn off plot flag
    - Delete local variables
//:://////////////////////////////////////////////
//:: Created By: Jasperre
//::////////////////////////////////////////////*/

#include "PHS_INC_SPELLS"

void main()
{
    // Set plot flag on the exiter to false (if not a DM)
    object oExiter = GetExitingObject();
    object oThierMazeObject;

    if(!GetIsDM(oExiter) && GetIsObjectValid(oExiter))
    {
        // If it is an NPC, we set them to commandable.
        SetCommandable(TRUE, oExiter);

        // We make sure that we delete the maze object associated with them
        oThierMazeObject = GetLocalObject(oExiter, PHS_MAZEPRISON_OBJECT);
        SetPlotFlag(oThierMazeObject, FALSE);
        // Destroy it
        DestroyObject(oThierMazeObject);

        // Remove the spells effects (the visual mostly)
        PHS_RemoveSpellEffectsFromTarget(PHS_SPELL_MAZE, oExiter);
        // Plot flag remove
        SetPlotFlag(oExiter, FALSE);
        // Delete locals
        DeleteLocalLocation(oExiter, PHS_S_MAZEPRISON_LOCATION);
        DeleteLocalObject(oExiter, PHS_S_MAZEPRISON_OLD_AREA);
        DeleteLocalInt(oExiter, PHS_S_MAZE_ROUND_COUNTER);
        DeleteLocalObject(oExiter, PHS_MAZEPRISON_OBJECT);
    }
}
