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
    var token: NotificationToken?
    
    var friend: Friend?
    var selectedIndex: Int = 0
    var photos: Results<Photo>?
    var photosArray = [Photo]()
    
    
    var photosVK = [Photo]()
    var photosNew = [Photo]()
    var photosToDelete = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
//        print("enter view")
//        print(friend?.id)
        
        service.getPhotosOf(token: session.token, ownerId: friend?.id ?? 0, completion: { photos in
            let arrayPhotos = Array(photos)
//            self.photos = arrayPhotos
            self.photosVK = arrayPhotos

//            print("\(photos.count) photos")
//            self.savePhotosToRealm()
            self.updatePhotosInRealm()
            self.collectionView.reloadData()
            
        })
        
        getPhotosFromRealm()
        photosArray = photos?.toArray() ?? [Photo]()
        self.collectionView.reloadData()
        
        
        
//        self.collectionView.reloadData()
   
        
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
        return photosArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendPhotoCell", for: indexPath) as? PhotoCell else {
            preconditionFailure("Error")
        }
        
        let photo = photosArray[indexPath.row].sizes.last?.url
//        photos[indexPath.row].sizes.last?.url
        cell.imagePhotoCell.sd_setImage(with: URL(string: photo ?? ""))
        
//        print("photo loaded")
        
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhotos",
            let destinationVC = segue.destination as? PhotosUpcloseViewController {
            destinationVC.friend = friend
            destinationVC.photos = photosArray
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
        
        for i in photosVK.indices {
            let onePhoto = Photo()
            onePhoto.id = photosVK[i].id
            onePhoto.ownerId = photosVK[i].ownerId
            onePhoto.sizes = photosVK[i].sizes
            photoItems.items.append(onePhoto)
//            print(onePhoto.id)
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
            
            guard let oldPhotos = allPhotos.first?.items else {
                print("all Photos is empty")
                return
            }
            
            for newPhoto in photosVK {
                for oldPhoto in oldPhotos {
                    if newPhoto.id == oldPhoto.id {
                        if let index = photoItems.items.firstIndex(where: { $0.id == newPhoto.id }) {
                            photoItems.items.remove(at: index)
                            print("oldPhoto = \(newPhoto.id)")
                            print("photoItems = \(photoItems.items.count)")
                        }
                    }
                }
            }
            print("photoItems = \(photoItems.items.count)")
            
//            if let oldPhotoIs = oldPhotos.first(where: {$0.id == photoId}) {
//                print("checkup didn't work for \(oldPhotoIs.id)")
//            } else {
//                print("Nope, this photo is truly new. Why didn't it upload?")
//            }
            
            
//            let newFriendsPhotos = photosVK.filter { (photo) -> Bool in
//               return !oldPhotos.contains(photo) //возвращается пустым!!
            //
            //            }
            
//            print(" \(oldPhotos.count) old photos in oldPhotos")
//            print(" \(newFriendsPhotos.count) new photos in NewFriendsPhotos")
//            print(newFriendsPhotos.first?.id)
//            print(oldPhotos.first?.id)
            
            
//            let resultPhotos = Array(Set(photosVK).subtracting(Set(oldPhotos)))
//            print("\(resultPhotos.first) фото из сетов")
//            print("\(resultPhotos.count) фото из сетов")
            
            try! realm.write {
                allPhotos.first?.items.append(objectsIn: photoItems.items)
            }
            }
        }
    func getPhotosFromRealm() {
        photos = realm.objects(Photo.self).where { $0.ownerId == self.friend?.id ?? 0 }
//        photosArray = photos?.toArray() ?? [Photo]()
        
        token = photos!.observe { [weak self] (changes: RealmCollectionChange) in

            switch changes {
            case .initial:

                self?.collectionView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):

                self?.collectionView.performBatchUpdates({
                   
                    self?.collectionView.deleteItems(at: deletions.map({ IndexPath(row: $0, section: 0)}))
                    self?.collectionView.insertItems(at: insertions.map({ IndexPath(row: $0, section: 0) }))
                    self?.collectionView.reloadItems(at: modifications.map({ IndexPath(row: $0, section: 0) }))
                }, completion: { finished in
                    // ...
                })
            case .error(let error):
                print(error.localizedDescription)
            }
        }
        
//        if let photoItems = allPhotos.first?.items {
//            let photosOfFriend = photoItems.filter({ $0.ownerId == self.friend?.id })
//            self.photos = Array(photosOfFriend)
//            self.collectionView.reloadData()
//        }
    }
    
    func updatePhotosInRealm() {
        
        // проверить фото по id
        // если есть id которых нету в рилме то добавить, если есть в рилме те, которых нет в вк, то удалить
        
        let allPhotos = realm.objects(PhotoItems.self)
        
        if let photoItems = allPhotos.first?.items {
            
            //массив фото, которые есть в вк, но нет в рилме
            photosNew = Array(photosVK)
            print("photosNew initial count  = \(photosNew.count)")
            
            for newPhoto in photosVK {
                for oldPhoto in photoItems {
                    if newPhoto.id == oldPhoto.id {
                        if let index = photosNew.firstIndex(where: { $0.id == newPhoto.id }) {
                            photosNew.remove(at: index)
//                            print("oldPhoto deleted from the array of new photos = \(newPhoto.id)")
                        }
                    }
                }
            }
            print("photosNew final  = \(photosNew.count)")
            
            //массив фото,которые есть в рилме, но нет в вк
            
            var photosToDeleteFunc = photoItems.filter({ $0.ownerId == self.friend?.id })
            photosToDelete = Array(photosToDeleteFunc)
            print("photosToDelete initial count  = \(photosToDelete.count)")
            
            // в цикле для photoItems необходим ownerId
            for oldPhoto in photosToDelete {
                for newPhoto in photosVK {
                    if newPhoto.id == oldPhoto.id {
                        if let index = photosToDelete.firstIndex(where: { $0.id == newPhoto.id }) {
                            photosToDelete.remove(at: index)
//                            print("oldPhoto true to reality = \(newPhoto.id)")
                        }
                    }
                }
            }
            
            print("photosToDelete final  = \(photosToDelete.count)")
             
            if !photosNew.isEmpty || !photosToDelete.isEmpty {
                print("Here we shall write in realm")
//                try! realm.write {
//                    allPhotos.first?.items.append(objectsIn: photosNew)
//                }
                
            }
                
                
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
