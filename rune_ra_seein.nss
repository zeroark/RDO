void main()
{

object oPC = OBJECT_SELF;
object oScribe = GetFirstItemInInventory(oPC);

     while(GetIsObjectValid(oScribe))
      {
           if(GetResRef(oScribe) == "runescarreddagge")
           {
            SetLocalString(oScribe, "ra_seein", "1");
           }
      oScribe = GetNextItemInInventory(oPC);
      }
}
