#   NBA Stats GO
NBA Stats Go is our (David Liu and Jorge Raad) final project for ECE 564. The idea for this app came from our mutual interest in basketball and the NBA. The app allows users to search and view stats on NBA players, compare stats between players, and search for instances of a player's career high.  

## Key Features/Functions
Below are the key features and functions of NBA Stats GO based on the views present in our product. For more detailed information into how to use the app on a component level, check out the "Additional Information" section below.

### Home Page
Initial Page that the user first sees containing information about our app including the rest of our feature list and our app logo. This page also corresponds with the Home tab on the tab bar controller

### Search Table
Table view page corresponding to the Search tab on the tab bar controller. The view contains a player base of ~3500 players sorted by last name and sectioned based on last name initial. There's also filter functionality in the form of a search bar and section headers on the right side.

### Player Stats
A page that shows an individual player's info, including personal info, a few career stats, and season-by-season averages of all the stat categories. This page is shown after selecting a player in the search table view page.

### Player Comparison
A set of two pages corresponding to the Compare tab on the tab bar controller. The first page allows the user to select two players that will be compared. After pressing the "Go" button, the second page appears, showing a side-by-side comparison of career averages for the two selected players. 

### Career High
A page corresponding to the Statlines tab on the tab bar controller. After selecting a player and a stat category and pressing the "Go" button, the career high of the player in that stat category will be displayed as part of a text blurb.

## Config / Setup / Login Info
Currently, there is no config, setup, or login info that users need to know about prior to using our app. Users can just build our app and enjoy.

## Additional Information (User's Guide)

### Home Page
Initial Page that the user first sees which includes: <br />
* Welcome statement <br />
* NBA Stats GO logo <br />
* Info about what the rest of the app contains (3 tabs) <br />
* Scrolling screen of currently existing NBA teams <br />
* Tab bar displayed at the bottom

Because this is the home page with information, the user should only view this page when the app first loads. There is no need to revisit this page again.

### Search Table
Table view page corresponding to the Search tab on the tab bar controller which includes: <br />
* Player base of ~3500 players dating back to 1979 <br />
* Players sorted by last name, sectioned based on last name initial <br />
* Search bar that filters by the following four formats: "first name", "last name", "last name, first name", and "first name last name" <br />
* Section headers on the right side (A-Z) that jumps to the corresponding section header <br />
* Refresh button that pulls player data from the BallDontLie API and updates the player list <br />
* Segue to Player Stats view or back to Player Comparison/Career High view based on player table view cell selection <br />
* Tab bar displayed at the bottom

This table view is actually used multiple times. This is used as part of the Search tab to allow the user to segue to the Player Stats view and display an individual player's stats. However, it's also used to help select players for the Player Comparison and Career High views. In those cases, rather than go to the Player Stats view, the view would unwind back to either the Player Comparison or Career High view, depending on whichever view initially called the Search Table view. Because of this, this view will be visited the most out of all the views.

### Player Stats
A page that is shown after selecting a player in the search table view page and includes:
* Individual player's info - name, team, height, weight, position <br />
* Some career stats - points, rebounds, assists, blocks, steals <br />
* Season-by-season averages of all stat categories through SpreadsheetView <br />
* Tab bar displayed at the bottom

The season-by-season averages utilizes a Pod called SpreadsheetView that helps display the stats in a grid-like view. If there's more stats than can fit in the initial view, the user can scroll horizontally and vertically to see all the stats. For users interested in looking up individual player stats, this view would be the most useful for them.

### Player Comparison
A set of two pages corresponding to the Compare tab on the tab bar controller. 

The first page includes:
* Two rows in a small tableview to select players <br />
* A "Go" button to segue to the second page <br />
* Tab bar displayed at the bottom

The second page includes:
* Both player's basic info - name, team <br />
* Tableview made up of custom table view cells, each of which help compare the two players for a specific stat  <br />
* Tab bar displayed at the bottom

When clicking on the Compare tab, the first page will appear. The user can then select the two players. When selecting, the view will segue to a Search Table view where the user can select a table view cell to select a player. 

After both players have been selected and pressing the "Go" button, the second page appears, showing a side-by-side comparison of career averages for the two selected players. Each multi-colored bar in the second page is colored based on comparing the values of the corresponding stat for both players. For users interested in comparing two players, this view would be the most applicable.

### Career High
A page corresponding to the Statlines tab on the tab bar controller and includes:
* One row in a small tableview to select a player <br />
* One row in a small tableview to select a stat category from a picker view <br />
* A "Go" button to find the career high for the selected player and stat category <br />
* Output label that displays the career high for the selected player and stat category
* Tab bar displayed at the bottom

After selecting a player and a stat category and pressing the "Go" button, the career high of the player is displayed in the output label. For users interested in finding the career high of any stat of any player, this should be their most used view.


