//
//  CompositionCollectionVC.swift
//  JSON_Trainer
//
//  Created by Zinko Viacheslav on 14.02.2021.
//  Copyright © 2021 Zinko Viacheslav. All rights reserved.
//

import UIKit

class CompositionCollectionVC: UIViewController {
    
    enum SectionKind: Int, CaseIterable {
        case sectionOne_list
        case sectionTwo_grid
        case sectionTwo_grid2
        case sectionTwo_grid3
        
        init(intVal: Int) {
            if let safeInstance = SectionKind(rawValue: intVal) {
                self = safeInstance
            }
            else {
                self = .sectionOne_list
            }
        }
    }
    private var dataSource: UICollectionViewDiffableDataSource<SectionKind, Int>! = nil
    private var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.8921883046, green: 1, blue: 0.8100706013, alpha: 1)
        navigationItem.title = "Composition"
        setupCollectionView()
        setupDataSource()
    }
    
    
    //MARK: Setup layout
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.register(SampleCell.self, forCellWithReuseIdentifier: SampleCell.reuseID)
        collectionView.register(SecondCell.self, forCellWithReuseIdentifier: SecondCell.reuseID)
        view.addSubview(collectionView)
        collectionView.delegate = self
    }
    
    
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 40
        //config.scrollDirection = .horizontal
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let section = SectionKind(intVal: sectionIndex)
            switch section {
            case .sectionOne_list: return self.createListLayoutSection()
            case .sectionTwo_grid: return self.createGridLayoutSection()
            default: return self.createGridLayoutSection()
            }
        }, configuration: config)

        return layout
    }
    
    
    /// top collection
    private func createListLayoutSection() -> NSCollectionLayoutSection {
        // section -> groups -> items -> size
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        let spacing = CGFloat(10)
        group.interItemSpacing = .fixed(spacing)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: 0, trailing: spacing)
        return section
    }
    
    
    /// bottom collection with paging
    private func createGridLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension : .fractionalWidth(0.5),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let containerGroupLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                                              heightDimension: .fractionalHeight(0.3))
        let containerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: containerGroupLayoutSize,
                                                                //subitems: [item])
                                                                subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: containerGroup)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
      
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: {
            (collectionView: UICollectionView, indexPath: IndexPath, _ ) -> UICollectionViewCell? in
            let section = SectionKind(intVal: indexPath.section)
            switch section {
            
            case .sectionOne_list:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SampleCell.reuseID,
                                                              for: indexPath) as! SampleCell
                cell.configure(color: .red)
                return cell
                
            case .sectionTwo_grid:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SecondCell.reuseID,
                                                              for: indexPath) as! SecondCell
                cell.configure(color: .green)
                return cell
                
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SecondCell.reuseID,
                                                              for: indexPath) as! SecondCell
                cell.configure(color: .blue)
                return cell
            }
        })
        reloadData()
    }
    
    
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<SectionKind, Int>()
        var identifierOffset = 0
        let itemsPerSection_list = 14
        let itemsPerSection_grid = 30
        
        SectionKind.allCases.forEach {
            (sectionKind) in
            let itemsPerSection = (sectionKind == .sectionOne_list) ? itemsPerSection_list : itemsPerSection_grid
            snapshot.appendSections([sectionKind])
            let maxIdentifier = identifierOffset + itemsPerSection
            snapshot.appendItems(Array(identifierOffset..<maxIdentifier))
            identifierOffset += itemsPerSection
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
}


//MARK: - UICollectionViewDelegate

extension CompositionCollectionVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.section, indexPath.row)
    }
    
}
    
    
    










////MARK: - SwiftUI
//import SwiftUI
//struct MyProvider: PreviewProvider {
//
//    static var previews: some View {
//        ContainerView().edgesIgnoringSafeArea(.all)
//    }
//
//    struct ContainerView: UIViewControllerRepresentable {
//        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
//
//        func makeUIViewController(context: Context) -> some UIViewController {
//            let vc = UINavigationController(rootViewController: CompositionCollectionVC())
//            return vc
//        }
//    }
//}
