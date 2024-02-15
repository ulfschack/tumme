Detta repo använder jag som en global usb-pinne. Jag har lagt till två
quick actions (macOS) så jag kan högerklicka i Finder för att push:a
valfri fil, samt för att ta bort. Repot är statiskt och heter:
~/gits/tumme (men använder $HOME i scripten eftersom de har svårt med
tilde)

======================  Push ============================

Skapa filen ~/.gitpushconfig, som innehåller din gh-token, och inget annat

1. Öppna Automator

2. Quick Action

3. Run shell script
---------------------------------------
#!/bin/bash

# Your existing setup
GITUSERNAME="ulfschack"
TOKEN=$(<"$HOME/.gitpushconfig")
FILE_PATH=$1
FILE_NAME=$(basename "$FILE_PATH")

REPO_NAME="tumme"
REPO_PATH="$HOME/gits/$REPO_NAME"

mkdir -p "$REPO_PATH"
cp "$FILE_PATH" "$REPO_PATH/"
cd "$REPO_PATH"

# Pajpa till dev null så git-output inte klottrar popuppen
git add "$FILE_NAME" > /dev/null 2>&1
git commit -m "Adding $FILE_NAME" > /dev/null 2>&1
git push https://$TOKEN@github.com/$GITUSERNAME/$REPO_NAME.git main > /dev/null 2>&1

# Only echo the URL at the end
echo "https://$GITUSERNAME.github.io/$REPO_NAME/$FILE_NAME"
---------------------------------------------------


4. Run apple script
------------------------------------------------------
on run {input, parameters}
    tell application "System Events"
        display dialog input as string buttons {"OK"} default button "OK"
    end tell
    return input
end run
------------------------------------------------------

================================= END PUSH ======================





================================= Remove ========================


Samma som för push, fast med denna kod


1. Run shell Script
---------------------------------------------------
GITUSERNAME="ulfschack"
REPO_NAME="tumme"
TOKEN=$(<"$HOME/.gitpushconfig")
REPO_PATH="$HOME/gits/$REPO_NAME"

for FILE_PATH in "$@"
do
  FILE_NAME=$(basename "$FILE_PATH")
  cd "$REPO_PATH"
  git rm "$FILE_NAME" > /dev/null 2>&1
  git commit -m "Removed $FILE_NAME via Quick Action" > /dev/null 2>&1
  git push https://$TOKEN@github.com/$GITUSERNAME/$REPO_NAME.git main > /dev/null 2>&1
done

echo "Selected files removed from $REPO_NAME."
------------------------------------------------------


2. Run Apple Script
----------------------------------------------------------
(Samma som ovan)
---------------------------------------------------------

================================= END REMOVE =========================
