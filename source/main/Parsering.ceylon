import java.util {
    ArrayList,
    LinkedList
}
import ceylon.file {
    forEachLine
}

variable String result = "";
variable Integer currTok = 0;


shared String  parsering(String tokens) {

    String tmp = "<tokens>
                  <keyword> class </keyword>
                  <identifier> Main </identifier>
                  <symbol> { </symbol>
                  <keyword> function </keyword>
                  <keyword> void </keyword>
                  <identifier> main </identifier>
                  <symbol> ( </symbol>
                  <symbol> ) </symbol>
                  <symbol> { </symbol>
                  <keyword> var </keyword>
                  <identifier> Array </identifier>
                  <identifier> a </identifier>
                  <symbol> ; </symbol>
                  <keyword> var </keyword>
                  <keyword> int </keyword>
                  <identifier> length </identifier>
                  <symbol> ; </symbol>
                  <keyword> var </keyword>
                  <keyword> int </keyword>
                  <identifier> i </identifier>
                  <symbol> , </symbol>
                  <identifier> sum </identifier>
                  <symbol> ; </symbol>
                  <keyword> let </keyword>
                  <identifier> length </identifier>
                  <symbol> = </symbol>
                  <identifier> Keyboard </identifier>
                  <symbol> . </symbol>
                  <identifier> readInt </identifier>
                  <symbol> ( </symbol>
                  <stringConstant> HOW MANY NUMBERS?  </stringConstant>
                  <symbol> ) </symbol>
                  <symbol> ; </symbol>
                  <keyword> let </keyword>
                  <identifier> a </identifier>
                  <symbol> = </symbol>
                  <identifier> Array </identifier>
                  <symbol> . </symbol>
                  <identifier> new </identifier>
                  <symbol> ( </symbol>
                  <identifier> length </identifier>
                  <symbol> ) </symbol>
                  <symbol> ; </symbol>
                  <keyword> let </keyword>
                  <identifier> i </identifier>
                  <symbol> = </symbol>
                  <integerConstant> 0 </integerConstant>
                  <symbol> ; </symbol>
                  <keyword> while </keyword>
                  <symbol> ( </symbol>
                  <identifier> i </identifier>
                  <symbol> &lt; </symbol>
                  <identifier> length </identifier>
                  <symbol> ) </symbol>
                  <symbol> { </symbol>
                  <keyword> let </keyword>
                  <identifier> a </identifier>
                  <symbol> [ </symbol>
                  <identifier> i </identifier>
                  <symbol> ] </symbol>
                  <symbol> = </symbol>
                  <identifier> Keyboard </identifier>
                  <symbol> . </symbol>
                  <identifier> readInt </identifier>
                  <symbol> ( </symbol>
                  <stringConstant> ENTER THE NEXT NUMBER:  </stringConstant>
                  <symbol> ) </symbol>
                  <symbol> ; </symbol>
                  <keyword> let </keyword>
                  <identifier> i </identifier>
                  <symbol> = </symbol>
                  <identifier> i </identifier>
                  <symbol> + </symbol>
                  <integerConstant> 1 </integerConstant>
                  <symbol> ; </symbol>
                  <symbol> } </symbol>
                  <keyword> let </keyword>
                  <identifier> i </identifier>
                  <symbol> = </symbol>
                  <integerConstant> 0 </integerConstant>
                  <symbol> ; </symbol>
                  <keyword> let </keyword>
                  <identifier> sum </identifier>
                  <symbol> = </symbol>
                  <integerConstant> 0 </integerConstant>
                  <symbol> ; </symbol>
                  <keyword> while </keyword>
                  <symbol> ( </symbol>
                  <identifier> i </identifier>
                  <symbol> &lt; </symbol>
                  <identifier> length </identifier>
                  <symbol> ) </symbol>
                  <symbol> { </symbol>
                  <keyword> let </keyword>
                  <identifier> sum </identifier>
                  <symbol> = </symbol>
                  <identifier> sum </identifier>
                  <symbol> + </symbol>
                  <identifier> a </identifier>
                  <symbol> [ </symbol>
                  <identifier> i </identifier>
                  <symbol> ] </symbol>
                  <symbol> ; </symbol>
                  <keyword> let </keyword>
                  <identifier> i </identifier>
                  <symbol> = </symbol>
                  <identifier> i </identifier>
                  <symbol> + </symbol>
                  <integerConstant> 1 </integerConstant>
                  <symbol> ; </symbol>
                  <symbol> } </symbol>
                  <keyword> do </keyword>
                  <identifier> Output </identifier>
                  <symbol> . </symbol>
                  <identifier> printString </identifier>
                  <symbol> ( </symbol>
                  <stringConstant> THE AVERAGE IS:  </stringConstant>
                  <symbol> ) </symbol>
                  <symbol> ; </symbol>
                  <keyword> do </keyword>
                  <identifier> Output </identifier>
                  <symbol> . </symbol>
                  <identifier> printInt </identifier>
                  <symbol> ( </symbol>
                  <identifier> sum </identifier>
                  <symbol> / </symbol>
                  <identifier> length </identifier>
                  <symbol> ) </symbol>
                  <symbol> ; </symbol>
                  <keyword> do </keyword>
                  <identifier> Output </identifier>
                  <symbol> . </symbol>
                  <identifier> println </identifier>
                  <symbol> ( </symbol>
                  <symbol> ) </symbol>
                  <symbol> ; </symbol>
                  <keyword> return </keyword>
                  <symbol> ; </symbol>
                  <symbol> } </symbol>
                  <symbol> } </symbol>
                  </tokens>";

    value tmp_ =tmp.lines;
    value arrayOfTokens =  LinkedList<String>();

    for (token in tmp_.rest ){
        arrayOfTokens.add(token);
    }
    arrayOfTokens.remove(arrayOfTokens.last);



    classFun(arrayOfTokens);
    print(result);
    return result;

}

