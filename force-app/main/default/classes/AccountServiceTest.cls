@isTest
public class AccountServiceTest {
    @isTest
    static void testCreateAccount() {
        // Positive test case for createAccount
        Test.startTest();
        Account acc = AccountService.createAccount('Test Account', '1234567890', 'Technology');
        Test.stopTest();
        
        // Verify the account was created successfully
        Account retrievedAcc = [SELECT Id, Name, Phone, Industry FROM Account WHERE Id = :acc.Id];
        System.assertNotEquals(null, retrievedAcc);
        System.assertEquals('Test Account', retrievedAcc.Name);
        System.assertEquals('1234567890', retrievedAcc.Phone);
        System.assertEquals('Technology', retrievedAcc.Industry);
    }
    
    @isTest
    static void testUpdateAccount() {
        // Create an account to update
        Account acc = new Account(Name = 'Update Test Account');
        insert acc;
        
        // Positive test case for updateAccount
        Test.startTest();
        AccountService.updateAccount(acc.Id, '0987654321', 'Finance');
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
        
        // Positive test case for deleteAccount
        Test.startTest();
        AccountService.deleteAccount(acc.Id);
        Test.stopTest();
        
        // Verify the account was deleted successfully
        Account[] deletedAcc = [SELECT Id FROM Account WHERE Id = :acc.Id];
        System.assertEquals(0, deletedAcc.size());
    }
    
    @isTest
    static void testCreateAccountInvalidName() {
        // Negative test case for createAccount with invalid name
        Test.startTest();
        try {
            AccountService.createAccount('', '1234567890', 'Technology');
            System.assert(false, 'Expected IllegalArgumentException was not thrown');
        } catch (IllegalArgumentException e) {
            System.assertEquals('Account name cannot be blank', e.getMessage());
        }
        Test.stopTest();
    }
}
