////////////////////////////////////////////
//  Kittrell's Persistent Banking System  //
//  Designed by: Brian J. Kittrell        //
//                                        //
//  This script does the following:       //
//                                        //
//  kpb_invest_markt - This script allows //
//  players to invest 2500 of their gold  //
//  into Market development.              //
////////////////////////////////////////////

void main()
{
object oPC = GetPCSpeaker();
int nInvestment = 2500;
int nInvested = GetCampaignInt("kpb_bank", "KPB_BROKER_TOGGLE", oPC);
int nGold = GetGold(oPC);
int iMonth = GetCalendarMonth();
int iDay = GetCalendarDay();
int iYear = GetCalendarYear();
if (nGold >= nInvestment && nInvested < 1)
    {
    TakeGoldFromCreature(nInvestment, oPC, TRUE);
    SetCampaignInt("kpb_bank", "KPB_BROKER_TOGGLE", 1, oPC);
    SetCampaignInt("kpb_bank", "KPB_INVEST_TYPE", 3, oPC);
    SetCampaignInt("kpb_bank", "KPB_INVEST_YEAR", iYear, oPC);
    SetCampaignInt("kpb_bank", "KPB_INVEST_DAY", iDay, oPC);
    SetCampaignInt("kpb_bank", "KPB_INVEST_MONTH", iMonth, oPC);
    SpeakString("You have invested 2500 gold into a Market development.  Give the bank one day to invest your gold.", TALKVOLUME_TALK);
    return;
    }
if (nInvested == 1)
    {
    SpeakString("Sorry, you may not invest in more than one project at a time.", TALKVOLUME_TALK);
    return;
    }
else
    {
    SpeakString("Sorry, you do not have enough gold to invest!", TALKVOLUME_TALK);
    return;
    }
}
