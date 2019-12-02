# 语法

## interface{}

An interface can store either a struct directly *or* a pointer to a struct. In the latter case, you still **just** use the interface directly, *not* a pointer to the interface.

## []{}interface

![](pics/20190609163022.png)

[]interface{} 是一个具体的类型，而不是代表所有类型。能直接把 []string 转换为 []int 吗？

## slice

```go
var nums []int//nums 为 null
nums = append(nums,1)
//OR
nums := make([]int,0)
// this slice built with lenght of zero, so nums[0]=xx is wrong.
```

## Map

```go
var m1 map[string]string
// map is nil
m1 := make(map[string]string)
// map is valid
```

## chan

```go
func randomNumberGenerator() <-chan int {}
chan   // read-write
<-chan // read only
chan<- // write only
```

channel 在 closed 后还 send，会 panic

## 反射和类型转换

type assertion、type switch 是反射；反射是从“抽象类型获取具体类型”，而类型转换是不同静态类型之间的转换。

## pass by value or pointer

Everything in go is passed by value. 

But a slice value is a header, decribing the slice, called SliceHeader. Unlike array, all elements passed as a value.

slices, maps, channels, interfaces, are all "passed by pointer(reference)".

## ++/--

++ 和 -- 只能放在变量后面，而且

```go
nums[i--]
```

是非法的；

这么做是为了简化语法


## defer

当 defer 中 panic 时，不会再被同函数其他 panic 捕获

# 网络编程

- 没有办法直接判断连接状态。当读写时，是否错误，可知状态。

- 客户端和服务器交流的应该是命令而“不是日志”。命令，应该根据数据的格式判断，而不是数据的具体内容来判断

  ```go
  // 不合适写法
  sturct GMsg{
      type string
  }
  // 合适写法
  struct AType{
  }
  struct BType{
  }
  ```

# 性能调优

## 内存消耗优化

- 启用 pprof

  gorilla mux 启用方法 google

- curl 相应页面的数据

- 分析

  go tool pprof ./** 

## Cpu 消耗优化

- 解决整体耗时区域
  
  1. go test
  
	2. 下面两个命令几乎同时运行
	
	   ```go
	    go-wrk -d 60 http://localhost:8080/a@golang.org
		```
	
 -  解决整体中某一部分的过多耗时
	1. 写 Benchmark方法
		 	func BenchmarkXX(b *testing.B)
	2. go test
	3.  go test -bench . -cpu.profile prof.cpu
	4.  用 pprof 分析文件

`参考`

- Youtube. Just For Func