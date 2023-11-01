//
//  Menu.swift
//  Little Lemon
//
//  Created by Kevin Troyan on 10/29/23.
//


import SwiftUI


struct Menu: View {
    
    @Environment(\.managedObjectContext) private var viewContext
 
    @State var searchText = ""
    @State private var selectedCategory: String = ""
    
    
    //    Build sort descriptor for FetchObjects to sort by title
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title",
                                 ascending: true,
                                 selector: #selector(NSString.localizedStandardCompare))]
    }

        
    //    Create predicate to filder FetchObjects with searchText variable
    func buildPredicate() -> NSPredicate {
        var predicates: [NSPredicate] = []
        
        if !searchText.isEmpty {
            predicates.append(NSPredicate(format: "title CONTAINS[cd] %@", searchText))
        }
        
        if !selectedCategory.isEmpty {
            predicates.append(NSPredicate(format: "category == %@", selectedCategory))
        }
        
        if predicates.isEmpty {
            return NSPredicate(value: true) // Empty predicates return all dishes
        } else {
            return NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        }
    }
    
    
    var body: some View {
        
        VStack {
            Header()
            VStack(alignment: .leading, spacing: 5) {
                HeroSection()
                TextField(" ...Search menu", text: $searchText)
                    .frame(width: 350, height: 40)
                //  .font(.body)
                    .background(Color(red: 240, green: 240, blue: 240))
                    .foregroundColor(.black)
                    .cornerRadius(15)
                    .padding(8)
            }
            .frame(maxWidth: .infinity)
            .padding(.leading)
//            .foregroundColor(.white)
            .background(Color(red: 57, green: 76, blue: 69))

            Picker("Category", selection: $selectedCategory) {
                Text("All").tag("")
                Text("Starters").tag("starters")
                Text("Mains").tag("mains")
                Text("Desserts").tag("desserts")
                Text("Drinks").tag("drinks")
            }
            .pickerStyle(.segmented)

            FetchedObjects(predicate: buildPredicate(),
                           sortDescriptors: buildSortDescriptors(),
                           content: { (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                        VStack(alignment: .leading) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text((dish.title ?? ""))
                                        .fontWeight(.semibold)
                                    Text("Price: $" + (dish.price ?? ""))
                                    Text((dish.descriptionDish ?? "Description"))
                                        .lineLimit(2)
                                }
                                Spacer()
                                let imageURL = dish.image ?? ""
                                AsyncImage(url: URL(string: imageURL)!){ image in
                                    image
                                        .resizable()
                                } placeholder: {
                                    Image(systemName: "photo.fill")
                                }
                                .frame(width: 125, height: 100)
                            }
                            
                        }
                    }
                }
            })
            .onAppear{
                getMenuData()
            }
        }

    }
    
    func getMenuData() {
        //        first clear database each time before saving the menu list again
        PersistenceController.shared.clear()
        
        let menuAddress = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let menuURL = URL(string: menuAddress)!
        let request = URLRequest(url: menuURL)
        let task = URLSession.shared.dataTask(with: request)
        { data, response, error in
            if let data = data,
               let _ = String(data: data, encoding: .utf8) {
                let decoder = JSONDecoder()
                
                let menu = try? decoder.decode(MenuList.self, from: data)
                
                menu?.menu.forEach({
                    let newDish = Dish(context: viewContext)
                    newDish.title = $0.title
                    newDish.image = $0.image
                    newDish.price = $0.price
                    newDish.category = $0.category
                    newDish.descriptionDish = $0.descriptionDish
                    
                })
                //                Save data in database after loop ends
                try? viewContext.save()
            }
        }
        
        task.resume()
        
    }
    
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}






