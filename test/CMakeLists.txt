if(NOT BUILD_TESTING)
    return()
endif()

add_custom_target(tests)

add_test(
    NAME test-generate-gdb-header.py
    COMMAND "${Python3_EXECUTABLE}"
    ${CMAKE_CURRENT_SOURCE_DIR}/test-generate-gdb-header.py
    ${CMAKE_CURRENT_SOURCE_DIR}/../generate-gdb-header.py
    ${CMAKE_CURRENT_SOURCE_DIR}/gdb.py)


boost_pretty_printers_gdb_python_header(
    TARGET generate-gdb-hpp
    INPUT gdb.py
    OUTPUT include/testlib/gdb.hpp
    EXCLUDE_FROM_ALL)

add_library(testlib testlib.cpp)
target_include_directories(testlib PUBLIC include)
add_dependencies(testlib generate-gdb-hpp)

boost_pretty_printers_test_gdb_printers(
    TEST test_gdb
    SOURCES gdb.cpp)
target_link_libraries(test_gdb PRIVATE testlib)
add_dependencies(tests test_gdb)
