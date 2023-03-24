
import Foundation
import CoreData

protocol ContactRepository{
    func create(contact: Contacts)
    func getAll() -> [Contacts]?
    func get(byIdentifier id: UUID) -> Contacts?
    func update(contact: Contacts) -> Bool
    func delete(record: UUID) -> Bool
}


struct ContactData: ContactRepository{
    
    func create(contact: Contacts) {
        let myContact = CDContacts(context: PersistentStorage.shared.context)
        myContact.firstName = contact.firstName
        myContact.secondName = contact.secondName
        myContact.phnNumber = contact.mobile
        myContact.id = contact.id
        
        PersistentStorage.shared.saveContext()
    }
    
    func getAll() -> [Contacts]? {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(path)
        var contacts: [Contacts] = []
        do {
            guard let result = try PersistentStorage.shared.context.fetch(CDContacts.fetchRequest()) as? [CDContacts] else {return nil}
            
            
            result.forEach { cdContacts in
                let myContact = Contacts(firstName: cdContacts.firstName!, secondName: cdContacts.secondName!, mobile: cdContacts.phnNumber!, id: cdContacts.id!)
                contacts.append(myContact)
            }
        } catch let error {
            debugPrint(error)
        }
        return contacts
        
    }
    
    func get(byIdentifier id: UUID) -> Contacts? {

        let result = getContact(byIdentifier: id)
        guard result != nil else {return nil}
        let myContact = Contacts(firstName: result!.firstName!, secondName: result!.secondName!, mobile: result!.phnNumber!, id: result!.id!)
        return myContact
    }
    
    private func getContact(byIdentifier id: UUID) -> CDContacts?{
        let request = NSFetchRequest<CDContacts>(entityName: "CDContacts")
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)
        request.predicate = predicate
        do {
            let result = try PersistentStorage.shared.context.fetch(request).first
            guard result != nil else {return nil}
            return result
            
        } catch let error {
            debugPrint(error)
        }
        return nil
    }
    
    
    func update(contact: Contacts) -> Bool{
        let record = getContact(byIdentifier: contact.id)
        guard record != nil else{ return false }
        record?.firstName = contact.firstName
        record?.secondName = contact.secondName
        record?.phnNumber = contact.mobile
        record?.id = contact.id
        
        PersistentStorage.shared.saveContext()
        return true
    }

    func delete(record: UUID) -> Bool{
        let field = getContact(byIdentifier: record)
        guard field != nil else{ return false }
        
        PersistentStorage.shared.context.delete(field!)
        PersistentStorage.shared.saveContext()
        return true
    }
    
    
}
