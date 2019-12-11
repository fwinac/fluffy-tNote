## 画图

- 初始化

  seaborn.set()

  ​	开启默认美化设置

  import matplotlib.pyplot as plt

- 单画布

  plt.plot(横轴坐标list，纵轴坐标list, 'bo', ms=8)
  
  ​	蓝色的原点，原点大小为8
  
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


## 分布

scipy.stats 有几十种离散或连续分布。可遍历 stats 的 \_\_dict\_\_ 来查看。

- binom，二项分布

  某种分布 = binom(n=10,p=0.5)

  ​	连续投 10 次硬币的伯努利试验。如利用 rvs 取样，则大部分取样结果在 5。

- 某种分布.rvs(size=10000)

  ​	对某种分布的随机变量（rv）取样（sample）10000 次；

- 某种分布.pmf(x)

  ​	对输入 x list 通过 pmf 计算输出；取得 list 某个 item 在这种分布下的概率。
