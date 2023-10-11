*** Settings ***
Resource                ../keywords/common.robot
Test Setup              Setup
Test Teardown           Tear Down
Library                 DateTime

*** Variables ***

*** Test Cases ***
### Link to Test Cases: https://docs.google.com/spreadsheets/d/1DbP64bT7QpASuE3NeiIVDdeHpdrKQon3HqF9rsUzbFU/edit#gid=1634097049 ###

### Check the User Interface of the Customer-Account page ###
CA_01 Verify that navigating to the right "Customer-Account" page
    [Tags]                                                                                       MainPage                                     UI                                          Smoketest
    Login to admin
    When Click "QUẢN LÝ TÀI KHOẢN" menu
    When Click "Tài khoản Người dùng" sub menu to "/customer-account"
    Then Heading should contains "Danh sách tài khoản khách hàng" inner Text
    Then Webpage should contains the list account from database
    Then Webpage should contains the search function
    Then Webpage should contains the "Ngày tham gia" filter function
    Then Webpage should contains the "Loại tài khoản" filter function
    Then Webpage should contains the "Trạng thái" filter function
    Then Webpage should contains the "Kích hoạt" filter function

CA_02 Verify the function changing the number of accounts show in each list
    [Tags]                                                                                        MainPage                                     UI                                          Smoketest
    Go to "Customer Account" page
    When Click on "second" selection to change the number of account show in list and check
    When Click on "third" selection to change the number of account show in list and check
    When Click on "fourth" selection to change the number of account show in list and check
    When Click on "fifth" selection to change the number of account show in list and check
    When Click on "third" selection to change the number of account show in list and check
    When Click on "second" selection to change the number of account show in list and check

CA_03 Verify the function of navigating the list of account page
    [Tags]                                                                                        MainPage                                     UI                                          Smoketest
    Go to "Customer Account" page
    Then Check the amount of page list
         ${Last_name}=                                                                            Get the last account name
    When Create another test account with "Farmer Side" type
    When Move to the "next" page
         ${First_name}=                                                                           Get the first account name
         Should Be Equal                                                                          ${First_name}                                ${Last_name}
    When Move to the "previous" page
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line
    When Move to the last page and check

CA_04 Verify the highlight table line function after operated
    [Tags]                                                                                        MainPage                                     UI
    Create a test account with "Farmer Side" type
    When Click on the "Sửa" button in the "_@Họ và tên@_" table line
    When Click "Đóng lại" button
    Then "_@Họ và tên@_" table line should be highlighted
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

### Verify the correct design in detail information's account page ###
CA_05 Verify that navigating to the right "Detail-information" page
    [Tags]                                                                                        DetailedInfo                                 UI                                          Smoketest
    Create a test account with "Farmer Side" type
    When Click on the "Chi tiết" button in the "_@Họ và tên@_" table line
    Then Heading should contains "Xem chi tiết thông tin tài khoản" inner Text
    When Click "Trở lại" button
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

CA_06_01 Check account information after creation (Farmer Side)
    [Tags]                                                                                        DetailedInfo                                 UI                                          Smoketest
    ${today}=                                                                                     Get Current Date                             local                                       result_format=%d/%m/%Y
    Create a test account with "Farmer Side" type
    When Click on the "Chi tiết" button in the "_@Họ và tên@_" table line
    Then Account's information in "Họ và tên" should be equal "_@Họ và tên@_"
    Then Account's information in "Email" should be equal "_@Email@_"
    Then Account's information in "Giới tính" should be equal "_@Giới tính@_"
    Then Account's information in "Loại tài khoản" should be equal "_@Loại tài khoản@_"
#    Then Account's information in "Số điện thoại" should be equal "_@Số điện thoại@_"
#    Then Account's information in "Ngày hoạt động cuối" should be equal "${today}"
    When Click "Trở lại" button
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

CA_06_02 Check account information after creation (Order Side)
    [Tags]                                                                                        DetailedInfo                                 UI                                          Smoketest
    ${today}=                                                                                     Get Current Date                             local                                       result_format=%d/%m/%Y
    Create a test account with "Order Side" type
    When Click on the "Chi tiết" button in the "_@Họ và tên@_" table line
    Then Account's information in "Họ và tên" should be equal "_@Họ và tên@_"
    Then Account's information in "Email" should be equal "_@Email@_"
    Then Account's information in "Giới tính" should be equal "_@Giới tính@_"
    Then Account's information in "Loại tài khoản" should be equal "_@Loại tài khoản@_"
