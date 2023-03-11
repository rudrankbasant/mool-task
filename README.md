# Mool-Task
I have completed the tast (with the bonus) but couldn't add enhancement functionalities from my side as I have exams from tomorrow. The apk of the app can be found on [the drive link](https://drive.google.com/drive/folders/1ZxowKuRrlpMb2EofJQhnLH0UGqFwbFV3?usp=sharing).

## SplashScreen
The package used to implement this was [flutter_native_splash](https://pub.dev/packages/flutter_native_splash)
It currently shows the mool logo with a background color.

## Architecture  
The app uses the Cubit/Bloc Architecture for state management and the Repository Pattern for data management.
The app shows a custom flushbar whenever it  receives an error from the backend and displays the message for the user.

## Auth/Login (with jwt tokens)
The demo api used for the project is this: [https://chitros.dhruvshah.ml/docs](https://chitros.dhruvshah.ml/docs)
The api gives the jwt token lasts for 30 minutes, but in this demo api it doesn't refresh it automatically. 

The endpoints used are /signup /login and /users/ .
The jwt token is passed as the header to fetch all users in the get request with the endpoint /users/ and all the users are displayed in the home screen.

## Loading Page 
The app implements the loadding stage whenever the state "AuthLoading" is emitted. Hence the user is shown a screen with the circular progress indicator while the authorization is happening.



