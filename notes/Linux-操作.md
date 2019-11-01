# 快捷键

- Tab：命令和文件名补全；
- Ctrl+C：中断正在运行的程序；
- **Ctrl+D**：结束键盘输入（End Of File，EOF），进入python的命令符后用它来退出

# 包管理工具

YUM 基于 RPM，APT 基于 DPKG。前者都添加了在线功能。

`参考`

- [Linux 平台上的软件包管理](https://www.ibm.com/developerworks/cn/linux/l-cn-rpmdpkg/index.html)

# 用户和组

## 用户和组
- 查看同组成员

  ```shell
  $ groups fwinac
  ```
  
- 查看所有的组

  ```shell
  $ cat /etc/group
  ```


- sudo

  在 /etc/sudoers 配置文件中添加的用户可以用它切换到管理员权限

- 添加新组和用户

  ```shell
  $ groupadd postgres&&useradd -m -g postgres postgres
  # -m 会创建用户的 home 目录；-r 创建 system account，不会创建 home 目录
  ```

## 权限
- SUID，SGID，Sticky Bit
  
  前两个表示执行该文件时，该文件的有效用户/组（执行该程序的用户/组）在该程序看来就变成了该程序的所属。
  
  ​	- passwd 命令需要修改 /etc/passwd 文件（该文件属于root），那么passwd 在不特权时是怎么修改自己的密码的
  
  ​	- SGID 设置在目录上时，在该目录下创建的文件的所属组和该目录一致。
  
  Sticky Bit 用在目录上，使该目录下的文件只能由所属用户删除
  
  ```shell
  # 使用
  chmod 4777 **
  chmod 2777 **
  chmod 1777 **
  ```


# 求助

- --help

  ```shell
$ date --help
  ```

	注意，方括号括住表示可选参数
	
- man

  man(manual) 查看详细信息。man pages 可通过命令`manpath`查看

  当执行`man date`时，有 DATE(1) 出现

  | 代号 | 类型                                            |
  | :--: | ----------------------------------------------- |
  |  1   | 用户在 shell 环境中可以操作的指令或者可执行文件 |
  |  5   | 配置文件                                        |
  |  8   | 系统管理员可以使用的管理指令                    |


# 关机

- **who**

  关机前查看谁在线

- **sync**

  同步在缓存中的数据到磁盘

- **shutdown**

  ```shell
  $ shutdown [-krhc] 时间 [信息]
  -k ： 发送警告信息，通知在线的用户
  -r ： 重新启动
  -h ： 停掉服务后关机
  -c ： 取消已经在进行的 shutdown 指令内容
  时间: 如，now
  ```

# 负载

如：top、uptime

其中 load average 依次表示在 1min、5min 和 15min 需要的 CPU 时间。

假设为：2.9、2.6、2.2

依次表示需要 2.9\*1min、2.6\*5min、2.2\*15min 个 CPU 时间

如果为 CPU 可以并行执行两个，可以依次提供 2\*1min、2\*5min、2\*15min 个 CPU 时间

# 文件操作

## 常用
- ls、cd、mkdir、rmdir、touch、cp、rm、mv

## 进阶
- **查看目录占用空间情况**
	
	```shell
	$ du -h -d 1 /home
	-h 空间大小为人类可读
	-d 深度，换为2，0测试
	/home 目标
	```
	
- **权限**
   r : 4、w : 2、x : 1。

  示例：将 .bashrc 文件的权限修改为 -rwxr-xr--（分为四段，类型、用户、组、其他）。
  ```shell
  $ sudo chmod 754 .bashrc
  ```
  示例：为 .bashrc 文件的所有用户添加写权限。

  ```shell
  $ sudo chmod a+w .bashrc
  ```

- **查找**
  - 可执行文件
  ```shell
  # 找 ls 命令在哪个目录
  $ which ls
  # 找 ls 命令及其文档在哪个目录
  $ whereis ls
  ```
  - 文件搜索
  ```shell
  # 在当前目录找 shadow 开头的文件
  $ find . -name "shadow*"
  ```
    `参考`

    - +4、4 和 -4 的指示的时间范围如下：
      
    <div align="center"> <img src="pics/658fc5e7-79c0-4247-9445-d69bf194c539.png" width=""/> </div><br>
  
- 命令行生成文件

  ```shell
  $ echo -e 'abc\nabc'
  # -e enable backslash，加了之后\n才生效
  ```

- 行处理文件 sed

  ```shell
  $ sed -i '2,5c hello' xx
  $ sed -i 's/abc/a/g' xx
  # -i in place，不加则不会修改源文件
  ```

   
# 获取文件内容
- **cat**
取得文件内容。

	```shell
	$ cat [-AbEnTv] filename
	-n ：打印出行号，连同空白行也会有行号
	```

- **tac**
从最后一行开始打印。

- **more**
一页一页查看文件内容

- **less**
和 more 类似，但是可以向前翻页。

- **head**
  取得文件前几行。

  ```shell
  $ head [-n number] filename
  -n ：后面接数字，代表显示几行的意思
  ```

- **tail**
最后几行

- **od**
以字符或者十六进制的形式显示二进制文件。

# 正则表达式

- **grep**
g/re/p（globally search a regular expression and print)。

	示例：把含有 the 字符串的**行**提取出来（注意默认会有 --color=auto 选项，因此以下内容在 Linux 中有颜色显示 the 字符串）

	```shell
	$ grep -n 'the' regular_express.txt
	8:I can't finish the test.
	12:the symbol '*' is represented as start.
	15:You are the best is mean you are the no. 1.
	16:The world Happy is the same with "glad".
	18:google is the best tools for search keyword
	```

	因为 { 和 } 在 **shell** 是有特殊意义的，因此必须要使用转义字符进行转义。

	```shell
	$ grep -n 'go\{2,5\}g' regular_express.txt
	```