#    Then Account's information in "Số điện thoại" should be equal "_@Số điện thoại@_"
#    Then Account's information in "Ngày hoạt động cuối" should be equal "${today}"
#    Then Account's information should contain "Số phòng khám" field
#    Then Account's information should contain "Tổng số đơn hàng" field
    When Click "Trở lại" button
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

### Verify the lock function ###
CA_07 Verify the lock funtion
    [Tags]                                                                                        Lock                                        Smoketest
    Create a test account with "Order Side" type
    When Click on the "Chi tiết" button in the "_@Họ và tên@_" table line
    When Click "Khóa" button
    Then User look message "Khóa tài khoản người dùng thành công !" popup
    When Click "Trở lại" button
    When Click filter "Kích hoạt" with "Khóa"
    Then Account "_@Họ và tên@_" should be visible in table line
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

CA_08 Verify the unlock function
    [Tags]                                                                                        Lock                                        Smoketest
    Create a test account with "Farmer Side" type
    When Click on the "Chi tiết" button in the "_@Họ và tên@_" table line
    When Click "Khóa" button
    Then User look message "Khóa tài khoản người dùng thành công !" popup
    When Click "Mở Khóa" button
    Then User look message "Mở khóa tài khoản người dùng thành công." popup
    When Click "Trở lại" button
    When Click filter "Kích hoạt" with "Mở Khóa"
    Then Account "_@Họ và tên@_" should be visible in table line
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

### Verify the search function ###
CA_09 Verify the search function when enter the existed name
    [Tags]                                                                                        Search                                      Smoketest
    Create a test account with "Farmer Side" type
    When Enter "test name" in "Tìm kiếm" with "_@Họ và tên@_"
    When Click on magnifier icon in search box
    Then Account "_@Họ và tên@_" should be visible in table line
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

CA_10 Verify the search function when enter the name was not existed
    [Tags]                                                                                        Search
    Create a test account with "Order Side" type
    When Enter "text" in "Tìm kiếm" with "opp"
    When Click on magnifier icon in search box
    Then Table line should show empty
    When Enter "test name" in "Tìm kiếm" with ""
    When Click on magnifier icon in search box
    Then Account "_@Họ và tên@_" should be visible in table line
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

CA_11 Check the update of account list after cancel the search action
    [Tags]                                                                                        Search
    ${AccountName}=                                                                               Create a test account with "Farmer Side" type
    Create another test account with "Order Side" type
    When Enter "text" in "Tìm kiếm" with "${AccountName}"
    When Click on magnifier icon in search box
    Then Account "${AccountName}" should be visible in table line
    Then Account "_@Họ và tên@_" should not be visible in table line
    When Enter "text" in "Tìm kiếm" with ""
    When Click on magnifier icon in search box
    Then Account "_@Họ và tên@_" should be visible in table line
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line
    When Click on the "Xóa" button in the "${AccountName}" table line

### Verify the filter function ###
CA_12 Verify the "Loại tài khoản" filter function when select "Farmer Side"
    [Tags]                                                                                        Filter
    Create a test account with "Farmer Side" type
    When Click filter "Loại tài khoản" with "Order Side"
    Then Account "_@Họ và tên@_" should not be visible in table line
    When Click filter "Loại tài khoản" with "Farmer Side"
    Then Account "_@Họ và tên@_" should be visible in table line
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

CA_13 Verify the "Loại tài khoản" filter function when select "Order Side"
    [Tags]                                                                                        Filter
    Create a test account with "Order Side" type
    When Click filter "Loại tài khoản" with "Farmer Side"
    Then Account "_@Họ và tên@_" should not be visible in table line
    When Click filter "Loại tài khoản" with "Order Side"
    Then Account "_@Họ và tên@_" should be visible in table line
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

CA_14 Verify the "Trạng thái" filter function when select "Đã xác thực"
    [Tags]                                                                                        Filter
    Create a test account with "Farmer Side" type
    When Click filter "Trạng thái" with "Chưa xác thực"
    Then Account "_@Họ và tên@_" should not be visible in table line
    When Click filter "Trạng thái" with "Đã xác thực"
    Then Account "_@Họ và tên@_" should be visible in table line
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

