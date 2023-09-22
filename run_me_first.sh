#!/bin/bash

# Run startup scripts
/etc/scripts/CSC127/./setup.sh
/etc/scripts/CSC127/./users.sh
/etc/scripts/CSC127/./groups.sh

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
         `.........||||                    ,||||
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
                    \`!9899fT|!^"'
                      \`!^\""
