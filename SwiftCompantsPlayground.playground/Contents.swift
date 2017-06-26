//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let ary1 = [1,2,3,4,5,6]

//转换数组
let ary2 = ary1.map{temp in temp*temp}

//添加一个元素
var ary3 = ary2
//ary3.append(3)

//求和、求积到一个值
let sum = ary1.reduce(1, *)

//筛选
let ary4 = ary2.filter{ $0 > 10 }

print(ary4)


//遍历
ary1.forEach{ let item = $0;   print(item) }

//元素是否相等
print(ary3.elementsEqual(ary2))

//变形操作
let ary5 = (1..<10).map{ $0*$0 }

print(ary5)

let ary6 = (1..<20).map{ $0 }

print(ary6)
//删除操作
var ary7 = ary6.dropLast(5)

ary7 = ary7.dropFirst(3)

print(ary7)

for (num,ele) in ary7.enumerated()
{
    print(num,ele)
}

//添加操作
var fibs = [0,1,1,2,3,5]
fibs.append(contentsOf: [7,11,13])
fibs.append(17)
print(fibs)

//插入操作
fibs.insert(9, at: 1)
print(fibs)

fibs.remove(at: 1)
print(fibs)


//错误抛出与捕获

enum FileError:Error{
    case fileNotExist
    case noPermission
}

enum TESTENUM{
    case a
    case b
}

print(TESTENUM.a)
print(FileError.fileNotExist)


func contents(ofFile filename:String?) throws ->String{
    
    if filename != nil {
        return "openfile"
    }
    else{
        throw  FileError.noPermission
    }
}

func checkFile(ofFile filename:String?) throws ->Bool{
    
    if filename != nil {
        return true
    }
    else{
        throw  FileError.fileNotExist
    }
}

do{
//    let result = try   contents(ofFile:nil)
    try checkFile(ofFile: nil)
//    print("结果：\(result)")
}
catch {
  print("错误抛出 \(error)")
}






