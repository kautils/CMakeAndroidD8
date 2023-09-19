### CMakeAndroidD8
* generate dex file using d8 internally

### note 
* D8 : path to d8[.bat|.sh] in ${android_sdk}/build_tools/version
* RELEASE | DEBUG : --release | --debug 
* CLASSPASS : --classpath arg --classpath arg ...
* DESTINATION : where classes.dex generated into
* FILES : class files or jar files
* WORKING_DIRECTORY : working directory for execute_process. the default is "${CMAKE_CURRENT_LIST_DIR}"
* REQUIRED : if execute_process not to return 0, causes fatal error.

### example
```cmake
include(CMakeAndroidD8.cmake)

# d8 --release --classpath "${sdk.android_jar}" --classpath "./libs/*" --output . ${__class_jars} ${__libs_jars} 
CMakeAndroidD8(
    D8 "${sdk.d8}"
    RELEASE
    CLASSPASS "${sdk.android_jar}" "./libs/*"
    DESTINATION .
    FILES ${__class_jars} ${__libs_jars}
    WORKING_DIRECTORY "${CMAKE_CURRENT_LIST_DIR}"
    REQUIRED
)

```