# Github Auto Timeclock
If your school or employer requires evidence of your activity on GitHub, the Auto Timeclock tool is perfect for you! It automates the process of making commits to your projects by creating a commit at a certain time (or random times), tracking your activity without the hassle. With this tool, you can focus on your work or learning while letting automation handle the rest. Don't hesitate to send in Issues or Pull Requests! Happy learning!

## Features
- Makes a commit every hour, 2 hours, 6 hours, 12 hours or at a random time
- Allows for empty commits (creates a commit even if there are no changes)
- Each commit includes a timestamp and a sequence number

## How to Use
1. Download this Repo onto your Mac
2. Edit this file: `xx_pfadzumprojekt.txt` giving it the path to your project you wish to auto-commit
3. Make sure your local project has a remote repository on GitHub. If you loaded your project using a Version Control System (VCS), it will already have a remote set up.
4. Open the `xx_autoclock.sh` script file and adjust the time interval between commits by uncommenting the corresponding line (instructions are in the script file).
5. Run the script with the following command in your terminal:

```cd /path/to/your/startscript/```  
```chmod +x xx_autoclock.sh```  
```./xx_autoclock.sh```  

This script will now auto-commit to your project, and it will create a commit even if there are no changes to the project. These commits will include a timestamp and a sequence number.

I hope this tool will make your learning journey smoother by taking care of the commit process. You can now focus on what truly matters: Learning and growing!

#HappyCoding #SyntaxInstitute #GitHub #Automation #Learning #hacks
