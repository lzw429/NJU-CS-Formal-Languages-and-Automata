# 形式语言与自动机 课程项目

2020 年 秋季

舒意恒 MF20330067 计算机科学与技术系

yhshu@smail.nju.edu.cn

## 构建，编译与运行

集成开发环境 CLion，使用 CMake 进行构建，配置文件见 `CMakeList.txt`.

## 解析器设计

解析器通过 `TuringMachine` 类的构造函数实现。解析器支持 `verbose` 模式，语法检查支持以下类型的错误：


- 判断图灵机程序所声明的初始状态、终止状态集合是否都定义在同一程序的状态集中；
- 判断图灵机程序所声明的空白符号是否属于其纸带符号集；
- 判断图灵机程序所声明的纸带数是否是一个非零自然数；
- 判断图灵机程序所声明的转移函数是否满足确定性图灵机的要求

## 模拟器设计

模拟器通过 `TuringMachine` 类的 `Run` 函数实现。模拟器支持 `verbose` 模式，语法检查将判断输入串中的所有字符是否均属于输入符号集。


## 代码

- `turing-project` 目录包含 C++ 源码
- `programs` 目录包含图灵机程序代码


