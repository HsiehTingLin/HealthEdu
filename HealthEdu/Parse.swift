// Parse JSON 的 class

import Foundation


class Parse{
    static func parseJSONdata(jsonData: NSData?) -> NSArray? {
        
        do {
            let jsonArray = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers) as? NSArray
            // 暫時先把東西轉換成 array 以後應該是要用 Dictionary
            
            return jsonArray
            
        } catch let error as NSError {
            print("error processing json data: \(error.localizedDescription)")
        }
        
        return nil
        
    }
    
}