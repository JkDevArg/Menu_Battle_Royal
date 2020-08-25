#include <amxmodx>

#define PLUGIN "Menu General BattleRoyal"
#define VERSION "1.0"
#define AUTHOR "JkDev"

public plugin_init()
{
	register_plugin( PLUGIN, VERSION, AUTHOR );
    register_clcmd("say /menu", "HookCmdMenu");
    register_clcmd("say_team /menu", "HookCmdMenu");
    register_clcmd("chooseteam", "HookCmdMenu");
}

stock bool:is_user_admin(id)
{
    return (get_user_flags(id) & ADMIN_RCON) ? true : false
}

public HookCmdMenu(id)
{
    new menu = menu_create("\rMenu:", "HookMenuHandler")

    menu_additem(menu, "\rInformación", "1", 0);
    menu_additem(menu, "\rTops", "2", 0);
    menu_additem(menu, "\rSkins", "3", 0);
    menu_additem(menu, "\rMenu BattleRoyal", "4", 0);
    menu_additem(menu, "\rInfo Cuenta", "5", 0);
    if(is_user_admin(id)){ //SI ES ADMIN
        if(get_user_flags(id) & ADMIN_RCON)
        {
            menu_additem(menu, "\yMENU ADMIN", "6", 0);
        }
        else if(get_user_flags(id) & ADMIN_KICK)
        {
            menu_additem(menu, "\yMENU ADMIN", "7", 0);
        }
    }
    menu_setprop(menu, MPROP_EXITNAME, "Salir");
    menu_setprop(menu, MPROP_EXIT, MEXIT_ALL);

    menu_display(id, menu, 0);
    return PLUGIN_HANDLED;
}

public HookMenuHandler(id, menu, item)
{
    if(item == MENU_EXIT)
    {
        menu_destroy(menu);
        return PLUGIN_HANDLED;
    }

    new data[6], iName[64];
    new access, callback;
    menu_item_getinfo(menu, item, access, data, 5, iName, 63, callback);

    new key = str_to_num(data);

    switch(key)
    {
        case 1:
        {
            SubMenuInfo(id);
        }
        case 2:
        {
            SubMenuTops(id);
        }
        case 3:
        {
            SubMenuSkins(id);
        }
        case 4:
        {
            SubMenuBattle(id);
        }
        case 5:
        {
            client_cmd(id, "say /info");
        }
        case 6:
        {
            SubMenuAdminR(id);
        }
        case 7:
        {
            SubMenuAdminK(id);
        }
    }

    menu_destroy(menu);
    return PLUGIN_HANDLED;
}

SubMenuInfo(id)
{

    new menu = menu_create("\rInformación:", "HookSubInfoMenuHandler")

    menu_additem(menu, "\wJuego", "1", 0);
    menu_additem(menu, "\wAdmin", "2", 0);
    menu_additem(menu, "\wVIP", "3", 0);

    menu_setprop(menu, MPROP_EXIT, MEXIT_ALL);
    menu_display(id, menu, 0);
}

public HookSubInfoMenuHandler(id, menu, item)
{
    if(item == MENU_EXIT)
    {
        menu_destroy(menu);

        // aca lo que hacemos es que si el usuario sigue conectado y cierra
        // el submenu, le mostramos el menu principal, esto es opcional

        if(is_user_connected(id) )
            HookCmdMenu(id);

        return PLUGIN_HANDLED;
    }

    new data[6], iName[64];
    new access, callback;
    menu_item_getinfo(menu, item, access, data, 5, iName, 63, callback);

    new key = str_to_num(data);

    switch(key)
    {
        case 1:
        {
            ChatColor(id, "!y[!gBattleRoyal!y] !teamServidor MODO !yBattleRoyal !teamversión 3.0b !teamIngresa a nuestro discord !ghttps://discord.gg/qrCBVp")
        }
        case 2:
        {
            ChatColor(id, "!y[!gBattleRoyal!y] !teamPara obtener ADMIN comunicate con !gJkDev o !gTsuka")
        }
        case 3:
        {
            ChatColor(id, "!y[!gBattleRoyal!y] !teamPara obtener VIP comunicate con !gJkDev !teamo !gTsuka")
        }
    }

    menu_destroy(menu);

    // al elegir una opcion del menu, si queremos que aparezca el menu principal,
    // agregamos lo siguiente:

    SubMenuInfo(id);

    return PLUGIN_HANDLED;
}

