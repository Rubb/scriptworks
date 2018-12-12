/*
    open_group_joiner.lsl
    
    Last edited: 2018-09-2

    Uses llInstantMessage to invite any avatar to your open-enrollment 
    group on touch.

    Possible uses:
    1. It's an effortless way to allow your visitors to join your group
    2. Invite visitors to any group, even if it's not the land group

    Instructions:
    1. Place this script into the object you wish to use as the joiner.
    2. Edit the script with:
       a. The hovertext you wish to display, if any.
       b. The UUID of the open-enrollment group you want your visitors to join.
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
    Change the value of HOVERTEXT to whatever you want the joiner to display.

    Just leave the text empty, if you don't want hover text.
*/

string HOVERTEXT = "";

/*
    Change the value below to the UUID of the open-enrollment group you
    want your visitors to join.

    Please make sure that the group is open-enrollment, or there's no point,
    because the touching avatar won't be able to join it.
*/

key GROUP_KEY = "";

/* DO NOT EDIT BELOW THIS LINE, UNLESS YOU KNOW WHAT YOU'RE DOING! */

default
{
    state_entry()
    {
        llSetText(HOVERTEXT, <1.0, 1.0 , 1.0>, 1.0);
    }

    touch_start(integer total_number)
    {
        key avatar = llDetectedKey(0);
        llInstantMessage(avatar, "Simply click the link in nearby chat (Ctrl+H)"
            + " and then click on the \"Join group\" button. secondlife:///app/group/" 
            + (string) GROUP_KEY + "/about"); 
    }
}
