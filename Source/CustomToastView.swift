//
//  CustomToastView.swift
//  Outfitted
//
//  Created by Leticia Rodriguez on 3/10/21.
//

import UIKit

/// Simple has no action at the right
/// Action has an action at the right

public enum CustomToastType {
    case simple
    case action
    
//    func title() -> String {
//        switch self {
//        case .favorite: return Localized("custom_toast_favorite")
//        case .unfavorite: return Localized("custom_toast_unfavorite")
//        case .log: return Localized("custom_toast_log")
//        case .unlog: return Localized("custom_toast_unlog")
//        case .itemDelete: return Localized("custom_toast_item_deleted")
//            case .outfitDelete: return Localized("custom_toast_outfit_deleted")
//        case .unableDeleteOutfit: return Localized("custom_toast_unable_to_delete_outfit")
//        case .unableDeleteItem: return Localized("custom_toast_unable_to_delete")
//        case .unableToFavorite: return Localized("custom_toast_unable_to_favorite_item")
//        case .none: return ""
//        }
//    }
//
//    func actionsText() -> String {
//        switch self {
//        case .favorite, .unfavorite, .log, .unlog, .itemDelete, .outfitDelete: return Localized("custom_toast_undo")
//        case .unableDeleteOutfit, .unableDeleteItem, .unableToFavorite: return Localized("custom_toast_retry")
//        case .none: return ""
//        }
//    }
    
//    func backgroundColor() -> UIColor {
//        switch self {
//        case .favorite, .unfavorite, .log, .unlog, .itemDelete, .outfitDelete: return UIColor.CustomToast.educational
//        case .unableDeleteItem, .unableDeleteOutfit, .unableToFavorite: return UIColor.CustomToast.error
//        case .none: return .clear
//        }
//    }
//
//    func textColor() -> UIColor {
//        switch self {
//        case .favorite, .unfavorite, .log, .unlog, .itemDelete, .outfitDelete: return UIColor.CustomToast.educationalText
//        case .unableDeleteItem, .unableDeleteOutfit, .unableToFavorite: return UIColor.CustomToast.errorText
//        case .none: return .clear
//        }
//    }
}

class CustomToastView: UIView {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var toastMessageLabel: UILabel!
    @IBOutlet private weak var actionLabel: UILabel!
    
    private var type: CustomToastType = .simple
    
    var toastTappedNotification: () -> () = {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }
    
    private func setUI() {
//        toastMessageLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
//        actionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
//
        let gesture = UITapGestureRecognizer(target: self, action: #selector(toastTapped))
        containerView.addGestureRecognizer(gesture)
    }
    
    func config(type: CustomToastType) {
        self.type = type
        
        containerView.backgroundColor = .magenta
    }
    
    func configToast(data: ToastData) {
        if let cornerRadius = data.cornerRadius {
            containerView.layer.cornerRadius = cornerRadius
        } else {
            containerView.layer.cornerRadius = data.toastHeight/2
        }
        type = data.type
    
        containerView.backgroundColor = data.backgroundColor
        
        toastMessageLabel.textColor = data.textColor
        toastMessageLabel.text = data.title
        toastMessageLabel.font = data.font
        
        actionLabel.textColor = data.actionTextColor
        actionLabel.text = data.actionText
        
        hideAction(for: type)
    }
    
    private func hideAction(for type: CustomToastType) {
        switch type {
        case .simple:
            actionLabel.isHidden = true
            toastMessageLabel.textAlignment = .center
        case .action:
            actionLabel.isHidden = false
            toastMessageLabel.textAlignment = .left
        }
    }
    
    @objc private func toastTapped() {
        toastTappedNotification()
    }
}
