# LFTransitionViewController
a demo project for LFTransitionViewController's usage

### How to Use
#### 1.drag `Transition` into your project
#### 2.create a new class inhert from `LFTransitionViewController`
```
class TestViewController: LFTransitionViewController
```
#### 3.present a instance of the class
```
let vc = TestViewController(transitionStyle: style)
present(vc, animated: true, completion: nil)
```
