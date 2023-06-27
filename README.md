# auto_timeclock
## Code that auto commits your project every hour and allows for empty commits.

## How to use
To run the script, you need to do the following:

1. Ensure that the path to your project in the xx_pfadzumprojekt.txt file is correct. The xx_pfadzumprojekt.txt file must be in the same directory as your xx_syntax_commit.sh file.
   
3. Ensure that your local project has a remote on GitHub (it will, if you loaded it via VCS).

4. Run the script with this command in the terminal:

Navigate to the folder where the scripts are saved:<p>

cd /path/to/your/startscript/<br>
chmod +x xx_syntax_commit.sh<br>
sudo ./xx_syntax_commit.sh

This script will now auto commit your project every hour. Note that it will create a commit even if there are no changes to the project, and these commits will include a time stamp and a running number.
