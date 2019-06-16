/*
    set_hovertext.lsl
    
    Last edited: 2018-09-02

    Shows how llSetText works to set (and more importantly REMOVE) prim hovertext.

    Possible uses:
    1. Put a label on yourself without having to set a display name 
       Just attach the prim somewhere on your face, after making it 
       transparent, obvs.
    2. Removing annoying hovertext using a pre-prepared script you drag and drop 
       onto a prim.

    Instructions:
    1. Place this script into the object you wish to use.
    2. Edit the script with:
       a. The hovertext you wish to display (or not).
       b. The color of the hovertext.
    4. Set the script to "Running".
    5. Save.

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
    Change the value of HOVER_TEXT to your desired text.

    The hovertext can be up to 254 characters long (less if you use
    special characters).

    If you want the text to wrap, use '\n' for the return character
    (without the quotes).

    If you want the text to be higher up than the default, use several 
    returns in a row, just make sure to leave a space between like 
    this: '\n \n \n \n'.
*/
string HOVER_TEXT = "Your text here.";

/*
    Change the values in the vector below. The order is <RED, BLUE, GREEN>.

      * RED would be <1.0, 0.0, 0.0>
      * BLUE is <0.0, 0.0, 1.0>
      * GREEN is (you guessed it) <0.0, 1.0, 0.0>
      * WHITE is <1.0, 1.0, 1.0>
      * BLACK is <0.0, 0.0, 0.0>

    If you need assistance in choosing a color, please see: 
    http://wiki.secondlife.com/wiki/Color
*/

vector TEXT_COLOR = <1.0, 1.0, 1.0>;

/* DO NOT EDIT BELOW THIS LINE, UNLESS YOU KNOW WHAT YOU'RE DOING! */

default
{ 
    state_entry()
    {
        llSetText(HOVER_TEXT, TEXT_COLOR, 1.0);
    }
}
