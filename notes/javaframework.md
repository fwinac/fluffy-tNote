## Spring

### 原理

初始化过程。读取配置文件，生成 beanName 和 BeanDefinition 的 Map。然后利用反射，根据 Map 实例化 Bean，再将 Bean 放入一个统一容器中。

- IOC

  IOC 即 DI，由容器负责对象的依赖和生命周期

  要有地方声明依赖，然后根据依赖描述利用反射生成对象，并在合适的时候调用 bean 不同生命周期的方法。

- Bean 生命周期

  在不同阶段会调用不同接口的函数

  属性填充、调用 Aware、初始化前后（后置处理器的 Before/After Initialization、afterPropertiesSet）、使用、毁灭( DisposableBean 的 destroy())

- Spring Boot

  目的：是 Spring 的扩展；1. 减少配置：对使用的库自动配置，maven 中引入 starters 2. 内嵌服务器: Tomcat，Jetty

- 源码

  1. Spring Application 构造过程

     调用构造函数，会调用 initialize() 方法，它为 sources、initializers、listeners 赋值。后两者，是通过扫描 classpath 中得 spring.factories 文件，得到目标名字得 list，然后通过反射调用无参构造器创建。

  2. 调用 run()

     即对应启动时打印日志的那个过程，这个过程就扫描了注解和配置文件，完成 Bean 的实例化了。

### 使用

#### Aspect

```java
@Aspect
@Configuration
public class {
    @Around("@annotation(app.fwinac.xx.MyAnnotation)")
    public Object interceptXX(ProceedingJoinPoint joinPoint){
        Method method = ((MethodSignature) joinPoint.getSignature()).getMethod();
        method.getAnnotation(MyAnnotation.class);
        method.toString();
        // 返回二维数组，位于位置 0 的数组表示第一个参数所拥有的注解
        method.getParameterAnnotations();
        joinPoint.getArgs()[i];
        arg.toString();
        return joinPoint.proceed();
    }
}
```



## Netty

组件

EventLoopGroup

interface，允许注册 Channel 的特殊的 EventExcutorGroup，Channel 和 Group 中某个 EventLoop 关联

ChannelInitializer

特殊的 ChannelInboundHandler，用于当 Channel 被注册到 EventLoop 时被激活的 handler。

源码分析

BootStrap

- NioSocketChannel 的产生过程

  产生 SocketChannel（SelectableChannel），传递 parent（null）和 Socket 到父类 AbstractNioByteChannel，该类传递 parent, SelectableChannel，interest（SelectionKey.OP_READ）到 AbstractNioChannel，AbstractNioChannel 传递 parent 到父类 AbstractChannel 的构造（设置parent，产生 unsafe、pipeline），然后配置 NIO 属性。
  
  - Unsafe 对 Java 原生 Socket 封装，在 AbstractChannel 中通过 newUnsafe() 产生。
  - pipeline 的初始化，new DefaultChannelPipeline(this)：构建了一个双向链表，头部 HeadContext（AbstractChannelHandlerContext，ChannelOutboundHandler），尾部 TailContext（AbstractChannelHandlerContext，ChannelInboundHandler）
  
- EventLoopGroup 内部包含一个存储 SingleThreadEventExcutor（EventLoop）的数组，该数组默认大小为 核心数*2。将一个 channel 注册到 EventLoopGroup，转换到注册到一个 eventloop 上，最后转换到调用 channel.register()，将 eventloop 添加到 channel 的属性中，并将 channel 注册到 eventloop 的 selector 上。

ServerBootStrap

- bootstrap.channel()

  设定 channelFactory 产生的 server channel 的类型。

- bootstrap.childHandler()

   为 server channel 产生的 channel 添加默认 handler。

  实现过程：
  
  需要在父 channel 的 pipeline 末尾添加一个接收到新 channel 时被激活的 handler：ServerBootstrapAcceptor，该 handler 包含 bootstrap.childHandler() 传入的 childHandler，被激活后会在新 channel 的 pipeline 中添加 childHandler，并将 channel 注册到 childEventLoopGroup。要添加末尾需要借助 eventloop.excute() 异步添加，所以要等待 eventloop 准备好，需要 ChannelInitializer。添加这个 initializer 是在 init(channel) 时，init() 在 initAndRegister() 中。

Pipeline

怎么添加 handler 的？通过 handler() 添加 channel initializer，所以在 pipeline 初始时，有 head、initializer 和 tail。当 channel register 到 eventloop 时，initializer 的 channelRegistered() 被调用，该方法再调用 initChannel()，用户重写的 initChannel() 会注册自定义 handler，在调用 initChannel() 后，channel initializer 把自己从 pipeline 中移除。