CA_15 Verify the "Trạng thái" filter function when select "Chưa xác thực"
    [Tags]                                                                                        Filter
    Create a test account with "Farmer Side" type
    When Click filter "Trạng thái" with "Chưa xác thực"
    Then Account "_@Họ và tên@_" should not be visible in table line
    When Click filter "Trạng thái" with "Đã xác thực"
    Then Account "_@Họ và tên@_" should be visible in table line
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

CA_16 Verify the "Kích hoạt" filter function when select "Khóa"
    [Tags]                                                                                        Filter
    Create a test account with "Farmer Side" type
    when Click on the "Chi tiết" button in the "_@Họ và tên@_" table line
    When Click "Khóa" button
    Then User look message "Khóa tài khoản người dùng thành công !" popup
    When Click "Trở lại" button
    When Click filter "Kích hoạt" with "Mở Khóa"
    Then Account "_@Họ và tên@_" should not be visible in table line
    When Click filter "Kích hoạt" with "Khóa"
    Then Account "_@Họ và tên@_" should be visible in table line
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

CA_17 Verify the "Kích hoạt" filter function when select "Mở Khóa"
    [Tags]                                                                                        Filter
    Create a test account with "Farmer Side" type
    When Click filter "Kích hoạt" with "Mở Khóa"
    Then Account "_@Họ và tên@_" should be visible in table line
    When Click filter "Kích hoạt" with "Khóa"
    Then Account "_@Họ và tên@_" should not be visible in table line
    When Click on cross icon in select "Kích hoạt"
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

CA_18 Verify the deselect filter function when click on cross button
    [Tags]                                                                                        Filter
    Create a test account with "Order Side" type
    When Click filter "Loại tài khoản" with "Farmer Side"
    Then Account "_@Họ và tên@_" should not be visible in table line
    When Click on cross icon in select "Loại tài khoản"
    Then Account "_@Họ và tên@_" should be visible in table line
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

CA_19 Verify the date selection filter function
    [Tags]                                                                                        Filter
    ${today}=                                                                                     Get Current Date                             local                   result_format=%Y-%m-%d
    ${yesterday}=                                                                                 Get Current Date                             local                   - 1 day                        result_format=%Y-%m-%d
    Create a test account with "Farmer Side" type
    When Enter date in placeholder "Bắt đầu" with "${yesterday}"
    When Enter date in placeholder "Kết thúc" with "${yesterday}"
    Then Account "_@Họ và tên@_" should not be visible in table line
    When Enter date in placeholder "Bắt đầu" with "${today}"
    When Enter date in placeholder "Kết thúc" with "${today}"
    Then Account "_@Họ và tên@_" should be visible in table line
    Then Click on the "Xóa" button in the "_@Họ và tên@_" table line

CA_20 Verify the filter function by applying all filter at the same time
    [Tags]                                                                                        Filter
    ${today}=                                                                                     Get Current Date                             local                   result_format=%Y-%m-%d
    Create a test account with "Farmer Side" type
    When Click filter "Loại tài khoản" with "Farmer Side"
    When Enter date in placeholder "Bắt đầu" with "${today}"
    When Enter date in placeholder "Kết thúc" with "${today}"
    When Click filter "Trạng thái" with "Đã xác thực"
    When Click filter "Kích hoạt" with "Mở Khóa"
    Then Account "_@Họ và tên@_" should be visible in table line
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

### Verify the creating account function ###
CA_21 Verify "Tạo mới" button function
    [Tags]                                                                                        Create                                      Smoketest
    Go to "Customer Account" page
    When Click "Tạo mới" button
    Then Heading should contains "Tạo mới tài khoản khách hàng" inner Text
    Then Confirm adding account "/customer-account" page

CA_22 Create new customer account with the valid data
    [Tags]                                                                                        Create                                      Smoketest
    Go to page create account "Tài khoản Người dùng" with "/customer-account"
    When Enter "test name" in "Họ và tên" with "_RANDOM_"
    When Enter "email" in "Email" with "_RANDOM_"
    When Enter "phone" in "Số điện thoại" with "_RANDOM_"
    When Click select "Giới tính" with "Nam"
    When Click select "Loại tài khoản" with "Farmer Side"
    When Enter "password" in "Mật khẩu" with "_RANDOM_"
    When Enter "password" in "Xác nhận mật khẩu" with "_@Mật khẩu@_"
    When Click "Lưu lại" button
    Then User look message "Tạo tài khoản thành công" popup
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

