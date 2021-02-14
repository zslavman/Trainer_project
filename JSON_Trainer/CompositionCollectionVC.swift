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
        
        init(intVal: Int) {
            if let safeInstance = SectionKind(rawValue: intVal) {
                self = safeInstance
            }
            else {
                self = .sectionOne_list
            }
        }
    }
    private var dataSource: UICollectionViewDiffableDataSource<Int, Int>! = nil
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
        view.addSubview(collectionView)
        collectionView.delegate = self
    }
    
    
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let section = SectionKind(intVal: sectionIndex)
            switch section {
            case .sectionOne_list: return self.createListLayoutSection()
            case .sectionTwo_grid: return self.createGridLayoutSection()
            }
        }, configuration: config)
        
        return layout
    }
    
    
    private func createGridLayoutSection() -> NSCollectionLayoutSection {
        let itemLayoutSize = NSCollectionLayoutSize(widthDimension : .fractionalWidth(0.5),
                                                    heightDimension: .fractionalHeight(1.0))
        let leadingItem = NSCollectionLayoutItem(layoutSize: itemLayoutSize)
        leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let containerGroupLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                              heightDimension: .fractionalHeight(1.0))
        let containerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: containerGroupLayoutSize,
                                                                subitems: [leadingItem])
        let section = NSCollectionLayoutSection(group: containerGroup)
        section.orthogonalScrollingBehavior = .paging
        return section
    }
    
    
    private func createListLayoutSection() -> NSCollectionLayoutSection {
        // section -> groups -> items -> size
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        let spacing = CGFloat(20)
        group.interItemSpacing = .fixed(spacing)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacing, bottom: 0, trailing: spacing)
        return section
    }
    
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: {
            (collectionView: UICollectionView, indexPath: IndexPath, sectionID: Int) -> UICollectionViewCell? in
            let section = SectionKind(intVal: sectionID)
            switch section {
            
            case .sectionOne_list:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SampleCell.reuseID,
                                                              for: indexPath) as! SampleCell
                cell.configure(color: .red)
                return cell
                
            case .sectionTwo_grid:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SampleCell.reuseID,
                                                              for: indexPath) as! SampleCell
                cell.configure(color: .green)
                return cell
            }
        })
        reloadData()
    }
    
    
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        var identifierOffset = 0
        let itemsPerSection = 18
        SectionKind.allCases.forEach {
            snapshot.appendSections([$0.rawValue])
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
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
    
    
    










//MARK: - SwiftUI
import SwiftUI
struct MyProvider: PreviewProvider {
    
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
        
        func makeUIViewController(context: Context) -> some UIViewController {
            let vc = UINavigationController(rootViewController: CompositionCollectionVC())
            return vc
        }
    }
}
