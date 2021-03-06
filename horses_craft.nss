#include "Horses_persist"

const int Horses_Craft_APP_MIN          = 3199;
const int Horses_Craft_APP_MAX          = 3265;

const string Horses_Craft_ORIGINAL_MODEL = "Horses_Craft_ORIGINAL_MODEL";

// Devuelve la apariencia minima para el modelo de caballo nMountType
int Horses_Craft_GetMinModelByMountType( int nMountType );
int Horses_Craft_GetMinModelByMountType( int nMountType )
{
    int minModel;
    switch (nMountType) {
        case MOUNT_TYPE_HORSE_CARGO:        minModel = Horses_APP_CARGO_1; break;
        case MOUNT_TYPE_HORSE_LIGHT:        minModel = Horses_APP_LIGHT_1; break;
        case MOUNT_TYPE_HORSE_HEAVY:        minModel = Horses_APP_HEAVY_1; break;
        case MOUNT_TYPE_WARHORSE_LIGHT:     minModel = Horses_APP_WAR_LIGHT_1; break;
        case MOUNT_TYPE_WARHORSE_HEAVY:     minModel = Horses_APP_WAR_HEAVY_1; break;
        case MOUNT_TYPE_HORSE_JOUSTING:     minModel = Horses_APP_JOUSTING_1; break;
        default:                            minModel = Horses_Craft_APP_MIN;
    }
    return minModel;
}

// Devuelve la apariencia maxima para el modelo de caballo nMountType
int Horses_Craft_GetMaxModelByMountType( int nMountType );
int Horses_Craft_GetMaxModelByMountType( int nMountType )
{
    int maxModel;
    switch (nMountType) {
        case MOUNT_TYPE_HORSE_CARGO:        maxModel = Horses_APP_CARGO_4; break;
        case MOUNT_TYPE_HORSE_LIGHT:        maxModel = Horses_APP_LIGHT_4; break;
        case MOUNT_TYPE_HORSE_HEAVY:        maxModel = Horses_APP_HEAVY_12; break;
        case MOUNT_TYPE_WARHORSE_LIGHT:     maxModel = Horses_APP_WAR_LIGHT_4; break;
        case MOUNT_TYPE_WARHORSE_HEAVY:     maxModel = Horses_APP_WAR_HEAVY_4; break;
        case MOUNT_TYPE_HORSE_JOUSTING:     maxModel = Horses_APP_JOUSTING_11; break;
        default:        maxModel = Horses_Craft_APP_MAX;
    }
    return maxModel;
}

const int Horse_Craft_NEXT_MODEL = 1;
const int Horse_Craft_PREV_MODEL = -1;

// Cambia el modelo del caballo
void Horses_Craft_ChangeModel( object oHorse, int nDirection = Horse_Craft_NEXT_MODEL );
void Horses_Craft_ChangeModel( object oHorse, int nDirection = Horse_Craft_NEXT_MODEL )
{
    if (GetIsObjectValid(oHorse)) {
        int nCurrApp = GetAppearanceType( oHorse );
        int nMountType = Horses_GetCreatureMountType( oHorse );

        nCurrApp = nCurrApp + nDirection;

        int minModel = Horses_Craft_GetMinModelByMountType(nMountType);
        int maxModel = Horses_Craft_GetMaxModelByMountType(nMountType);
        while (!Horses_GetModelBelongsToMountType(nCurrApp, nMountType)) {
            nCurrApp = nCurrApp + nDirection;
            if (nCurrApp > maxModel) nCurrApp = minModel;
            if (nCurrApp < minModel) nCurrApp = maxModel;
        }

        SetCreatureAppearanceType(oHorse, nCurrApp);
    }
}

// Comienza el "craft" del caballo
void Horses_Craft_Start( object oHorse );
void Horses_Craft_Start( object oHorse )
{
    SetLocalInt(oHorse, Horses_Craft_ORIGINAL_MODEL, GetAppearanceType(oHorse));
}

// Vuelve al modelo original de caballo
void Horses_Craft_Undo( object oHorse );
void Horses_Craft_Undo( object oHorse )
{
    int originalApp = GetLocalInt(oHorse, Horses_Craft_ORIGINAL_MODEL);
    SetCreatureAppearanceType(oHorse, originalApp);
}

// Termina el "craft" del caballo
void Horses_Craft_End( object oHorse, int nHorseId, object oOwner );
void Horses_Craft_End( object oHorse, int nHorseId, object oOwner )
{
    DeleteLocalInt(oHorse, Horses_Craft_ORIGINAL_MODEL);
    Horses_SetPersistantHorseAppearance(GetAppearanceType(oHorse), nHorseId, oOwner);
}