CA_23 Verify showing "Mật khẩu" and "Xác nhận mật khẩu" on "Tạo mới" page
    [Tags]                                                                                        Create                                      Smoketest
    Go to page create account "Tài khoản Người dùng" with "/customer-account"
    When Enter "password" in "Mật khẩu" with "_RANDOM_"
    When Enter "password" in "Xác nhận mật khẩu" with "_@Mật khẩu@_"
    When Click on eye icon in "Mật khẩu" field
    Then The hidden password in "Mật khẩu" field should be visibled as "_@Mật khẩu@_"
    When Click on eye icon in "Xác nhận mật khẩu" field
    Then The hidden password in "Xác nhận mật khẩu" field should be visibled as "_@Xác nhận mật khẩu@_"
    When Click "Đóng lại" button

CA_24 Check the update of account list after creating a new account
    [Tags]                                                                                        Create                                      Smoketest
    Go to "Customer Account" page
    When Create another test account with "Farmer Side" type
    Then Account "_@Họ và tên@_" should be visible in table line
    Then Click on the "Xóa" button in the "_@Họ và tên@_" table line

### Create new account with blank field ###
CA_25 Create a new account with all blank fields
    [Tags]                                                                                        Create                                      BlankField
    Go to page create account "Tài khoản Người dùng" with "/customer-account"
    When Click "Lưu lại" button
    Then Required message "Xin vui lòng nhập họ và tên" displayed under "Họ và tên" field
    Then Required message "Xin vui lòng nhập email" displayed under "Email" field
    Then Required message "Xin vui lòng nhập số điện thoại" displayed under "Số điện thoại" field
    Then Required message "Xin vui lòng chọn giới tính" displayed under "Giới tính" field
    Then Required message "Xin vui lòng chọn loại tài khoản" displayed under "Loại tài khoản" field
    Then Required message "Xin vui lòng nhập mật khẩu" displayed under "Mật khẩu" field
    Then Required message "Xin vui lòng nhập xác nhận mật khẩu" displayed under "Xác nhận mật khẩu" field

CA_26 Create a new account when leaving "Họ và tên" field blank
    [Tags]                                                                                        Create                                      BlankField
    Go to page create account "Tài khoản Người dùng" with "/customer-account"
    When Enter "email" in "Email" with "_RANDOM_"
    When Enter "phone" in "Số điện thoại" with "_RANDOM_"
    When Click select "Giới tính" with "Nam"
    When Click select "Loại tài khoản" with "Farmer Side"
    When Enter "password" in "Mật khẩu" with "_RANDOM_"
    When Enter "password" in "Xác nhận mật khẩu" with "_@Mật khẩu@_"
    When Click "Lưu lại" button
    Then Required message "Xin vui lòng nhập họ và tên" displayed under "Họ và tên" field

CA_27 Create a new account when leaving "Email" field blank
    [Tags]                                                                                        Create                                      BlankField
    Go to page create account "Tài khoản Người dùng" with "/customer-account"
    When Enter "test name" in "Họ và tên" with "_RANDOM_"
    When Enter "phone" in "Số điện thoại" with "_RANDOM_"
    When Click select "Giới tính" with "Nam"
    When Click select "Loại tài khoản" with "Farmer Side"
    When Enter "password" in "Mật khẩu" with "_RANDOM_"
    When Enter "password" in "Xác nhận mật khẩu" with "_@Mật khẩu@_"
    When Click "Lưu lại" button
    Then Required message "Xin vui lòng nhập email" displayed under "Email" field

CA_28 Create a new account when leaving "Số điện thoại" field blank
    [Tags]                                                                                        Create                                      BlankField
    Go to page create account "Tài khoản Người dùng" with "/customer-account"
    When Enter "test name" in "Họ và tên" with "_RANDOM_"
    When Enter "email" in "Email" with "_RANDOM_"
    When Click select "Giới tính" with "Nam"
    When Click select "Loại tài khoản" with "Farmer Side"
    When Enter "password" in "Mật khẩu" with "_RANDOM_"
    When Enter "password" in "Xác nhận mật khẩu" with "_@Mật khẩu@_"
    When Click "Lưu lại" button
    Then Required message "Xin vui lòng nhập số điện thoại" displayed under "Số điện thoại" field