void classFun (LinkedList<String> tokens){
    result += "<class>\n";
    result += tokens.get(currTok++) + "\n"; //The word 'class'
    result += tokens.get(currTok++) + "\n"; //Name of the Class
    result += tokens.get(currTok++) + "\n"; //{

    classVarDecFun(tokens);
    subrotineDecFun(tokens);

    result += tokens.get(currTok++) + "\n"; //}
    result += "</class>\n";

}

void classVarDecFun (LinkedList<String> tokens) {

    while (tokens.get(currTok).contains("static") || tokens.get(currTok).contains("field")) {
        result += "<classVarDec>\n";
        result += tokens.get(currTok++) + "\n"; //The word 'static' or 'field'
        result += tokens.get(currTok++) + "\n"; //Type - int|boolean|ClassName
        result += tokens.get(currTok++) + "\n"; //varName -identifier

        while (tokens.get(currTok).contains(",")) {
            result += tokens.get(currTok++) + "\n"; // token --> ,
            result += tokens.get(currTok++) + "\n"; //varName -identifier
        }

        result += tokens.get(currTok++) + "\n"; // ;
        result += "</classVarDec>\n";
    }
}

void parameterListFunc(LinkedList<String> tokens){
    result += "<parameterList>\n";
    if(! tokens.get(currTok+1).contains(")")){ //if it dose so the Parm list is empty
        result += tokens.get(currTok++) + "\n"; // Type -identifier
        result += tokens.get(currTok++) + "\n"; //varName -identifier
    }

    while (tokens.get(currTok).contains(",")) {
        result += tokens.get(currTok++) + "\n"; // token --> ,
        result += tokens.get(currTok++) + "\n"; // Type -identifier
        result += tokens.get(currTok++) + "\n"; //varName -identifier
    }
    result += "</parameterList>\n";
}


void subrotineDecFun (LinkedList<String> tokens) {

    while(tokens.get(currTok).contains("constructor") ||
    tokens.get(currTok).contains("function") ||
    tokens.get(currTok).contains("method")) {

        result += "<subroutineDec>\n";
        result += tokens.get(currTok++) + "\n"; // Token for word function or constractor or method
        result += tokens.get(currTok++) + "\n"; //Token for word void or type(identifier)
        result += tokens.get(currTok++) + "\n"; //Name of the Subrotine
        result += tokens.get(currTok++) + "\n"; //token--> (

        parameterListFunc(tokens); //The Parm list

        result += tokens.get(currTok++) + "\n"; //token --> )

        subrutinBodyFunc(tokens); //body of func

        result += "</subroutineDec>\n";
    }

}

void subrutinBodyFunc(LinkedList<String> tokens){
    result += "<subroutineBody>\n";
    result += tokens.get(currTok++) + "\n"; //token --> {

    varDecFunc(tokens);
    statementsFunc(tokens);

    result += tokens.get(currTok++) + "\n"; //token --> {
    result += "</subroutineBody>\n";
}

void varDecFunc(LinkedList<String> tokens) {

    while (tokens.get(currTok).contains("var")) {
        result+= "<varDec>\n";
        result += tokens.get(currTok++) + "\n"; //The word 'var'
        result += tokens.get(currTok++) + "\n"; //Type - identifier
        result += tokens.get(currTok++) + "\n"; //varName -identifier

        while (tokens.get(currTok).contains(",")) {
            result += tokens.get(currTok++) + "\n"; // token --> ,
            result += tokens.get(currTok++) + "\n"; //varName -identifier
        }

        result += tokens.get(currTok++) + "\n"; // ;
        result+= "</varDec>\n";
    }
}

void statementsFunc(LinkedList<String> tokens) {

    result+= "<statements>\n";


    while(tokens.get(currTok).contains("let") ||
    tokens.get(currTok).contains("if") ||
    tokens.get(currTok).contains("while")||
    tokens.get(currTok).contains("do")||
    tokens.get(currTok).contains("return")){

        if(tokens.get(currTok).contains("let")){
            letStatementFunc(tokens);
        }else if(tokens.get(currTok).contains("if")){
            ifStatementFunc(tokens);
        }else if(tokens.get(currTok).contains("while")){
            whileStatementFunc(tokens);
        }else if(tokens.get(currTok).contains("do")){
            doStatementFunc(tokens);
        }else if(tokens.get(currTok).contains("return")){
            returnStatementFunc(tokens);
        }

    }
    result+= "</statements>\n";
}