SubMenuTops(id)
{

    new menu = menu_create("\rTOPS:", "HookSubTopsMenuHandler")

    menu_additem(menu, "\wTOP15 WINS", "1", 0);
    menu_additem(menu, "\wTOP15 VBUCKS", "2", 0);
    menu_additem(menu, "\wTUS VICTORIAS", "3", 0);
    menu_additem(menu, "\wRANK", "4", 0);
    menu_additem(menu, "\wTOP15", "5", 0);

    menu_setprop(menu, MPROP_EXIT, MEXIT_ALL);
    menu_display(id, menu, 0);
}

public HookSubTopsMenuHandler(id, menu, item)
{
    if(item == MENU_EXIT)
    {
        menu_destroy(menu);

        // aca lo que hacemos es que si el usuario sigue conectado y cierra
        // el submenu, le mostramos el menu principal, esto es opcional

        if(is_user_connected(id) )
            HookCmdMenu(id);

        return PLUGIN_HANDLED;
    }

    new data[6], iName[64];
    new access, callback;
    menu_item_getinfo(menu, item, access, data, 5, iName, 63, callback);

    new key = str_to_num(data);

    switch(key)
    {
        case 1:
        {
            client_cmd(id,"say /top15_wins")
        }
        case 2:
        {
            client_cmd(id,"say /top15_vbucks")
        }
        case 3:
        {
            client_cmd(id,"say /pub_rank")
        }
        case 4:
        {
            client_cmd(id,"say /rank")
        }
        case 5:
        {
            client_cmd(id,"say /top15")
        }
    }

    menu_destroy(menu);

    // al elegir una opcion del menu, si queremos que aparezca el menu principal,
    // agregamos lo siguiente:

    SubMenuTops(id);

    return PLUGIN_HANDLED;
}

SubMenuSkins(id)
{

    new menu = menu_create("\rSKINS:", "HookSubSkinsMenuHandler")

    menu_additem(menu, "\wKNIFE MODELS", "1", 0);
    menu_additem(menu, "\wPLAYER MODELS", "2", 0);
    if(get_user_flags(id) & ADMIN_LEVEL_A)
        {
            menu_additem(menu, "\wKNIFE MODELS \rVIP", "3", 0);
            menu_additem(menu, "\wPLAYER MODELS \rVIP", "4", 0);
        }
    if(get_user_flags(id) & ADMIN_KICK)
        {
            menu_additem(menu, "\wKNIFE MODELS \rADMIN", "5", 0);
            menu_additem(menu, "\wPLAYER MODELS \rADMIN", "6", 0);
        }
    menu_setprop(menu, MPROP_EXIT, MEXIT_ALL);
    menu_display(id, menu, 0);
}

public HookSubSkinsMenuHandler(id, menu, item)
{
    if(item == MENU_EXIT)
    {
        menu_destroy(menu);

        // aca lo que hacemos es que si el usuario sigue conectado y cierra
        // el submenu, le mostramos el menu principal, esto es opcional

        if(is_user_connected(id) )
            HookCmdMenu(id);

        return PLUGIN_HANDLED;
    }

    new data[6], iName[64];
    new access, callback;
    menu_item_getinfo(menu, item, access, data, 5, iName, 63, callback);

    new key = str_to_num(data);

    switch(key)
    {
        case 1:
        {
            client_cmd(id,"say /kmodels")
        }
        case 2:
        {
            client_cmd(id,"say /pmodels")
        }
        case 3:
        {
            client_cmd(id,"vipkmodel")
        }
        case 4:
        {
            client_cmd(id,"vippmodel")
        }
        case 5:
        {
            client_cmd(id,"admkmodel")
        }
        case 6:
        {
            client_cmd(id,"admpmodel")
        }
    }

    menu_destroy(menu);

    // al elegir una opcion del menu, si queremos que aparezca el menu principal,
    // agregamos lo siguiente:

    SubMenuSkins(id);

    return PLUGIN_HANDLED;
}

