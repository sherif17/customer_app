
# Customer_App

This is the main application on which the idea originated, through this app customers could use the provided services with a simple and fast registration process at first time using this app, that could be helpful in many critical situations when a customer has any issues related to his car.
<img src="https://user-images.githubusercontent.com/43541909/126675827-f8aeea91-687e-4c72-a157-ddeaa3771a57.jpg" width="150" height="300" align = "right" />

## Table of Contents
1. [Installation.](#Installation)
2. [Techanologies Used.](#Techanologies_Used)
3. [Learning OutComes.](#Learning_OutComes)
4. [Documentaion For Project.](#Documentaion_For_Project)

   4.1 [Registration[LogIn / SignUp]](#Registration)  
   
   4.2 [Adding Cars](#Adding_cars)
   
   4.3 [Requesting_Winch_Service](#Requesting_Winch_Service)  
   
   4.4 [Requesting_Mechanic_Service](#Requesting_Mechanic_Service)  
   
5. [Project Status.](#Project_Status)


.
<a name="Installation"/>
## Installation

1. Install Android Studio / Visual Studio.

2. Add Dart & Flutter Exstensions.

3. Download Flutter SDK.

4. Clone The Project.

5. Open Emulator,Run The Project & Enjoy..

#### Note : You may can't proceed in using app normally, this is due to server in off state.
.
<a name="Techanologies_Used"/>
## Techanologies Used :

* Dart / Flutter.
* Firbase Phone Authuntication [Baas].
* Working with Networking [HTTP Requests] 
* Working with Google cloud services [GMaps - GeoCoding API - Directions API - Places API -Distance Matrix API]
* Hive [No Sql] Local DB. 

.
<a name="Learning_OutComes"/>
## Learning Out-Comes :

* Designing somehow beautiful UI screens.
* Using provider as state a mangmnet solution.
* Working with google maps services.
* Creating somehow e-commerce system.
* Impleminting local BB to save user info & app data.
* Supporting Localization [AR - EN]


.
<a name="Documentaion_For_Project"/>
## Documentaion For Project.

.
<a name="Registration"/>
### Registration[LogIn / SignUp]
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
### Adding Cars 
Before registered customer could be able to make requests for winch driver or individual mechanic,customer should add information of atleast one of his car,so he could select from them while requesting services.

<img src="https://user-images.githubusercontent.com/43541909/126760365-468b10b1-d73d-45a7-9938-009f765417b5.png" width="150" height="300" align = "center"  />  <img src="https://user-images.githubusercontent.com/43541909/126760515-8a98934e-8637-4a78-8376-0e6d1c3f7a80.png" width="150" height="300" align = "center" /> <img src="https://user-images.githubusercontent.com/43541909/126760677-724ef73e-af2e-4bd3-bb7c-b5d081a5c34f.png" width="150" height="300" align = "center" /> <img src="https://user-images.githubusercontent.com/43541909/126760978-07f43f5d-1634-47ad-a8a5-a5f0bdbbac9f.png" width="150" height="300" align = "center" /> <img src="https://user-images.githubusercontent.com/43541909/126761096-dceb496e-0539-432c-ad61-8261ff6de571.png" width="150" height="300" align = "center" />.

### Records




https://user-images.githubusercontent.com/43541909/126775136-c50cd634-ca99-4723-9eaf-4ffa3ddc5a4c.mp4



https://user-images.githubusercontent.com/43541909/126775028-5a11b558-056d-4bf5-bf12-030f04e707dc.mp4



https://user-images.githubusercontent.com/43541909/126775232-9db7eeac-5496-4876-b210-f155f874a7d3.mp4



.
<a name="Requesting_Winch_Service"/>
### Requesting Winch Service 

* Getting Customer Current Location

  <img src="https://user-images.githubusercontent.com/43541909/126791283-6c707ca7-3c21-4bec-9a56-fa02ef0a5e32.jpg" width="150" height="300" align = "center" />  
  <img src="https://user-images.githubusercontent.com/43541909/126790729-f33921df-6fd5-4e4f-b5b5-e2136a630f96.jpg" width="150" height="300" align = "center" />  
 
  
* Searching For Customer Distination

  <img src="https://user-images.githubusercontent.com/43541909/126791545-49603c35-a9d1-458f-8ccf-ae403e5d5fd9.jpg" width="150" height="300" align = "center" />  
  <img src="https://user-images.githubusercontent.com/43541909/126791557-5ed7722c-55e1-4cfe-919f-c990c7478470.jpg" width="150" height="300" align = "center" />  
  
* Confirming Winch  Service 

   Confirmed information:
    * Pickup Location.
    * Drop Off Location. 
    * Estimated Time. 
    * Estimated Distance.  
    * Estimated Fare.  
    * Selected Car.
    
      <img src="https://user-images.githubusercontent.com/43541909/126792589-068fa8bf-ed4d-4a29-b61b-c9ce7a01a898.jpg" width="150" height="300" align = "center" />
      <img src="https://user-images.githubusercontent.com/43541909/126792807-e3995d12-05cc-4750-8b4f-d08382dbb102.jpg" width="150" height="300" align = "center" />
      <img src="https://user-images.githubusercontent.com/43541909/126792875-13510d4c-913a-434c-aa3c-cfc5eae0b00d.jpg" width="150" height="300" align = "center" />
 
 
* Searching For Winch:

  * Customer start searching for nearest winch.  
  * Winch driver receives , customer request ,while searching for nearest client.
  * Winch driver needs to respond to that request.
  
    <img src="https://user-images.githubusercontent.com/43541909/126794201-46b439e4-1817-47c7-984c-3a9daf7b2e9e.jpg" width="150" height="300" align = "center" />
    <img src="https://user-images.githubusercontent.com/43541909/126794207-401bc042-781e-48d9-9017-f31f364afca7.jpg" width="150" height="300" align = "center" />
    
* Customer Start Tracking For arrival of Winch Driver

   Customer listened that winch driver approved his request & then he start tracking it's movmnet to arrive to customer pickup location.
  
   <img src="https://user-images.githubusercontent.com/43541909/126795498-3062ce93-bccf-47fb-81fd-35a53bed5228.jpg" width="150" height="300" align = "center" />
   
* Customer Start Tracking For Winch Driver while dropping off him.

  Now, winch driver picked up,customer car,heading to drop off location. 
  
  <img src="https://user-images.githubusercontent.com/43541909/126797400-36d8ac04-0dd7-47a4-a82e-7ea9f870856e.jpg" width="150" height="300" align = "center" />

* Arrival To dropOff location.

  when customer listen for finishing the trip, final fare will be shown with an option for rating winch driver. 
  
  <img src="https://user-images.githubusercontent.com/43541909/126797742-9aa9404f-2fd2-403e-8ee6-7e0d657c3674.jpg" width="150" height="300" align = "center" />
  
  
### Records  

https://user-images.githubusercontent.com/43541909/126798885-ad9e1875-e34b-4de8-a2b0-bf4b187274da.mp4



https://user-images.githubusercontent.com/43541909/126799151-5ce81a12-2bd5-4cdf-8538-44b593cbf41c.mp4

.
<a name="Requesting_Mechanic_Service"/>
### Requesting Mechanic Service

* Selecting Services Needed

  * Customer will be able to choose the type of service needed.
     * If customer faces breakdowns.
     * Or  needs routine maintainence service. 
      
  * He will be directed to lists of services that he can choose from.
 
   <img src="https://user-images.githubusercontent.com/43541909/126808512-d5e1fdb2-ad49-4f9e-abf4-e7a9258c5511.png" width="150" height="300" align = "center" />
   <img src="https://user-images.githubusercontent.com/43541909/126808604-bd573852-eff5-46ba-a82c-ccff16bd4264.png" width="150" height="300" align = "center" />
   <img src="https://user-images.githubusercontent.com/43541909/126808686-cc43c5ad-14ca-4344-8f29-8b06422cb734.png" width="150" height="300" align = "center" />
   
* Adding To Mechanic Service Cart.

  customer can  the service needed and add it to his cart.
  
   <img src="https://user-images.githubusercontent.com/43541909/126811026-d761200f-f6c6-4f4a-ac4c-82dd3b55c841.png" width="150" height="300" align = "center" />
   <img src="https://user-images.githubusercontent.com/43541909/126811034-cc656941-1c84-4931-8d31-d40915e7e7af.png" width="150" height="300" align = "center" />
   <img src="https://user-images.githubusercontent.com/43541909/126811051-5eb137d5-b753-4d65-bd03-17256f95c21a.png" width="150" height="300" align = "center" />

* Choosing One Of Owned Cars.

  Customer can choose the car that needs the service in any level of the requesting process.
  
   <img src="https://user-images.githubusercontent.com/43541909/126812117-1af0f567-ee00-43b6-b496-456e4a4ae717.png" width="150" height="300" align = "center" />
   <img src="https://user-images.githubusercontent.com/43541909/126812127-a23cfce7-3a9a-49a7-a611-8a97fb09b1b4.png" width="150" height="300" align = "center" />
   
* Confirming Mechanic Request

  * Before Confirming,Customer will view a summary of his selection. 
  * If this summary is confirmed,customer will be directed to a Gmap To confirm the meeting point with the mechanic.
  
     <img src="https://user-images.githubusercontent.com/43541909/126813872-5032e324-b326-46e9-b45f-65bcf8b0cad8.png" width="150" height="300" align = "center" />
     <img src="https://user-images.githubusercontent.com/43541909/126813882-6f583ee7-4118-4f0d-9817-b61fd68d6b15.png" width="150" height="300" align = "center" />

* Searching For Mechanic

 * Customer start searching for nearest mechanic 
 * Mechanic receives customer request,vwhile searching for nearest client.
 * Mechanic needs to respond to that request
 
     <img src="https://user-images.githubusercontent.com/43541909/126815364-7c2afaa2-2674-45c6-b43a-8a41a20c4752.png" width="150" height="300" align = "center" />

* Customer Start Tracking For arrival of Mechanic

   Customer listened that mechanic approved his request & then he start tracking it's movmnet to arrive to customer location.
  
    <img src="https://user-images.githubusercontent.com/43541909/126816000-b2fbed79-5831-4e3b-bcb3-b0bd8b068f14.png" width="150" height="300" align = "center" />
    <img src="https://user-images.githubusercontent.com/43541909/126816009-67b6a1ce-da9d-4cac-b0bf-4cc17fb10bb8.png" width="150" height="300" align = "center" />

* Waiting For Repairs To Be Made

  * Mechanic is checking customer car Now.
  * Customer waiting for mechanic finish his diagnosis for the car.
  * To receive list of repairs to  be made.
  
  <img src="https://user-images.githubusercontent.com/43541909/126816391-e3309e05-00a5-4c6c-a356-20d01f82827c.png" width="150" height="300" align = "center" />
  
* Receiving Mechanic Diagnosis

   * Customer now, received repairs to be made. 
   * customer could accept or reject those repairs.
   * And mechanic now, is waiting for customer response. 
   
    <img src="https://user-images.githubusercontent.com/43541909/126816872-bb0b69b5-2005-4abc-9e7e-39c9beac3941.png" width="150" height="300" align = "center"/>
    
 * Ending Service & Submit Rating For Mechanic
 
   When customer listen for finishing that service, final fare will be shown with an option for rating mechanic.
  
  <img src="https://user-images.githubusercontent.com/43541909/126819796-186a812a-cf9a-4ea5-89f6-af2dc74feefc.png " width="150" height="300" align = "center"/>
  
  ### Records
  
  

https://user-images.githubusercontent.com/43541909/126820207-ff55a401-599b-4c4c-9eaa-39779265067b.mp4



https://user-images.githubusercontent.com/43541909/126820473-34bf9a09-ae85-4829-8f52-29c467f9b3ef.mp4

.
<a name="Project_Status"/>
## Project Status.

#### Project Has Been closed For Now, Wait For Further notice 
