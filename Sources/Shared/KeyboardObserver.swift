//
//  KeyboardObserver.swift
//  Zazo
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import UIKit

struct FrameChange {
    
    enum ChangeType {
        case appear
        case disappear
        case change
    }
    
    let from: CGRect
    let to: CGRect
    let type: ChangeType
}

struct NotifiсationData {
    let change: FrameChange
    let curve: UIViewAnimationCurve
    let duration: TimeInterval
}

protocol KeyboardObserver: class {
    
    func didChangeKeyboardFrame(change: FrameChange)
    func willChangeKeyboardFrame(change: FrameChange)
    func animateChangeKeyboardFrame(change: FrameChange)
    
    func startKeyboardObserving()
    func finishKeyboardObserving()
}

extension KeyboardObserver {
    
    func didChangeKeyboardFrame(change: FrameChange) {
        
    }
    
    func willChangeKeyboardFrame(change: FrameChange) {
        
    }
    
    func animateChangeKeyboardFrame(change: FrameChange) {
        
    }
    
    func startKeyboardObserving() {
        
        let center = NotificationCenter.default
        
        weak var observer: KeyboardObserver? = self
        
        center.addObserver(name: NSNotification.Name.UIKeyboardWillHide) {
            observer?.keyboardWillHide(notification: $0)
        }
        center.addObserver(name: NSNotification.Name.UIKeyboardWillShow) {
            observer?.keyboardWillShow(notification: $0)
        }
        center.addObserver(name: NSNotification.Name.UIKeyboardDidHide) {
            observer?.keyboardDidHide(notification: $0)
        }
        center.addObserver(name: NSNotification.Name.UIKeyboardDidShow) {
            observer?.keyboardDidShow(notification: $0)
        }
        center.addObserver(name: NSNotification.Name.UIKeyboardDidShow) {
            observer?.keyboardDidShow(notification: $0)
        }
        center.addObserver(name: NSNotification.Name.UIKeyboardDidChangeFrame) {
            observer?.keyboardDidChange(notification: $0)
        }
        center.addObserver(name: NSNotification.Name.UIKeyboardWillChangeFrame) {
            observer?.keyboardWillChange(notification: $0)
        }
        
    }
    
    func finishKeyboardObserving() {
        
        let center = NotificationCenter.default
        
        let names = [
            NSNotification.Name.UIKeyboardWillChangeFrame,
            NSNotification.Name.UIKeyboardDidChangeFrame,
            NSNotification.Name.UIKeyboardWillHide,
            NSNotification.Name.UIKeyboardWillShow,
            NSNotification.Name.UIKeyboardDidHide,
            NSNotification.Name.UIKeyboardDidShow]
        
        for name in names {
            center.removeObserver(self, name: name, object: nil)
        }
        
    }
    
    fileprivate func keyboardDidChange(notification: Notification) {
        guard let data = NotifiсationData(with: notification, of: .change) else {
            return
        }
        didChangeKeyboardFrame(change: data.change)
    }
    
    fileprivate func keyboardWillChange(notification: Notification) {
        guard let data = NotifiсationData(with: notification, of: .change) else {
            return
        }
        willChangeKeyboardFrame(change: data.change)
        animatedChange(with: data)
    }
    
    fileprivate func keyboardWillShow(notification: Notification) {
        guard let data = NotifiсationData(with: notification, of: .appear) else {
            return
        }
        willChangeKeyboardFrame(change: data.change)
        animatedChange(with: data)
    }
    
    
    fileprivate func keyboardWillHide(notification: Notification) {
        guard let data = NotifiсationData(with: notification, of: .disappear) else {
            return
        }
        willChangeKeyboardFrame(change: data.change)
        animatedChange(with: data)
    }
    
    fileprivate func keyboardDidShow(notification: Notification) {
        guard let data = NotifiсationData(with: notification, of: .appear) else {
            return
        }
        didChangeKeyboardFrame(change: data.change)
    }
    
    fileprivate func keyboardDidHide(notification: Notification) {
        guard let data = NotifiсationData(with: notification, of: .disappear) else {
            return
        }
        didChangeKeyboardFrame(change: data.change)
    }
    
    fileprivate func animatedChange(with data: NotifiсationData) {
//        let options = data.curve.toOptions()
//        print(options, [UIViewAnimationOptions.curveEaseOut])
        //MARK: TODO: curve -> options
        UIView.animate(withDuration: data.duration, animations: {
            self.animateChangeKeyboardFrame(change: data.change)
        })
    }
}

extension NotifiсationData {
    init?(with notification: Notification, of type: FrameChange.ChangeType) {
        
        guard
            let userInfo = notification.userInfo,
            let endFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect,
            let beginFrame = userInfo[UIKeyboardFrameBeginUserInfoKey] as? CGRect,
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval,
            let int = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? Int,
            let curve = UIViewAnimationCurve(rawValue: int)
        else {
            return nil
        }

        let frameChange = FrameChange(from: beginFrame, to: endFrame, type: type)
        self = NotifiсationData(change: frameChange, curve: curve, duration: duration)
    }
}