SubMenuBattle(id)
{

    new menu = menu_create("\rMenu BattleRoyal:", "HookSubBattleMenuHandler")

    menu_additem(menu, "\wMOCHILA", "1", 0);
    menu_additem(menu, "\wMENU VOZ", "2", 0);
    menu_additem(menu, "\wSQUAD", "3", 0);
    menu_additem(menu, "\wSALIR SQUAD", "4", 0);
    menu_additem(menu, "\wREGALAR VBUCKS", "5", 0);
    menu_additem(menu, "\wREPORTAR ADM/PLAYER", "6", 0);
    menu_additem(menu, "\wMENSAJE PRIVADO", "7", 0);
    menu_setprop(menu, MPROP_EXIT, MEXIT_ALL);
    menu_display(id, menu, 0);
}

public HookSubBattleMenuHandler(id, menu, item)
{
    if(item == MENU_EXIT)
    {
        menu_destroy(menu);

        // aca lo que hacemos es que si el usuario sigue conectado y cierra
        // el submenu, le mostramos el menu principal, esto es opcional

        if(is_user_connected(id) )
            HookCmdMenu(id);

        return PLUGIN_HANDLED;
    }

    new data[6], iName[64];
    new access, callback;
    menu_item_getinfo(menu, item, access, data, 5, iName, 63, callback);

    new key = str_to_num(data);

    switch(key)
    {
        case 1:
        {
            client_cmd(id, "radio2")
        }
        case 2:
        {
            client_cmd(id, "radio3")
        }
        case 3:
        {
            client_cmd(id, "/squad")
        }
        case 4:
        {
            client_cmd(id, "/team_off")
        }
        case 5:
        {
            client_cmd(id, "say /give_vbucks")
        }
        case 6:
        {
            client_cmd(id, "say !report")
        }
        case 7:
        {
            client_cmd(id, "say /mensaje")
        }
    }

    menu_destroy(menu);

    // al elegir una opcion del menu, si queremos que aparezca el menu principal,
    // agregamos lo siguiente:

    SubMenuBattle(id);

    return PLUGIN_HANDLED;
}


SubMenuAdminR(id)
{
    if(get_user_flags(id) & ADMIN_RCON)
    {
    new menu = menu_create("\rMENU ADMIN:", "HookSubAdminRMenuHandler")

    menu_additem(menu, "\wDAR VBUCKS", "1", 0);
    menu_additem(menu, "\wDAR WINS", "2", 0);
    menu_additem(menu, "\wLISTA ARMAS", "3", 0);
    menu_additem(menu, "\wCREAR ARMAS", "4", 0);
    menu_additem(menu, "\wARMAR EQUIPOS", "5", 0);
    menu_additem(menu, "\wMAX OBJ EN COFRES", "6", 0);
    menu_additem(menu, "\wDAR ARMA A JUGADOR", "7", 0);
    menu_setprop(menu, MPROP_EXIT, MEXIT_ALL);
    menu_display(id, menu, 0);
    }
    else
    {
        ChatColor(id, "!y[!gBattleRoyal!y] !teamOuuuuh no tienes permiso para ver este menu amigito")
    }
}

