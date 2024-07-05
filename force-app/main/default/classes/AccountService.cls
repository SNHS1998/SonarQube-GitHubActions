public class AccountService {

    // Method to create a new Account
    public static Account createAccount(String name, String phone, String industry) {
        // Validate account name
        if (String.isBlank(name)) {
            throw new IllegalArgumentException('Account name cannot be blank');
        }

        // Create a new Account instance
        Account acc = new Account(Name = name, Phone = phone, Industry = industry);

        // Insert the Account and handle DML exceptions
        try {
            insert acc;
        } catch (DmlException e) {
            // Handle DML exception (log it, rethrow it, etc.)
            System.debug('Error inserting account: ' + e.getMessage());
            throw e;
        }

        return acc;
    }

    // Method to update an existing Account
    public static void updateAccount(Id accountId, String phone, String industry) {
        // Validate accountId
        if (accountId == null) {
            throw new IllegalArgumentException('Account ID cannot be null');
        }

        // Perform the SOQL query and handle exceptions
        Account acc;
        try {
            acc = [SELECT Id, Phone, Industry FROM Account WHERE Id = :accountId];
        } catch (QueryException e) {
            // Handle Query exception (log it, rethrow it, etc.)
            System.debug('Error querying account: ' + e.getMessage());
            throw e;
        }

        // Update fields if provided
        if (phone != null) {
            acc.Phone = phone;
        }
        if (industry != null) {
            acc.Industry = industry;
        }

        // Update the Account and handle DML exceptions checking exception
        try {
            update acc;
        } catch (DmlException e) {
            // Handle DML exception (log it, rethrow it, etc.)
            System.debug('Error updating account: ' + e.getMessage());
            throw e;
        }
    }

    // Method to delete an Account
    public static void deleteAccount(Id accountId) {
        // Validate accountId
        if (accountId == null) {
            throw new IllegalArgumentException('Account ID cannot be null');
        }

        // Perform the SOQL query and handle exceptions
        Account acc;
        try {
            acc = [SELECT Id FROM Account WHERE Id = :accountId];
        } catch (QueryException e) {
            // Handle Query exception (log it, rethrow it, etc.)
            System.debug('Error querying account: ' + e.getMessage());
            throw e;
        }

        // Delete the Account and handle DML exceptions check code quality 
        try {
            delete acc;
        } catch (DmlException e) {
            // Handle DML exception (log it, rethrow it, etc.)
            System.debug('Error deleting account: ' + e.getMessage());
            throw e;
        }
    }
}
