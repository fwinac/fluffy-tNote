## 画图

- 初始化

  seaborn.set()

  ​	开启默认美化设置

  import matplotlib.pyplot as plt

- 单画布

  plt.figure()
  
  plt.plot(横轴坐标list，纵轴坐标list, 'bo', ms=8)
  
  ​	蓝色的原点，原点大小为8
  
  plt.gca().axes.set_xticks(), 获取当前画布的轴并设置 xticks
  
- 多画布

  fig,axs = plt.subplots(3, 1)

  ​	三行一列排列子画布。axs[0] 为第一个子画布的 Axe

  ax.set_title('\*\*{}\*\*'.format('a'))

  ax.set_xlimit(0, 10)

  ​	包括 10

  ax.set_ylimit(0, 0.4)

  ax.set_xticks(x轴竖线起点的list)

  ax.plot()

  ax.vlines(x, 0, y, colors='b', lw=3)

  ​	把 x list 的点从 0 开始画到 y list 的点

- 展示画布

  plt.ioff()

  plt.show()

## 图类型

- 直方图

  反应数据在范围内的分布情况；即某个范围内有几个数据。

  plt/ax.hist(x, bins=10, normed=True)

  ​	归一化后，纵轴就表示某个范围内数据所占的比例。

## 函数

- PMF(Probability Mass Function)

  PMF 输入离散随机变量取的某个值，输出此时的概率

