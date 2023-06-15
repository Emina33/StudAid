# StudAid

StudAid is an application for people that want to connect with tutors for a specific subject or want to tutor someone because they have good knowledge of a certain topic. Users can publish their adverts, make reservations and also publish and download documents. 

To start, first make sure that you select "StudAid.Services" project in package manager console and set "StudAid" as the startup project in the solution.

After that, start the Docker with the "docker-compose up --build" command in package manager console. By doing this, the database is made and the tables are populated.
To open and test the API, add "/swagger/index.html" to the link in the top when opening it in a browser. 

For the Desktop app, which is "StudAid.WinUI", you can test it using **"admin"** as the username and **"test"** as the password.

## Mobile App

To test the mobile app, open the **StudAidMobileApp** folder and run **flutter run** in the terminal. This will resolve the dependencies and start the app. 

You have two users you can test this app with:
  -John Doe (**username:johndoe**, **password:test**)
  -Jane Doe(**username:janedoe**, **password:test**)
  
You can also make a new user and use the app normally.
