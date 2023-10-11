*** Settings ***
Resource                ../keywords/common.robot
Test Setup              Setup
Test Teardown           Tear Down

*** Test Cases ***
### Link to Testcases: https://docs.google.com/spreadsheets/d/1DbP64bT7QpASuE3NeiIVDdeHpdrKQon3HqF9rsUzbFU/edit#gid=1999164743 ###

### Verify the User Interface of the Login Page ###
LO_02 Verify showing password when click on eye icon in "Mật khẩu" field
  [Tags]                                                                                            MainPage                         UI
  When Enter "password" in "Mật khẩu" with "_RANDOM_"
  When Click on eye icon in "Mật khẩu" field
  Then The hidden password in "Mật khẩu" field should be visibled as "_@Mật khẩu@_"

LO_03 Verify that login successfully when enter the valid data (admin account)
  [Tags]                                                                                            Login                            Valid                            Smoketest
  When Enter "email" in "Email" with "admin@gmail.com"
  When Enter "password" in "Mật khẩu" with "123123"
  When Click "Đăng nhập" button
  Then User look message "Success" popup

### Verify that login with leaving a blank field ###
LO_04 Verify that log in with leaving the blank field in "Email"
  [Tags]                                                                                            Login                            BlankField                       Smoketest
  When Enter "password" in "Mật khẩu" with "123123"
  When Click "Đăng nhập" button
  Then Required message "Xin vui lòng nhập email" displayed under "Email" field

LO_05 Verify that log in with leaving the blank field in "Mật khẩu"
  [Tags]                                                                                            Login                            BlankField                       Smoketest
    When Enter "email" in "Email" with "_RANDOM_"
  When Click "Đăng nhập" button
  Then Required message "Xin vui lòng nhập mật khẩu" displayed under "Mật khẩu" field

### Verify the login when enter the invalid data ###
LO_06 Verify that login with entering the invalid data in "Email" field
  [Tags]                                                                                            Login                            Invalid                         Smoketest
  When Enter "email" in "Email" with "_RANDOM_"
  When Enter "password" in "Mật khẩu" with "123123"
  When Click "Đăng nhập" button
  Then User look message "Tài khoản _@Email@_ không tồn tại trong hệ thống. Vui lòng đăng ký mới." popup in login

### Verify the remember account function ###
LO_07 Verify the remember account function when click on "Ghi nhớ" check field
  [Tags]                                                                                            Login                            Remember
  When Enter "email" in "Email" with "admin@gmail.com"
  When Enter "password" in "Mật khẩu" with "123123"
  When Click on "Ghi nhớ" check box
  When Click "Đăng nhập" button
  Then User look message "Success" popup
  When Log out account