CA_29 Create a new account when leaving "Giới tính" field blank
    [Tags]                                                                                        Create                                      BlankField
    Go to page create account "Tài khoản Người dùng" with "/customer-account"
    When Enter "test name" in "Họ và tên" with "_RANDOM_"
    When Enter "email" in "Email" with "_RANDOM_"
    When Enter "phone" in "Số điện thoại" with "_RANDOM_"
    When Click select "Loại tài khoản" with "Farmer Side"
    When Enter "password" in "Mật khẩu" with "_RANDOM_"
    When Enter "password" in "Xác nhận mật khẩu" with "_@Mật khẩu@_"
    When Click "Lưu lại" button
    Then Required message "Xin vui lòng chọn giới tính" displayed under "Giới tính" field

CA_30 Create a new account when leaving "Loại tài khoản" field blank
    [Tags]                                                                                        Create                                      BlankField
    Go to page create account "Tài khoản Người dùng" with "/customer-account"
    When Enter "test name" in "Họ và tên" with "_RANDOM_"
    When Enter "email" in "Email" with "_RANDOM_"
    When Enter "phone" in "Số điện thoại" with "_RANDOM_"
    When Click select "Giới tính" with "Nam"
    When Enter "password" in "Mật khẩu" with "_RANDOM_"
    When Enter "password" in "Xác nhận mật khẩu" with "_@Mật khẩu@_"
    When Click "Lưu lại" button
    Then Required message "Xin vui lòng chọn loại tài khoản" displayed under "Loại tài khoản" field

CA_31 Create a new account when leaving "Mật khẩu" field blank
    [Tags]                                                                                        Create                                      BlankField
    Go to page create account "Tài khoản Người dùng" with "/customer-account"
    When Enter "test name" in "Họ và tên" with "_RANDOM_"
    When Enter "email" in "Email" with "_RANDOM_"
    When Enter "phone" in "Số điện thoại" with "_RANDOM_"
    When Click select "Giới tính" with "Nam"
    When Click select "Loại tài khoản" with "Farmer Side"
    When Enter "password" in "Xác nhận mật khẩu" with "_RANDOM_"
    When Click "Lưu lại" button
    Then Required message "Xin vui lòng nhập mật khẩu" displayed under "Mật khẩu" field

CA_32 Create a new account when leaving "Xác nhận mật khẩu" field blank
    [Tags]                                                                                        Create                                      BlankField
    Go to page create account "Tài khoản Người dùng" with "/customer-account"
    When Enter "test name" in "Họ và tên" with "_RANDOM_"
    When Enter "email" in "Email" with "_RANDOM_"
    When Enter "phone" in "Số điện thoại" with "_RANDOM_"
    When Click select "Giới tính" with "Nam"
    When Click select "Loại tài khoản" with "Farmer Side"
    When Enter "password" in "Mật khẩu" with "_RANDOM_"
    When Click "Lưu lại" button
    Then Required message "Xin vui lòng nhập xác nhận mật khẩu" displayed under "Xác nhận mật khẩu" field

### Create new account with invalid data ###
CA_33 Create a new account with the invalid email
    [Tags]                                                                                        Create                                      Invalid
    Go to page create account "Tài khoản Người dùng" with "/customer-account"
    When Enter "test name" in "Họ và tên" with "_RANDOM_"
    When Enter "text" in "Email" with "_RANDOM_"
    When Enter "phone" in "Số điện thoại" with "_RANDOM_"
    When Click select "Giới tính" with "Nam"
    When Click select "Loại tài khoản" with "Farmer Side"
    When Enter "password" in "Mật khẩu" with "_RANDOM_"
    When Enter "password" in "Xác nhận mật khẩu" with "_@Mật khẩu@_"
    When Click "Lưu lại" button
    Then Required message "Xin vui lòng nhập địa chỉ email hợp lệ!" displayed under "Email" field

#CA_34 Create a new account with the invalid phone number
#    [Tags]                                                                                        Create                Error                      Invalid
#    Go to page create account "Tài khoản Người dùng" with "/customer-account"
#    When Enter "test name" in "Họ và tên" with "_RANDOM_"
#    When Enter "email" in "Email" with "_RANDOM_"
#    When Enter "phone" in "Số điện thoại" with "123456789"
#    When Click select "Giới tính" with "Nam"
#    When Click select "Loại tài khoản" with "Farmer Side"
#    When Enter "password" in "Mật khẩu" with "_RANDOM_"
#    When Enter "password" in "Xác nhận mật khẩu" with "_@Mật khẩu@_"
#    When Click "Lưu lại" button
#    Then User look message "Số điện thoại gồm 10 số" pop up

