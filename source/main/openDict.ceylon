
import ceylon.file {
    File,
    parsePath,
    Directory
}

"Run the module `openDict`."

shared void openDict(String dictPath){

    value resource_ = parsePath(dictPath).resource;


    if (is Directory resource_) {
    Integer numOfVmFiles= resource_.childPaths("*.vm").size;//num of VM's files on directory
    variable String dict = resource_.string;//neme of directory

    for (path in resource_.childPaths("*.jack")) {
        String currentFilePhath = path.string;
        value pathOfF = parsePath(currentFilePhath).resource;

        readFile(currentFilePhath);
    }

        }
    }