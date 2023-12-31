//
// Generated by JSON2Apex http://json2apex.herokuapp.com/
//
// The supplied json has fields with names that are not valid in apex
// and so can only be parsed with explicitly generated code, this option
// was auto selected for you.

public class ResponseClassCal {

    public class Timezone {
        public String offset {get;set;} 
        public String zoneabb {get;set;} 
        public Integer zoneoffset {get;set;} 
        public Integer zonedst {get;set;} 
        public Integer zonetotaloffset {get;set;} 

        public Timezone(JSONParser parser) {
            while (parser.nextToken() != System.JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                        if (text == 'offset') {
                            offset = parser.getText();
                        } else if (text == 'zoneabb') {
                            zoneabb = parser.getText();
                        } else if (text == 'zoneoffset') {
                            zoneoffset = parser.getIntegerValue();
                        } else if (text == 'zonedst') {
                            zonedst = parser.getIntegerValue();
                        } else if (text == 'zonetotaloffset') {
                            zonetotaloffset = parser.getIntegerValue();
                        } else {
                            System.debug(LoggingLevel.WARN, 'Timezone consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    public class Response {
        public List<Holidays> holidays {get;set;} 

        public Response(JSONParser parser) {
            while (parser.nextToken() != System.JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                        if (text == 'holidays') {
                            holidays = arrayOfHolidays(parser);
                        } else {
                            System.debug(LoggingLevel.WARN, 'Response consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    public Meta meta {get;set;} 
    public Response response {get;set;} 

    public ResponseClassCal(JSONParser parser) {
        while (parser.nextToken() != System.JSONToken.END_OBJECT) {
            if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                String text = parser.getText();
                if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                    if (text == 'meta') {
                        meta = new Meta(parser);
                    } else if (text == 'response') {
                        response = new Response(parser);
                    } else {
                        System.debug(LoggingLevel.WARN, 'ResponseClassCal consuming unrecognized property: '+text);
                        consumeObject(parser);
                    }
                }
            }
        }
    }
    
    public class Meta {
        public Integer code {get;set;} 

        public Meta(JSONParser parser) {
            while (parser.nextToken() != System.JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                        if (text == 'code') {
                            code = parser.getIntegerValue();
                        } else {
                            System.debug(LoggingLevel.WARN, 'Meta consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    public class Holidays {
        public String name {get;set;} 
        public String description {get;set;} 
        public Country country {get;set;} 
        public Date_Z date_Z {get;set;} // in json: date
        public List<String> type {get;set;} 
        public String primary_type {get;set;} 
        public String canonical_url {get;set;} 
        public String urlid {get;set;} 
        public String locations {get;set;} 
        public String states {get;set;} 

        public Holidays(JSONParser parser) {
            while (parser.nextToken() != System.JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                        if (text == 'name') {
                            name = parser.getText();
                        } else if (text == 'description') {
                            description = parser.getText();
                        } else if (text == 'country') {
                            country = new Country(parser);
                        } else if (text == 'date') {
                            date_Z = new Date_Z(parser);
                        } else if (text == 'type') {
                            type = arrayOfString(parser);
                        } else if (text == 'primary_type') {
                            primary_type = parser.getText();
                        } else if (text == 'canonical_url') {
                            canonical_url = parser.getText();
                        } else if (text == 'urlid') {
                            urlid = parser.getText();
                        } else if (text == 'locations') {
                            locations = parser.getText();
                        } else if (text == 'states') {
                            states = parser.getText();
                        } else {
                            System.debug(LoggingLevel.WARN, 'Holidays consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    public class Country {
        public String id {get;set;} 
        public String name {get;set;} 

        public Country(JSONParser parser) {
            while (parser.nextToken() != System.JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                        if (text == 'id') {
                            id = parser.getText();
                        } else if (text == 'name') {
                            name = parser.getText();
                        } else {
                            System.debug(LoggingLevel.WARN, 'Country consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    public class Datetime_Z {
        public Integer year {get;set;} 
        public Integer month {get;set;} 
        public Integer day {get;set;} 

        public Datetime_Z(JSONParser parser) {
            while (parser.nextToken() != System.JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                        if (text == 'year') {
                            year = parser.getIntegerValue();
                        } else if (text == 'month') {
                            month = parser.getIntegerValue();
                        } else if (text == 'day') {
                            day = parser.getIntegerValue();
                        } else {
                            System.debug(LoggingLevel.WARN, 'Datetime_Z consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    public class Date_Y {
        public String iso {get;set;} 
        public Datetime_Y datetime_Z {get;set;} // in json: datetime
        public Timezone timezone {get;set;} 

        public Date_Y(JSONParser parser) {
            while (parser.nextToken() != System.JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                        if (text == 'iso') {
                            iso = parser.getText();
                        } else if (text == 'datetime') {
                            datetime_Z = new Datetime_Y(parser);
                        } else if (text == 'timezone') {
                            timezone = new Timezone(parser);
                        } else {
                            System.debug(LoggingLevel.WARN, 'Date_Y consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    public class Date_Z {
        public String iso {get;set;} 
        public Datetime_Z datetime_Z {get;set;} // in json: datetime

        public Date_Z(JSONParser parser) {
            while (parser.nextToken() != System.JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                        if (text == 'iso') {
                            iso = parser.getText();
                        } else if (text == 'datetime') {
                            datetime_Z = new Datetime_Z(parser);
                        } else {
                            System.debug(LoggingLevel.WARN, 'Date_Z consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    public class Datetime_Y {
        public Integer year {get;set;} 
        public Integer month {get;set;} 
        public Integer day {get;set;} 
        public Integer hour {get;set;} 
        public Integer minute {get;set;} 
        public Integer second {get;set;} 

        public Datetime_Y(JSONParser parser) {
            while (parser.nextToken() != System.JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                        if (text == 'year') {
                            year = parser.getIntegerValue();
                        } else if (text == 'month') {
                            month = parser.getIntegerValue();
                        } else if (text == 'day') {
                            day = parser.getIntegerValue();
                        } else if (text == 'hour') {
                            hour = parser.getIntegerValue();
                        } else if (text == 'minute') {
                            minute = parser.getIntegerValue();
                        } else if (text == 'second') {
                            second = parser.getIntegerValue();
                        } else {
                            System.debug(LoggingLevel.WARN, 'Datetime_Y consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    
    public static ResponseClassCal parse(String json) {
        System.JSONParser parser = System.JSON.createParser(json);
        return new ResponseClassCal(parser);
    }
    
    public static void consumeObject(System.JSONParser parser) {
        Integer depth = 0;
        do {
            System.JSONToken curr = parser.getCurrentToken();
            if (curr == System.JSONToken.START_OBJECT || 
                curr == System.JSONToken.START_ARRAY) {
                depth++;
            } else if (curr == System.JSONToken.END_OBJECT ||
                curr == System.JSONToken.END_ARRAY) {
                depth--;
            }
        } while (depth > 0 && parser.nextToken() != null);
    }
    




    private static List<String> arrayOfString(System.JSONParser p) {
        List<String> res = new List<String>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(p.getText());
        }
        return res;
    }











    private static List<Holidays> arrayOfHolidays(System.JSONParser p) {
        List<Holidays> res = new List<Holidays>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Holidays(p));
        }
        return res;
    }


}