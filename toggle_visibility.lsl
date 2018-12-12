/*
    toggle_visibility.lsl
    
    Last edited: 2018-09-02

    Uses llSetLinkAlpha to hide one or more sides of an object or linkset.

    Possible uses:
    1. Hide all or part of a privacy screen
    2. Surprise someone with a gift by doing a "big reveal"

    Instructions:
    1. Place this script into the object you wish to use.
    2. Edit the script with:
       a. The number of the prim/link you wish to affect.
       b. The number of the side(s) you wish to affect.
    4. Set the script to "Running".
    5. Touch!

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
    Change the value of "LINK" to affect particular prims
      * LINK_SET            All prims in the linkset
      * LINK_ROOT           The root prim in a linkset
      * LINK_ALL_OTHERS     All prims other than the one containing the script
      * LINK_ALL_CHILDREN   All prims bu the root prim
      * LINK_THIS           The prim that the script is in
*/
integer LINK = LINK_SET;

/*
    Change the value of "SIDE" to specify which sides to affect
      * ALL_SIDES       All sides of the prim or linkset
      * 1, 2, 3, ...    A single number specifies one side of each prim
*/
integer SIDE = ALL_SIDES;

// *** DO NOT EDIT BELOW THIS LINE, UNLESS YOU KNOW WHAT YOU'RE DOING! *** //

integer g_invisible = FALSE;

default
{
    touch_start(integer total_number)
    {
        if(g_invisible)
        {
            g_invisible = FALSE;
            llSetLinkAlpha(LINK, 1.0, SIDE);
            llOwnerSay("Ta da!");

        }
        else
        {
            g_invisible = TRUE;
            llSetLinkAlpha(LINK, 0.0, SIDE);
            llOwnerSay("Hidden...");
        }
    }
}
