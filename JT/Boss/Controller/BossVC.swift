//
//  BossVC.swift
//  JT
//
//  Created by apple on 2021/3/22.
//

import UIKit

private let defultRowH:CGFloat = 50
private let maxStrLength = 200
private let bossIdentifier = "bossIdentifier"
let boss_mainBlueTextColor = UIColor.init(red: CGFloat(7)/CGFloat(255), green: CGFloat(132)/CGFloat(255), blue: CGFloat(255)/CGFloat(255), alpha: 1)
let boss_mainBlackColor = UIColor.init(red: CGFloat(45)/CGFloat(255), green: CGFloat(45)/CGFloat(255), blue: CGFloat(45)/CGFloat(255), alpha: 1)
let boss_mainGaryColor = UIColor.init(red: CGFloat(171)/CGFloat(255), green: CGFloat(171)/CGFloat(255), blue: CGFloat(171)/CGFloat(255), alpha: 1)
let boss_mainLineColor = UIColor.init(red: CGFloat(239)/CGFloat(255), green: CGFloat(239)/CGFloat(255), blue: CGFloat(239)/CGFloat(255), alpha: 1)
let boss_mainBlueAlphaColor = UIColor.init(red: CGFloat(7)/CGFloat(255), green: CGFloat(132)/CGFloat(255), blue: CGFloat(255)/CGFloat(255), alpha: 0.2)

class BossVC: UIViewController {

    var dataArr:[BossSectionModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "不匹配原因"
        initUI()
        layoutContentViews()
    }
     
    private func initUI(){
        view.addSubview(tableView)
        view.addSubview(bottomView)
        setFooterView()
        lee_inputView.updatePlaceholder()
        lee_inputView.textContainerInset = UIEdgeInsets.init(top: 5, left: 10, bottom: 5, right: 10)
        dataArr = getDataWithJson()
        tableView.reloadData()
        registerNotification()
    }
    
