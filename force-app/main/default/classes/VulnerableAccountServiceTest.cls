@isTest
public class VulnerableAccountServiceTest {
    @isTest
    static void testCreateAccount() {
        // No input validation, creating an account with invalid data
        Test.startTest();
        VulnerableAccountService.createAccount('', '1234567890', 'Technology');
        Test.stopTest();
        
        // Check if account with blank name is created
        Account acc = [SELECT Id, Name, Phone, Industry FROM Account WHERE Phone = '1234567890'];
        System.assertNotEquals(null, acc.Id);
        System.assertEquals('', acc.Name);
    }
    
    @isTest
    static void testUpdateAccount() {
        // Create an account to update
        Account acc = new Account(Name = 'Update Test Account');
        insert acc;
        
        // Risk of SOQL injection, passing malicious input
        Test.startTest();
        VulnerableAccountService.updateAccount(acc.Id, '0987654321', 'Finance');
        Test.stopTest();
        
        // Verify the account was updated successfully
        Account updatedAcc = [SELECT Id, Phone, Industry FROM Account WHERE Id = :acc.Id];
        System.assertEquals('0987654321', updatedAcc.Phone);
        System.assertEquals('Finance', updatedAcc.Industry);
    }
    
    @isTest
    static void testDeleteAccount() {
        // Create an account to delete
        Account acc = new Account(Name = 'Delete Test Account');
        insert acc;
        
        // No error handling, attempting to delete
        Test.startTest();
        VulnerableAccountService.deleteAccount(acc.Id);
        Test.stopTest();
        
        // Verify the account was deleted successfully
        Account[] deletedAcc = [SELECT Id FROM Account WHERE Id = :acc.Id];
        System.assertEquals(0, deletedAcc.size());
    }
    
    @isTest
    static void testGetAllAccounts() {
        // Create multiple accounts
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 5; i++) {
            accounts.add(new Account(Name = 'Test Account ' + i));
        }
        insert accounts;
        
        // Test getAllAccounts without pagination
        Test.startTest();
        List<Account> retrievedAccou
