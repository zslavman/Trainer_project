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
        case sectionOne
        case sectionTwo
        
        var columnCount: Int {
            switch self {
            case .sectionOne: return 2
            case .sectionTwo: return 3
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
        configureDataSource()
    }
    
    
    //MARK: Setup layout
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.delegate = self
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let leadingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.7), heightDimension: .fractionalHeight(1.0)))
            leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            
            let containerGroupLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                                  heightDimension: .fractionalHeight(1.0))
            
            let containerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: containerGroupLayoutSize,
                                                                    subitems: [leadingItem])

            let section = NSCollectionLayoutSection(group: containerGroup)
            section.orthogonalScrollingBehavior = .paging
            return section
            
        }, configuration: config)
        
        return layout
    }
    
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: {
            (collectionView: UICollectionView, indexPath: IndexPath, intValueID: Int) -> UICollectionViewCell? in
            //TODO: switch cell types
            let cell = self.configureCell(cellType: SampleCell.self, intValueID: intValueID, indexPath: indexPath)
            return cell
        })
    }
    
    private func configureCell<T: Reusable>(cellType: T.Type, intValueID: Int, indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseID, for: indexPath) as? T
        else { fatalError("Could not implement cell with type \(cellType)") }
        return cell
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
