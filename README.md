# Little Lemon Menu App
Little Lemon Restaurant App
- The application is an iOS app written in Swift for viewing a restaurant menu.
- Users will be capable of registering on the Little Lemon restaurant app.
- Once they successfully registered, they are redirected to a home screen.
- The home screen will display all menu items, a search bar, and a filter menu (along with a hero section and header).
- Users can search for their favorite menu item or select a category to see which items are available.
- The Profile screen allows users to see their profile and log out. The log-out button will redirect them to the registration screen.
- User defaults are used to store the login details.
- Core data is used to store the JSON data from the menu API.

## Table of Contents
- [About the Brand](#about-the-brand)
- [User Journey Map and Persona](#User-Journey-Map-and-Persona)
    - [Persona](#persona)
    - [User Journey Map](#User-Journey-Map)
    - [Wireframes](#Wireframes)
- [App Functionality](#App-Functionality)
    - [Screenshots - Onboarding, Home, User Profile](#Screenshots---Onboarding,-Home,-User-Profile)
    - [Video](#Video)
    - [Built With](#Built-With)
    - [Sample Code](#Sample-Code)

## About the Brand
<img width="731" alt="Brand" src="https://github.com/ktroyan7/littlelemon/assets/108959100/5fed7e30-a4b0-4832-bd5a-f029233f9c4e">

Little Lemon is a charming neighborhood bistro that serves simple food and classic cocktails in a lively but casual environment.
The restaurant features a locally-sourced menu with daily specials.

## User Journey Map and Persona
### Persona
<img width="644" alt="Persona" src="https://github.com/ktroyan7/littlelemon/assets/108959100/0f949f88-f2e8-477c-94f1-a0d3eb7a91f9">

### User Journey Map
<img width="660" alt="Journey" src="https://github.com/ktroyan7/littlelemon/assets/108959100/2815465c-21de-4db8-90c2-6c517104d869">

### Wireframes
<img width="902" alt="Wireframe" src="https://github.com/ktroyan7/littlelemon/assets/108959100/964a5929-52dc-4375-8632-3341c6275b65">

## App Functionality
- First enter your 'First Name', 'Last Name', and 'Email' to register for the app.
- This will take you to the home screen where you can view the full menu.
- Search for your favorite food using the search bar or use the picker to select a category to explore.
- You can use the bottom navigation to visit your user profile page.
- If you would like to log out, click the 'Logout' button on the user profile page.

### Screenshots - Onboarding, Home, User Profile
<img width="320" alt="Onboarding" src="https://github.com/ktroyan7/littlelemon/assets/108959100/83288771-414a-4bb5-8e33-7278a4d02e9c"><img width="320" alt="Home" src="https://github.com/ktroyan7/littlelemon/assets/108959100/3eac75b3-2f7a-483b-b714-5029663c6ed7"><img width="320" alt="UserProfile" src="https://github.com/ktroyan7/littlelemon/assets/108959100/826be02a-796f-4100-b417-519cb96e88f4">

### Video
The below video shows a walkthrough of the app and its features.
Click play on the below video to view the app features:
https://github.com/ktroyan7/littlelemon/assets/108959100/dac16ad8-8386-42a9-b291-9861085c11b1

### Built With
- [Swift](https://developer.apple.com/documentation/swift/)
- [SwiftUI](https://developer.apple.com/documentation/swiftui/)
- [Core Data](https://developer.apple.com/documentation/coredata/)
- [User Defaults](https://developer.apple.com/documentation/foundation/userdefaults/)

### Sample Code
Here is example code from my User Profile page.

```swift
struct UserProfile: View {
    
    @Environment(\.presentationMode) var presentation
    
    let firstName: String = UserDefaults.standard.string(forKey: kFirstName) ?? "First Name not provided"
    let lastName: String = UserDefaults.standard.string(forKey: kLastName) ?? "Last name not provided"
    let email: String = UserDefaults.standard.string(forKey: kEmail) ?? "Email not provided"
    
    var body: some View {
        VStack {
            Text("Personal Information")
                .font(.title)
                .foregroundColor(.black)
            
            Image("profile-image-placeholder")
                .resizable()
                .frame(width: 150, height: 150)
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.black, lineWidth: 3))
            
            Text("First Name: \(firstName)")
                .font(.headline)
            
            Text("Last Name: \(lastName)")
                .font(.headline)
            
            Text("Email: \(email)")
                .font(.headline)
            
            Button {
                UserDefaults.standard.set("", forKey: kFirstName)
                UserDefaults.standard.set("", forKey: kLastName)
                UserDefaults.standard.set("", forKey: kEmail)
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                self.presentation.wrappedValue.dismiss()
            } label: {
                Text("Logout")
                    .font(.headline)
                    .frame(width: 200, height: 40)
                    .background(Color.yellow)
                    .foregroundColor(.black)
                    .cornerRadius(20)
            }
        }
    }
}
```