- **awk**
	是由 Alfred Aho，Peter Weinberger, 和 Brian Kernighan 创造，awk 这个名字就是这三个创始人名字的首字母。
	
	示例：取出最近五个登录用户的用户名和 IP
		

	```shell
	 $ last -n 5
	 dmtsai pts/0 192.168.1.100 Tue Jul 14 17:32 still logged in
	 dmtsai pts/0 192.168.1.100 Thu Jul 9 23:36 - 02:58 (03:22)
	 dmtsai pts/0 192.168.1.100 Thu Jul 9 17:23 - 23:36 (06:12)
	 dmtsai pts/0 192.168.1.100 Thu Jul 9 08:02 - 08:17 (00:14)
	 dmtsai tty1 Fri May 29 11:55 - 12:11 (00:15)
	```

	```shell
	$ last -n 5 | awk '{print $1 "\t" $3}'
	```

	可以根据字段的某些条件进行匹配，例如匹配字段小于某个值的那一行数据。
	
	```shell
	 $ awk '条件类型 1 {动作 1} 条件类型 2 {动作 2} ...' filename
	```
	

	示例：/etc/passwd 文件第三个字段为 UID，对 UID 小于 10 的数据进行处理。
	```shell
	 $ cat /etc/passwd | awk 'BEGIN {FS=":"} $3 < 10 {print $1 "\t " $3}'
	 root 0
	 bin 1
	 daemon 2
	```
	
	awk 变量：
	
	| 变量名称 | 代表意义                     |
	| :------: | ---------------------------- |
	|    NF    | 每一行拥有的字段总数         |
	|    NR    | 目前所处理的是第几行数据     |
	|    FS    | 目前的分隔字符，默认是空格键 |
	
	示例：显示正在处理的行号以及每一行有多少字段
	
	```shell
	 $ last -n 5 | awk '{print $1 "\t lines: " NR "\t columns: " NF}'
	 dmtsai lines: 1 columns: 10
	 dmtsai lines: 2 columns: 10
	 dmtsai lines: 3 columns: 10
	 dmtsai lines: 4 columns: 10
	 dmtsai lines: 5 columns: 9
	```

# VIM
参考[1]

# 管道

管道将一个命令的 stdout 作为另一个命令的 stdin 

```bash
$ ls -al /etc | less
```

- **cut**
对数据逐行切分

	示例 ：last 显示登入者的信息，取出用户名。
	```shell
	$ last
	root pts/1 192.168.201.101 Sat Feb 7 12:35 still logged in
	root pts/1 192.168.201.101 Fri Feb 6 12:13 - 18:46 (06:33)
	root pts/1 192.168.201.254 Thu Feb 5 22:37 - 23:53 (01:16)

	$ last | cut -d ' ' -f 1
	```

	示例 ：将 export 输出的信息，取出第 12 字符以后的所有字符串。
	```shell
	$ export
	declare -x HISTCONTROL="ignoredups"
	declare -x HISTSIZE="1000"
	declare -x HOME="/home/dmtsai"
	declare -x HOSTNAME="study.centos.vbird"
	.....(其他省略).....

	$ export | cut -c 12-
	```

