/*
@Author : Jyoti Tripathi
Description : To make the callout and get holidays
*/

public class CalloutClass {
    public static List<ResponseClassCal.Holidays> getInfoFromExternalService(String saID) {
        List<Cal_API_Base_URL__mdt> endpointDetails = Cal_API_Base_URL__mdt.getAll().values();
        List<ResponseClassCal.Holidays> holidaysOnDOB = new List<ResponseClassCal.Holidays>();
        String currentYear = String.valueof(System.Today().year());
        Integer dobMonth = Integer.valueOf(saID.mid(2, 2));
        Integer dobDay = Integer.valueOf(saID.mid(4, 2));
        String formatEndpointURL = String.format(
            '{0}{1}{2}{3}{4}{5}{6}',
            new List<String>{
                endpointDetails[0].Base_URL__c,
                '&api_key=',
                endpointDetails[0].API_Key__c,
                '&country=',
                endpointDetails[0].Country__c,
                '&year=',
                currentYear
            }
        );
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setEndpoint(formatEndpointURL);
        HttpResponse res = new Http().send(req);

        // Replacing the JSON keys, as date and datetime are reserved keywords in system.
        String replaceReservedJOSN = res.getBody().replaceAll('"date"', '"Date_Z"');
        replaceReservedJOSN = replaceReservedJOSN.replaceAll('"datetime"', '"Datetime_Z"');
        ResponseClassCal obj = (ResponseClassCal) JSON.deserialize(replaceReservedJOSN, ResponseClassCal.class);

        for (ResponseClassCal.Holidays holidays : obj.Response.holidays) {
            if (
                Integer.valueOf(holidays.date_Z.Datetime_Z.year) == Integer.valueOf(currentYear) &&
                Integer.valueOf(holidays.date_Z.Datetime_Z.month) == dobMonth &&
                Integer.valueOf(holidays.date_Z.Datetime_Z.day) == dobDay
            ) {
                holidaysOnDOB.add(holidays);
            }
        }
        return holidaysOnDOB;
    }
}