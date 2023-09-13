# StudAid

StudAid is an application for people that want to connect with tutors for a specific subject or want to tutor someone because they have good knowledge of a certain topic. Users can publish their adverts, make reservations and also publish and download documents. 

To start, first make sure that you select "StudAid.Services" project in package manager console and set "StudAid" as the startup project in the solution.

After that, start the Docker with the "docker-compose up --build" command in package manager console. By doing this, the database is made and the tables are populated.
To test the API, open "http://localhost:5090/swagger/index.html". 

For the Desktop app, which is "StudAid.WinUI", you can test it using **"admin"** as the username and **"test"** as the password.

## Mobile App

To test the mobile app, open the **StudAidMobileApp** folder and run **flutter run** in the terminal. This will resolve the dependencies and start the app. You can also add --dart-define baseUrl=yourNewUrl if you want to change the baseUrl. Add --dart-define clientId=yourNewClientId and --dart-define secretKey=yourNewSecretKey if you wish to change the payment credentials for Paypal. If you choose to not change the credentials, default values will be used and the Paypal account email and password are:
- email: sb-9s2tu26233819@personal.example.com
- password: 78>;5I.z

You have two users you can test this app with:
- John Doe (**username:johndoe**, **password:test**)
- Jane Doe(**username:janedoe**, **password:test**)
- John Smith(**username:johnsmith**, **password:test**)
  
You can also make a new user and use the app normally.
