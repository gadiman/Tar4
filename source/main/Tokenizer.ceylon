
{String*} keywords={"class","constructor","function","method","field","static","var","int","char","boolean","void","true","false","null","this","let","do","if","else","while","return"};
shared String  tokenizer(String line) {
    variable String token ="";
    variable String result ="";
    result += "<tokens>\n";
    variable Integer index = 0;
    while(index != line.size){
        index++;
        token = line.substring(0,index);
        if(token == " ") {
            token = "";
        }
        else if(token == '"'.string){
            while(token.substring(index,index) != '"'.string)
            {
                index++;
                token = line.substring(0,index);
            }
            result += "<stringConstant>" + " " + token + " " + "</stringConstant>\n";
            token="";

        }
        else if("{}()[].,;+-*/&|<>=~".contains(token)){

            if (token == ">") {
                token = "&gt;";
            }
            if (token == "<") {
                token = "&lt;";
            }
            if (token == "&") {
                token = "&amp;";
            }
            if((token == '/'.string || token == "*") &&
                (token.substring(index,index+1) == "*"
                ||token.substring(index,index+1) == "/")){
                break;
            }
            result += "<symbol>" + " " + token + " " + "</symbol>";
            token ="";
        }
        else{
            if(token.substring(index,index+1) == " "||
             "{}()[].,;+-*/&|<>=~".contains(token.substring(index,index+1))){

                if(keywords.contains(token)){
                    result+= "<keyword>" + " " + token + " " + "</keyword>\n";
                }
                else if(exists num = parseInteger(token)){
                    result += "<integerConstant>" + " " + token + " " + "</integerConstant>\n";
                }
                else if(token != " "){
                    result += "<identifier>" + " " + token + " " + "</identifier>\n";
                }
                token ="";


            }

        }


    }
    result += "</tokens>";
    return result;
}