
import Foundation
import UIKit

//MARK: String Extension

public extension String
{
    // MARK: Public Helper Variable
    
    var length: Int { return self.count }
    
    var localized: String? {
        return NSLocalizedString(self, comment: "")
    }
    
    var doubleValue: Double {
        return (self as NSString).doubleValue
    }
    
    // MARK: Public Helper Method
    
    func view(bundle:Bundle? = Bundle.main) -> UIView?
    {
        var view:UIView? = nil
      
        // I assume, that there is only one root view in interface file
        let loadedObjects = bundle!.loadNibNamed(self, owner: nil, options: nil);
        
        view = loadedObjects?.last as? UIView;
        
        return view;
    }
    
    /* Check string is empty or not*/
    public func isNotEmpty() -> Bool
    {
        return !(self.trim().count == 0)
    }

    
    /* Add $ Sing */
    func addCurrencySing() -> String {
        
        let str = self.removeCurrencySing()
        
        if self.isNotEmpty() {
            return String(format:"%@%0.2lf", "€", Double(str)!)
        }
        
        return self
    }
    
    /* Remove $ Sing */
    func removeCurrencySing() -> String {
        
        if self.isNotEmpty() {
            return self.replaceString(target: "€", with: "").trim()
        }
        
        return self
    }
    
    /* Trunc String */
    func trunc(_ length: Int) -> String {
        if self.count > length {
            return self.substring(to: self.index(self.startIndex, offsetBy: length))
        } else {
            return self
        }
    }
    
    /* Convert To Boolean */
    func toBool() -> Bool {
        switch self {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return false
        }
    }
    
    /* Trim String */
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }

    /* Split String */
    public func split(separator:String) -> [String]
    {
        return self.components(separatedBy: separator);
    }
    
    /* ReplaceComma in string */
    public func replaceComma() -> String
    {
        if self.isNotEmpty()
        {
            return self.replaceString(target: "'", with: "''")
        }
        return ""
    }
    
    /* Replace String */
    public func replaceString(target:String, with:String) -> String
    {
        return self.replacingOccurrences(of: target, with: with)
    }
    
    /* Convert NSRange to Range */
    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = from16.samePosition(in: self),
            let to = to16.samePosition(in: self)
            else { return nil }
        return from ..< to
    }
    
    /* Conver Range to NSRange */
    func nsRange(from range: Range<String.Index>) -> NSRange {
        
        return NSRange(range, in: self)
      
    }
    
    /* Check input email is valid or not */
    public func isEmail() -> Bool
    {
        return NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}").evaluate(with: self)
    }
    
    /* Encoding URL */
    func URLEncodedString() -> String? {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }
    
    /* remove html tags */
    public func fromHtml() -> String
    {
        var s = self.copy() as! String;
        
        while(s.range(of:"<[^>]+>", options:.regularExpression) != nil)
        {
            s = s.replacingCharacters(in: s.range(of: "<[^>]+>", options: .regularExpression)!, with: "")
        }
        
        return s;
    }
    
    /* Check Russian Char */
    public func hasRussianCharacters() -> Bool
    {
        let set = CharacterSet(charactersIn: "абвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ")
        return self.rangeOfCharacter(from: set) != nil;
    }
    
    /* Check English Char */
    public func hasEnglishCharacters() -> Bool
    {
        let set = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
        return self.rangeOfCharacter(from: set) != nil;
    }
    
    func beginsWith (_ str: String) -> Bool {
        if let range = self.range(of:str) {
            return range.lowerBound == self.startIndex
        }
        return false
    }
    
    func endsWith (_ str: String) -> Bool {
        if let range = self.range(of:str) {
            return range.upperBound == self.endIndex
        }
        return false
    }

    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return boundingBox.height
    }
    
    // MARK: Pref File Helper Method
    
    func set(Value value:Any)
    {
        UserDefaults.standard.setValue(value, forKey: self);
        UserDefaults.standard.synchronize();
    }
    
    func get(DefaultValue defaultValue:String?) -> String?
    {
        let value:String? = UserDefaults.standard.object(forKey: self) as? String;
        return (value != nil) ? value : defaultValue;
    }
    
    func get(DefaultObject defaultObject:Any?) -> Any?
    {
        let value:Any? = UserDefaults.standard.object(forKey: self);
        return (value != nil) ? value : defaultObject;
    }
    
    func removeValue()
    {
        UserDefaults.standard.removeObject(forKey: self);
        UserDefaults.standard.synchronize();
    }
}
