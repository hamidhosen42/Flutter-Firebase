### [Firebase](https://console.firebase.google.com/u/0/project/flutter-firebase-1e704/authentication/users)

### Screenshots
<img src="./assets/1-splash_screen.png" width=200> <img src="./assets/2-account_option.png" width=200> <img src="./assets/3-create_account.png" width=200> 
<img src="./assets/4-phone_auth_screen.png" width=200><img src="./assets/5-sign_in_screen.dart.png" width=200> <img src="./assets/6-forgot_screen.dart.png" width=200> 
<img src="./assets/7-otp_screen.png" width=200> <img src="./assets/8-real-time-data-screen.png" width=200> <img src="./assets/8.1-post_real_time_data.png" width=200> 
<img src="./assets/9-real-time-data-post-screen.png" width=200> <img src="./assets/10-real-time-data-update-screen.png" width=200> <img src="./assets/11-add-firestore-data.png" width=200> <img src="./assets/12-firestore_screen.png" width=200> <img src="./assets/13-firstore_update_screen.png" width=200> <img src="./assets/13-real-time-blog-screen.png" width=200> <img src="./assets/14-real-time-blog-upload.png" width=200> 

### [APK](https://github.com/hamidhosen42/Flutter-Firebase/blob/main/app-release.apk)
### dependencies:
1. firebase_core: ^1.10.0
2. firebase_auth: ^3.2.0
3. firebase_database: ^8.1.0
4. cloud_firestore: ^3.1.0
5. firebase_storage:
6. flutter_loading_animation_kit: 
7. flutter_screenutil: 
8. fluttertoast: 
9. firebase_database: 
10.image_picker: 

### Real Time data base Permission denied in firbase:
 ```
{
  "rules": {
    ".read": true,
    ".write": true
  }
}
 ```

SHA1 KeyWord commend =keytool -list -v -keystore C:\Users\user\.android\debug.keystore -alias androiddebugkey -storepass android -keypass android

android->app->build.grad=
1. multiDexEnabled true
2. implementation 'com.android.support:multidex:1.0.3'
