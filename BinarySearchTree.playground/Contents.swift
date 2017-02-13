//: Playground - noun: a place where people can play
// 教程地址: https://gold.xitu.io/entry/57cd6b028ac24700645a789c?utm_source=gold-miner&utm_medium=readme&utm_campaign=github

import UIKit

var str = "Hello, i am binary search tree"

enum BinaryTree<T: Comparable>{
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
    
    
    /// insert new node
    ///
    /// - Parameter newValue: new value
    // mutating : 可变的意思 -- 创建了尝试在类型值(这里就是 BinaryTree 这个枚举)中改变什么东西的方法
    // 问题: 每次你尝试着去修改这棵树的时候，一个新的子树的拷贝就会被创建。这个新的拷贝是不会链接到你的旧的拷贝的，所以你的最开始的二叉树是永远不会被新的值所修改的。
    mutating func naiveInsert(newValue: T){
        
        // 没有结点
        // slef is BinaryTree
        guard case .node(var left, let value, var right) = self else {
            self = .node(.empty, newValue, .empty)
            return
        }
        
        //
        if newValue < value {
           left.naiveInsert(newValue: newValue)
        }else{
            right.naiveInsert(newValue: newValue)
        }
    }
    
    
    private func newTreeWithInsertedValue(newValue: T) -> BinaryTree{
        switch self {
        case .empty:
            return .node(.empty, newValue, .empty)
            
        case let .node(left, value, right):
            if newValue < value {
                return .node(left.newTreeWithInsertedValue(newValue: newValue), value, right)
            }else{
                return .node(left, value, right.newTreeWithInsertedValue(newValue: newValue))
            }
        }
    }
    
    mutating func insert(newValue: T){
        self = newTreeWithInsertedValue(newValue: newValue)
    }
    
    // 中序遍历
    // 中序遍历是按照升序来遍历一颗二叉搜索树的。
    func traverseInOrder(process: (T) -> ()){
        switch self {
        case .empty:
            return
        case let .node(left, value, right):
            left.traverseInOrder(process: process)
            process(value)
            right.traverseInOrder(process: process)

        }
    }
    
    // 先序遍历
    // 一种在遍历过程中首先遍历节点的遍历方法
    // 这里的关键是在遍历子树之前首先调用 process 方法
    func traversePreOrder(process: (T) -> ()){
        switch self {
        case .empty:
            return
        case let .node(left, value, right):
           
            process(value)
            left.traverseInOrder(process: process)
            right.traverseInOrder(process: process)
            
        }

    }
    
    // 后序遍历
    // 首先遍历左子树和右子树的遍历方法
    func traversePostOrder(process: (T) -> ()){
        switch self {
        case .empty:
            return
        case let .node(left, value, right):
            
            left.traverseInOrder(process: process)
            right.traverseInOrder(process: process)
            process(value)
        }
    }
    
    // 搜索
    func search(searchValue: T) -> BinaryTree?{
        switch self {
        case .empty:
            return nil
        case let .node(left, value, right):
            if searchValue == value {
                return self
            }
            if searchValue < value {
                return left.search(searchValue: searchValue)
            }else{
                return right.search(searchValue: searchValue)
            }
      
        }
    }
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

var binaryTree: BinaryTree<Int> = .empty

//binaryTree.naiveInsert(newValue: 5) // binaryTree now has a node value with 5
//binaryTree.naiveInsert(newValue: 7) // binaryTree is unchanged -- 原树没有被改变
//binaryTree.naiveInsert(newValue: 9)

binaryTree.insert(newValue: 5)
binaryTree.insert(newValue: 7)
binaryTree.insert(newValue: 9)

binaryTree.traverseInOrder { print($0) }

print("***************")
binaryTree.traversePreOrder { print($0) }

print("***************")
binaryTree.traversePostOrder { print($0) }

print("***************")

binaryTree.search(searchValue: 7)

