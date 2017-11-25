# SwiftSnapshotDemo
### 11月25日练习
* 使用截屏实现一些动画效果：
```
let snapshotView = selectedCell?.snapshotView(afterScreenUpdates: false)!
```
比如在demo中，CollectionView中的每一个Cell都有一个ImageView，动画开始前使用上面的代码给点击的cell截图，将其frame设置与原cell一致，并将原cell隐藏。接下来的位移及缩放动画则均是以该截图为操作对象
