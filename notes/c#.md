# C##

## Extension Methods

在不修改原文件代码的情况下，对原来的类添加新方法

```c#
public static class XXExtensions{
    public static ** **(this 旧类名 a,**)
}
```

## 委派

给方法定义取个名字，以作为函数参数等

```c#
delegate int ScoreDelegate(PlayerStats stats)
```

## 协变和逆变

带泛型的容器，协变（表扩展，类似 T extends)，逆变（表溯源，类似 T super)

## Async

主线程会执行 async 方法直到遇到 await，主线程回到调用方法处。另一个线程执行 await 的任务，任务完成后，该线程会继续执行 await 下面的代码。

## ? ??

```c#
int i;//默认0
int? i;//默认null
test?.A();//即使对象test为null，仍然不会抛异常
i = ii??0;//ii为null，返回0
```

## 重写

父类（virtual），子类（override)都有，才能重写。缺一，都不能实现多态调用子类。

# .Net Core

## 服务器模型

### In-process

用户的 .net core app 和 IIS 是同一个进程，效率更高

### Out-of-process

用户的 .net core app（由 Kestrel 运行） 和 IIS 是不同进程，IIS 反向代理 Kestrel 服务器，IIS 和 Kestrel 之间借助网络 loopback 通信。

查看监听端口配置：Properties/launchSettings.json

## Options模式

把配置文件变为”Bean“

将 appsettings.json 转换为 Option，然后放入到容器中。注入时，分为 IOptions、IOptionsMonitor、IOptionsSnapshot；前两个为单例，但是 Monitor 会根据配置文件刷新。Snapshot 每次请求产生新实例，产生新实例时会根据配置文件更新。