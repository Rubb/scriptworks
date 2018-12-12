/*
    give_notecard_and_message.lsl
    
    Last edited: 2018-09-02

    Uses llGiveInventory to give a notecard on touch and llInstant message to
    the avatar that touched the prim.

    Possible uses:
    1. Offer the latest news or status of your shop
    2. Tell your friends when you'll be around next, if they happen by

    Instructions:
    1. Place this script and a notecard into the object you wish to use.
    2. Edit the script with the message you want to send to the avatar that 
       touched the object.
    3. Set the script to "Running".
    4. Touch!

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
    Change the value of MESSAGE to the text you'd like to send along with the
    notecard.

    If you don't want to send a message, just leave the text blank.
*/

string MESSAGE = "";

/* DO NOT EDIT BELOW THIS LINE, UNLESS YOU KNOW WHAT YOU'RE DOING! */

string g_itemName = "";

default
{
    touch_start(integer total_number)
    {
        key avatar = llDetectedKey(0);
        g_itemName = llGetInventoryName(INVENTORY_NOTECARD, 0);
        llGiveInventory(avatar, g_itemName);

        if("" == MESSAGE)
        {
            return;
        }

        llInstantMessage(avatar, MESSAGE);
    }
}
