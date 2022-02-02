//
//  FiniteSum.swift
//  Finite-Sum-Problem
//
//  Created by Katelyn Lydeen on 2/1/22.
//

import Foundation
import SwiftUI

class FiniteSum: NSObject, ObservableObject {
    // Initialize values and text for N, the number of terms in the sum and for the
    // three methods of finding the sum
    var N:Int = 1
    @Published var nString = ""
    @Published var s1:Float = 0.0
    @Published var s2:Float = 0.0
    @Published var s3:Float = 0.0
    @Published var s1Text = ""
    @Published var s2Text = ""
    @Published var s3Text = ""
    
    // Set the calculate button to enabled
    @Published var enableButton = true
    
    /// initWithN
    /// Initializes a finite sum with N terms using the three different expressions for finding the sum
    /// - Parameter N: the number of terms for the sum
    /// returns true to indicate the function has finished running
    func initWithN(passedN: Int) async -> Bool {
        N = passedN
        let _ = await withTaskGroup(of: Void.self) { taskGroup in
            taskGroup.addTask {let _ = await self.calculateS1(N: self.N)}
            taskGroup.addTask {let _ = await self.calculateS2(N: self.N)}
            taskGroup.addTask {let _ = await self.calculateS3(N: self.N)}
        }
        
        await setButtonEnable(state: true)
        
        return true
    }
    
    /// calculateS1
    /// Solves the finite sum using the formula listed in the method
    /// - Parameter N: (int), the number of terms to use in calculating the sum
    /// returns calculatedS1, the value of the sum
    func calculateS1(N: Int) async -> Float {
        //   2N
        //   __         n    n
        //  \     ( - 1)   -----
        //  /__            n + 1
        //  n=1
        
        var calculatedS1:Float = 0.0
        var currentTerm:Float = 0.0
        let lowerIndex = 1
        
        for n in stride(from:lowerIndex, to:(2*N+1), by: 1) {
            let n_f = Float(n)
            currentTerm = Float(pow(-1,n_f) * n_f / (n_f + 1))
            calculatedS1 += currentTerm
        }

        let newS1Text = String(calculatedS1)
        
        await updateS1(s1TextString: newS1Text)
        await newS1Value(s1Value: calculatedS1)
        
        return calculatedS1
    }
    
    /// calculateS1Sync
    /// Synced version of calculateS1. Used for avoiding errors in plotting these data
    func calculateS1Sync(N: Int) -> Float {
        //   2N
        //   __         n    n
        //  \     ( - 1)   -----
        //  /__            n + 1
        //  n=1
        
        var calculatedS1:Float = 0.0
        var currentTerm:Float = 0.0
        let lowerIndex = 1
        
        for n in stride(from:lowerIndex, to:(2*N+1), by: 1) {
            let n_f = Float(n)
            currentTerm = Float(pow(-1,n_f) * n_f / (n_f + 1))
            calculatedS1 += currentTerm
        }
        return calculatedS1
    }
    
    /// calculateS2
    /// Solves the finite sum using the formula listed in the method
    /// - Parameter N: (int), the number of terms to use in calculating the sum
    /// returns calculatedS2, the value of the sum
    func calculateS2(N: Int) async -> Float {
        //     N                 N
        //     __   2n - 1      __    2n
        //  - \     ------  +  \    ------
        //    /__     2n       /__  2n + 1
        //   n = 1            n = 1
        
        var calculatedS2:Float = 0.0
        var odd:Float = 0.0
        var even:Float = 0.0
        var currentTerm:Float = 0.0
        let lowerIndex = 1
        
        // Summation for the odd terms
        for n in stride(from:lowerIndex, to:(N+1), by: 1) {
            let n_f = Float(n)
            currentTerm = Float((2*n_f - 1) / (2*n_f))
            odd += currentTerm
        }
        
        currentTerm = 0.0
        
        // Summation for the even terms
        for n in stride(from:lowerIndex, to:(N+1), by:1) {
            let n_f = Float(n)
            currentTerm = Float((2*n_f) / (2*n_f + 1))
            even += currentTerm
        }
        
        calculatedS2 = even - odd
        
        let newS2Text = String(calculatedS2)
        
        await updateS2(s2TextString: newS2Text)
        await newS2Value(s2Value: calculatedS2)
        
        return calculatedS2
    }
    
    /// calculateS3
    /// Solves the finite sum using the formula listed in the method
    /// - Parameter N: (int), the number of terms to use in calculating the sum
    /// returns calculatedS3, the value of the sum
    func calculateS3(N: Int) async -> Float {
        //    N
        //    __        1
        //   \      ----------
        //   /__    2n(2n + 1)
        //  n = 1
        
        var calculatedS3:Float = 0.0
        var currentTerm:Float = 0.0
        let lowerIndex = 1
        
        for n in stride(from: lowerIndex, to: (N+1), by: 1) {
            let n_f = Float(n)
            currentTerm = Float(1 / (2*n_f * (2*n_f + 1)))
            calculatedS3 += currentTerm
        }
        
        let newS3Text = String(calculatedS3)
        
        await updateS3(s3TextString: newS3Text)
        await newS3Value(s3Value: calculatedS3)
        
        return calculatedS3
    }
    
    /// calculateS3Sync
    /// Synced version of calculateS3
    func calculateS3Sync(N: Int) -> Float {
        //    N
        //    __        1
        //   \      ----------
        //   /__    2n(2n + 1)
        //  n = 1
        
        var calculatedS3:Float = 0.0
        var currentTerm:Float = 0.0
        let lowerIndex = 1
        
        for n in stride(from: lowerIndex, to: (N+1), by: 1) {
            let n_f = Float(n)
            currentTerm = Float(1 / (2*n_f * (2*n_f + 1)))
            calculatedS3 += currentTerm
        }
        
        return calculatedS3
    }
    
    /// calculateRelErrorS1
    /// Solves for the relative error of the sum s1 assuming s3 is the precise value
    /// | s1 - s3  | / s3
    /// - Parameter N: the number of terms to use in calculating the sum
    /// returns relError, the calculated relative error
    func calculateRelErrorS1(passedN: Int) -> Float {
        let n = passedN
        var relError:Float = 0.0
        let s1 = self.calculateS1Sync(N: n)
        let s3 = self.calculateS3Sync(N: n)
        relError = Float(abs(s1 - s3) / s3)
        
        return relError
    }
    
    /// setButtonEnable
    /// Toggles the state of the calculate button
    /// - Parameter state: Boolean indicating whether the button should be enabled or not
    @MainActor func setButtonEnable(state: Bool) {
        if state {
            Task.init {
                await MainActor.run {
                    self.enableButton = true
                }
            }
        }
        else{
            Task.init {
                await MainActor.run {
                    self.enableButton = false
                }
            }
        }

    }
    
    /// updateS1
    /// Executes on the main thread to update the text that gives the value of s1
    /// - Parameter s1TextString: Text describing the value of s1
    @MainActor func updateS1(s1TextString: String){
        s1Text = s1TextString
    }
    
    /// newS1Value
    /// Updates the value of s1
    /// - Parameter s1Value: Double describing the value of s1
    @MainActor func newS1Value(s1Value: Float){
        self.s1 = s1Value
    }
    
    /// Same as above for the second sum s2
    @MainActor func updateS2(s2TextString: String){s2Text = s2TextString}
    @MainActor func newS2Value(s2Value: Float){self.s2 = s2Value}
    
    /// Same as above for the third sum s3
    @MainActor func updateS3(s3TextString: String){s3Text = s3TextString}
    @MainActor func newS3Value(s3Value: Float){self.s3 = s3Value}
}
