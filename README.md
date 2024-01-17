# WeatherApp-Cubit

Introducing Weather App: Your iOS & Android app to subscribe to a fetch the current weather. Crafted with Flutter, this app, built on the Bloc architecture, empowers you with to fetch the latest weather and see all details on the go.

## App Image
<img width="469" alt="Screenshot 2024-01-17 at 4 58 18 PM" src="https://github.com/abdullahihsan3/WeatherApp-Cubit/assets/109294768/d3a7c68e-e528-4f89-bfca-be1d82590aeb">


## Requirements
Flutter & Dart

## Architecture

The app is built using the Bloc architecture pattern. Here's a brief overview of the different layers:

- Model: The data layer that represents the app's data and business logic.
- View: The UI layer that displays the data to the user and handles user input. In this app, the views are implemented using Bloc Builder and Consumer patterns.
- Cubit: The cubit layer manages the methods and initial data handling. Additionally, the cubit handles the various state methods that are to be called.
- State: The state file manages the different states of the application which include but not limited to initial, loading, success or failure. These can be defined as enums to handle the state.
- Repository: The repository contains the methods that interact with the different network services. The repository contains various methods which are defined according to the cubit.


## Usage

1. Clone the repository locally or use the template for your own projects:

2. Install dependencies using the following command:

```bash
flutter pub get
```
3. Run the app on your emulator of choice (simulator in case of iOS):

```
flutter run
```

## Folder Structure

```
lib/
|- bloc/
|- models/
|- repository/
|- enums/
|- screens/
|- widgets/
|- utils
|- main.dart
```




