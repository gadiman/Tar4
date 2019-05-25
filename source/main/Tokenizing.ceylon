import ceylon.file {
    forEachLine,
    Resource,
    File,
    parsePath,
    Nil,
    lines,
    Directory,
    Visitor,
    home
}
 class Tokenizing()
 {
     String symbol = "{}()[].,;+-*/&|<>=~";
     {String*} keyword = {
         "class", "constructor", "function",
         "method", "field", "static", "var",
         "int", "char", "boolean", "void",
         "true", "false", "null", "this",
         "let", "do", "if", "else", "while", "return"
     };
     String getToken(variable String  token) {
             value tok => if (symbol.contains(token))
                    then checkspaicel(token)
             else if (keyword.contains(token))
                    then "keyword"
             else if (exists number = parseInteger(token))
                    then "integerConstant"
             else if (!token.empty)
             then idOrConstat(token)
             else "";
         return tok;
     }
     String checkspaicel(String str){
         value spaicel =>
                 if (str == ">")  then  "&gt"
         else if (str == "<")     then  "&lt"
             else if (str == "&") then  "&amp"
         else                            str;
         return spaicel;
     }
     String idOrConstat( String str) {
         variable Integer i = 0;
         variable Integer check = 0;
         for (chr in str){
             if (chr == '"'&& (i == 0 ||i==str.size-1)){
                 check=check+1;
             }
             i = i + 1;
         }
         if(check==2){
             return "StringConstant";
         }
         return "identifier";
     }

 }






