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


print_help() {
    echo "${YELLOW_FG}Usage:${RESET}"
    echo ""
    echo "  ${ITALIC_ON}py-prompts COMMAND [ARGS]${ITALIC_OFF}"
    echo ""
    echo "${YELLOW_FG}Commands:${RESET}"
    echo ""
    echo "  ${BOLD_ON}${GREEN_FG}help${RESET}    - Show this message and exit."
    echo "  ${BOLD_ON}${GREEN_FG}list/ls${RESET} - Lists all available prompts."
    echo "  ${BOLD_ON}${GREEN_FG}set${RESET}     - Set a new prompt."
    echo ""
}


print_list() {
    echo "${BOLD_ON}Available prompts:${BOLD_OFF}"
    echo "${YELLOW_FG}${ITALIC_ON}"
    ls $HOME/.py-prompts/prompts | awk -F. '{print "  "$1}'
    echo "${RESET}"
}


set_prompt() {
    PROMPT=$1
    FILE="$HOME/.py-prompts/current-prompt.sh"

    if [ -z "$PROMPT" ]; then
        echo "${RED_FG}Error: Usage - py-prompts set ${BOLD_ON}<PROMPT_NAME>${RESET}"
        echo ""
        print_list

        exit 1
    elif [ ! -f "$HOME/.py-prompts/prompts/$PROMPT.py" ]; then
        echo "${RED_FG}Error: Prompt ${BOLD_ON}$PROMPT${BOLD_OFF} does not exist.${RESET}"
        echo ""
        print_list

        exit 1
    fi

    echo "Set ${BOLD_ON}$PROMPT${RESET} as your current prompt."
    echo ""

    echo "#!/bin/sh" > $FILE
    echo "" > $FILE
    echo "export PYTHONSTARTUP=\$HOME/.py-prompts/prompts/$PROMPT.py" > $FILE

    echo "${BOLD_ON}${GREEN_FG}The prompt was set successfully!${RESET}"
    echo "${YELLOW_FG}Note: The changes will take effect from the next terminal session.${RESET}"
}


main() {
    COMMAND=$1

    if [ -z $COMMAND ]; then
        print_help
        exit 1
    fi

    if [ "$COMMAND" = "help" ]; then
        print_help
        exit 0
    fi

    if [ "$COMMAND" = "list" ] || [ "$COMMAND" = "ls" ]; then
        print_list
        exit 0
    fi

    if [ "$COMMAND" = "set" ]; then
        set_prompt $2
        exit 0
    fi

    echo "${RED_FG}Error: No such command '$COMMAND'.${RESET}"
    echo ""

    print_help
    exit 1
}


main $@