void letStatementFunc(LinkedList<String> tokens) {
    result +="<letStatement>\n";

    result += tokens.get(currTok++) + "\n"; // Word 'let'
    result += tokens.get(currTok++) + "\n"; //varName -identifier

    if(tokens.get(currTok).contains("[")){
        result += tokens.get(currTok++) + "\n"; // token--> [
        expressionFunc(tokens);
        result += tokens.get(currTok++) + "\n"; //token-->]
    }

    result += tokens.get(currTok++) + "\n"; // token--> =
    expressionFunc(tokens);
    result += tokens.get(currTok++) + "\n"; // token--> ;

    result += "</letStatement>\n";
}

void ifStatementFunc(LinkedList<String> tokens) {
    result +="<ifStatement>\n";
    result += tokens.get(currTok++) + "\n"; // Word 'if'
    result += tokens.get(currTok++) + "\n"; // token--> (
    expressionFunc(tokens);
    result += tokens.get(currTok++) + "\n"; // token--> )
    result += tokens.get(currTok++) + "\n"; // token--> {
    statementsFunc(tokens);
    result += tokens.get(currTok++) + "\n"; // token--> }

    if(tokens.get(currTok).contains("else")){
        result += tokens.get(currTok++) + "\n"; // Word 'else'
        result += tokens.get(currTok++) + "\n"; // token--> {
        statementsFunc(tokens);
        result += tokens.get(currTok++) + "\n"; // token--> }
    }
    result += "</ifStatement>\n";
}

void whileStatementFunc(LinkedList<String> tokens) {
    result +="<whileStatement>\n";
    result += tokens.get(currTok++) + "\n"; // Word 'While'
    result += tokens.get(currTok++) + "\n"; // token--> (
    expressionFunc(tokens);
    result += tokens.get(currTok++) + "\n"; // token--> )
    result += tokens.get(currTok++) + "\n"; // token--> {
    statementsFunc(tokens);
    result += tokens.get(currTok++) + "\n"; // token--> }
    result += "</whileStatement>\n";
}

void doStatementFunc(LinkedList<String> tokens) {
    result +="<doStatement>\n";

    result += tokens.get(currTok++) + "\n"; // Word 'do'
    subrotineCallFunc(tokens);
    result += tokens.get(currTok++) + "\n"; // token--> ;

    result += "</dotStatement>\n";

}

void returnStatementFunc(LinkedList<String> tokens) {
    result +="<returnStatement>\n";
    result += tokens.get(currTok++) + "\n"; // Word 'return'

    if(!tokens.get(currTok).contains(";")){
        expressionFunc(tokens);
    }
    result += tokens.get(currTok++) + "\n"; // token--> ;
    result += "</returnStatement>\n";
}

void expressionFunc(LinkedList<String> tokens) {
    result += "<expression>\n";
    termFunc(tokens);

    while (tokens.get(currTok).contains("+") ||
    tokens.get(currTok).contains("-") ||
    tokens.get(currTok).contains("*") ||
    tokens.get(currTok).contains("> / <")||
    tokens.get(currTok).contains("&amp") ||
    tokens.get(currTok).contains("|") ||
    tokens.get(currTok).contains("&lt") ||
    tokens.get(currTok).contains("&gt")||
    tokens.get(currTok).contains("=")) {

        result += tokens.get(currTok++) + "\n"; // op token
        termFunc(tokens);
    }

    result += "</expression>\n";
}

void subrotineCallFunc(LinkedList<String> tokens) {

    result += "<subrotineCall>\n";

    if(! tokens.get(currTok+1).contains("("))
    {
        result += tokens.get(currTok++) + "\n"; // Name of subroutin
        result += tokens.get(currTok++) + "\n"; // token--> (
        expressionListFunc(tokens);
        result += tokens.get(currTok++) + "\n"; // token--> )

    }
    else
    {
        result += tokens.get(currTok++) + "\n"; // Name of class or var
        result += tokens.get(currTok++) + "\n"; // token--> .
        result += tokens.get(currTok++) + "\n"; // token--> Name of subroutin
        result += tokens.get(currTok++) + "\n"; // token--> (
        expressionListFunc(tokens);
        result += tokens.get(currTok++) + "\n"; // token--> )
    }

    result += "</subrotineCall>\n";

}

void termFunc(LinkedList<String> tokens) {
    result += "<term>\n";



    result += "</term>\n";
}

void expressionListFunc(LinkedList<String> tokens) {
    result += "<expressionList>";
    if(!tokens.get(currTok).contains(")")){
        result += tokens.get(currTok++) + "\n"; // token--> ,
        expressionFunc(tokens);
    }
    result += "</expressionList>";
}
