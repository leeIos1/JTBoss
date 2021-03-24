//
//  BossCell.swift
//  JT
//
//  Created by apple on 2021/3/22.
//

import UIKit

class BossCell: UITableViewCell {

    var tagButtonArr:[UIButton] = []
    var titleArr:[UILabel] = []
 
    var model:BossSectionModel?{
        didSet{
            if let m = model{
                configModel(m)
            }
        }
    }
  
    // MARK: - Life Cycle Methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .white
        initUI()
        layoutContentViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Private Methods
    private func initUI(){
        contentView.addSubview(titleLabel)
        contentView.addSubview(arrowView)
        contentView.addSubview(bgView)
        contentView.addSubview(lineView)
    }
    
    private func layoutContentViews(){
        arrowView.frame = CGRect.init(x: lee_screenW - 35, y: 15, width: 30, height: 30)
        bgView.frame = CGRect.init(x: 0, y: 60, width: lee_screenW, height: (model?.rowHeight ?? 60) - 60)
        lineView.frame = CGRect.init(x: 20, y: (model?.rowHeight ?? 60) - 1, width: lee_screenW - 20, height: 1)
    }
    
    private func configModel(_ model:BossSectionModel){
        if(model.isOpen){
            updateOpenViews()
            bgView.isHidden = false
            lineView.isHidden = true
            arrowView.image = UIImage.init(named: "arrowBottom")
        }else{
            updateCloseViews()
            bgView.isHidden = true
            lineView.isHidden = false
            arrowView.image = UIImage.init(named: "arrowRight")
        }
        updateTitleColor()
        layoutContentViews()
    }
    
    
    private func updateTitleColor(){
        if(model!.selectValue.count > 0){
            titleLabel.textColor = boss_mainBlueTextColor
        }else{
            titleLabel.textColor = boss_mainBlackColor
        }
        
    }
    
    private func updateCloseViews(){
        for lb in titleArr {
            lb.removeFromSuperview()
        }
        titleArr.removeAll()
        for btn in tagButtonArr {
            btn.removeFromSuperview()
        }
        tagButtonArr.removeAll()
        
        titleLabel.frame = model!.closeViewFrameArr.first?.cgRectValue ?? .zero
        titleLabel.text = model!.sectionTitle
        
        if let datas = model?.selectValue{
            for(index, item) in datas.enumerated(){
                let label = UILabel.init()
                label.text = item.name
                label.textColor = boss_mainBlueTextColor
                label.backgroundColor = boss_mainBlueAlphaColor
                label.font = UIFont.systemFont(ofSize: 12)
                label.layer.cornerRadius = CGFloat(5)
                label.layer.masksToBounds = true
                label.textAlignment = .center
                label.frame = model!.closeViewFrameArr[index+1].cgRectValue
                contentView.addSubview(label)
                titleArr.append(label)
            }
        }
    }
    
    private func updateOpenViews(){
        for btn in tagButtonArr {
            btn.removeFromSuperview()
        }
        tagButtonArr.removeAll()
        for lb in titleArr {
            lb.removeFromSuperview()
        }
        titleArr.removeAll()
        
        titleLabel.frame = model!.openViewFrameArr.first?.cgRectValue ?? .zero
        titleLabel.text = model!.sectionTitle
        if let datas = model?.values{
            for(index, item) in datas.enumerated(){
                let btn = UIButton.init()
                btn.setTitle(item.name, for: .normal)
                btn.setTitleColor(boss_mainBlackColor, for: .normal)
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
                btn.backgroundColor = .white
                btn.adjustsImageWhenHighlighted = false;
                btn.tag = index + 1000
                btn.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
                btn.layer.cornerRadius = CGFloat(5)
                btn.layer.masksToBounds = true
                btn.layer.borderWidth = 1
                btn.layer.borderColor =  boss_mainLineColor.cgColor
                setButtonStatus(selected: item.isSelected, btn: btn)
                btn.frame =  model!.openViewFrameArr[index+1].cgRectValue
                contentView.addSubview(btn)
                tagButtonArr.append(btn)
            }
        }
    }
    
    private func setButtonStatus(selected:Bool,btn:UIButton){
        if(selected){
            btn.setTitleColor(.white, for: .normal)
            btn.backgroundColor = boss_mainBlueTextColor
            btn.layer.borderColor =  boss_mainBlueTextColor.cgColor
        }else{
            btn.setTitleColor(boss_mainBlackColor, for: .normal)
            btn.backgroundColor = .white
            btn.layer.borderColor =  boss_mainLineColor.cgColor
        }
        btn.isSelected = selected
    }
    
    // MARK: - Event Methods
    @objc private func tapAction(btn:UIButton){
        let tag = btn.tag - 1000
        let item = model!.values[tag]
        item.isSelected = !item.isSelected
        setButtonStatus(selected: item.isSelected, btn: btn)
        updateTitleColor()
    }
    
    lazy private var bgView:UIView = {
        let view = UIView.init()
        view.backgroundColor = boss_mainLineColor
        view.isHidden = true
        return view
    }()
   
    lazy private var titleLabel:UILabel = {
        let label = UILabel.init()
        label.textColor = boss_mainBlackColor
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    lazy private var lineView:UIView = {
        let view = UIView.init()
        view.backgroundColor = boss_mainLineColor
        return view
    }()
    
    private lazy var arrowView: UIImageView = {
        let view = UIImageView.init(image: UIImage.init(named: "arrowRight"))
//        clickCourse
        return view
    }()

}
