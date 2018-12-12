/*
    stop_scripts.lsl
    
    Last edited: 2018-09-02

    Uses llSetScriptState to stop the other scripts in a prim's inventory on rez.

    Possible uses:
    1. If you sell scripts, like I do, then you may not want them to run when
       the prim first rezzes.
    2. If you are in a high-lag situation, being able to stop all of the scripts
       in a prim could save you creating even more lag.

    Instructions:
    1. Place this script into your scripted object.
    2. Take the object into your inventory.
    3. Rez the object.
    4. The scripts will stop, hovertext will be removed, and you're there!.

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
    If you want the script to stop itself at the end, set this to TRUE
*/
integer STOP_MYSELF = FALSE;

// *** DO NOT EDIT BELOW THIS LINE, UNLESS YOU KNOW WHAT YOU'RE DOING! *** //

stop()
{
    string thisScript = llGetScriptName();
    integer count = llGetInventoryNumber(INVENTORY_SCRIPT);
    integer i = 0;
    for(i = 0; i < count; ++i)
    {
        string name = llGetInventoryName(INVENTORY_SCRIPT, i);
        if(thisScript != name)
        {
            llResetOtherScript(name);
            llSetScriptState(name, FALSE);
        }
    }

    llOwnerSay("Stopped " + (string) (count - 1) + " scripts. " + 
    "Now removing hovertext.");
    llSetText("", <1.0, 1.0, 1.0>, 1.0);
    llTargetOmega(<0,0,0>,0,0);
    
    if(STOP_MYSELF)
    {
        llOwnerSay("Now stopping myself.");
        llSetScriptState(thisScript, FALSE);
    }
}

default
{
    on_rez(integer start_param)
    {
        stop();
    }
    
    touch_start(integer number)
    {
        stop();
    }
}
