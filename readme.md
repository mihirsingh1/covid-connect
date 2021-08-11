# Covid Connect

Connect those in need


## Screenshots
![](https://raw.githubusercontent.com/mihirsingh1/covid-connect/main/screenshots/Screenshot_1628649171.png)

## How to test?

This project is built with Flutter, NodeJS and MongoDB. The testing machine will require the development environment for these set up.

The server can be started by running:
```
npm start // In the folder where the main.js file is located
```


To start the app the following steps need to be followed:

1. Inside covid_connect/lib/constants/strings.dart, there is a variable named serverAddress, this string will hold the IP address of the server. 

2. Here if the server is running locally and the app is being tested on an android emulator then the serverAddress variable will hold the IP address: **http://10.0.2.2:3000/**

3. And if the app is being tested on a real device then it must be ensured that the pc running the server and the mobile device are connected to the same wifi/hotspot and in this case, the serverAddress variable will hold **http://IPV4-OF-PC:3000/**


## Features

1. This is a secure platform, it uses JWT Authentication and Password hashing to protect user data from being hacked