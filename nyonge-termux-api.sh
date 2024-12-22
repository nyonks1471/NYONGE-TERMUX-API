#!/bin/bash

# Install necessary packages if not installed
install_if_missing() {
    if ! command -v $1 &> /dev/null; then
        echo "$1 not found, installing..."
        pkg install $1 -y
    fi
}

install_if_missing jq
install_if_missing lolcat
install_if_missing cowsay

# Colors and text effects
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
BOLD=$(tput bold)
RESET=$(tput sgr0)

# Function to display the animated title
display_title() {
    clear
    echo "${BOLD}${CYAN}"
    echo "============================"
    echo "    Nyonge Termux API"
    echo "============================"
    echo "${RESET}"
}

# Function to show loading bar
loading_bar() {
    echo -n "${CYAN}Loading..."
    for i in {1..10}; do
        sleep 0.3
        echo -n "."
    done
    echo "${RESET}"
}

# Function to log outputs to a file for debugging
log_output() {
    echo "$1" >> termux_log.txt
}

# Function to display the main menu
display_main_menu() {
    echo "${BOLD}${YELLOW}Main Menu${RESET}"
    echo "============================"
    echo "${CYAN}1. Contacts"
    echo "2. Device Info"
    echo "3. Network"
    echo "4. Sensors"
    echo "5. Storage"
    echo "6. System"
    echo "7. Media"
    echo "8. Messaging"
    echo "9. Exit${RESET}"
    echo "============================"
    echo -n "${BOLD}${YELLOW}Choose a category: ${RESET}"
}

# Function to display the contacts menu
display_contacts_menu() {
    echo "${BOLD}${YELLOW}Contacts Menu${RESET}"
    echo "============================"
    echo "${CYAN}1. Display Contacts"
    echo "2. Show Call Log"
    echo "3. Send SMS"
    echo "4. Back to Main Menu${RESET}"
    echo "============================"
    echo -n "${BOLD}${YELLOW}Choose an option: ${RESET}"
}

# Function to display the device info menu
display_device_info_menu() {
    echo "${BOLD}${YELLOW}Device Info Menu${RESET}"
    echo "============================"
    echo "${CYAN}1. Show Battery Status"
    echo "2. Show Device Info"
    echo "3. Check Device Location"
    echo "4. Back to Main Menu${RESET}"
    echo "============================"
    echo -n "${BOLD}${YELLOW}Choose an option: ${RESET}"
}

# Function to display the network menu
display_network_menu() {
    echo "${BOLD}${YELLOW}Network Menu${RESET}"
    echo "============================"
    echo "${CYAN}1. List Wi-Fi Networks"
    echo "2. Network Information"
    echo "3. Back to Main Menu${RESET}"
    echo "============================"
    echo -n "${BOLD}${YELLOW}Choose an option: ${RESET}"
}

# Function to display the sensors menu
display_sensors_menu() {
    echo "${BOLD}${YELLOW}Sensors Menu${RESET}"
    echo "============================"
    echo "${CYAN}1. Show Sensor Information"
    echo "2. Vibrate Device"
    echo "3. Back to Main Menu${RESET}"
    echo "============================"
    echo -n "${BOLD}${YELLOW}Choose an option: ${RESET}"
}

# Function to display the storage menu
display_storage_menu() {
    echo "${BOLD}${YELLOW}Storage Menu${RESET}"
    echo "============================"
    echo "${CYAN}1. Show Storage Info"
    echo "2. Back to Main Menu${RESET}"
    echo "============================"
    echo -n "${BOLD}${YELLOW}Choose an option: ${RESET}"
}

# Function to display the system menu
display_system_menu() {
    echo "${BOLD}${YELLOW}System Menu${RESET}"
    echo "============================"
    echo "${CYAN}1. Torch Control"
    echo "2. Make Toast"
    echo "3. Back to Main Menu${RESET}"
    echo "============================"
    echo -n "${BOLD}${YELLOW}Choose an option: ${RESET}"
}

# Function to display the media menu
display_media_menu() {
    echo "${BOLD}${YELLOW}Media Menu${RESET}"
    echo "============================"
    echo "${CYAN}1. Record Audio"
    echo "2. Take Photo"
    echo "3. Scan Barcode"
    echo "4. Back to Main Menu${RESET}"
    echo "============================"
    echo -n "${BOLD}${YELLOW}Choose an option: ${RESET}"
}

# Function to send SMS with success message
send_sms() {
    echo -n "${BOLD}${YELLOW}Enter phone number: ${RESET}"
    read number
    echo -n "${BOLD}${YELLOW}Enter message: ${RESET}"
    read message
    termux-sms-send -n $number "$message"
    echo "${BOLD}${GREEN}SMS sent to $number.${RESET}"
    echo "${GREEN}Operation successfully completed. Press any key to return.${RESET}"
    log_output "SMS sent to $number: $message"
    read -n 1
}

# Main loop
while true; do
    display_title
    display_main_menu
    read category
    case $category in
        1)
            while true; do
                display_title
                display_contacts_menu
                read choice
                case $choice in
                    1) 
                        loading_bar
                        termux-contact-list | jq . || termux-contact-list
                        ;;
                    2) 
                        loading_bar
                        termux-call-log | jq . || termux-call-log
                        ;;
                    3) 
                        send_sms
                        ;;
                    4) break ;;
                    *) echo "${BOLD}${RED}Invalid option. Please try again.${RESET}" ;;
                esac
            done
            ;;
        2)
            while true; do
                display_title
                display_device_info_menu
                read choice
                case $choice in
                    1) 
                        show_battery_status
                        ;;
                    2) 
                        show_device_info
                        ;;
                    3) 
                        check_device_location
                        ;;
                    4) break ;;
                    *) echo "${BOLD}${RED}Invalid option. Please try again.${RESET}" ;;
                esac
            done
            ;;
        9) 
            echo "Exiting. Goodbye!"
            exit 0
            ;;
        *)
            echo "${BOLD}${RED}Invalid option. Please try again.${RESET}"
            ;;
    esac
done
