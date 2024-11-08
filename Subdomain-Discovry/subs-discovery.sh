#!/bin/bash

result_dir_fun(){
    if [ -d "results" ]; then
        cd results
    else
        mkdir results
        cd results
    fi
}
result_dir_fun


subfinder_tool(){
    local attack=$1
    subfinder -d "$attack" -all -silent | tee subfinder-subdomains
}

sublist3r_tool(){
    local attack=$1
    sublist3r -d "$attack" -o sublister
}

crt_tool(){
    local attack=$1
    curl -s "https://crt.sh/?q=$attack&output=json" | jq -r '.[].common_name' | sed 's/\*\.//g' | sort -u | sudo tee crt-subdomains
}

assetfinder_tool(){
    local attack=$1
    assetfinder "$attack" -subs-only | tee assetfinder-subdomains
}

knock_tool(){
    local attack=$1
    knockpy -d "$attack" --bruteforce --recon
    cat *.json | grep "com [" | sort -u | tee knockpy-subdomains
}

findomain_tool(){
    local attack=$1
    findomain -t "$attack" -q | tee findomin-subdomains
}

echo "
        Welcome to the Subdomain Discovery Script
"

# Start Function
start_fun(){
    echo "
        MENU

    Wildcard [1]            Exit [0]

    "
    read -p "Enter Option: " user_option
}

start_fun

while true; do
	start_chose_fun() {
		if [ "$user_option" = 1 ]; then
			# Ask for wildcard
			read -p "
Enter Wildcard: " user_wildcard

			user_tools_fun() {
				echo "

                        Tools:

            - assetfinder       - crt.sh [website]
            - findomain         - knockpy
            - subfinder         - sublist3r

            Wildcard: $user_wildcard

            Run All [1]             Not all, select tools [2]

            Change Wildcard [3]      Exit [0]

				"
				read -p "Enter Option: " user_tools_option

				if [ "$user_tools_option" = 1 ]; then
					echo "Starting Discovery..."
					assetfinder_tool "$user_wildcard"
					crt_tool "$user_wildcard"
					findomain_tool "$user_wildcard"
					knock_tool "$user_wildcard"
					subfinder_tool "$user_wildcard"
					sublist3r_tool "$user_wildcard"
					echo "Process Completed (:"
					exit 0
				elif [ "$user_tools_option" = 2 ]; then
					selected_tools=()
					echo "
                                            Available tools:
                    "
					echo "          1. assetfinder       2. crt.sh [website]
                    "
					echo "          3. findomain         4. sublist3r
                    "
					echo "          5. knockpy           6. subfinder

                    "

					# Read the selected tools from the user
					read -p "Enter tools to run (space-separated, e.g., 1 2 3): " -a user_input
					for option in "${user_input[@]}"; do
						case $option in
							1) selected_tools+=("assetfinder_tool") ;;
							2) selected_tools+=("crt_tool") ;;
							3) selected_tools+=("findomain_tool") ;;
							4) selected_tools+=("sublist3r_tool") ;;
							5) selected_tools+=("knock_tool") ;;
							6) selected_tools+=("subfinder_tool") ;;
							*) echo "Invalid option: $option" ;;
						esac
					done

					# Ask to confirm starting the selected tools
					read -p "
Enter 'start' to run the selected tools, or 'exit' to quit.
                    
Enter Option: " user_command

					if [[ "$user_command" =~ ^(start|START|Start)$ ]]; then
						for tool in "${selected_tools[@]}"; do
							$tool "$user_wildcard"
						done
					elif [[ "$user_command" =~ ^(exit|EXIT|Exit)$ ]]; then
						echo "Exiting..."
						exit 0
					else
						echo "Invalid command."
						user_tools_fun
					fi
					exit 0
				elif [ "$user_tools_option" = 3 ]; then
					echo "Wrong Wildcard entered. Please try again."
					start_chose_fun
				elif [ "$user_tools_option" = 0 ]; then
					echo "Exiting..."
					exit 0
				else
					echo "Invalid option."
					user_tools_fun
				fi
			}

			user_tools_fun

		elif [ "$user_option" = 0 ]; then
			echo "Exiting..."
			exit 0
		else
			echo "Wrong Option"
			start_fun
		fi
	}
	start_chose_fun
done