- **sort**
  排序。

  示例：/etc/passwd 文件内容以 : 来分隔，要求以第三列进行排序。

  ```shell
  $ cat /etc/passwd | sort -t ':' -k 3
  root:x:0:0:root:/root:/bin/bash
  dmtsai:x:1000:1000:dmtsai:/home/dmtsai:/bin/bash
  alex:x:1001:1002::/home/alex:/bin/bash
  arod:x:1002:1003::/home/arod:/bin/bash
  ```

- **uniq**  

  去重之前肯定要 sort

  ```shell
  $ uniq [-ic]
  -i ：忽略大小写
  -c ：进行计数
  ```

  示例：取得每个人的登录总次数
  ```shell
  $ last | cut -d ' ' -f 1 | sort | uniq -c
  1
  6 (unknown
  47 dmtsai
  4 reboot
  7 root
  1 wtmp
  ```

- **双向输出重定向**
输出重定向会将输出内容重定向到文件中，而  **tee**  不仅能够完成这个功能，还能保留屏幕上的输出。

	```shell
	$ tee [-a] file
	```

- **字符转换指令**
**tr**  用来删除一行中的字符，或者对字符进行替换。

	```shell
	$ tr [-d] SET1 ...
	-d ： 删除行中 SET1 这个字符串
	```

	示例，将 last 输出的信息所有小写转换为大写。
	```shell
	$ last | tr '[a-z]' '[A-Z]'
	```

  **col**  将 tab 字符转为空格字符。

	```shell
	$ col [-xb]
	-x ： 将 tab 键转换成对等的空格键
	```

	**expand**  将 tab 转换一定数量的空格，默认是 8 个。

	```shell
	$ expand [-t] file
	-t ：tab 转为空格的数量
	```

	**join**  将有相同数据的那一行合并在一起。

	```shell
	$ join [-ti12] file1 file2
	-t ：分隔符，默认为空格
	-i ：忽略大小写的差异
	-1 ：第一个文件所用的比较字段
	-2 ：第二个文件所用的比较字段
	```

	**paste**  直接将两行粘贴在一起。

	```shell
	$ paste [-d] file1 file2
	-d ：分隔符，默认为 tab
	```

# 数据流重定向

重定向指的是使用文件代替标准输入、标准输出和标准错误输出。

|         类别          | 代码 |   运算符   |
| :-------------------: | :--: | :--------: |
|   标准输入 (stdin)    |  0   |  < 或 <<   |
|   标准输出 (stdout)   |  1   | &gt; 或 >> |
| 标准错误输出 (stderr) |  2   | 2> 或 2>>  |

一个箭头的表示以覆盖的方式重定向，而有两个箭头的表示以追加的方式重定向。

可以将不需要的标准输出以及标准错误输出重定向到 /dev/null，相当于扔进垃圾箱。

如果需要将标准输出以及标准错误输出同时重定向到一个文件，需要将某个输出转换为另一个输出，例如 2>&1 表示将标准错误输出转换为标准输出。

```bash
$ find /home -name .bashrc > list 2>&1
```

# 压缩与打包

## 后缀

Linux 下压缩文件：

| 扩展名 | 压缩程序 |
| -- | -- |
| \*.Z | compress |
|\*.zip |  zip |
|\*.gz  | gzip|
|\*.bz2 |  bzip2 |
|\*.xz  | xz |
|\*.tar |  tar 程序打包的数据，没有经过压缩 |
|\*.tar.gz | tar 程序打包的文件，经过 gzip 的压缩 |
|\*.tar.bz2 | tar 程序打包的文件，经过 bzip2 的压缩 |
|\*.tar.xz | tar 程序打包的文件，经过 xz 的压缩 |

## 压缩

