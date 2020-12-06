//
//  PersistenceService.swift
//  Prizes
//
//  Created by Valerii on 05.12.2020.
//  Copyright © 2020 Valerii. All rights reserved.
//

import CoreData

protocol PersistenceStore: AnyObject {
    func fetch(at indexPath: IndexPath) -> PrizesListInteractor.PrizeEntity
    func save(entity: PrizesListInteractor.PrizeEntity)
    func delete(at indexPath: IndexPath)
    
    func fetchSelectedObjects() -> [PrizesListInteractor.PrizeEntity]
    
    func updateRecord(entity: PrizesListInteractor.PrizeEntity)
    
    func isRecordsAreEmpty() -> Bool
    
    var delegate: PersistenceServiceDelegate? { get set }
    var fetchedResultsController: NSFetchedResultsController<Prize>! { get }
}

protocol PersistenceServiceDelegate: AnyObject {
    func controllerWillChangeContent(_ persistenceService: PersistenceService)
    func controllerDidChangeContent(_ persistenceService: PersistenceService)
    func controllerProcessingUpdate(_ persistenceService: PersistenceService, type: PersistenceService.BatchUpdate)
}

final class PersistenceService: NSObject {
    
    weak var delegate: PersistenceServiceDelegate?
    
    private(set) var fetchedResultsController: NSFetchedResultsController<Prize>!
    
    override init() {
        super.init()
        configureFRC()
        performFetch()
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Prizes")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private(set) lazy var mainMOC = persistentContainer.viewContext
}

// MARK: - PersistenceStore

extension PersistenceService: PersistenceStore {
    
    func fetch(at indexPath: IndexPath) -> PrizesListInteractor.PrizeEntity {
        let fetchedObject = fetchedResultsController.object(at: indexPath)
        let entity: PrizesListInteractor.PrizeEntity = .init(
            name: fetchedObject.name ?? "",
            price: fetchedObject.price,
            uuid: fetchedObject.uuid ?? UUID(),
            isSelected: fetchedObject.isSelected
        )
        
        return entity
    }
    
    func save(entity: PrizesListInteractor.PrizeEntity) {
        mainMOC.perform {
            let modelObject = Prize(context: self.mainMOC)
            modelObject.price = entity.price
            modelObject.name = entity.name
            modelObject.uuid = entity.uuid
            modelObject.isSelected = entity.isSelected
            modelObject.date = entity.date
            self.saveMainMOC()
        }
    }
    
    func delete(at indexPath: IndexPath) {
        let fetchedObject = fetchedResultsController.object(at: indexPath)
        
        mainMOC.perform {
            do {
                self.mainMOC.delete(fetchedObject)
                try self.mainMOC.save()
            } catch {
                print(error)
            }
        }
    }
    
    func fetchSelectedObjects() -> [PrizesListInteractor.PrizeEntity] {
        var result: [PrizesListInteractor.PrizeEntity] = []
        
        let predicate = NSPredicate(format: "isSelected == %@", NSNumber(value: true))
        performFetch(with: predicate)
    
        let fetchedObjects = fetchedResultsController.fetchedObjects
        performFetch()
        
        fetchedObjects?.forEach {
            
            let entity: PrizesListInteractor.PrizeEntity = .init(
                name: $0.name ?? "",
                price: $0.price,
                uuid: $0.uuid ?? UUID(),
                isSelected: $0.isSelected
            )
            result.append(entity)
        }
        
        return result
    }
    
    func updateRecord(entity: PrizesListInteractor.PrizeEntity) {
        let predicate = NSPredicate(format: "uuid == %@", entity.uuid as NSUUID)
        performFetch(with: predicate)
        
        guard let object = fetchedResultsController.fetchedObjects?.first else {
            performFetch()
            return
        }
        
        performFetch()
        object.isSelected.toggle()
        saveMainMOC()
    }
    
    func isRecordsAreEmpty() -> Bool {
        var isEmpty = true
        
        let fetchRequest: NSFetchRequest<Prize> = Prize.fetchRequest()
        
        mainMOC.performAndWait {
            do {
                let fetchedObjects = try self.mainMOC.fetch(fetchRequest)
                isEmpty = fetchedObjects.count == 0
            } catch {
                print(error)
            }
        }
        
        return isEmpty
    }
}

// MARK: - NSFetchedResultsControllerDelegate

extension PersistenceService: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.controllerWillChangeContent(self)
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.controllerDidChangeContent(self)
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        
        switch type {
        case .delete:
            guard let indexPath = indexPath else { return }
            delegate?.controllerProcessingUpdate(self, type: .delete(indexPath: indexPath))
        case .insert:
            guard let indexPath = newIndexPath else { return }
            delegate?.controllerProcessingUpdate(self, type: .insert(indexPath: indexPath))
        case .update:
            guard let indexPath = indexPath else { return }
            delegate?.controllerProcessingUpdate(self, type: .update(indexPath: indexPath))
            
        default:
            break
        }
    }
}

// MARK: - Private

private extension PersistenceService {
    
    func configureFRC() {
        fetchedResultsController = initalFRC()
        fetchedResultsController.delegate = self
    }
    
    func initalFRC() -> NSFetchedResultsController<Prize> {
        var fetchedResultsController: NSFetchedResultsController<Prize>
        
        let fetchRequest: NSFetchRequest<Prize> = Prize.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        let priceSortDescriptor = NSSortDescriptor(key: #keyPath(Prize.price), ascending: true)
        let dateSortDescriptor = NSSortDescriptor(key: #keyPath(Prize.date), ascending: true)
        
        fetchRequest.sortDescriptors = [priceSortDescriptor, dateSortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController<Prize>(
            fetchRequest: fetchRequest,
            managedObjectContext: mainMOC,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        
        return fetchedResultsController
    }
    
    func performFetch(with predicate: NSPredicate? = nil) {
        fetchedResultsController.fetchRequest.predicate = predicate
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error)
        }
    }
    
    func saveMainMOC() {
        if mainMOC.hasChanges {
            do {
                try mainMOC.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

// MARK: - BatchUpdate

extension PersistenceService {
    
    enum BatchUpdate {
        case delete(indexPath: IndexPath)
        case insert(indexPath: IndexPath)
        case update(indexPath: IndexPath)
    }
}
