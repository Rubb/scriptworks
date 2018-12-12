/*
    give_contents.lsl
    
    Last edited: 2018-09-02

    Uses llGiveInventory list to give a folder of the copiable contents 
    of the object containing the script (except the script itself).

    Possible uses:
    1. Provide information, a landmark and a gift to any visitor.
    2. Give a collection of textures to anyone that wants them.

    Instructions:
    1. Place this script into the object you wish to use.
    2. Add the items you wish to give away.
    3. Set the script to "Running".
    4. Touch!
    5. No unpacking needed :-)

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

/* DO NOT EDIT BELOW THIS LINE, UNLESS YOU KNOW WHAT YOU'RE DOING! */

list g_items = [];
string g_name = "";

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
    state_entry()
    {
        make_inventory_list();
        g_name = llGetObjectName();
    }

    changed(integer change)
    {
        if(change & CHANGED_INVENTORY)
        {
            make_inventory_list();
        }
    }

    touch_start(integer num_detected)
    {
        key avatar = llDetectedKey(0);
        llGiveInventoryList(avatar, g_name, g_items);
    }
}
