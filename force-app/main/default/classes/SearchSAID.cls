/*
@Author : Jyoti Tripathi
Description : To make the callout and get holidays and update the database with user data and searches count
Error Handling : Done on client side. The class will only receive a valid SA-ID.
               : Server side errors will be sent to client side and will be displayed there.
Assumptions    :
                1. Since the year of birth is only two digits, assuming if it is between 0-23, it is in 20's (example - 2013, 2009 etc)
                and if it is from 23-99, it is in 19s (example 1987, 1956 etc)
                2. The MMDD is used to find holidays in current year, and it is dynamic. 
Notes          : 1. There is no authentication, so no authorization is needed. The URL and it's parameters are stored in custom metadata.
                 2. Currently only SA is supported country, but it can be configured and the code is dynamic. Multiple countries can be supported with small 
                 tweaks in the logic.
                 3. The API key shared in requirement documents reached it's limit of callout, so I signed up and got my own API Key
*/

public without sharing class SearchSAID {
    //Constants
    private static final String MALE = 'MALE';
    private static final String FEMALE = 'FEMALE';
    private static final String OTHERS = 'OTHERS';
    private static final String PERMANENT_RESIDENT = 'PERMANENT RESIDENT';
    private static final String SA_CITIZEN = 'SA CITIZEN';

    // Cannot use cacheable = true, else it will throw error ->Too Many DML statements: 1
    @AuraEnabled
    public static OutputWrapper search(String saID) {
        // Parameters
        List<SAID_Search__c> record = new List<SAID_Search__c>();
        List<ResponseClassCal.Holidays> holidaysOnUserDOB = new List<ResponseClassCal.Holidays>();
        OutputWrapper finalReturnValue;
        List<showHoliday> skinnyHolidays = new List<showHoliday>();

        // Callout before DML to avoid incomplete transaction error.
        holidaysOnUserDOB = CalloutClass.getInfoFromExternalService(saID);

        //The JSON response hsa a bunch of details we don't need. So the skinny holidays extracts only what we need and in the right format
        for (ResponseClassCal.Holidays h : holidaysOnUserDOB) {
            Date temp = Date.newInstance(h.date_Z.Datetime_Z.year, h.date_Z.Datetime_Z.month, h.date_Z.Datetime_Z.day);
            skinnyHolidays.add(new showHoliday(h.name, h.description, h.type[0], temp));
        }

        // Check if the research search on a number is done earlier.
        record = [
            SELECT Id, Date_of_Birth_DOB__c, Gender__c, ID__c, Search_Counter__c, Citizenship_Status__c
            FROM SAID_Search__c
            WHERE ID__c = :saID
            LIMIT 1
        ];

        if (record.size() == 0) {
            record.add(parseSAID(saID));
            record[0].Search_Counter__c = 1;
            record[0].ID__c = saID;
        } else {
            record[0].Search_Counter__c += 1;
        }

        Database.upsert(record[0]);

        // Part of this final return variable comes from the object and part from outbound call, hence a seperate wrapper.
        finalReturnValue = new OutputWrapper(
            record[0].Date_of_Birth_DOB__c,
            record[0].Gender__c,
            record[0].Citizenship_Status__c,
            Integer.valueOf(record[0].Search_Counter__c),
            saID,
            skinnyHolidays
        );
        return finalReturnValue;
    }

    // Returns DOB of user from saID
    private static Date getDOB(String saID) {
        Date dob;
        Integer dobYear = Integer.valueOf(saID.mid(0, 2));
        Integer dobMonth = Integer.valueOf(saID.mid(2, 2));
        Integer dobDay = Integer.valueOf(saID.mid(4, 2));

        if (dobYear >= 0 && dobYear <= 23) {
            dobYear = Integer.valueOf(String.format('{0}{1}', new List<Object>{ '20', dobYear }));
        } else {
            dobYear = Integer.valueOf(String.format('{0}{1}', new List<Object>{ '19', dobYear }));
        }

        dob = Date.newInstance(Integer.valueOf(dobYear), dobMonth, dobDay);
        return dob;
    }

    // Extracting Gender from SAID
    private static String getGender(String saID) {
        if (Integer.valueOf(saID.mid(6, 4)) >= 0 && Integer.valueOf(saID.mid(6, 4)) <= 4999) {
            return FEMALE;
        } else if (Integer.valueOf(saID.mid(6, 4)) >= 5000 && Integer.valueOf(saID.mid(6, 4)) <= 9999) {
            return MALE;
        } else {
            return OTHERS;
        }
    }

    // Extracting citizenship
    private static String getCitizenship(String saID) {
        if (Integer.valueOf(saID.mid(9, 1)) == 0) {
            return SA_CITIZEN;
        } else if (Integer.valueOf(saID.mid(9, 1)) == 1) {
            return PERMANENT_RESIDENT;
        } else {
            return OTHERS;
        }
    }
    private static SAID_Search__c parseSAID(String saID) {
        SAID_Search__c toReturn = new SAID_Search__c();
        toReturn.Date_of_Birth_DOB__c = getDOB(saID);
        toReturn.Gender__c = getGender(saID);
        toReturn.Citizenship_Status__c = getCitizenship(saID);
        return toReturn;
    }
    public class showHoliday {
        @auraenabled
        public String nameH;
        @auraenabled
        public String descriptionH;
        @auraenabled
        public String typeH;
        @auraenabled
        public Date dateH;
        showHoliday(String nameP, String descriptionP, String typeP, Date dateP) {
            this.nameH = nameP;
            this.descriptionH = descriptionP;
            this.typeH = typeP;
            this.dateH = dateP;
        }
    }
    public class OutputWrapper {
        @auraenabled
        public Date dob;
        @auraenabled
        public String gender;
        @auraenabled
        public String citizen;
        @auraenabled
        public Integer searchCounter;
        @auraenabled
        public String saID;
        @auraenabled
        public List<showHoliday> holidayMessage;

        OutputWrapper(
            Date dob,
            String gender,
            String citizen,
            Integer searchCounter,
            String saID,
            List<showHoliday> holidayMessage
        ) {
            this.dob = dob;
            this.gender = gender;
            this.citizen = citizen;
            this.searchCounter = searchCounter;
            this.saID = saID;
            this.holidayMessage = holidayMessage;
        }
    }
}