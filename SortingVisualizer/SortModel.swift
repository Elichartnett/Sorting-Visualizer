//
//  SortModel.swift
//  SortingVisualizer
//
//  Created by Eli Hartnett on 9/18/22.
//

import Foundation

class SortModel: ObservableObject {
    
    @Published var chartData: [Series] = []
    
    func runSelectionSort(array: inout [Int], size: Int) {
        let start = DispatchTime.now()
        
        selectionSort(array: &array)
        
        let finish = DispatchTime.now()
        let timeInterval = Int(finish.uptimeNanoseconds - start.uptimeNanoseconds)
        
        chartData.append(Series(sortMethod: "Selection Sort", data: (inputSize: size, time: timeInterval)))
    }
    
    func runInsertionSort(array: inout [Int], size: Int) {
        let start = DispatchTime.now()
        
        insertionSort(array: &array, low: 0, high: array.count - 1)
        
        let finish = DispatchTime.now()
        let timeInterval = Int(finish.uptimeNanoseconds - start.uptimeNanoseconds)
        
        chartData.append(Series(sortMethod: "Insertion Sort", data: (inputSize: size, time: timeInterval)))
    }
    
    func runQuickSort(array: inout [Int], size: Int) {
        let start = DispatchTime.now()
        
        let _ = quickSort(array: &array, low: 0, high: array.count-1)
        
        let finish = DispatchTime.now()
        let timeInterval = Int(finish.uptimeNanoseconds - start.uptimeNanoseconds)
        
        chartData.append(Series(sortMethod: "Quick Sort", data: (inputSize: size, time: timeInterval)))
    }
    
    func runHybridSort(array: inout [Int], size: Int) {
        let start = DispatchTime.now()
        
        let _ = hybridSort(array: &array, low: 0, high: array.count - 1)
        
        let finish = DispatchTime.now()
        let timeInterval = Int(finish.uptimeNanoseconds - start.uptimeNanoseconds)
        
        chartData.append(Series(sortMethod: "Hybrid Sort", data: (inputSize: size, time: timeInterval)))
    }
    
    func createRandomArrayOfInts(size: Int) -> [Int] {
        var array = [Int]()
        for _ in 0..<size {
            array.append(Int.random(in: 0..<size))
        }
        
        return array
    }
    
    func selectionSort(array: inout [Int]) {
        let size = array.count
        
        for index in 0..<size {
            var minIndex = index
            
            for j in (index + 1)..<size {
                if array[j] < array[minIndex] {
                    minIndex = j
                }
            }
            
            (array[index], array[minIndex]) = (array[minIndex], array[index])
        }
    }
    
    func insertionSort(array: inout [Int], low: Int, high: Int) {
        let size = array.count
        
        for index in low..<high {
            let key = array[index]
            var j = index - 1
            while j >= 0 && key < array[j] {
                array[j+1] = array[j]
                j -= 1
            }
            array[j+1] = key
        }
    }
    
    func partition(array: inout [Int], low: Int, high: Int) -> Int {
        let pivot = array[high]
        var pointer = low
        
        for i in low..<high {
            if array[i] <= pivot {
                (array[i], array[pointer]) = (array[pointer], array[i])
                pointer += 1
            }
        }
        
        (array[pointer], array[high]) = (array[high], array[pointer])
        
        return pointer
    }
    
    func quickSort(array: inout [Int], low: Int, high: Int) -> [Int] {
        if array.count == 1 { return array }
        
        if low < high {
            let pivot = partition(array: &array, low: low, high: high)
            let _ = quickSort(array: &array, low: low, high: pivot - 1)
            let _ = quickSort(array: &array, low: pivot + 1, high: high)
        }
        
        return array
    }
    
    func hybridSort(array: inout [Int], low: Int, high: Int) -> [Int] {
        if high - low <= 1 { return array }
        
        if high - low < 25 {
            insertionSort(array: &array, low: low, high: high)
            return array
        }
        else if low < high {
            let pivot = partition(array: &array, low: low, high: high)
            let _ = hybridSort(array: &array, low: low, high: pivot - 1)
            let _ = hybridSort(array: &array, low: pivot + 1, high: high)
        }
        return array
    }
}
