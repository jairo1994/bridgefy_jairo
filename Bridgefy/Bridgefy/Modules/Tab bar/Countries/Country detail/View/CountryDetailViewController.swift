//
//  viewModel.countryDetailViewController.swift
//  Bridgefy
//
//  Created by Jairo Lopez on 27/09/22.
//

import UIKit

class CountryDetailViewController: UIViewController {
    private let countryCell = "countryCell"
    var viewModel: CountryDetailViewModel!
    
    convenience init(viewModel: CountryDetailViewModel) {
        self.init(nibName:nil, bundle:nil)
        self.viewModel = viewModel
    }

    // This extends the superclass.
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    // This is also necessary when extending the superclass.
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented") // or see Roman Sausarnes's answer
    }
    
    private lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    
    private lazy var collection: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.countryDetail.name
        navigationController?.navigationBar.isHidden = false
        if viewModel.isSaved {
            
        }
        addBarButton()
        navigationController?.navigationBar.tintColor = Colors.Enfasis.color

        configureSubviews()
    }
    
    private func configureSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
        scrollView.constraintToParent(parent: view)
        contentView.constraintToParent(parent: scrollView)
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        stackView.constraintToParent(parent: contentView, leading: 8, trailing: -8)
        
        setup()
    }
    
    func setup() {
        //Top section
        let topView = topView()
        stackView.addArrangedSubview(topView)
        
        //Map section
        let map = mapView()
        stackView.addArrangedSubview(map)
        map.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.16).isActive = true
        
        //Map section
        let peopleContent = peopleView()
        stackView.addArrangedSubview(peopleContent)
        peopleContent.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.16).isActive = true
        
        //Exchange section
        let exchangeContent = exchangeView()
        stackView.addArrangedSubview(exchangeContent)
        exchangeContent.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08).isActive = true

        //Map section
        if let borders = viewModel.countryDetail.borders, borders.count > 0 {
            
            layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
            collection.translatesAutoresizingMaskIntoConstraints = false
            collection.setCollectionViewLayout(layout, animated: true)
            collection.delegate = self
            collection.dataSource = self
            collection.register(FlagCollectionViewCell.self, forCellWithReuseIdentifier: countryCell)
            
            let bordersContent = bordersView()
            stackView.addArrangedSubview(bordersContent)
            bordersContent.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.16).isActive = true
        }
    }
    
    func addBarButton(){
        if viewModel.isSaved {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(deleteCountry))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveCountry))
        }
        
    }
    
    @objc func saveCountry() {
        let alert = UIAlertController(title: "Confirm", message: "¿Are you shure to save?", preferredStyle: .actionSheet)
            
        alert.addAction(UIAlertAction(title: "Accept", style: .default , handler:{ (UIAlertAction) in
            self.viewModel.save()
            Messages.showMessage(theme: .success, title: "¡Ready!", body: "Country saved successfull")
            self.addBarButton()
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        
        self.present(alert, animated: true)
    }
    
    @objc func deleteCountry() {
        let alert = UIAlertController(title: "Confirm", message: "¿Are you shure to delete?", preferredStyle: .actionSheet)
            
        alert.addAction(UIAlertAction(title: "Accept", style: .default , handler:{ (UIAlertAction) in
            self.viewModel.delete()
            Messages.showMessage(theme: .error, title: "¡Ready!", body: "Country deleted successfull")
            self.addBarButton()
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        
        self.present(alert, animated: true)
    }
}

extension CountryDetailViewController {
    func topView() -> UIView {
        let stackView = UIView().getStack()
        let countryLbl = UIView().getLabel(text: viewModel.countryDetail.nativeName, font: .bold)
        let capitalOfCountry = UIView().getLabel(text: viewModel.countryDetail.capital ?? "")
        let countryImage = UIView().getImage()
        countryImage.shadow()
        
        stackView.addArrangedSubview(countryImage)
        stackView.addArrangedSubview(countryLbl)
        stackView.addArrangedSubview(capitalOfCountry)
        
        if let url = URL(string: viewModel.countryDetail.flags.png) {
            countryImage.kf.setImage(with: url)
        }
        
        stackView.addArrangedSubview(countryImage)
        stackView.addArrangedSubview(countryLbl)
        stackView.addArrangedSubview(capitalOfCountry)
        
        countryImage.widthAnchor.constraint(equalToConstant: 170).isActive = true
        countryImage.heightAnchor.constraint(equalToConstant: 95).isActive = true
        
        return stackView
    }
    
    func mapView() -> UIView {
        let hstack = UIView().getStack(axis: .horizontal, aligment: .center, distribution: .fillEqually)
        let contentImg = UIView().getView()
        let image = UIView().getImage(content: .scaleAspectFit)
        image.tintColor = Colors.Enfasis.color
        image.image = UIImage(named: viewModel.countryDetail.alpha3Code) ?? UIImage(named: "default")
        
        hstack.layer.cornerRadius = 10
        hstack.backgroundColor = .white
        hstack.addArrangedSubview(contentImg)
        
        let nstackTime = UIView().getStack(axis: .vertical, aligment: .center, distribution: .fill, space: 0)
        
        nstackTime.addArrangedSubview(UIView().getLabel(text: viewModel.countryDetail.subregion))
        nstackTime.addArrangedSubview(UIView().getLabel(text: "\(viewModel.countryDetail.area)"))
        
        if viewModel.countryDetail.latlng.indices.contains(1) {
            nstackTime.addArrangedSubview(UIView().getLabel(text: "(\("\(viewModel.countryDetail.latlng.first ?? 0.0)" ), \(viewModel.countryDetail.latlng[1]))" ))
        }
        
        
        hstack.addArrangedSubview(nstackTime)
        
        contentImg.addSubview(image)
        image.centerYAnchor.constraint(equalTo: contentImg.centerYAnchor).isActive = true
        image.centerXAnchor.constraint(equalTo: contentImg.centerXAnchor).isActive = true
        image.heightAnchor.constraint(equalTo: contentImg.widthAnchor, multiplier: 0.5).isActive = true
        image.widthAnchor.constraint(equalTo: contentImg.widthAnchor, multiplier: 0.5).isActive = true
        
        hstack.shadow()
        return hstack
    }
    
    func peopleView() -> UIView {
        let hstack = UIView().getStack(axis: .horizontal, aligment: .fill, distribution: .fillEqually)
        hstack.layer.cornerRadius = 10
        hstack.backgroundColor = .white
        
        let people = UIView().getView(corner: 10)
        people.backgroundColor = .white
        people.shadow()
        
        let vStackPeople = UIView().getStack(aligment: .fill)
        
        let population = UIView().getStack(axis: .horizontal, aligment: .fill, distribution: .fill)
        population.addArrangedSubview(iconLbl(lblText: "\(viewModel.countryDetail.population)", img: UIImage(named: "Population") ?? UIImage()))
        
        var languages = ""
        for (index, language) in viewModel.countryDetail.languages.enumerated() {
            languages = "\(language.name)\(index == viewModel.countryDetail.languages.count-1 && viewModel.countryDetail.languages.count > 1 ? "," : "")"
        }
        
        let language = UIView().getStack(axis: .horizontal, aligment: .fill, distribution: .fill)
        language.addArrangedSubview(iconLbl(lblText: languages, img: UIImage(named: "Languages") ?? UIImage()))
        
        var codes = ""
        for (index, code) in viewModel.countryDetail.callingCodes.enumerated() {
            codes = "\(code)\(index == viewModel.countryDetail.callingCodes.count-1 && viewModel.countryDetail.callingCodes.count > 1 ? "," : "")"
        }
        
        let codePhone = UIView().getStack(axis: .horizontal, aligment: .fill, distribution: .fill)
        codePhone.addArrangedSubview(iconLbl(lblText: codes, img: UIImage(named: "PhoneCode") ?? UIImage()))
        
        vStackPeople.addArrangedSubview(population)
        vStackPeople.addArrangedSubview(language)
        vStackPeople.addArrangedSubview(codePhone)
        
        people.addSubview(vStackPeople)
        vStackPeople.constraintToParent(parent: people, top: 16, leading: 16, bottom: -16)
        
        let time = UIView().getView(corner: 10)
        time.backgroundColor = .white
        time.shadow()
        
        let stackTime = UIView().getStack(axis: .horizontal, space: 0)
        
        let image = UIImageView(image: UIImage(named: "Timezones") ?? UIImage())
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = Colors.Enfasis.color
        
        
        let nstackTime = UIView().getStack(axis: .vertical, aligment: .fill, distribution: .fillEqually, space: 0)
        
        if let timeZones = viewModel.countryDetail.timezones{
            timeZones.forEach { time in
                var character = "+"
                if time.contains("-"){
                    character = "-"
                }
                
                let withoutCode = time.components(separatedBy: character)
                if withoutCode.indices.contains(1){
                    let lbl = UIView().getLabel(text: "\(character)\(withoutCode[1])")
                    nstackTime.addArrangedSubview(lbl)
                }
            }
        }
        
        time.addSubview(stackTime)
        stackTime.constraintToParent(parent: time, top: 16, leading: 16, bottom: -16)
        
        stackTime.addArrangedSubview(image)
        stackTime.addArrangedSubview(nstackTime)
        if viewModel.countryDetail.timezones != nil{
            hstack.addArrangedSubview(people)
            hstack.addArrangedSubview(time)
            people.widthAnchor.constraint(equalTo: hstack.widthAnchor, multiplier: 0.58).isActive = true
            time.widthAnchor.constraint(equalTo: hstack.widthAnchor, multiplier: 0.38).isActive = true
        } else {
            hstack.addArrangedSubview(people)
        }
            
        
        image.widthAnchor.constraint(equalToConstant: 32).isActive = true
        image.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        return hstack
    }
    
    func exchangeView() -> UIView {
        let contentView = UIView().getView(corner: 10)
        contentView.shadow()
        contentView.backgroundColor = .white
        
        let hstack = iconLbl(lblText: getSymbol(viewModel.countryDetail.currencies.first?.code ?? "") ?? "", img:  UIImage(named: "Currency") ?? UIImage())
        
        contentView.addSubview(hstack)
        hstack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        hstack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        return contentView
    }
    
    func bordersView() -> UIView {
        let borders = UIView().getView(corner: 10)
        borders.backgroundColor = .white
        borders.shadow()
        
        let lbl = UIView().getLabel(text: "Borders", size: 19)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        borders.addSubview(lbl)
        
        lbl.centerXAnchor.constraint(equalTo: borders.centerXAnchor).isActive = true
        lbl.topAnchor.constraint(equalTo: borders.topAnchor, constant: 8).isActive = true
        
        borders.addSubview(collection)
        NSLayoutConstraint.activate([
            collection.leadingAnchor.constraint(equalTo: borders.leadingAnchor),
            collection.topAnchor.constraint(equalTo: lbl.bottomAnchor, constant: 8),
            collection.trailingAnchor.constraint(equalTo: borders.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: borders.bottomAnchor),
        ])
        
        return borders
    }
    
    func getSymbol(_ code: String) -> String? {
        let locale = NSLocale(localeIdentifier: code)
        if locale.displayName(forKey: .currencySymbol, value: code) == code {
            let newlocale = NSLocale(localeIdentifier: code.dropLast() + "_en")
            return newlocale.displayName(forKey: .currencySymbol, value: code)
        }
        return locale.displayName(forKey: .currencySymbol, value: code)
    }
    
    func iconLbl(lblText: String, img: UIImage) -> UIStackView {
        let hstack = UIView().getStack(axis: .horizontal, aligment: .fill, distribution: .fill)
        
        let img = UIImageView(image: img)
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        img.tintColor = Colors.Enfasis.color
        
        let lbl = UIView().getLabel(text: lblText)
        
        hstack.addArrangedSubview(img)
        hstack.addArrangedSubview(lbl)
        
        img.widthAnchor.constraint(equalToConstant: 32).isActive = true
        img.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        contentView.addSubview(hstack)
        
        
        
        return hstack
    }
}

extension CountryDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.countryDetail.borders?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: countryCell, for: indexPath) as? FlagCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configCell(border: viewModel.countryDetail.borders?[indexPath.item] ?? "")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height, height: collectionView.frame.height)
    }
    
    
}
