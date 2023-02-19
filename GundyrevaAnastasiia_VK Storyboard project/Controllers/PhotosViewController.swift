//
//  PhotosViewController.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 07.12.2022.
// добавить: подсчет лайков, комменты
// исправить: отображение лайков

import UIKit
import RealmSwift

private let reuseIdentifier = "Cell"

class PhotosViewController: UICollectionViewController {
    
    let session = Session.shared
    let service = Service()
    let realm = try! Realm()
    
    var friend: Friend?
    var selectedIndex: Int = 0
    var photos = [Photo]()
    var photosVK = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        print("enter view")
        print(friend?.id)
        
        service.getPhotosOf(token: session.token, ownerId: friend?.id ?? 0, completion: { photos in
            let arrayPhotos = Array(photos)
            self.photos = arrayPhotos
            self.photosVK = arrayPhotos

            self.collectionView.reloadData()
            print("\(photos.count) photos")
            
            self.savePhotosToRealm()
        })
        print("\(photos.count) photos")
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        navigationController?.setNavigationBarHidden(false, animated: false)
    }


    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendPhotoCell", for: indexPath) as? PhotoCell else {
            preconditionFailure("Error")
        }
        
        let photo = photos[indexPath.row].sizes.last?.url
//        photos[indexPath.row].sizes.last?.url
        cell.imagePhotoCell.sd_setImage(with: URL(string: photo ?? ""))
        
        print("photo loaded")
        print(photo)
        
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhotos",
            let destinationVC = segue.destination as? PhotosUpcloseViewController {
            destinationVC.friend = friend
            destinationVC.photos = photos
            destinationVC.selectedIndex = selectedIndex
//            let photo = photos[destinationVC.selectedIndex].url
//            destinationVC.photo?.sd_setImage(with: URL(string: photo ?? ""))
        }
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    
     //Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        performSegue(withIdentifier: "showPhotos", sender: self)
    }

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

    func savePhotosToRealm() {
        let allPhotos = realm.objects(PhotoItems.self)
        var photoItems = PhotoItems()
        
        for i in photos.indices {
            let onePhoto = Photo()
            onePhoto.id = photos[i].id
            onePhoto.ownerId = photos[i].ownerId
            onePhoto.sizes = photos[i].sizes
            photoItems.items.append(onePhoto)
            print(onePhoto.id)
//            print(onePhoto.sizes.last?.url)
        }
        
        print(photoItems.items.first?.sizes.last?.url)
        if allPhotos.isEmpty {
            print("allPhotos is empty. \(photoItems.items.count) photoItems.items added")
            try! realm.write {
                realm.add(photoItems)
            }
        } else {
            // проверить что все массивы каждого юзера в наличии по ownerId
            // проверить что все фото в наличии по id
            // сравниваем photosVK и photoItems.items
//            photosVK.forEach { photo in
//                for
//            var newFriendsPhotos = [Photo]()
                
//            }
            let newFriendsPhotos = photosVK.filter {
                !photos.contains($0)
            }
//            try! realm.write {
//                realm.add(newFriendsPhotos)
            print(" \(newFriendsPhotos.count) new photos in NewFriendsPhotos")
            }
        }
    func getPhotosFromRealm() {
        let allPhotos = realm.objects(PhotoItems.self)
        
        if let photoItems = allPhotos.first?.items {
            self.photos = Array(photoItems)
            self.collectionView.reloadData()
        }
    }
}




extension PhotosViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TransitionAnimator()
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TransitionAnimator()
    }
}
