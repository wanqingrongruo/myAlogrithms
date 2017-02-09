//: Playground - noun: a place where people can play
// 教程地址: https://gold.xitu.io/entry/57cd6b028ac24700645a789c?utm_source=gold-miner&utm_medium=readme&utm_campaign=github

import UIKit

var str = "Hello, i am binary search tree"

enum BinaryTree<T>{
    case empty
    indirect case node(BinaryTree, T, BinaryTree) // inderect 间接
//    间接
//    
//    Swift 中的枚举是一种类型值。当 Swift 试图去为类型值分配内存的时候，它需要去确切的知道所需要被分配的内存大小。
//    
//    你所定义的枚举是一种 recursive （递归）枚举。那是一种有着一个指向自身的相关值（associated value）的一种枚举。递归类型的类型值内存大小无法被确定。
//    所以在这里你有一个问题。Swift 希望能准确的知道枚举的大小，然而你所创建的递归类型的枚举却没有暴露这个消息。
//    
//    这就是 indirect（间接）这个关键字的由来。indirect（间接）实现了一个两个类型值之间的 indirection（间接层）。这引出了语义与类型值之间的一层中间层。
//    
//    这个枚举现在引用的是它的关联值而不是自身的值。引用值有着一个确切的大小，所以就不再存在之前的问题。
}

// left node
let node5 = BinaryTree.node(.empty, "5", .empty)
let nodeA = BinaryTree.node(.empty, "a", .empty)
let node10 = BinaryTree.node(.empty, "10", .empty)
let node4 = BinaryTree.node(.empty, "4", .empty)
let node3 = BinaryTree.node(.empty, "3", .empty)
let nodeB = BinaryTree.node(.empty, "b", .empty)

// intermediate nodes on the left
let Aminus10 = BinaryTree.node(nodeA, "-", node10)
let timesLeft = BinaryTree.node(node5, "*", Aminus10)

// intermediate node on the right
let minus4 = BinaryTree.node(.empty, "-", node4)
let divide3andB = BinaryTree.node(node3, "/", nodeB)
let timesRight = BinaryTree.node(minus4, "*", divide3andB)

// root node
let tree = BinaryTree.node(timesLeft, "+", timesRight)


extension BinaryTree: CustomStringConvertible{
    
    // implement the function of "print"
    var description: String{
        switch self {
        case let .node(left, value, right):
            return "value: \(value), left = [" + left.description + "], right = [" + right.description + "]"
        case .empty:
            return ""
            
        }
    }
    
    // calculate nodes
    var count: Int{
        switch self {
        case let .node(left, _, right):
            return left.count + 1 + right.count
        case .empty:
            return 0
        }
    }
}

tree.description
tree.count 

// Binary search tree
// 二叉搜索树的主要特性: 每个左子树的数值小于它的父结点的数值，每个右子树的数值大于父结点的数值