CA_35 Create a new account with the existed phone number
    [Tags]                                                                                        Create                                      Invalid
    ${AccountName}=                                                                               Create a test account with "Farmer Side" type
    When Click "Tạo mới" button
    When Enter "test name" in "Họ và tên" with "_RANDOM_"
    When Enter "email" in "Email" with "_RANDOM_"
    When Enter "phone" in "Số điện thoại" with "_@Số điện thoại@_"
    When Click select "Giới tính" with "Nam"
    When Click select "Loại tài khoản" with "Farmer Side"
    When Enter "password" in "Mật khẩu" with "_RANDOM_"
    When Enter "password" in "Xác nhận mật khẩu" with "_@Mật khẩu@_"
    When Click "Lưu lại" button
    Then User look message "Số điện thoại đã được sử dụng." popup
    When Click "Đóng lại" button
    Then Click on the "Xóa" button in the "${AccountName}" table line

CA_36 Create a new account with the existed email
    [Tags]                                                                                        Create                                       Invalid
    ${AccountName}=                                                                               Create a test account with "Farmer Side" type
    When Click "Tạo mới" button
    When Enter "test name" in "Họ và tên" with "_RANDOM_"
    When Enter "email" in "Email" with "_@Email@_"
    When Enter "phone" in "Số điện thoại" with "_RANDOM_"
    When Click select "Giới tính" with "Nam"
    When Click select "Loại tài khoản" with "Farmer Side"
    When Enter "password" in "Mật khẩu" with "_RANDOM_"
    When Enter "password" in "Xác nhận mật khẩu" with "_@Mật khẩu@_"
    When Click "Lưu lại" button
    Then User look message "Tên người dùng/Email đã được sử dụng." popup
    When Click "Đóng lại" button
    Then Click on the "Xóa" button in the "${AccountName}" table line


CA_37 Create a new account with the "Xác nhận mật khẩu" different with "Mật khẩu"
    [Tags]                                                                                        Create                                       Invalid
    Go to page create account "Tài khoản Người dùng" with "/customer-account"
    When Enter "test name" in "Họ và tên" with "_RANDOM_"
    When Enter "email" in "Email" with "_RANDOM_"
    When Enter "phone" in "Số điện thoại" with "_RANDOM_"
    When Click select "Giới tính" with "Nam"
    When Click select "Loại tài khoản" with "Farmer Side"
    When Enter "password" in "Mật khẩu" with "_RANDOM_"
    When Enter "password" in "Xác nhận mật khẩu" with "abc123"
    When Click "Lưu lại" button
    Then Required message "Mật khẩu và mật khẩu xác nhận không khớp" displayed under "Xác nhận mật khẩu" field
    When Click "Đóng lại" button

### Verify changing Password function ###
CA_38 Verify the changing password function
     [Tags]                                                                                       ChangePassword                               Smoketest
    Create a test account with "Farmer Side" type
    When Click on the "Đổi mật khẩu" button in the "_@Họ và tên@_" table line
    When Enter "password" in "Mật khẩu" with "_RANDOM_"
    When Enter "password" in "Xác nhận mật khẩu" with "_@Mật khẩu@_"
    When Click "Lưu lại" button
    Then User look message "Đổi mật khẩu thành công" popup
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

CA_39 Verify the changing password function by entering the "Xác nhận mật khẩu" different with the "Mật khẩu"
    [Tags]                                                                                        ChangePassword                               Smoketest
    Create a test account with "Order Side" type
    When Click on the "Đổi mật khẩu" button in the "_@Họ và tên@_" table line
    When Enter "password" in "Mật khẩu" with "_RANDOM_"
    When Enter "password" in "Xác nhận mật khẩu" with "123123"
    When Click "Lưu lại" button
    Then Required message "Mật khẩu và mật khẩu xác nhận không khớp" displayed under "Xác nhận mật khẩu" field
    When Click "Đóng lại" button
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

CA_40 Verify the changing password function when leave the "Mật khẩu" filed blank
    [Tags]                                                                                        ChangePassword
    Create a test account with "Order Side" type
    When Click on the "Đổi mật khẩu" button in the "_@Họ và tên@_" table line
    When Enter "password" in "Xác nhận mật khẩu" with "123123"
    When Click "Lưu lại" button
    Then Required message "Xin vui lòng nhập mật khẩu" displayed under "Mật khẩu" field
    When Click "Đóng lại" button
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

