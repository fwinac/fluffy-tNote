## 类型

容器，包含的元素可以不是一个类型，且都用 x[0] 的方式访问

- list：[]

  [k for k in dictA if 42 in k]

- dict: {x:y}

  - for k in dict

    go 中，有 for k,v := range dictA，区别于 python 中的 range 函数

  - for k,v in dict.items()

- set: {x}

- tuple: ()

  (1,2,3)

## 变量

- 命名

  以 _ 开头的名字，约定为模块私有的，不要操作。
  
- __dict__

  ```python
  def func():
      pass
  func.temp = 1
  
  print func.__dict__
  
  class TempClass(object):
      a = 1
      def tempFunction(self):
          pass
  
  print TempClass.__dict__
  ```

  ```
  {'temp': 1}
  {'a': 1, '__module__': '__main__', 'tempFunction': <function tempFunction at 0x7f77951a95f0>, '__dict__': <attribute '__dict__' of 'TempClass' objects>, '__weakref__': <attribute '__weakref__' of 'TempClass' objects>, '__doc__': None}
  ```

## 模块

- 模块名

  一个文件被导入到其他文件，这种文件叫 module。文件名就是 module name，可通过全局变量 \_name\_ 获取。

- 导入

  ```py
  import seaborn
  seaborn.set()
  import scipy.stats
  scipy.stats.binom()
  import scipy.stats as stats
  stats.binom()
  from scipy.stats import binom
  binom()
  ```

  