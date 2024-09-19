if(NOT BUILD_TESTING)
    return()
endif()

add_custom_target(tests)

boost_pretty_printers_gdb_python_header(
    TARGET generate-gdb-hpp
    INPUT gdb.py
    OUTPUT gdb.hpp)

add_dependencies(tests generate-gdb-hpp)