CA_41 Verify the changing password function when leave the "Xác nhận mật khẩu" filed blank
    [Tags]                                                                                        ChangePassword
    Create a test account with "Order Side" type
    When Click on the "Đổi mật khẩu" button in the "_@Họ và tên@_" table line
    When Enter "password" in "Mật khẩu" with "_RANDOM_"
    When Click "Lưu lại" button
    Then Required message "Xin vui lòng nhập xác nhận mật khẩu" displayed under "Xác nhận mật khẩu" field
    When Click "Đóng lại" button
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

CA_42 Verify the ability of showing password when in the "Mật khẩu" field
    [Tags]                                                                                        ChangePassword
    Create a test account with "Order Side" type
    When Click on the "Đổi mật khẩu" button in the "_@Họ và tên@_" table line
    When Enter "password" in "Mật khẩu" with "_RANDOM_"
    When Enter "password" in "Xác nhận mật khẩu" with "_@Mật khẩu@_"
    When Click on eye icon in "Mật khẩu" field
    Then The hidden password in "Mật khẩu" field should be visibled as "_@Mật khẩu@_"
    When Click "Đóng lại" button
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

CA_43 Verify the ability of showing password when in the "Xác nhận mật khẩu" field
    [Tags]                                                                                        ChangePassword
    Create a test account with "Farmer Side" type
    When Click on the "Đổi mật khẩu" button in the "_@Họ và tên@_" table line
    When Enter "password" in "Mật khẩu" with "_RANDOM_"
    When Enter "password" in "Xác nhận mật khẩu" with "_@Mật khẩu@_"
    When Click on eye icon in "Xác nhận mật khẩu" field
    Then The hidden password in "Xác nhận mật khẩu" field should be visibled as "_@Xác nhận mật khẩu@_"
    When Click "Đóng lại" button
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

### Verify the funtion of changing account information ###
CA_44 Verify the changing "Họ và tên" field
    [Tags]                                                                                        ChangeInfo
    Create a test account with "Farmer Side" type
    When Click on the "Sửa" button in the "_@Họ và tên@_" table line
    When Enter "test name" in "Họ và tên" with "_RANDOM_"
    When Click "Lưu lại" button
    Then User look message "Chỉnh sửa tài khoản thành công" popup
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

CA_45 Verify the changing "Số điện thoại" field
    [Tags]                                                                                        ChangeInfo
    Create a test account with "Farmer Side" type
    When Click on the "Sửa" button in the "_@Họ và tên@_" table line
    When Enter "number" in "Số điện thoại" with "_RANDOM_"
    When Click "Lưu lại" button
    Then User look message "Chỉnh sửa tài khoản thành công" popup
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

CA_46 Verify the changing "Giới tính" field
    [Tags]                                                                                        ChangeInfo
    Create a test account with "Order Side" type
    When Click on the "Sửa" button in the "_@Họ và tên@_" table line
    When Click select "Giới tính" with "Nữ"
    When Click "Lưu lại" button
    Then User look message "Chỉnh sửa tài khoản thành công" popup
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

CA_47 Verify the changing "Loại tài khoản" field
    [Tags]                                                                                        ChangeInfo
    Create a test account with "Farmer Side" type
    When Click on the "Sửa" button in the "_@Họ và tên@_" table line
    When Click select "Loại tài khoản" with "Order Side"
    When Click "Lưu lại" button
    Then User look message "Chỉnh sửa tài khoản thành công" popup
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

#CA_48 Verify the changing with the existed "Số điện thoại"
#    [Tags]                                                                                        ChangeInfo            Error
#    ${AccountName}=                                                                               Create a test account with "Farmer Side" type
#    Create another test account with "Order Side" type
#    When Click on the "Sửa" button in the "${AccountName}" table line
#    When Enter "number" in "Số điện thoại" with "_@Số điện thoại@_"
#    When Click "Lưu lại" button
#    Then User look message "Số điện thoại đã được sử dụng." popup
#    When Click "Đóng lại" button
#    When Click on the "Xóa" button in the "_@Họ và tên@_" table line
#    When Click on the "Xóa" button in the "${AccountName}" table line

### Verify the delete account function ###
 CA_49 Verify the delete account function
    [Tags]                                                                                        Delete                                       Smoketest
    Create a test account with "Order Side" type
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line
    Then User look message "Xóa thành công" popup
    Then Account "_@Họ và tên@_" should not be visible in table line

