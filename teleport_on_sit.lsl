/*
    teleport_on_sit.lsl
    
    Last edited: 2018-09-02

    Uses llSitTarget with an offset to "teleport" the sitter within the same region.

    Possible uses:
    1. An "elevator" for your home or shop.
    2. Travel to another parcel in the same region. (Make sure you're welcome first!)

    Instructions:
    1. Place this script into the object you wish to use.
    2. Edit the script with the target position at which you want to arrive.
    4. Set the script to "Running".
    5. Optionally, set the "Click to" of the teleporter to "Sit on object" in the "General" tab.
    5. Sit!

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
    Change TELEPORT_TO to the coordinates of the location to teleport to.

    To find the coordinate, go to the location and record the three numbers
    that appear at the top of your viewer window, after the region name.

    For example, if I am in the Braunworth region, and I want to teleport to 
    Braunworth (111, 142, 179), those are the three numbers I put in the vector
    below and *in that order*, or you won't wind up where you want!

    Please note that this script will only move you within the same region.
*/
vector TELEPORT_TO = <0, 0, 0>;

/* DO NOT EDIT BELOW THIS LINE, UNLESS YOU KNOW WHAT YOU'RE DOING! */

string g_hovertext = "Teleport";
vector g_textcolor = <1.0, 1.0, 1.0>;

init()
{
    vector target = (TELEPORT_TO - llGetPos()) * (ZERO_ROTATION / llGetRot());
    llSitTarget(target, ZERO_ROTATION);
    llSetSitText("Let's go!");
}

default
{
    state_entry()
    {
        init();            
        llSetText(g_hovertext, g_textcolor, 1.0); 
    }
    
    on_rez(integer startup_param)
    {
        init();
    }
    
    changed(integer change)
    {
        key avatar = llAvatarOnSitTarget();
        llUnSit(avatar);
        init();
    }    
}
