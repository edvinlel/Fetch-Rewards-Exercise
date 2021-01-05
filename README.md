# Fetch Rewards Exercise

Application built for FetchRewards exercise that will fetch data from the SeatGeek API
to present to the user. The user can store favorited events in Firebase using the anonymous sign in.

## Libraries

Firebase: Used for the backend of the application to store users favorite events.

https://www.firebase.com

KingFisher: A Swift library used to download and cache images downloaded from the web.

https://github.com/onevcat/Kingfisher

## Installation

Install the pod file in the terminal at folder directory.

```bash
cd ProjectDirectory
pod install
```

## Screenshots
### Home
##### When application is first opened, user will be shown 100 events fetched from SeatGeek's API. They have the option to click and view more information about the event as well as like the event and it would be stored in the Firebase backend.
![image](https://user-images.githubusercontent.com/5642714/103710241-66d00000-4f69-11eb-97e7-c441d4c801b4.png)

### Search
##### User can also search for events. In this example, "los angeles lakers" was the event searched for.
![image](https://user-images.githubusercontent.com/5642714/103710704-89aee400-4f6a-11eb-93dc-2aa429d8f5b9.png)

### Detailed View
##### Detailed information on the event. As well as allow the user to share, buy tickets and like this event.
![image](https://user-images.githubusercontent.com/5642714/103710980-325d4380-4f6b-11eb-9383-4a9787332e97.png)

### Buy Tickets
##### When the buy tickets button is pressed, the user will be sent to the url link to purchase tickets via safari or the SeatGeek app if installed on phone.
![image](https://user-images.githubusercontent.com/5642714/103710757-b2cf7480-4f6a-11eb-8e65-d6d04ac3c818.png)


### Share
##### User can share an event to a friend via sms, email, etc.
![image](https://user-images.githubusercontent.com/5642714/103710999-3b4e1500-4f6b-11eb-88b1-16d2f338e75f.png)
