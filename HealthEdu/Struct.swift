//  分科的各科別基礎 struct 資料結構

import Foundation

class DivisionStruct {
    
    var id: String?
    var division: String?
    var domain: String?
    var description: String?
    
    init(id: String?, division: String?, domain: String? , description: String?)
    {
        self.id = id
        self.division = division
        self.domain = domain
        self.description = description
    }
    
}

class DomainAndDivisionStruct {
    
    var id: String?
    var domain: String?
    var division_data: [DivisionStruct?]
    
    init(id: String?, domain: String?, division_data: [DivisionStruct?])
    {
        self.id = id
        self.domain = domain
        self.division_data = division_data
    }
    
}