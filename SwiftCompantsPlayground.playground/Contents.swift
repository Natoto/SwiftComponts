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
let ary4 = ary2.filter({ $0 > 10 })

//遍历
ary1.forEach{ let item = $0;   print(item) }

//元素是否相等
print(ary3.elementsEqual(ary2))


print(ary4)







