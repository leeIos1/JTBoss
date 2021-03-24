//
//  SceneDelegate.swift
//  JT
//
//  Created by apple on 2021/3/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
/**
     
     {"sectionTitle":"年龄性别",
     "values":[
         {
             "id": "nlgd",
             "name": "年龄过低"
             "isSelected": false,
         },{
             "id": "nlgg",
             "name": "年龄过高"
             "isSelected": false,
         },{
             "id": "manyx",
             "name": "男士优先"
             "isSelected": false,
         },{
             "id": "womenyx",
             "name": "女士优先"
             "isSelected": false,
         }]
     },
     {"sectionTitle":"工作经验",
     "values":[
         {
             "id": "1n",
             "name": "一年"
             "isSelected": false,
         },{
             "id": "3n",
             "name": "三年"
             "isSelected": false,
         },{
             "id": "5n",
             "name": "5年"
             "isSelected": false,
         },{
             "id": "bx",
             "name": "不限"
             "isSelected": false,
         }]
     },
     {"sectionTitle":"薪资",
     "values":[
         {
             "id": "1000",
             "name": "1000"
             "isSelected": false,
         },{
             "id": "2000",
             "name": "2000"
             "isSelected": false,
         },{
             "id": "100000",
             "name": "100000"
             "isSelected": false,
         }]
     },
     {"sectionTitle":"职位类型",
     "values":[
         {
             "id": "qdkf",
             "name": "前端开发"
             "isSelected": false,
         },{
             "id": "hdkf",
             "name": "后端开发"
             "isSelected": false,
         },{
             "id": "cpjl",
             "name": "产品经理"
             "isSelected": false,
         },{
             "id": "cs",
             "name": "测试"
             "isSelected": false,
         }]
     },
     {"sectionTitle":"其他",
     "values":[
         {
             "id": "szrs",
             "name": "深圳人士"
             "isSelected": false,
         }]
     }
     */

}

