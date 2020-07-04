# Koronako

## SUMMARY
Koronako app is a trial to track devices with bluetooth to help to estimate exposures. The app main idea is to maintain privacy. Of course that reduces the efficiency. No pairing of the phones are needed.

The tracking what the app does is taking seven last letters from your device name and from a close phone name. From those names both phones can count and save independently the same number so they can later check from server if the phone exposed or not. The first part of the code is a current day. Multiple phone pairs might have the same result, but I assume that this not very probable. If there are too many false alarms, more letters could be taken to account. Some simulation should be made to set up right amount of the saved data.

When you send your infection data to the server you lose the ability to check your exposures on those days. That reduces the motivation to send false data to the server.

The whole software is licensed under BSD.

## PRIVACY
As a maintainer of this code I do not collect any information of you. All the data is locally on your phone until you possibly send it to the server temporarily to be used in checks or permanently when infected by corona. 

Koronako cannot operate without a server solution. That is a privacy concern. To overcome this the data model is simplified and real device names are not saved by the app. From the data the app user can not to be identified. The data transfer to the server is protected by SSL.

The app is not sending any information of your identity to me. I might get some general information of the app users depending on the store you installed the app.

I do not install any adds to this app.

## KNOWN ISSUES (ANDROID)

Currently Android user have to permit the device to be discoverable in every 5 minutes. 