- **gzip**
	gzip 是 Linux 使用最广的压缩指令，可以解开 compress、zip 与 gzip 所压缩的文件。

	gzip 压缩后源文件就不存在了。

	有 9 个不同的压缩等级可以使用。

	可以使用 zcat、zmore、zless 来读取压缩文件的内容。

	```shell
	$ gzip [-cdtv#] filename
	-c ：将压缩的数据输出到屏幕上
	-d ：解压缩
	-t ：检验压缩文件是否出错
	-v ：显示压缩比等信息
	-# ： # 为数字的意思，代表压缩等级，数字越大压缩比越高，默认为 6
	```

- **bzip2**
提供比 gzip 更高的压缩比。压缩比越高，压缩的时间也越长。

	查看命令：bzcat、bzmore、bzless、bzgrep。

	```shell
	$ bzip2 [-cdkzv#] filename
	-k ：保留源文件
	```

- **xz**
提供比 bzip2 更佳的压缩比。

	查看命令：xzcat、xzmore、xzless、xzgrep。

	```shell
$ xz [-dtlkc#] filename
	```

## 打包
压缩指令只能对一个文件进行压缩，而打包能够将多个文件打包成一个大文件。tar 不仅可以打包，还可在打包后使用 gip、bzip2、xz 将打包文件压缩。

```html
-z ：使用 gzip；
-j ：使用 bzip2；
-J ：使用 xz；
-c ：新建打包文件；
-t ：查看打包文件里面有哪些文件；
-x ：解打包或解压缩的功能；
-v ：在压缩/解压缩的过程中，显示正在处理的文件名；
-f : filename：要处理的文件；
-C 目录 ： 在特定目录解压缩。
```

| 使用方式 | 命令 |
| :---: | --- |
| 打包压缩 | tar -zcvf file1 file2 要被压缩的文件或目录名称 |
| 查 看 | tar -ztvf filename.tar.gz |
| 解压缩 | tar -xvzf filename.tar.gz -C 要解压缩的目录 |



# 链接

```shell
$ ln [-sf] source_filename dist_filename
-s ：默认是 hard link，加 -s 为 symbolic link
-f ：如果目标文件存在时，先删除目标文件
```

<div align="center"> <img src="pics/b8081c84-62c4-4019-b3ee-4bd0e443d647.jpg" width="400px"> </div><br>
## 硬链接

对源文件创建一个新引用

有以下限制：不能跨越文件系统、不能对目录进行链接。

```shell
$ sudo ln /etc/crontab .
$ ll -i /etc/crontab crontab
34474855 -rw-r--r--. 2 root root 451 Jun 10 2014 crontab
34474855 -rw-r--r--. 2 root root 451 Jun 10 2014 /etc/crontab
```

## 符号链接

创建一个新文件保存着源文件的“路径”

```shell
$ ln -s source target 
$ ll -i /etc/crontab /root/crontab2
34474855 -rw-r--r--. 2 root root 451 Jun 10 2014 /etc/crontab
53745909 lrwxrwxrwx. 1 root root 12 Jun 23 22:31 /root/crontab2 -> /etc/crontab
```

# 日志

- **查看重要的日志**

  ```shell
  # 查看用户日志
  $ journalctl -p 3 -xb
  -p 优先级，大于等于3的日志才会被查看
  -b 查看这次启动以来的日志
  -x 查看到的内容带有辅助信息
  # 查看内核日志、“特权日志"、用户日志
  $ sudo journalctl -p 3 -xb
  ```
  
- **查看启动信息（内核日志）**

  ```shell
  $ dmesg
  ```

# 进程管理

## 查看进程

- **ps**
查看某个时间点的进程信息

	示例一：查看自己的进程

	```sh
	$ ps -l
	```

	示例二：查看系统所有进程
	```sh
	$ ps -ef
	```
- **top**
实时显示进程信息

	示例：两秒钟刷新一次

	```sh
	$ top -d 2
	```

- **netstat**
	查看占用某个端口的进程

	示例：查看特定端口的进程

	```sh
	$ netstat -nlp/n4p | grep port
	```
## 强制结束进程

```bash
$ sudo kill -9 `ps -aux|grep java|grep -v grep|awk '{print $2}'`
```



# 开机启动脚本

