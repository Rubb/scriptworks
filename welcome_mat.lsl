/*
    welcome_mat.lsl
    
    Last edited: 2018-09-02
    
    Uses the collision_start event to detect avatars that come into contact with the object
    and welcomes with their name and a cutomisable location name. Only greets the same avatar
    about once a week (the script resets on region restart).
    
    NOTE: The mat will never greet its owner, so you may want to test it with an alt.
    
    Possible uses:
    1. Greet visitors to your shop.
    2. Greet visitors to your home.
    
    Instructions:
    1. Edit the script to use the location name you want. Leave blank to use the name of the parcel.
    2. Drop the script into your welcome mat.
    3. You may want to make the mat invisible by setting the textire transparency to 100%, if it's
       not going to be a decorative item.
    4. Set the script to "Running".
    5. Wait for users to arrive.
    
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
    Change the value of LOCATION_NAME to whatever you wish.
    
    Just leave the text empty, if you want to use the parcel name.
*/

string LOCATION_NAME = "";

// *** DO NOT EDIT BELOW THIS LINE, UNLESS YOU KNOW WHAT YOU'RE DOING! *** //

list g_visitors = [];
key g_owner = "";

default
{
    // Init the owner key and the name of the location, if not set above
    state_entry()
    {
        g_owner = llGetOwner();
        if(LOCATION_NAME == "")
        {
            list location = llGetParcelDetails(llGetPos(), [PARCEL_DETAILS_NAME]);
            LOCATION_NAME = llList2String(location, 0);
        }
    }

    // Empty the list, when the region is restarted (at least once a week), to save memory
    changed(integer change)
    {
        if(change & CHANGED_REGION_START)
        {
            g_visitors = [];
        }
    }
    
    // When someone lands on the mat, and they haven't been greeted this week, greet them
    collision_start(integer collisions)
    {
        integer n;
        
        for(n = 0; n < collisions; ++n)
        {
            key agent = llDetectedKey(n);
            if(agent)
            {
                list test = [agent];
                integer is_owner = agent == g_owner;
                integer is_avatar = llGetAgentSize(agent) != ZERO_VECTOR;
                integer in_list = llListFindList(g_visitors, test) >= 0;
                
                if(!is_owner && is_avatar && !in_list)
                {
                    llRegionSayTo(agent, 0, "Welcome to " + LOCATION_NAME + ", " + llGetDisplayName(agent) + "!");
                    g_visitors += agent;
                }
            }
        }
    }
}
