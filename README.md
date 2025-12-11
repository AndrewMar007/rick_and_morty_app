# rick_and_morty_app

## 📱 Rick and Morty API Testing App

#### A Flutter application built for testing and exploring the Rick and Morty API.

### 📸 Screenshots

| Characters List Page | Search Character Page |
|----------------------|-----------------------|
| <img src="screenshots/main.png" height="400"/> | <img src="screenshots/search.png" height="400"/> |

<br>

| Character Info Page | Episode Info Page |
|---------------------|-------------------|
| <img src="screenshots/character.png" height="400"/> | <img src="screenshots/episode.png" height="400"/> |

## ✅ Implemented Features

#### 📄 Pagination support for the main list of characters

#### 🔍 Search by character name

#### 🔗 Deep navigation flow:
##### Characters list → Character info → Episode info

#### 🌐 Network outage handling (retry requests once the network is restored)

#### ⏳ Loading state handling across all data-fetching operations

## 🧩 Architecture Overview
### MVVM + BloC

```text
lib/
├─ core/
│  ├─ exceptions/
│  └─ network/
├─ model/
├─ services/
│  ├─ episode_service/
│  └─ character_service/
├─ view/
│  ├─ bloc/
│  ├─ pages/
│  └─ widgets/
└─ view_model/
   ├─ character_view_model/
   └─ episodes_view_model/
```

#### View — Flutter UI widgets
#### ViewModel — communicates with services, prepares data
#### BLoC — state machine that exposes states to the UI
#### Service layer — API calls using dio

## 🛠️ Core Technologies & Architecture

#### - State Management: flutter_bloc
##### It is used to transfer data from the ViewModel to the View.
###### Several classes were created for this purpose, each responsible for one of the main functions (fetching the list of characters, searching for a character, retrieving character information, and retrieving the episode in which the character appears)
##### (A powerful reactive state-management library built on top of Provider)

#### - Architecture Pattern: MVVM
###### A pattern used for structuring the application architecture (MVVM is well-suited for implementing small applications).
##### (Clean separation between UI, logic, and data layers)

#### - HTTP Client: dio
##### (Efficient networking, interceptors, error handling)
##### Using the dio package, GET requests were implemented to retrieve the following data:
###### - a list of characters
###### - character search by name
###### - detailed character information
###### - detailed episodes information

#### - Service Locator: get_it
###### It is used to create objects based on the Singleton pattern in order to reduce the number of objects instantiated by the application and to provide global access to them, which significantly decreases resource usage and improves control over class instances.
##### (Used for dependency injection and singletons)

### I highly recommend it to everyone and thank you for the opportunity.
#### https://rickandmortyapi.com/
