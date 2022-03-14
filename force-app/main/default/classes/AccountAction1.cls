public class AccountAction1 {
	@InvocableMethod
    public static void updateAccountName(List<ID> ids){
        List<Account> accountToBeUpdated = new List<Account>();
        List<Account> accounts = [SELECT Name FROM Account WHERE Id in :ids];
        
        for (Account account : accounts){
            
            account.Name = account.Name + ' Name';
            accountToBeUpdated.add(account);
        }
        update accountToBeUpdated;
    }
}