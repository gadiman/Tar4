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

}
    Resource resource = parsePath(filePath).resource;
    if (is File resource) {
        variable String textOfFile="";
        variable String tokens="";

        variable String dict = resource.directory.string;

        value index =resource.name.indexOf(".");
        variable String nameOfFile = resource.name.substring(0,index);

        forEachLine(resource, (String line) {
            tokens + = makeTokens(line);
        }

        //Print a XML file for Tokens
        String pathForXmlFile = changeNameOfSuffix(resource.name,dict);
        writeFileXml(pathForXmlFile,textOfFile);

        //Parser
        textOfFile = makeParsering(tokens);

        //Print a Tree
        pathForXmlFile = changeNameOfSuffix(resource.name,dict);
        writeFileXml(pathForXmlFile,textOfFile);
        textOfFile ="";

}

String changeNameOfSuffix(String name,String dict,Bollean isTokens){
    value index =name.indexOf(".");
    variable String newName = name.substring(0,index);
    newName+=".xml";
    if(!isTokens)
        return dict+"\\" +newName;

     return dict+"\\" + "T" + newName;
}

String makeTokens(String line){
  //return String of tokens for the current line
}

String makeParsering(String tokens){
   // return the tree
}


