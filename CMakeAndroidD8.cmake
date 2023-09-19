macro(CMakeAndroidD8)
    set(${PROJECT_NAME}_m_evacu ${m})
    set(m ${PROJECT_NAME}.CMakeAndroidD8)
    list(APPEND ${m}_unsetter  ${m}_REQUIRED ${m}_build_type ${m}_DEBUG ${m}_FILES ${m}_D8 ${m}_RELEASE ${m}_CLASSPASS ${m}_DESTINATION ${m}_WORKING_DIRECTORY ${m}_DEBUG_VERBOSE)
    cmake_parse_arguments(${m} "REQUIRED;RELEASE;DEBUG;DEBUG_VERBOSE" "D8;DESTINATION;WORKING_DIRECTORY;" "CLASSPASS;FILES" ${ARGV})
    
    if(${${m}_DEBUG_VERBOSE})
        include(CMakePrintHelpers)
        foreach(__var ${${m}_unsetter})
            cmake_print_variables(${__var})
        endforeach()
    endif()
    
    if(NOT DEFINED ${${m}_WORKING_DIRECTORY})
        set(${m}_WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR})
    endif()
    
    if(NOT DEFINED ${${m}_DESTINATION})
        set(${m}_DESTINATION ${CMAKE_CURRENT_LIST_DIR})
    endif()
    
    set(${m}_build_type --debug)
    if(DEFINED ${m}_RELEASE)
        set(${m}_build_type --release)
    endif()
    
    
    list(JOIN ${m}_CLASSPASS ";--classpath;" ${m}_CLASSPASS)
    set(${m}_CLASSPASS --classpath ${${m}_CLASSPASS})
    
    execute_process(
        COMMAND 
            "${${m}_D8}" 
            ${${m}_build_type}
            ${${m}_CLASSPASS}
            --output "${${m}_DESTINATION}"
            ${${m}_FILES}
        RESULT_VARIABLE CMakeAndroidD8.last_result
        OUTPUT_VARIABLE CMakeAndroidD8.last_output
        ERROR_VARIABLE CMakeAndroidD8.last_error
        WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}
    )
    
    if(NOT ${CMakeAndroidD8.last_result} EQUAL 0)
        string(APPEND ${m}_msg "[result] : ${CMakeAndroidD8.last_result}\n" "[output] : ${CMakeAndroidD8.last_output}\n" "[error]  : ${CMakeAndroidD8.last_error}\n")
        if(${${m}_REQUIRED})
            message(FATAL_ERROR ${m}_msg)
        else()
            message(WARNING ${m}_msg)
        endif()
    endif()
    
    
    foreach(__v ${${m}_unsetter})
        unset(${__v})
    endforeach()
    unset(${m}_unsetter)
    set(m ${${PROJECT_NAME}_m_evacu})
endmacro()
