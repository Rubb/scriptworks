/*
    sit_to_animate.lsl
    
    Last edited: 2018-09-02

    Uses llSitTarget to activate an animation.

    Possible uses:
    1. Sit target for a chair or sofa
    2. Single-dance dance pad or ball

    Instructions:
    1. Place your animation and this script into the object you wish to use.
    2. Edit the script with:
       a. The exact name of your animation.
       b. The hovertext you wish to display.
    4. Set the script to "Running".
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

// Make sure that the value of ANIMATION is *exactly* 
// the same as your animation, or the script won't work!
string ANIMATION = "";

// You can show up to 254 characters
string HOVERTEXT = "";

/* DO NOT EDIT BELOW THIS LINE, UNLESS YOU KNOW WHAT YOU'RE DOING! */

default
{
    state_entry()
    {
        llSitTarget(<0.0, 0.0, 1.0>, ZERO_ROTATION);
        llSetText(HOVERTEXT, <1.0 ,1.0, 1.0>, 1.0);
    }

    on_rez(integer start_param)
    {
        llResetScript();
    }

    changed(integer change)
    {
        if (change & CHANGED_LINK)
        {
            key avatar = llAvatarOnSitTarget();

            if (avatar == NULL_KEY)
            {
                return;
            }

            llRequestPermissions(avatar, PERMISSION_TRIGGER_ANIMATION);
        }
    }

    run_time_permissions(integer perm)
    {
        if (perm & PERMISSION_TRIGGER_ANIMATION)
        {
            llStopAnimation("sit");
            llStartAnimation(ANIMATION);
        }
    }
}
