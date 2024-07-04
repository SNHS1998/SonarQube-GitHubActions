public class AccountService {
    // Method to create a new Account
    public static Account createAccount(String name, String phone, String industry) {
        if (String.isBlank(name)) {
            throw new IllegalArgumentException('Account name cannot be blank');
        }
        
        Account acc = new Account(Name = name, Phone = phone, Industry = industry);
        insert acc;
        return acc;
    }
    
    // Method to update an existing Account
    public static void updateAccount(Id accountId, String phone, String industry) {
        Account acc = [SELECT Id, Phone, Industry FROM Account WHERE Id = :accountId];
        
        if (phone != null) {
            acc.Phone = phone;
        }
        if (industry != null) {
            acc.Industry = industry;
        }
        
        update acc;
    }
    
    // Method to delete an Account
    public static void deleteAccount(Id accountId) {
        Account acc = [SELECT Id FROM Account WHERE Id = :accountId];
        delete acc;
    }
}