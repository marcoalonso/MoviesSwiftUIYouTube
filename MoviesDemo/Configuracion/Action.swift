//
//  Action.swift
//  MoviesDemo
//
//  Created by Marco Alonso Rodriguez on 31/01/24.
//

import Foundation

struct Action: Identifiable {
    let id = UUID()
    let name: String
    let action: String
    let icon: String
    let url: String
}

var informationActions: [Action] = [
Action(name: "Hacer una sugerencia", action: "sugerencia", icon: "slider.vertical.3", url: "https://forms.gle/guA95kfHXphQHgbx5"),
Action(name: "Califica la aplicación", action: "califica", icon: "star.leadinghalf.filled", url: "https://apps.apple.com/us/app/top-global-news/id6447653915"),
Action(name: "iOS Bootcamp Mx - Facebook", action: "seguir", icon: "hand.thumbsup", url: "https://www.facebook.com/people/IOS-Bootcamp-Mx/100090332195526/"),
Action(name: "iOS Bootcamp Mx - LinkedIn", action: "seguir", icon: "apps.iphone", url: "https://www.linkedin.com/company/ios-bootcamp-mx"),
Action(name: "Desarrollador", action: "developer", icon: "person", url: "https://github.com/marcoalonso"),
Action(name: "YouTube Channel", action: "developer", icon: "apps.iphone", url: "https://www.youtube.com/@marcoalonso3284")
]

var cines: [Action] = [
    Action(name: "Cinepolis", action: "", icon: "ticket", url: "https://cinepolis.com/"),
    Action(name: "Cinemex", action: "", icon: "ticket", url: "https://cinemex.com/"),
    Action(name: "Sensacine", action: "", icon: "ticket", url: "https://www.sensacine.com.mx/")
    
]
