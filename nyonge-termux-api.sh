#!/bin/bash

# Install jq if not installed
if ! command -v jq &> /dev/null; then
    echo "jq not found, installing..."
    pkg install jq -y
fi

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

# Function to display contacts
display_contacts() {
    echo "${BOLD}${GREEN}Contacts:${RESET}"
    termux-contact-list | jq . 2>/dev/null || termux-contact-list
    echo "Press any key to return to the menu..."
    read -n 1
}

# Function to show battery status
show_battery_status() {
    echo "${BOLD}${GREEN}Battery Status:${RESET}"
    termux-battery-status | jq . 2>/dev/null || termux-battery-status
    echo "Press any key to return to the menu..."
    read -n 1
}

# Function to list Wi-Fi networks
list_wifi_networks() {
    echo "${BOLD}${GREEN}Wi-Fi Networks:${RESET}"
    termux-wifi-scaninfo | jq . 2>/dev/null || termux-wifi-scaninfo
    echo "Press any key to return to the menu..."
    read -n 1
}

# Function to check device location
check_device_location() {
    echo "${BOLD}${GREEN}Device Location:${RESET}"
    termux-location | jq . 2>/dev/null || termux-location
    echo "Press any key to return to the menu..."
    read -n 1
}

# Function to show device info
show_device_info() {
    echo "${BOLD}${GREEN}Device Info:${RESET}"
    termux-telephony-deviceinfo | jq . 2>/dev/null || termux-telephony-deviceinfo
    echo "Press any key to return to the menu..."
    read -n 1
}

# Function to show call log
show_call_log() {
    echo "${BOLD}${GREEN}Call Log:${RESET}"
    termux-call-log | jq . 2>/dev/null || termux-call-log
    echo "Press any key to return to the menu..."
    read -n 1
}

# Function to vibrate device
vibrate_device() {
    echo -n "${BOLD}${YELLOW}Enter duration in milliseconds: ${RESET}"
    read duration
    termux-vibrate -d $duration
    echo "${BOLD}${GREEN}Device vibrated for $duration ms.${RESET}"
    echo "Press any key to return to the menu..."
    read -n 1
}

# Function to control torch
torch_control() {
    echo -n "${BOLD}${YELLOW}Enter 'on' to turn on the torch or 'off' to turn off: ${RESET}"
    read state
    termux-torch $state
    echo "${BOLD}${GREEN}Torch turned $state.${RESET}"
    echo "Press any key to return to the menu..."
    read -n 1
}

# Function to show storage info
show_storage_info() {
    echo "${BOLD}${GREEN}Storage Info:${RESET}"
    termux-storage-get | jq . 2>/dev/null || termux-storage-get
    echo "Press any key to return to the menu..."
    read -n 1
}

# Function to record audio
record_audio() {
    echo -n "${BOLD}${YELLOW}Enter duration in seconds: ${RESET}"
    read duration
    termux-audio-record -d $duration -f 3gp -o /sdcard/audio_record.3gp
    echo "${BOLD}${GREEN}Audio recorded for $duration seconds.${RESET}"
    echo "Press any key to return to the menu..."
    read -n 1
}

# Function to take photo
take_photo() {
    echo -n "${BOLD}${YELLOW}Enter file name (without extension): ${RESET}"
    read filename
    termux-camera-photo -c back /sdcard/$filename.jpg
    echo "${BOLD}${GREEN}Photo saved as /sdcard/$filename.jpg.${RESET}"
    echo "Press any key to return to the menu..."
    read -n 1
}

# Function to scan barcode
scan_barcode() {
    echo "${BOLD}${GREEN}Scan a barcode...${RESET}"
    termux-camera-photo -c back /sdcard/barcode.jpg
    termux-barcode-scan
    echo "Press any key to return to the menu..."
    read -n 1
}

# Function to send SMS
send_sms() {
    echo -n "${BOLD}${YELLOW}Enter phone number: ${RESET}"
    read number
    echo -n "${BOLD}${YELLOW}Enter message: ${RESET}"
    read message
    termux-sms-send -n $number "$message"
    echo "${BOLD}${GREEN}SMS sent to $number.${RESET}"
    echo "Press any key to return to the menu..."
    read -n 1
}

# Function to make toast
make_toast() {
    echo -n "${BOLD}${YELLOW}Enter message: ${RESET}"
    read message
    termux-toast "$message"
    echo "${BOLD}${GREEN}Toast made with message: $message.${RESET}"
    echo "Press any key to return to the menu..."
    read -n 1
}

# Function to show sensor info
show_sensor_info() {
    echo "${BOLD}${GREEN}Sensor Info:${RESET}"
    termux-sensor -l
    echo "Press any key to return to the menu..."
    read -n 1
}

# Function to show network info
show_network_info() {
    echo "${BOLD}${GREEN}Network Info:${RESET}"
    termux-wifi-connectioninfo | jq . 2>/dev/null || termux-wifi-connectioninfo
    echo "Press any key to return to the menu..."
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
                    1) display_contacts ;;
                    2) show_call_log ;;
                    3) send_sms ;;
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
                    1) show_battery_status ;;
                    2) show_device_info ;;
                    3) check_device_location ;;
                    4) break ;;
                    *) echo "${BOLD}${RED}Invalid option. Please try again.${RESET}" ;;
                esac
            done
            ;;
        3)
            while true; do
                display_title
                display_network_menu
                read choice
                case $choice in
                    1) list_wifi_networks ;;
                    2) show_network_info ;;
                    3) break ;;
                    *) echo "${BOLD}${RED}Invalid option. Please try again.${RESET}" ;;
                esac
            done
            ;;
        4)
            while true; do
                display_title
                display_sensors_menu
                read choice
                case $choice in
                    1) show_sensor_info ;;
                    2) vibrate_device ;;
                    3) break ;;
                    *) echo "${BOLD}${RED}Invalid option. Please try again.${RESET}" ;;
                esac
            done
            ;;
        5)
            while true; do
                display_title
                display_storage_menu
                read choice
                case $choice in
                    1) show_storage_info ;;
                    2) break ;;
                    *) echo "${BOLD}${RED}Invalid option. Please try again.${RESET}" ;;
                esac
            done
            ;;
        6)
            while true; do
                display_title
                display_system_menu
                read choice
                case $choice in
                    1) torch_control ;;
                    2) make_toast ;;
                    3) break ;;
                    *) echo "${BOLD}${RED}Invalid option. Please try again.${RESET}" ;;
                esac
            done
            ;;
        7)
            while true; do
                display_title
                display_media_menu
                read choice
                case $choice in
                    1) record_audio ;;
                    2) take_photo ;;
                    3) scan_barcode ;;
                    4) break ;;
                    *) echo "${BOLD}${RED}Invalid option. Please try again.${RESET}" ;;
                esac
            done
            ;;
        8) echo "${BOLD}${RED}Exiting...${RESET}"; exit 0 ;;
        *) echo "${BOLD}${RED}Invalid option. Please try again.${RESET}" ;;
    esac
done
