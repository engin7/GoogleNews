# GoogleNews

## About

  GoogleNews is an iOS app which connects to https://newsapi.org/ API and show users top headlines. 
  User can click on news to read the article. MVVM design pattern is used in this project.
  
  “Codable” protocol used for data serialization. Data returned from API inserted to SQLite Database.
  CollectionView cells loaded via database. CollectionView shows two columns for ipad for better user experience.
  Items clicked showed with SFSafariViewController.

<img width="200" alt="search for movies" src="https://user-images.githubusercontent.com/32449276/96362175-1b5d4100-1134-11eb-9c54-98df1ef2486c.png"> <img width="200" alt="iphone11" src="https://user-images.githubusercontent.com/32449276/96362228-7bec7e00-1134-11eb-8266-039e03b9689c.png"> <img width="200" alt="iphone11" src="https://user-images.githubusercontent.com/32449276/96362245-9e7e9700-1134-11eb-98ff-ae029562b94e.png"> 

<img width="300" alt="ipad9.7" src="https://user-images.githubusercontent.com/32449276/96362267-cff76280-1134-11eb-9e29-8290819d1bbb.png"> <img width="300" alt="ipad12.9" src="https://user-images.githubusercontent.com/32449276/96362432-ed78fc00-1135-11eb-91ba-16bcca5a93b1.png"> 


## Requirements

  SQLite.swift v0.12.2 installed via Swift Package Manager. 
  Gitignore file used to push this repository, please add necessary package dependency to run the project. You can get info about Sqlite.swift from site: https://github.com/stephencelis/SQLite.swift
  Also keys.plist file containing API key is not included in this public repository. Please request your own API key from the "https://newsapi.org/"
 
  Minimum IOS deployment target 14.0 and support both Iphone and Ipad.  
  XCode 12.0.1 Swift 5.3 used
 
 ## License

  This app is open source. If you find a bug please open an issue. Feel free to contribute.