1. 写 ss-go2.service

   ```shell
   [Unit]
   Description=go-shadowsocks2
   After=network.target
   After=systemd-user-sessions.service
   After=network-online.target
   
   [Service]
   User=root
   ExecStart=/home/fwinac/Custom/Apps/ss-go2/start.sh
   ExecStop=/home/fwinac/Custom/Apps/ss-go2/stop.sh
   Restart=on-failure
   RestartSec=10
   
   [Install]
   WantedBy=multi-user.target
   ```

2. 放入 /lib/systemd/system 目录

3. 使用 systemctl 命令

# Shell

## 基础

- 特殊注释

  #!

- =、!= 等等，两边不能有空格

- [] 在 shell 中对应 test command，[[]] 则是 bash 特有的语法，有几点提升：

  - 更好的处理变量为空

    ```shell
    # 在 shell 中
    if [ -f "$file" ]
    # 在 bash 中
    if [[ -f $file ]]
    ```

  - 表达式更丰富

    [[]] 中可以用 &&、||、> 等等

- if

  ```shell
  if [ -f xx ];then
  # 或者
  if [ -f xx ]
  then
   xx
  fi
  # 判断文件不存在
  if [[ ! -f xx ]]
  ```

- $() 用来替代 ``，但是有些不支持。${} 用来区分变量名的范围

- $? 上一个执行程序的返回值

- eval 和 exec

  都是 shell built-in command

  shell 默认执行程序，会创建子进程。exec 则会替换掉 shell 进程，而不是创建子进程

  eval 也创建子进程，但是它会将执行的 command 先替换为实际值，再执行

  ```shell
  command=ls
  # 下面的命令没有办法执行
  $command
  # 下面的可以执行
  eval $command
  ```

## 示例

- 服务启动

  ```shell
  # do_start.sh
  #!/bin/bash
  # 该脚本用于示范
  
  # 判断该脚本是否已经执行过
  if [[ -f /.wx7_excute ]];then
  	echo 'The script already excuted.'
  	exit 0;
  fi
  
  # 等等
  
  RET=1
  while [[ RET!=0 ]];do
  	echo '=>Waitting for service start'
  	sleep 5
  	start service
  	RET=$?
  done
  
  echo '=> Config service'
  echo '=> All done!'
  touch /.wx7_excute
  
  echo '========================'
  echo 'You can now use sercie:'
  echo '      service use      '
  echo 'Please do something:****'
  echo '========================'

  # start.sh
  #!/bin/bash
  
  if [[ ! -f /.wx7i_excute ]];then
  # 绝对路径
  	./do_start.sh
  fi
  ```
  
- 设置 alias

  ```shell
  # Proxy
  function proxy_status(){
  # = 判断字符串
          if [ "$all_proxy" = "" ];then
                  echo 'proxy is off.'
          else
                  echo 'proxy is on.'
          fi
  }
  
  function proxy_on(){
          export all_proxy="socks://127.0.0.1:1080"
          export http_proxy="http://127.0.0.1:8001"
          export https_proxy="http://127.0.0.1:8001"
          export no_proxy="localhost,127.0.0.1/8,::1"
          proxy_status
  }
  
  function proxy_off(){
          unset all_proxy
          unset http_proxy
          unset https_proxy
          unset no_proxy
          proxy_status
  }
  alias pon='proxy_on'
  alias poff='proxy_off'
  alias pst='proxy_status'
  ```


# 其他

- 对 shell 脚本加密

  思路：把 shell 变成二进制可执行文件

  ```shell
  $ shc -r -f update.s
  #生成 **.sh.x(可执行动态链接)和**.sh.x.c（可执行的 c 源文件)
  $ CFLAGs=-static shc -r -f  run.sh
  $ file run.sh.x
  # 生成 statically linked 可执行文件，-r relax
  ```

# 综合操作

- 判断是不是某个确定的系统

  ```shell
  cat /etc/issue | grep -i fedora &> /dev/null
  
  if [ $? -ne 0 ]; then
      echo "This script is meant for Fedora"
      exit 1
  fi
  ```
- 无间断运行程序
  终端退出时会发出 HUP 信号，此登录用户所有的进程都会退出，所以需要 nohup ；& 后台运行此程序

   ```bash
  $ nohup java -jar dev-manager.jar > dev-manager.log 2>&1 &
   ```
  
- 命令行进制转换

  ```shell
  $ echo 'obase=2;65535'|bc|wc
  ```

# 参考资料

[1] B站 TheCW 的"上古神器Vim：从恶言相向到爱不释手"