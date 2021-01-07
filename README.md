创建 `pods` 工程，即组件化工程

##### 1、创建组件库

使用 `cocoapods` 创建组件化库 `YLServices` ：

```
MacBook-Air Desktop % pod lib create YLServices
```

需要回答一些问题：

```
What platform do you want to use?? [ iOS / macOS ]
 > iOS

What language do you want to use?? [ Swift / ObjC ]
 > ObjC

Would you like to include a demo application with your library? [ Yes / No ]
 > Yes

Which testing frameworks will you use? [ Specta / Kiwi / None ]
 > Specta

Would you like to do view based testing? [ Yes / No ]
 > Yes

What is your class prefix?
 > YL

Running pod install on your new library.

Analyzing dependencies
Downloading dependencies
Installing Expecta (1.0.6)
Installing Expecta+Snapshots (3.1.1)
Installing FBSnapshotTestCase (2.1.4)
Installing Specta (1.0.7)
Installing YLServices (0.1.0)
Generating Pods project
Integrating client project

[!] Please close any current Xcode sessions and use `YLServices.xcworkspace` for this project from now on.
Pod installation complete! There are 5 dependencies from the Podfile and 5 total pods installed.

 Ace! you're ready to go!
 We will start you off by opening your project in Xcode
  open 'YLServices/Example/YLServices.xcworkspace'

To learn more about the template see `https://github.com/CocoaPods/pod-template.git`.
To learn more about creating a new pod, see `https://guides.cocoapods.org/making/making-a-cocoapod`.
MacBook-Air Desktop % 
```

至此，已经在本地创建了组件化库！

##### 2、配置文件 `.podspec` 

> 组件库的配置文件 `YLServices.podspec` !


如果需要依赖三方库，需要配置  `s.dependency`

```
s.dependency 'AFNetworking', '4.0.1'
s.dependency 'SDWebImage', '4.3.3'
s.dependency 'Bugly', '2.5.0'
```


如果模块间需要相互引用，同样需要配置 `s.dependency`，
如：组件库 `YLRouter` 需要引用 `YLServices`

```
//********1、修改 YLRouter.podspec 文件
s.dependency 'YLServices'

//********2、修改 YLRouter Podfile 文件
pod 'YLServices', :path => '../../YLServices'
```


配置 Git 仓库的主页与地址

```
/// 必须配置主页地址
s.homepage         = 'https://github.com/name/YLServices'

/// 必须配置 Git 仓库地址
s.source           = { :git => 'https://github.com/name/YLServices.git', :tag => s.version.to_s }
```

##### 3、在组件库添加文件

###### 添加类

创建 `PeopleModel` 类添加至指定目录：

![在指定目录添加类](https://upload-images.jianshu.io/upload_images/7112462-211a01d000b7c66c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


执行 `pod install` ,将 `PeopleModel` 更新至 `pods` 组件库中

```
MacBook-Air ~ % cd /Users/long/Desktop/YLServices/Example 
MacBook-Air Example % pod install
```

###### 添加资源文件

添加资源到指定目录，如图片、json、bundle文件等:

![添加资源到指定目录](https://upload-images.jianshu.io/upload_images/7112462-e40342c32d008c7f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


注意：必须在配置文件 `YLServices.podspec`  设置资源路径，否则无法读取资源！


```
s.resource_bundles = {
    # 添加所有类型文件
    'YLServices' => ['YLServices/Assets/*'],
    
    # 指定添加 png 图片
   'YLServices' => ['YLServices/Assets/*.png'],
   
   # 指定添加 bundle 类型文件
   'YLServices' => ['YLServices/Assets/*.bundle']
}
```

然后执行 `pod install` ,更新组件库

```
MacBook-Air Example % pod install
```

![工程目录.png](https://upload-images.jianshu.io/upload_images/7112462-118068953329099a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


##### 4、组件库上传至远程 Git 仓库

```
MacBook-Air YLServices % git add .
MacBook-Air YLServices % git commit -m'init'
MacBook-Air YLServices % git push
```

###### 打  `tag`

```
/// 新建tag
git tag 1.0.0

/// 推送tag到远程
git push origin 1.0.0
```


###### 验证 `podspec` 文件


```
///只验证一个本地仓库
MacBook-Air YLServices % pod lib

/// 同时验证本地仓库和远程仓库
MacBook-Air YLServices % pod spec lint
```


```
MacBook-Air YLServices % pod spec lint
 -> YLServices (0.0.1)
    - WARN  | url: The URL (https://github.com/774792381@qq.com/YLServices) is not reachable.
    - ERROR | [iOS] unknown: Encountered an unknown error ([!] /usr/bin/git clone https://github.com/774792381@qq.com/YLServices.git /var/folders/s5/127zrd4j7kl4llwhcl4cz3_40000gn/T/d20210106-20600-1a4bg2o --template= --single-branch --depth 1 --branch 0.0.1

Cloning into '/var/folders/s5/127zrd4j7kl4llwhcl4cz3_40000gn/T/d20210106-20600-1a4bg2o'...
fatal: unable to access 'https://github.com/774792381@qq.com/YLServices.git/': The requested URL returned error: 400
) during validation.

Analyzed 1 podspec.

[!] The spec did not pass validation, due to 1 error and 1 warning.
```




##### 5、在工程中使用组件库 `YLServices`

新建工程 `Demo`，创建 `Podfile` 文件

```
MacBook-Air Demo % pod init
```

在 `Podfile` 文件中添加：

```
pod 'YLServices', :git => 'https://github.com/name/YLServices',:tag => '0.0.1'
```

此时，就可以在  `Demo` 工程中使用 `YLServices` 组件库 了！！

---

参考文章

[YLServices 示例](https://github.com/Kanthine/YLServices)

[iOS 组件化方案](https://www.jianshu.com/p/7ca16c92ca37)
