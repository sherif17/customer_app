# Customer_App

This is the main application on which the idea originated, through this app customers could use the provided services with a simple and fast registration process at first time using this app, that could be helpful in many critical situations when a customer has any issues related to his car.
<img src="https://user-images.githubusercontent.com/43541909/126675827-f8aeea91-687e-4c72-a157-ddeaa3771a57.jpg" width="150" height="300" align = "right" />

## Table of Contents  
1. [Registration[LogIn / SignUp]](#Registration)  
2. [Adding Cars](#Adding_cars)
3. [Requesting_Winch_service](#emphasis)  
4. [Requesting_Mechanic_Service](#emphasis)  

.
<a name="Registration"/>
## Registration[LogIn / SignUp]
First time customers use the app the app only needs their mobile number for a verification step on this mobile number and to determine if this customer already has an account associated with this mobile number, to let him login to this account or if there is no associated account with this mobile number, to let this customer complete his registration process by entering his first and last name or login with his social accounts.

* Entering customer phone Number.
<img src="https://user-images.githubusercontent.com/43541909/126683400-bf1adb9d-c8fa-401a-92ee-c336248012f3.jpg" width="150" height="300" align = "center" />  
<img src="https://user-images.githubusercontent.com/43541909/126684684-9729c545-ba36-42a7-b10f-1fc62cbfc0f0.jpg" width="150" height="300" align = "center" />  
<img src="https://user-images.githubusercontent.com/43541909/126706165-649e138a-a885-4eab-b942-02b55ab01602.jpg" width="150" height="300" align = "center" />  

* Verify the mobile number using firebase.
  * Validate that you’re not a robot by solving a captcha.
  * Sending the code to the mobile number.
  <img src="https://user-images.githubusercontent.com/43541909/126706456-70e59b41-1650-458a-8d37-285259c80254.jpg" width="150" height="300" align = "center" />  
  <img src="https://user-images.githubusercontent.com/43541909/126707901-f99e793c-b34d-4615-b4af-d1cca8038e9b.jpg" width="150" height="300" align = "center" />  
  <img src="https://user-images.githubusercontent.com/43541909/126706879-75a668fc-3aa4-42e6-9e4c-c1607cda7d8f.jpg" width="150" height="300" align = "center" /> 
* Check if the user is existing on server DB or not and refirection customer to proper screen.
  * if customer exists on server DB:
  
      We make a check step to see if the customer wants to proceed in the app with his/her information or want to edit one of them. 
      
      <img src="https://user-images.githubusercontent.com/43541909/126752722-ea9f16fa-8b6e-4b9b-b619-c9889815304e.jpg" width="150" height="300" align = "center"  />  <img src="https://user-images.githubusercontent.com/43541909/126752779-374699fd-f7c2-4244-a835-efdd44c047f3.jpg" width="150" height="300" align = "center" /> <img src="https://user-images.githubusercontent.com/43541909/126752893-41892d69-ba4e-40ed-a02a-86bcd35057ee.jpg" width="150" height="300" align = "center" /> 

  * if customer doesn't exists on server DB:
  
    Customer will be asked to enter his first name and last name or can continue with social accounts to get his/her first and last name from it.
    
    <img src="https://user-images.githubusercontent.com/43541909/126753550-5a746dbe-8da4-463d-9975-a9ac10327bb6.jpg" width="150" height="300" align = "center"  />  <img src="https://user-images.githubusercontent.com/43541909/126755312-d8d6182d-21c0-4b59-9924-fb6215d5ee31.jpg" width="150" height="300" align = "center" /> <img src="https://user-images.githubusercontent.com/43541909/126754766-cb72bb2c-8d4c-4dcd-bbea-b8a26dda376c.jpg" width="150" height="300" align = "center" /> <img src="https://user-images.githubusercontent.com/43541909/126755365-251de62c-2c9a-42a0-859f-8405c91778a8.jpg" width="150" height="300" align = "center" />
    
* Home & Profile page.

 After registration, Customer will be able to use our app normally,choosing between winch & mechanic services, adding list of owned cars and viewing associated information to this account.
 
  <img src="https://user-images.githubusercontent.com/43541909/126762557-4b1dcf84-ae66-4d5a-8db7-b5d9f9bdce66.jpg" width="150" height="300" align = "center"  />  <img src="https://user-images.githubusercontent.com/43541909/126762827-b796583d-b0e5-48c5-b7e2-641b10482d72.jpg" width="150" height="300" align = "center" />
    
.
<a name="Adding_cars"/>
## Adding Cars 
Before registered customer could be able to make requests for winch driver or individual mechanic,customer should add information of atleast one of his car,so he could select from them while requesting services.

<img src="https://user-images.githubusercontent.com/43541909/126760365-468b10b1-d73d-45a7-9938-009f765417b5.png" width="150" height="300" align = "center"  />  <img src="https://user-images.githubusercontent.com/43541909/126760515-8a98934e-8637-4a78-8376-0e6d1c3f7a80.png" width="150" height="300" align = "center" /> <img src="https://user-images.githubusercontent.com/43541909/126760677-724ef73e-af2e-4bd3-bb7c-b5d081a5c34f.png" width="150" height="300" align = "center" /> <img src="https://user-images.githubusercontent.com/43541909/126760978-07f43f5d-1634-47ad-a8a5-a5f0bdbbac9f.png" width="150" height="300" align = "center" /> <img src="https://user-images.githubusercontent.com/43541909/126761096-dceb496e-0539-432c-ad61-8261ff6de571.png" width="150" height="300" align = "center" />.

Records

[lisa](https://user-images.githubusercontent.com/43541909/126764080-78503b0c-186b-4ecd-80cc-fe5d0201a928.mp4)

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
