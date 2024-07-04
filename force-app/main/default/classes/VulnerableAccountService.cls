public class VulnerableAccountService {
    // Method to create a new Account
    public static void createAccount(String name, String phone, String industry) {
        // No input validation or exception handling
        Account acc = new Account(Name = name, Phone = phone, Industry = industry);
        insert acc; // No error handling
    }
    
    // Method to update an existing Account
    public static void updateAccount(String accountId, String phone, String industry) {
        // SOQL query inside a loop (bad practice if there was a loop)
        String query = 'SELECT Id, Phone, Industry FROM Account WHERE Id = \'' + accountId + '\'';
        Account acc = Database.query(query); // Risk of SOQL injection
        
        // Direct field assignment without validation
        acc.Phone = phone;
        acc.Industry = industry;
        
        update acc; // No error handling
    }
    
    // Method to delete an Account
    public static void deleteAccount(String accountId) {
        // SOQL query inside a loop (bad practice if there was a loop)
        Account acc = [SELECT Id FROM Account WHERE Id = :accountId];
        delete acc; // No error handling
    }
    
    // Method to retrieve accounts (returns all records, no pagination)
    public static List<Account> getAllAccounts() {
        return [SELECT Id, Name, Phone, Industry FROM Account];
    }
}
