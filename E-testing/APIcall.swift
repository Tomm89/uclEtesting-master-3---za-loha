//
//  File.swift
//  E-testing
//
//  Created by tom on 20.12.16.
//  Copyright © 2016 Ondřej David. All rights reserved.
//

import Foundation


/*class APICall {
 
 static let sharedInstance = APICall()
 
 
 func accountDeviceCreate(user: User, completion: (verificationCode: String) -> ()){
 var verificationCodeResult = ""
 let userJson = JSONSerializer.toJson(user, prettify: true)
 
 RemoteAPI.sharedInstance.makePostRequest("account/device/create", jsonData: userJson, headers: ["Content-Type" : "application/json"])
 {
 statusCode, responseError, responseData in
 
 if let code = statusCode{
 if(code == 200)
 {
 do {
 let verificationCodeJson = try NSJSONSerialization.JSONObjectWithData(responseData!, options: .AllowFragments)
 
 if let code = verificationCodeJson["verificationCode"]{
 verificationCodeResult = code as! String
 }
 
 } catch {
 completion(verificationCode: verificationCodeResult)
 }
 
 }
 }
 completion(verificationCode: verificationCodeResult)
 }
 }
 
 // MARK: CheckVerificationCode
 func checkVerificationCode(verificationCode: String, completion: (isCorrect: Bool) -> ()){
 
 let code = VerificationCode(_verificationCode: verificationCode)
 let codeJson = JSONSerializer.toJson(code, prettify: true)
 
 RemoteAPI.sharedInstance.makePostRequest("account/device/verification", jsonData: codeJson, headers: ["Content-Type" : "application/json"])
 {
 statusCode, responseError, responseData in
 
 if let code = statusCode{
 if(code == 200)
 {
 
 do {
 let json = try NSJSONSerialization.JSONObjectWithData(responseData!, options: .AllowFragments)
 let userDefaults = NSUserDefaults.standardUserDefaults()
 
 if let deviceIdentifier = json["deviceIdentifier"]{
 let deviceIdentifierValue = deviceIdentifier as! String
 userDefaults.setValue(deviceIdentifierValue, forKey: "deviceIdentifier")
 }
 
 if let token = json["token"]{
 let tokenValue = token as! String
 userDefaults.setValue(tokenValue, forKey: "token")
 }
 
 userDefaults.synchronize()
 
 
 } catch {
 
 }
 completion(isCorrect: true)
 }
 else{
 completion(isCorrect: false)
 }
 }
 }
 }
 
 // MARK: GetMenu
 func getMenu(completion: (menuList: [Menu]) -> ()){
 
 var userToken = ""
 let defaults = NSUserDefaults.standardUserDefaults()
 if let token = defaults.stringForKey("token") {
 userToken = token
 }
 
 RemoteAPI.sharedInstance.makeGetRequest("menu", headers: ["X-API-Token" : userToken])
 {
 statusCode, responseError, responseData in
 var menuList = [Menu]()
 let dashboardMenu = Menu(title: "Dashboard", controllerIdentifier: "Dashboard", parentId: "", hasChildItems: false)
 let portfolioMenu = Menu(title: "Portfolio", controllerIdentifier: "MenuPortfolio", parentId: "", hasChildItems: false)
 let favouritiesMenu = Menu(title: "Oblíbené", controllerIdentifier: "MenuFavourities", parentId: "", hasChildItems: false)
 menuList.append(dashboardMenu)
 menuList.append(portfolioMenu)
 menuList.append(favouritiesMenu)
 
 if let code = statusCode{
 if(code == 200)
 {
 
 do {
 let json = try NSJSONSerialization.JSONObjectWithData(responseData!, options: .AllowFragments)
 if let menuItems = json["items"] as? [AnyObject] {
 
 print(json)
 
 for menuItem in menuItems{
 var parentId = ""
 let title = menuItem["name"] as! String
 let id = menuItem["id"] as! String
 let hasChildItems = menuItem["hasChildItems"] as! Bool
 
 if let parent = menuItem["parentId"]{
 if (parent is NSNull == false)
 {
 parentId = parent as! String
 }
 }
 
 let menu = Menu(title: title, controllerIdentifier: id, parentId: parentId, hasChildItems: hasChildItems)
 menuList.append(menu)
 }
 }
 
 } catch {
 
 }
 }
 }
 
 completion(menuList: menuList)
 }
 }
 
 // MARK: GetCodeList
 func getCodeList(completion: (success: Bool) -> ()){
 
 var userToken = ""
 let defaults = NSUserDefaults.standardUserDefaults()
 if let token = defaults.stringForKey("token") {
 userToken = token
 }
 var success = false
 
 RemoteAPI.sharedInstance.makeGetRequest("general/code-lists", headers: ["X-API-Token" : userToken])
 {
 statusCode, responseError, responseData in
 
 if let code = statusCode{
 if(code == 200)
 {
 do {
 let json = try NSJSONSerialization.JSONObjectWithData(responseData!, options: .AllowFragments) as! NSDictionary
 let codeList = CodeList(dictionary: json)
 let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(codeList!, toFile: CodeList.ArchiveURL.path!)
 success = isSuccessfulSave
 
 } catch {
 
 }
 }
 }
 
 completion(success: success)
 }
 }
 
 
 // MARK: GetClientData
 func getClientData(completion: (userData: UserData) -> ()){
 
 var userToken = ""
 let defaults = NSUserDefaults.standardUserDefaults()
 if let token = defaults.stringForKey("token") {
 userToken = token
 }
 var userData = UserData()
 
 RemoteAPI.sharedInstance.makeGetRequest("clients", headers: ["X-API-Token" : userToken])
 {
 statusCode, responseError, responseData in
 
 if let code = statusCode{
 if(code == 200)
 {
 do {
 let json = try NSJSONSerialization.JSONObjectWithData(responseData!, options: .AllowFragments) as! [String: AnyObject]
 
 print(json)
 
 if let firstName = json["firstName"] {
 userData.firstName = firstName as! String
 }
 
 if let lastName = json["lastName"]
 {
 userData.lastName = lastName as! String
 }
 
 } catch {
 
 }
 }
 }
 
 completion(userData: userData)
 }
 }
 
 // MARK: GetClientProductSettings
 func getClientProductSettings(completion: (productList: [ProductSettings]) -> ()){
 
 var userToken = ""
 let defaults = NSUserDefaults.standardUserDefaults()
 if let token = defaults.stringForKey("token") {
 userToken = token
 }
 
 RemoteAPI.sharedInstance.makeGetRequest("clients/products", headers: ["X-API-Token" : userToken])
 {
 statusCode, responseError, responseData in
 var productList = [ProductSettings]()
 
 if let code = statusCode{
 if(code == 200)
 {
 do {
 let json = try NSJSONSerialization.JSONObjectWithData(responseData!, options: .AllowFragments) as! [AnyObject]
 
 print(json)
 
 for settingsItem in json{
 let id = settingsItem["id"] as! Int
 let isActive = settingsItem["isActive"] as! Bool
 let isReadOnly = settingsItem["isReadonly"] as! Bool
 let name = settingsItem["name"] as! String
 
 let settingItem = ProductSettings(name: name, id: id, isActive: isActive, isReadOnly: isReadOnly)
 productList.append(settingItem)
 }
 
 } catch {
 
 }
 }
 }
 
 completion(productList: productList)
 }
 }
 
 // MARK: SetClientProductSettings
 func setClientProductSettings(productSettings: ProductSettings, completion: (success: Bool) -> ()){
 var isSuccess = false
 var userToken = ""
 let defaults = NSUserDefaults.standardUserDefaults()
 if let token = defaults.stringForKey("token") {
 userToken = token
 }
 
 let productSettingsJson = JSONSerializer.toJson(productSettings, prettify: true)
 
 print(productSettingsJson)
 
 RemoteAPI.sharedInstance.makePutRequest("clients/products", jsonData: productSettingsJson, headers: ["X-API-Token" : userToken, "Content-Type" : "application/json"])
 {
 statusCode, responseError, responseData in
 
 if let code = statusCode{
 if(code == 204)
 {
 isSuccess = true
 }
 }
 
 completion(success: isSuccess)
 }
 }
 
 // MARK: GetContacts
 func getContacts(completion: (contactList: [Contact]) -> ()){
 
 var userToken = ""
 let defaults = NSUserDefaults.standardUserDefaults()
 if let token = defaults.stringForKey("token") {
 userToken = token
 }
 
 RemoteAPI.sharedInstance.makeGetRequest("contacts", headers: ["X-API-Token" : userToken])
 {
 statusCode, responseError, responseData in
 var contactList = [Contact]()
 
 if let code = statusCode{
 if(code == 200)
 {
 
 do {
 let json = try NSJSONSerialization.JSONObjectWithData(responseData!, options: .AllowFragments) as! [[String : AnyObject]]
 
 for contactItem in json {
 let name = contactItem["name"] as! String
 let information = contactItem["information"] as! String
 let phoneNumber = contactItem["phoneNumber"] as! String
 
 }
 }
 }
 }
 }
 }
 } */