# AllerscanApp
Allerscan is an app that is able to read product ingredient labels and warn the users of possible dangers associated with the products, depending on allergens inputted into the system. Optical Character Recognition (OCR) technology is used by the app to convert sentences recognized on images into an array of string elements.

# OCR Implemenation 
In order to implement OCR feature into the app, Google Firebase's ML Kit library was utilized. According to Firebase, character recognition success rate is very high which reassures of the safety of the application. 

# Key Features 
The app is divided into three main pages by a bottom navigation bar - "Include Allergens", "Scan" and "User Profile". In the "Include Allergens" page, user inputs their allergens using a search bar. The data inputted by the search bar is then saved in the app for future uses. This is where a search algorithm comes to play. When the user scans various ingridient labels, a search algorithm traverses through an array of string elements. If one or more user-inputted elements are found within the array, the app will display a "Not Safe" label and, in addition, will show all the allergens that were found. If not, "Safe" label will pop out otherwise. "User Profile" page displays all the allergens inputted by the user and saved into the system. The user could drop any of the allergens if typed in by a mistake or etc.

![AllerscanApp](https://github.com/Zhalyn/AllerscanApp/blob/master/AllerScan/Images.xcassets/LaunchImage.launchimage/allerscanScreen1.jpeg)
![AllerscanApp](https://github.com/Zhalyn/AllerscanApp/blob/master/AllerScan/Images.xcassets/LaunchImage.launchimage/allerscanScreen2.jpeg)
![AllerscanApp](https://github.com/Zhalyn/AllerscanApp/blob/master/AllerScan/Images.xcassets/LaunchImage.launchimage/allerscanScreen3.jpeg)


# Main Controller Files
Main files that correspond for each page of the app are: AllergenController.swift (backend for "Include Allergens"), ProfileViewController.swift (backend for "User Profile"), ThirdViewController.swift (backend for "Scan") and ScaledElementProcessor.swift (backend for OCR and drawings of the blocks around each recognied string)

# Post-Scriptum 
The app was written on Swift. ML Kit is available here: https://firebase.google.com/docs/ml-kit
