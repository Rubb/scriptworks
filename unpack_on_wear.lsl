/*
    unpack_on_wear.lsl

    When the object is worn, uses llGiveInventory list to give a folder
    of the copiable contents of the object containing the script
    (except the script itself).

    Possible uses:
    1. Provide your customers with a shopping bag that unpacks their purchases
       without them needing a place where they can rez objects.
    2. Give the user wearing the object a HUD to use to control it.

    Instructions:
    1. Edit the script to indicate which hand to attach to.
    2. Add the items you want to give away to the object you wish to use as your package.
    3. Drop the script into the package and give it permission to attach.
    4. The package will offer you its contents.
    5. Detach the package back into your inventory.
    6. The next time the package, or a copy, is worn, it will attach to the same hand.
    7. No unpacking needed :-)

    Copyright 2018 Carissima Tedeschi @ Second Life

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

/*
    Change the value below to the hand you want the package to attach to:
    
        ATTACH_LHAND for the left hand
        ATTACH_RHAND for the right hand
*/

integer g_attach_to = ATTACH_RHAND;

// *** DO NOT EDIT BELOW THIS LINE, UNLESS YOU KNOW WHAT YOU'RE DOING! *** //

list g_items = [];
string g_name = "";

// Makes a list of all copiable items in the package, except this script.
make_inventory_list()
{
    g_items = [];
    integer i = 0;
    integer count = llGetInventoryNumber(INVENTORY_ALL);
    string script_name = llGetScriptName();

    for (i; i < count; i++)
    {
        string item_name = llGetInventoryName(INVENTORY_ALL, i);
        integer permission = llGetInventoryPermMask(item_name, MASK_OWNER);

        if((item_name != script_name) && (permission & PERM_COPY))
        {
            g_items += item_name;
        }
    }
}

default
{
    // Set up for the rest of the script.
    state_entry()
    {
        make_inventory_list();
        g_name = llGetObjectName();
        
        llRequestPermissions(llGetOwner(), PERMISSION_ATTACH);
    }
    
    // If another item is added to the inventory, the inventory list is updated.
    changed(integer change)
    {
        if(change & CHANGED_INVENTORY)
        {
            make_inventory_list();
        }
    }
    
    // When adding the script to your package for the first time, or when the
    // package is rezzed to the ground, it will ask for permission to attach.
    run_time_permissions(integer permissions)
    {
        if(permissions & PERMISSION_ATTACH)
        {
            llAttachToAvatar(g_attach_to);
        }
        else
        {
            llOwnerSay("Permission to attach denied.");
        }
    }
    
    // Make sure that the package is attached to the owner and then unpack.
    attach(key avatar)
    {
        if(avatar == NULL_KEY && llGetAttached() == 0)
        {
            return;
        }
        
        if(avatar == llGetOwner() && llGetAttached())
        {
            llInstantMessage(avatar, "Unpacking your items...");
            llGiveInventoryList(avatar, g_name, g_items);
        }
    }
    
    // If we log in wearing the item, we reset the script.
    on_rez(integer unused)
    {
        if(!llGetAttached())
        {
            llResetScript();
        }
    }
}