public HookSubAdminRMenuHandler(id, menu, item)
{
    if(item == MENU_EXIT)
    {
        menu_destroy(menu);

        // aca lo que hacemos es que si el usuario sigue conectado y cierra
        // el submenu, le mostramos el menu principal, esto es opcional

        if(is_user_connected(id) )
            HookCmdMenu(id);

        return PLUGIN_HANDLED;
    }

    new data[6], iName[64];
    new access, callback;
    menu_item_getinfo(menu, item, access, data, 5, iName, 63, callback);

    new key = str_to_num(data);

    switch(key)
    {
        case 1:
        {
            client_cmd(id,"agbattle_set_vbucks")
        }
        case 2:
        {
            client_cmd(id,"agbattle_set_wins")
        }
        case 3:
        {
            client_cmd(id,"agbattle_get_weapons_list")
        }
        case 4:
        {
            client_cmd(id,"agbattle_spawn_weapon")
        }
        case 5:
        {
            client_cmd(id,"agbattle_make_teams")
        }
        case 6:
        {
            client_cmd(id,"amx_cvar agbattle_max_items_on_chest")
        }
        case 7:
        {
            client_cmd(id, "agbattle_give_item")
        }
    }

    menu_destroy(menu);

    // al elegir una opcion del menu, si queremos que aparezca el menu principal,
    // agregamos lo siguiente:

    SubMenuAdminR(id);

    return PLUGIN_HANDLED;
}

SubMenuAdminK(id)
{
    if(get_user_flags(id) & ADMIN_KICK)
    {
    new menu = menu_create("\rMENU ADMIN:", "HookSubAdminKMenuHandler")

    menu_additem(menu, "\wKICK MENU", "1", 0);
    menu_additem(menu, "\wTEAM MENU", "2", 0);
    menu_additem(menu, "\wMAP MENU 1", "3", 0);
    menu_additem(menu, "\wRESTART", "4", 0);
    menu_setprop(menu, MPROP_EXIT, MEXIT_ALL);
    menu_display(id, menu, 0);
    }
    else
    {
        ChatColor(id, "!y[!gBattleRoyal!y] !teamOuuuuh no tienes permiso para ver este menu amigito")
    }
}

public HookSubAdminKMenuHandler(id, menu, item)
{
    if(item == MENU_EXIT)
    {
        menu_destroy(menu);

        // aca lo que hacemos es que si el usuario sigue conectado y cierra
        // el submenu, le mostramos el menu principal, esto es opcional

        if(is_user_connected(id) )
            HookCmdMenu(id);

        return PLUGIN_HANDLED;
    }

    new data[6], iName[64];
    new access, callback;
    menu_item_getinfo(menu, item, access, data, 5, iName, 63, callback);

    new key = str_to_num(data);

    switch(key)
    {
        case 1:
        {
            client_cmd(id,"amx_kickmenu")
        }
        case 2:
        {
            client_cmd(id,"amx_teammenu")
        }
        case 3:
        {
            client_cmd(id,"amx_mapmenu")
        }
        case 4:
        {
            client_cmd(id,"amx_cvar sv_restart 1")
        }
    }

    menu_destroy(menu);

    // al elegir una opcion del menu, si queremos que aparezca el menu principal,
    // agregamos lo siguiente:

    SubMenuAdminK(id);

    return PLUGIN_HANDLED;
}



stock ChatColor(const id, const input[], any:...)
{
    new count = 1, players[32]
    static msg[191]
    vformat(msg, 190, input, 3)

    replace_all(msg, 190, "!g", "^4") // Green Color
    replace_all(msg, 190, "!y", "^1") // Default Color
    replace_all(msg, 190, "!team", "^3") // Team Color
    replace_all(msg, 190, "!team2", "^0") // Team2 Color

    if (id) players[0] = id; else get_players(players, count, "ch")
    {
        for (new i = 0; i < count; i++)
        {
            if (is_user_connected(players[i]))
            {
                message_begin(MSG_ONE_UNRELIABLE, get_user_msgid("SayText"), _, players[i])
                write_byte(players[i]);
                write_string(msg);
                message_end();
            }
        }
    }
}
