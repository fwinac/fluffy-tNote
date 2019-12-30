# Dart

- 闭包

  向子组件传入的 callback 中的变量是该组件的，而不是子的

- 取 string 的 char

  xx[0]，取 xx 的第一个字符

- 构造函数

  ```dart
  class Product{
      const Product({this.name});
      final String name;
  }
  
  class **{
      ShoppingListItem({Product product, this.inCart, this.onCartChanged})
          :product = product, super(key:ObjectKey(product))
      final Product product;
      final bool inCart;
      final CartChangedCallBack onCartChanged;
  }
  ```

- List

  ```dart
  ShoppingList(products:<Product>[Product(name:'Eggs')])
  ```

# Widget

Flutter build ui out of widgets. 

runApp() 里运行的就是某个 widget，这个 widget 会填满屏幕。

StatelessWidget，父传入什么就展示什么（ 所以 Stateless 的 field 为 final）

StatefulWidget 根据 state 的变化来展示不同内容。

# BoxConstraint

怎样灵活的表示一个组件的大小？引入 minWidth、maxWidth、minHeight、maxHeight

怎样让组件树的组件都遵循某个限制？父把限制传给子，一直“往下”传递

当组件接收到限制后，怎样计算大小？尽可能的大

如果对 max 没有限制，怎样计算大小？尽可能的小

`参考`

- [Understanding Flutter Layout (Box)Constraint](https://proandroiddev.com/understanding-flutter-layout-box-constraints-292cc0d5e807)

# Common Widget list

- Stack

  图层，可用 Positioned(Align) 定位 widget 的位置

- Container

  rectangular

- Expanded

  填满父容器剩下的空间

- MaterialApp

  为子容器赋予 Material Design 主题

- Scaffold

  脚手架，有设置 appBar，body，fab 等的地方

- GustureDetector

  探测对 child 的操作

# Animation

```dart
//　AnimationController 产生 0 到 1 的 double，屏幕每刷新一次，就产生一个新的数
AnimationController controller = AnimationController(
    duration: const Duration(milliseconds: 500), vsync: this);
// this 当前类得 with SingleTickerProviderStateMixin 并在 initState() 中初始化 controller
// 让产生的数符合曲线
final Animation curve =
    CurvedAnimation(parent: controller, curve: Curves.easeOut);
// 让产生的数的类型和范围发生变化
Animation<int> alpha = IntTween(begin: 0, end: 255).animate(curve);
// 启动动画
controller.forward()
```

