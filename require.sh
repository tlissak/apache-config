#!/bin/bash

# COLORS
color() {
  Color_Off='\033[0m'       # Text Reset
  Yellow=$(echo "\033[33m")
  Blue=$(echo "\033[36m")
  Red=$(echo "\033[01;31m")
  Purple=$(echo "\033[0;35m")
  Cyan=$(echo "\033[0;36m")  
  Green=$(echo "\033[1;92m")
  #DGN=$(echo "\033[32m")
  #BGN=$(echo "\033[4;92m")
  CL=$(echo "\033[m")
  CM="${Green}✓${CL}"
  CROSS="${Red}✗${CL}"
  BFR="\\r\\033[K"
  HOLD=" "
}
# This function displays an informational message with a yellow color. msg_info "Your message"
msg_info() {
  #local msg="$1"
  #echo -ne " ${HOLD} ${Yellow}${msg}"

  #printf "\e[?25h"
  local msg="$1"
  echo -e "${BFR} ${Yellow}${msg}${CL}"
}

# This function displays a success message with a green color. usage : msg_ok "Your message"
msg_ok() {
  printf "\e[?25h"
  local msg="$1"
  echo -e "${BFR} ${CM} ${Green}${msg}${CL}"
}

# This function displays a error message with a red color. msg_error "Your message"
msg_error() {
  printf "\e[?25h"
  local msg="$1"
  echo -e "${BFR} ${CROSS} ${Red}${msg}${CL}"
}

catch_errors() {
  set -Eeuo pipefail
  trap 'error_handler $LINENO "$BASH_COMMAND"' ERR
}

# This function is called when an error occurs. It receives the exit code, line number, and command that caused the error, and displays an error message.
error_handler() {
  printf "\e[?25h"
  local exit_code="$?"
  local line_number="$1"
  local command="$2"
  local error_message="${Red}[ERROR]${CL} in line ${Red}$line_number${CL}: exit code ${Red}$exit_code${CL}: while executing command ${Yellow}$command${CL}"
  echo -e "\n$error_message\n"
}


updateOS() {
	# Update system repos
	msg_info "Updating package repositories.."
	apt-get -qq update 
	msg_ok "Update sys done"
}




cleanup() {
	msg_info "Cleaning up"
	apt-get -qqy autoremove
	apt-get -qqy autoclean
	msg_ok "Cleaned"
}

