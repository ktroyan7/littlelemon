//
//  Menu.swift
//  Little Lemon
//
//  Created by Kevin Troyan on 10/29/23.
//


import SwiftUI


struct Menu: View {
    
    @Binding var isLoggedIn: Bool
    
    @Environment(\.managedObjectContext) private var viewContext
    
//    Build sort descriptor for FetchObjects to sort by title
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title",
                                 ascending: true,
                                 selector: #selector(NSString.localizedStandardCompare))]
    }
    
//    Create search variable for filtering FetchObjects
    @State var searchText = ""
    
    
//    Create predicate to filder FetchObjects with searchText variable
    func buildPredicate() -> NSPredicate {
//        empy searchText filters all dishes so return value: true if empty
        if searchText.isEmpty {
            return NSPredicate(value: true)
        } else {
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
    }
    
    
    var body: some View {
        VStack {
            Header(isLoggedIn: $isLoggedIn)
            VStack(alignment: .leading, spacing: 5) {
                HeroSection()
                TextField(" ...Search menu", text: $searchText)
                    .frame(width: 350, height: 40)
//                    .font(.body)
                    .background(Color.white)
//                    .foregroundColor(.black)
                    .cornerRadius(15)
                    .padding(8)
                }
            .frame(maxWidth: .infinity)
            .padding(.leading)
//            .foregroundColor(.white)
            .background(Color(red: 57, green: 76, blue: 69))
            
            
            FetchedObjects(predicate: buildPredicate(),
                           sortDescriptors: buildSortDescriptors(),
                           content: { (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                            VStack(alignment: .leading) {
                                Text((dish.title ?? ""))
                                Text("$" + (dish.price ?? ""))
                                Text((dish.descriptionDish ?? "Description"))
                                Text((dish.category ?? "Category"))
                                let imageURL = dish.image ?? ""
                                AsyncImage(url: URL(string: imageURL)!){ image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                } placeholder: {
                                    Image(systemName: "photo.fill")
                                }.frame(width: 250, height: 250)
                                
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
        Menu(isLoggedIn: .constant(true))
    }
}

extension Color {
    init(red: Int, green: Int, blue: Int) {
        self.init(red: Double(red) / 255.0, green: Double(green) / 255.0, blue: Double(blue) / 255.0)
    }
}




