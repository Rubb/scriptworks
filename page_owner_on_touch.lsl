/*
    page_owner_on_touch.lsl
    
    Last edited: 2018-09-02

    Uses llInstantMessage to message the owner when the object is touched.

    Possible uses:
    1. If your IMs are often capped, then this will send you un-cappable IMs.
    2. A perfect way to know that someone else wants your attention

    Instructions:
    1. Place this script into the object you wish to use.
    2. Set the script to "Running".
    3. Touch to page.

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

key g_ownerKey = NULL_KEY;
key g_ownerNameRequest = NULL_KEY;
string g_ownerName = "my owner";

key g_visitorKey = NULL_KEY;
key g_visitorNameRequest = NULL_KEY;
string g_visitorName = "An avatar";

init()
{
    g_ownerKey = llGetOwner();
    g_ownerNameRequest = llRequestDisplayName(g_ownerKey);
}

set_text()
{
    llSetText("Touch to page " + g_ownerName, <0.0, 1.0, 0.0>, 1.0);
}

start_page()
{
    llInstantMessage(g_visitorKey, "Paging " + g_ownerName + ". Please wait...");
    llInstantMessage(g_ownerKey, g_visitorName + " has just paged you. secondlife:///app/agent/"
        + (string) g_visitorKey + "/about.");
    llSleep(5.0);
    llInstantMessage(g_visitorKey, "I have paged " + g_ownerName + 
        ". If you do not hear back soon, please try again later.");
}

default
{
    state_entry()
    {
        init();
    }

    on_rez(integer start_param)
    {
        llResetScript();
    }

    touch_start(integer total_number)
    {
        g_visitorKey = llDetectedKey(0);
        g_visitorNameRequest = llRequestDisplayName(g_visitorKey);
    }

    dataserver(key queryid, string data)
    {
        if(g_ownerNameRequest == queryid)
        {
            if("" != data)
            {
                g_ownerName = data;
            }

            set_text();
            return;
        }

        if(g_visitorNameRequest == queryid)
        {
            if("" != data)
            {
                g_visitorName = data;
            }

            start_page();
            return;
        }
    }
}