    private func registerNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardShow(noty:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardHidden(noty:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillChangeFrame(noty:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }
    
    @objc private func clickAction(recognizer:UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    private func layoutContentViews(){
        lee_inputView.frame = CGRect.init(x: 30, y: 20, width: lee_screenW - 60, height: 90)
        bottomView.frame = CGRect.init(x: 0, y: lee_screenH - (120 + lee_safeH), width: lee_screenW, height: 120 + lee_safeH)
        confirmBtn.frame = CGRect.init(x: 30, y: 30, width: lee_screenW - 60, height: 60)
        tipLb.frame = CGRect.init(x: 30, y: confirmBtn.frame.maxY + 10, width: lee_screenW - 60, height: 20)
        tableView.frame = CGRect.init(x: 0, y: lee_navTopH, width: lee_screenW, height: lee_screenH - lee_navTopH - bottomView.frame.height)
        
    }
    
    @objc private func commitAction(){

    }
    
    private func setFooterView(){
        footerView.frame = CGRect.init(x: 0, y: 0, width: lee_screenW, height:  130)
        footerView.addSubview(lee_inputView)
        tableView.tableFooterView = footerView
    }
    
    lazy private var tableView:UITableView = {
        let tableView = UITableView.init()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight =  defultRowH
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.tableHeaderView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: lee_screenW, height: 10))
        tableView.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: lee_screenW, height: lee_safeH))
        tableView.register(BossCell.self, forCellReuseIdentifier: bossIdentifier)
//        let clickGes = UITapGestureRecognizer.init(target: self, action: #selector(clickAction(recognizer:)))
//        tableView.isUserInteractionEnabled = true
//        tableView.addGestureRecognizer(clickGes)
        return tableView
    }()
    
    
    lazy var lee_inputView:UITextView = {
        let view = UITextView.init()
        view.backgroundColor = .white
        view.textColor = boss_mainBlackColor
        view.font = UIFont.systemFont(ofSize: 14)
        view.returnKeyType = .done
        view.delegate = self
        view.setPlaceholder("描述细节问题,以便猎头为您推荐更精准的候选人")
        view.layer.cornerRadius = CGFloat(5)
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor =  boss_mainLineColor.cgColor
        return view
    }()

    
    private lazy var bottomView:UIView = {
        let bottomView = UIView.init()
        bottomView.addSubview(confirmBtn)
        bottomView.addSubview(tipLb)
        return bottomView
    }()
    
    private lazy var footerView:UIView = {
        let footerView = UIView.init()
        footerView.backgroundColor = .white
        return footerView
    }()
    
    private lazy var confirmBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("确认", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.backgroundColor = boss_mainBlueTextColor
        btn.adjustsImageWhenHighlighted = false;
        btn.addTarget(self, action: #selector(commitAction), for: .touchUpInside)
        btn.layer.cornerRadius = CGFloat(5)
        btn.layer.masksToBounds = true
        return btn
    }()
    
    
    lazy private var tipLb:UILabel = {
        let label = UILabel.init()
        label.textColor = boss_mainGaryColor
        label.text = "不匹配原因将展示给其他猎头参考"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
}

extension BossVC:UITableViewDelegate,UITableViewDataSource{
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = dataArr[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: bossIdentifier, for: indexPath) as! BossCell
        cell.model = model
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return dataArr[indexPath.row].rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let model = dataArr[indexPath.row]
        model.isOpen = !model.isOpen
        var index = -1
        for (i,item) in dataArr.enumerated(){
            if(item.isOpen && item.sectionTitle != model.sectionTitle){
                item.isOpen = false
                index = i
                break
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.beginUpdates()
        tableView.endUpdates()
        if(index != -1){
            let idx = IndexPath.init(item: index, section: 0)
            tableView.reloadRows(at: [indexPath,idx], with: .fade)
        }else{
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
       
        
        
//        let model = dataArr[indexPath.row]
//        model.isOpen = !model.isOpen
//        for m in dataArr{
//            if(m.sectionTitle != model.sectionTitle){
//                m.isOpen = false
//            }
//        }
//        tableView.reloadData()
////        tableView.reloadRows(at: [indexPath], with: .fade)
//        view.endEditing(true)
    }
    
    
}

extension BossVC:UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            
        if (text == "\n") {
            view.endEditing(true)
            return false
        }
        
        let str = textView.text + text
        if str.count >= maxStrLength {
            let rangeIndex = (str as NSString).rangeOfComposedCharacterSequence(at: maxStrLength)
            if rangeIndex.length == 1{
            }else{
                let renageRange = (str as NSString).rangeOfComposedCharacterSequences(for: NSMakeRange(0, maxStrLength))
                textView.text = String.lee_range(str, renageRange.location, renageRange.length)
                textView.updatePlaceholder()
            }
            return false
        }
        textView.updatePlaceholder()
        return true
    }
    func textViewDidChange(_ textView: UITextView) {

        /// 选择区域
        if let selectedRange = textView.markedTextRange {

            //获取高亮部分
            if textView.position(from: selectedRange.start, offset: 0) != nil {
                //如果在变化中是高亮部分在变，就不要计算字符了
                return
            }
        }

        if textView.text.count >= maxStrLength {
            textView.text = String.lee_perfix(textView.text, maxStrLength)
            textView.updatePlaceholder()
        }
        textView.updatePlaceholder()
    }
}

extension BossVC{
    private func getDataWithJson() -> [BossSectionModel]{
        dataArr.removeAll()
        if let path = Bundle.main.path(forResource: "BossOptions", ofType: "json"){
            if let data = NSData(contentsOfFile: path){
                do {
                    let json = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as? Dictionary<String, Any>
                    var sectionTempArr:[BossSectionModel] = []
                    if let sectionList = json?["options"] as? Array<Dictionary<String, Any>> {
                        for sectionDic in sectionList{
//                            BossSectionModel.deserialize(from: sectionDic)
                            let sectionModel = BossSectionModel.init()
                            if let title = sectionDic["sectionTitle"] as? String{
                                sectionModel.sectionTitle = title
                            }
                            var tempArr:[BossModel] = []
                            if let values = sectionDic["values"] as? [Dictionary<String,Any>]{
                                
                                for valueDic in values{
                                    let bossModel = BossModel.init()
                                    if let id = valueDic["id"] as? String{
                                        bossModel.id = id
                                    }
                                    if let name = valueDic["name"] as? String{
                                        bossModel.name = name
                                    }
                                    if let isSelected = valueDic["isSelected"] as? Bool{
                                        bossModel.isSelected = isSelected
                                    }
                                    tempArr.append(bossModel)
                                }
                                sectionModel.values = tempArr
                            }
                            sectionTempArr.append(sectionModel)
                        }
                        return sectionTempArr
                    }
                } catch {
                    return []
                }
            }
        }
        return []
    }

}

extension BossVC{
    
    @objc func keyBoardShow(noty: Notification) {
        
    }
    
    @objc func keyBoardHidden(noty: Notification) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.view.frame = CGRect.init(x: 0, y: 0, width: lee_screenW, height: lee_screenH)
        } completion: { (result) in
        }
    }

    @objc func keyBoardWillChangeFrame(noty: Notification) {
//        tableView.scrollToRow(at: IndexPath.init(row: dataArr.count - 1, section: 0), at: .bottom, animated: false)
        guard let userInfo = noty.userInfo else {return}
        let value = userInfo["UIKeyboardFrameEndUserInfoKey"] as! NSValue
        let keyboardRect = value.cgRectValue
        let keyboradHeight = keyboardRect.size.height
        let footerViewFrame = footerView.convert(footerView.bounds, to: view)
        if(footerViewFrame.maxY + keyboradHeight > lee_screenH){
            UIView.animate(withDuration: 0.3) { [weak self] in
                let newY = lee_screenH - (footerViewFrame.maxY + keyboradHeight)
                let newFrame = CGRect.init(x: 0, y: newY, width: lee_screenW, height: lee_screenH)
                print(newFrame)
                self?.view.frame = newFrame
            } completion: { (result) in
            }
        }
    }
   
}
