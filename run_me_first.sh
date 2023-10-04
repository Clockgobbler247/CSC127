#!/bin/bash

# Run startup scripts
/etc/scripts/CSC171/./setup.sh
/etc/scripts/CSC171/./users.sh
/etc/scripts/CSC171/./groups.sh


#Add directories and permissions
mkdir /home/HumanResources
mkdir /home/Incorporation
mkdir /home/Policy
mkdir /home/Collab

chgrp hr /home/HumanResources
chmod 770 /home/HumanResources
chgrp execs /home/Incorporation
chmod 770 /home/Incorporation
chgrp policy /home/Policy
chmod 770 /home/Policy
chgrp allstaff /home/Collab
chmod 770 /home/Collab

# Clear the terminal
clear

# Print ASCII art
echo "
    A-Team!           .,,uod8B8bou,,.
              ..,uod8BBBBBBBBBBBBBBBBRPFT?l!i:.
         ,=m8BBBBBBBBBBBBBBBRPFT?!||||||||||||||
         !...:!TVBBBRPFT||||||||||!!^^\"\"'   ||||
         !.......:!?|||||!!^^\"\"'            ||||
         !.........||||                     ||||
         !.........|||| Git                 ||||
         !.........||||   Gud               ||||
         !.........||||                     ||||
         !.........||||                     ||||
         !.........||||                     ||||
         !.........||||                    ,||||
          .;.......||||               _.-!!|||||
   .,uodWBBBBb.....||||       _.-!!|||||||||!:' 
!YBBBBBBBBBBBBBBb..!|||:..-!!|||||||!iof68BBBBBb....
!..YBBBBBBBBBBBBBBb!!||||||||!iof68BBBBBBRPFT?!::   \`.
!....YBBBBBBBBBBBBBBbaaitf68BBBBBBRPFT?!:::::::::     \`.
!......YBBBBBBBBBBBBBBBBBBBRPFT?!::::::;:!^\"\`;:::       \`.
!........YBBBBBBBBBBRPFT?!::::::::::^''...::::::;         iBBbo.
\`..........YBRPFT?!::::::::::::::::::::::::;iof68bo.      WBBBBbo.
  \`..........:::::::::::::::::::::::;iof688888888888b.     \`YBBBP^'
    \`........::::::::::::::::;iof688888888888888888888b.     \`
      \`......:::::::::;iof688888888888888888888888888888b.
        \`....:::;iof688888888888888888888888888888888899fT!
          \`..::!8888888888888888888888888888888899fT|!^\"'
            \`' !!988888888888888888888888899fT|!^\"'
                \`!!8888888888888888899fT|!^\"'
                  \`!988888888899fT|!^\"'
                    \`!9899fT|!^\"'
                      \`!^\""
