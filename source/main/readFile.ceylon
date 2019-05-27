import ceylon.file {
    forEachLine,
    Resource,
    File,
    parsePath,
    lines,
    Directory,
    Visitor,
    home
}

shared void readFile(String filePath) {


    Resource resource = parsePath(filePath).resource;

    if (is File resource) {

        variable String textOfFile=""; //fainel result
        variable String tokens="";

        variable String pathForXmlFile ="";
        variable String dict = resource.directory.string;

        value index =resource.name.indexOf(".");
        variable String nameOfFile = resource.name.substring(0,index);

        forEachLine(resource, (String line) {
            String result = makeTokens(line);
            if(result != ""){
                tokens +=result;
            }
        });

        //Print a XML file for Tokens
        pathForXmlFile = changeNameOfSuffix(resource.name,dict,true);
        writeFileXml(pathForXmlFile,textOfFile);

        //Parser
        textOfFile = tokenizer(tokens);

        //Print a Tree
        pathForXmlFile = changeNameOfSuffix(resource.name,dict,false);
        writeFileXml(pathForXmlFile,textOfFile);
        textOfFile ="";
    }

}



String changeNameOfSuffix(String name,String dict,Boolean isTokens){
    value index =name.indexOf(".");
    variable String newName = name.substring(0,index);
    newName+=".xml";
    if(!isTokens) {
        return dict + "\\" + newName;
    }

     return dict+"\\" + "T" + newName;
}

String makeTokens(String line){
  //return String of tokens for the current line
    return "";
}

String makeParsering(String line){
   // return the tree

    variable Integer index =0;
    variable String tmp ="";
    tmp =line;
    while(tmp.startsWith(" ")){
        index++;
        tmp = tmp.substring(index);
    }
    if(line.startsWith("/")||line.startsWith("*")||line.empty){
        return "";
    }
    return parsering(line.substring(index));
}



