# GourmetGo

This project is a part of ITCS424 Wireless and Mobile Computing

| ID| Name |
|-----------------|-----------------|
| 6488020| NAVALUCK DUWA |
| 6488048 | NAPAT KAMAISOM |
| 6488057| PHAWIDA PHUNGCHUEN |
| 6488085| BHUBODIN SOMWHANG |

Welcome to GourmetGo, your ultimate companion for exploring food recipes! This Flutter project allows users to search for food recipes using the Spoonacular API, while also providing features for managing food allergies and receiving recipe recommendations.

## Features

1. **Food Recipe Search**: Utilize the Spoonacular API to search for a wide variety of food recipes based on keywords, ingredients, or even cuisine types.

2. **Food Allergy Management**: Users can specify their food allergies within the app, ensuring that the recipes recommended to them do not contain any ingredients they are allergic to.

3. **Recipe Recommendations**: Receive personalized recipe recommendations based on your preferences, previous searches, and dietary restrictions.

## Getting Started

To get started with GourmetGo, follow these simple steps:

1. Clone the repository to your local machine:

    ```bash
    git clone https://github.com/NapatPoon/GourmetGo.git
    ```
2. Navigate to the project directory:
    ```bash
    cd GourmetGo
    ```
3. Install dependencies using Flutter:
    ```dart
    flutter pub get
    ```
4. Ensure you have an API key from Spoonacular. You can obtain one by signing up at [Spoonacular](https://spoonacular.com/food-api) and following their documentation for getting an API key.

5. Once you have the API key, add it to the project. Find the file `lib/config.dart` and replace `"YOUR_API_KEY_HERE"` with your actual API key.

6. Run the app on your preferred device or simulator:
    ```dart
    flutter run
    ```
