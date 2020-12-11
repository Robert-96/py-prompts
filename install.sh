#!/bin/sh

ESC="\033"
RESET="${ESC}[0m"

BLACK_FG="${ESC}[30m"
RED_FG="${ESC}[31m"
GREEN_FG="${ESC}[32m"
YELLOW_FG="${ESC}[33m"
BLUE_FG="${ESC}[34m"
PURPLE_FG="${ESC}[35m"
CYAN_FG="${ESC}[36m"
WHITE_FG="${ESC}[37m"

BOLD_ON="${ESC}[1m"
BOLD_OFF="${ESC}[22m"
ITALIC_ON="${ESC}[3m"
ITALIC_OFF="${ESC}[23m"

ROOT_DIR=$HOME/.py-prompts
REPO_URL="https://github.com/Robert-96/py-prompts.git"


clone_repo() {
    rm -rf $ROOT_DIR

    echo "Cloning repository: ${BOLD_ON}${BLUE_FG}$REPO_URL${RESET} at ${BOLD_ON}${BLUE_FG}$ROOT_DIR${RESET}."

    echo "${ITALIC_ON}"
    git clone $REPO_URL $ROOT_DIR
    echo "${ITALIC_OFF}"
}


update_script() {
    NAME=$1

    echo "Login script detected: ${BOLD_ON}${BLUE_FG}$NAME${RESET}."
    echo "Updating PATH variable and exporting it through ${BOLD_ON}${BLUE_FG}$HOME/$NAME${RESET}."
    echo ""

    echo "# Add .py-prompts to your PATH variable" >> $HOME/$NAME
    echo "export PATH=\"\$PATH:$HOME/.py-prompts\"" >> $HOME/$NAME
    echo "source \$HOME/.py-prompts/current-prompt.sh" >> $HOME/$NAME

    echo "${GREEN_FG}${BOLD_ON}py-prompts${BOLD_OFF} is now installed on your machine.${RESET}"
}


main() {
    clone_repo

    FILES=( ".zshrc" ".bashrc" ".bash_profile" ".profile" )

    for file in "${FILES[@]}"; do
        if [ -f $HOME/$file ]; then
            grep -q ".py-prompts" $HOME/$file

            if [ $? -ne 0 ]; then
                update_script $file
            else
                echo "${YELLOW_FG}${BOLD_ON}py-prompts${BOLD_OFF} is already installed.${RESET}"
            fi

            exit 0
        fi
    done

    echo "${YELLOW_FG}"
    echo "Could not detect your login script. Add the following line in your login script file:"
    echo "${ITALIC_ON}"
    echo "export PATH=\"\$PATH:\$HOME/.py-prompts\""
    echo "source \$HOME/.py-prompts/current-prompt.sh"
    echo "${ITALIC_OFF}${RESET}"

    exit 1
}

main