CA_50 Verify the cancel action button when delete account
    [Tags]                                                                                        Delete
    Create a test account with "Farmer Side" type
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line with cancel
    Then Account "_@Họ và tên@_" should be visible in table line
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

*** Keywords ***

Go to "${page}" page
  Login to admin
  Click "QUẢN LÝ TÀI KHOẢN" menu
  ${cnt}=                     Get Length                                    ${page}
  IF          ${cnt} > 0 and '${page}' == 'Customer Account'
    Click "Tài khoản Người dùng" sub menu to "/customer-account"
  ELSE IF     ${cnt} > 0 and '${page}' == 'Internal Account'
    Click "Tài khoản Nội bộ" sub menu to "/internal-account"
  ELSE IF     ${cnt} > 0 and '${page}' == 'Profile Farmer'
    Click "Profile Farmer" sub menu to "/profile-farmer"
  END

Go to page create account "${name}" with "${url}"
    When Login to admin
    When Click "QUẢN LÝ TÀI KHOẢN" menu
    When Click "${name}" sub menu to "${url}"
    When Click "Tạo mới" button

Background ${type} Happy paths ${name} with ${url}
    When Go to page create account ${name} with ${url}
    When Enter "test name" in "Họ và tên" with "_RANDOM_"
    When Enter "email" in "Email" with "_RANDOM_"
    When Enter "phone" in "Số điện thoại" with "_RANDOM_"
    When Click select "Giới tính" with "Nam"
    When Click select "Loại tài khoản" with "${type}"
    When Enter "password" in "Mật khẩu" with "_RANDOM_"
    When Enter "password" in "Xác nhận mật khẩu" with "_@Mật khẩu@_"
    When Click "Lưu lại" button

Verify create account when inputting valid data into all fields
  [Arguments]           ${code}       ${name}      ${url}      ${type}
  Set Global Variable   ${TEST NAME}  ${code}
  When Background ${type} Happy paths ${name} with ${url}
  Then User look message "Tạo tài khoản thành công" popup
  When Click on the "Xóa" button in the "_@Họ và tên@_" table line

Create a test account with "${type}" type
    When Go to page create account "Tài khoản Người dùng" with "/customer-account"
    When Enter "test name" in "Họ và tên" with "_RANDOM_"
         ${text}=               Check Text             _@Họ và tên@_
         ${name}=               Set Variable           ${text}
         [Return]               ${name}
    When Enter "email" in "Email" with "_RANDOM_"
    When Enter "phone" in "Số điện thoại" with "_RANDOM_"
    When Click select "Giới tính" with "Nam"
    When Click select "Loại tài khoản" with "${type}"
    When Enter "password" in "Mật khẩu" with "_RANDOM_"
    When Enter "password" in "Xác nhận mật khẩu" with "_@Mật khẩu@_"
    When Click "Lưu lại" button
    Then User look message "Tạo tài khoản thành công" popup

Create another test account with "${type}" type
    When Click "Tạo mới" button
    When Enter "test name" in "Họ và tên" with "_RANDOM_"
         ${text}=               Check Text             _@Họ và tên@_
         ${name}=               Set Variable           ${text}
         [Return]               ${name}
    When Enter "email" in "Email" with "_RANDOM_"
    When Enter "phone" in "Số điện thoại" with "_RANDOM_"
    When Click select "Giới tính" with "Nữ"
    When Click select "Loại tài khoản" with "${type}"
    When Enter "password" in "Mật khẩu" with "_RANDOM_"
    When Enter "password" in "Xác nhận mật khẩu" with "_@Mật khẩu@_"
    When Click "Lưu lại" button
    Then User look message "Tạo tài khoản thành công" popup

Create random test account
    [Arguments]            ${code}         ${accName}    ${URL}    ${acctype}
    Set Global Variable    ${TEST NAME}    ${code}
    When Go to page create account "${accName}" with "${URL}"
    When Enter "test name" in "Họ và tên" with "_RANDOM_"
    When Enter "email" in "Email" with "_RANDOM_"
    When Enter "phone" in "Số điện thoại" with "_RANDOM_"
    When Click select "Giới tính" with "Nam"
    When Click select "Loại tài khoản" with "${acctype}"
    When Enter "password" in "Mật khẩu" with "_RANDOM_"
    When Enter "password" in "Xác nhận mật khẩu" with "_@Mật khẩu@_"
    When Click "Lưu lại" button
    Then User look message "Tạo tài khoản thành công" popup

