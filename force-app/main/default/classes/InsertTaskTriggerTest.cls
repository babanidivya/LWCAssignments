@isTest
public class InsertTaskTriggerTest {
    @testSetup
    static void setup() {
        Account testAccount = new Account();
        testAccount.Name='Test Account' ;
        insert testAccount;

    }
    
    @isTest static void testInsert() {
        test.startTest();
        Id acId = [SELECT id from Account where name='Test Account'].id;
        List<Event> events = new List<Event>{};
        for(Integer i = 0; i < 200; i++) {
            Event evt = new Event(WhatId=acId,
        						  StartDateTime=system.today(),
                                  EndDateTime=system.today()+5
                                 );
            events.add(evt);
        }
        insert events;
        test.stopTest();
    }
}