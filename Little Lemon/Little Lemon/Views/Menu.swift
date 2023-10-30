//
//  Menu.swift
//  Little Lemon
//
//  Created by Kevin Troyan on 10/29/23.
//


import SwiftUI
import CoreData


struct Menu: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @State private var searchText = ""
    
    var body: some View {
        
        VStack {
            Text("Little Lemon")
            Text("Chicago")
            Text("Happy to take your order!")
            TextField("Search menu", text: $searchText)
            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                        HStack {
                            Text((dish.title ?? "") + " " + (dish.price ?? ""))
                            AsyncImage(url: URL(string: dish.image ?? ""))
                        }
                    }
                }
            }
        }
        .onAppear {
            PersistenceController.shared.clear()
            getMenuData()
        }
        
    }
    
    
    func getMenuData() {
        let url = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let urlObject = URL(string: url)!
        let urlRequest = URLRequest(url: urlObject)
        let task = URLSession.shared.dataTask(with: urlRequest) { result,_,_ in
            if let res = result {
                let decoder = JSONDecoder()
                let data = try? decoder.decode(MenuList.self, from: res)
                guard let data = data else { return }
                for dish in data.menu {
                    let newDish = Dish(context: viewContext)
                    newDish.title = dish.title
                    newDish.image = dish.image
                    newDish.price = dish.price
                }
                try? viewContext.save()
            }
        }
        task.resume()
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key:"title", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))]
    }
    func buildPredicate() -> NSPredicate {
        return self.searchText.isEmpty ? NSPredicate(value: true) : NSPredicate(format: "title CONTAINS[cd] %@", searchText)
    }
    
    
    
    
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}


