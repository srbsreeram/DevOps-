public class FirstApexClass {
    @InvocableMethod
    public static void updateAccountName(List<ID> ids){
        List<Account> accountToBeUpdated = new List<Account>();
        List<Account> accounts = [SELECT Name FROM Account WHERE Id in :ids];
        
        for (Account account : accounts){
            
            
            account.Name = account.Name + ' Name1';
            account.Name = account.Name + ' Name2';
            accountToBeUpdated.add(account);
        }
        update accountToBeUpdated;
    }
}