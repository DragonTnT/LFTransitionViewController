# LFTransitionViewController
a demo project for LFTransitionViewController's usage

 ![](https://github.com/DragonTnT/LFTransitionViewController/blob/master/GIF/transition.gif?raw=true)

### How to Use
#### 1.drag `Transition` into your project
#### 2.create a new class inhert from `LFTransitionViewController`
```
class TestViewController: LFTransitionViewController
```
#### 3.present a instance of the class
```
let vc = TestViewController()
vc.transitionStyle = .scaleChange
present(vc, animated: true, completion: nil)
```
