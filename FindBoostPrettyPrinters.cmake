#
# Copyright (c) 2024 Dmitry Arkhipov (grisumbras@yandex.ru)
#
# Distributed under the Boost Software License, Version 1.0. (See accompanying
# file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
#
# Official repository: https://github.com/cppalliance/pretty_printers
#

find_package(Python3 QUIET COMPONENTS Interpreter)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(BoostPrettyPrinters
    REQUIRED_VARS Python3_Interpreter_FOUND)

find_program(BoostPrettyPrinters_GDB gdb DOC "GDB executable tos use")
set(BoostPrettyPrinters_HAS_GDB "${BoostPrettyPrinters_GDB}")

set(BoostPrettyPrinters_GDB_EMBED_SCRIPT
    "${CMAKE_CURRENT_LIST_DIR}/embed-gdb-extension.py")
set(BoostPrettyPrinters_GDB_TEST_SCRIPT
    "${CMAKE_CURRENT_LIST_DIR}/generate-gdb-test-runner.py")
set(BoostPrettyPrinters_INCLUDES "${CMAKE_CURRENT_LIST_DIR}/include")

function(boost_pretty_printers_embed_gdb_extension)
    set(options EXCLUDE_FROM_ALL)
    set(oneValueArgs TARGET INPUT OUTPUT)
    set(multiValueArgs FLAGS)
    cmake_parse_arguments(BOOST_PPRINT_GDB_GEN
        "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})
    foreach(kw TARGET INPUT OUTPUT)
        if(NOT DEFINED "BOOST_PPRINT_GDB_GEN_${kw}")
            message(FATAL_ERROR "Argument ${kw} is required for function \
                boost_pretty_printers_embed_gdb_extension.")
        endif()
    endforeach()

    add_custom_command(
        OUTPUT "${BOOST_PPRINT_GDB_GEN_OUTPUT}"
        MAIN_DEPENDENCY "${BOOST_PPRINT_GDB_GEN_INPUT}"
        DEPENDS "${BoostPrettyPrinters_GDB_EMBED_SCRIPT}"
        COMMAND
            "${Python3_EXECUTABLE}"
            "${BoostPrettyPrinters_GDB_EMBED_SCRIPT}"
            "${CMAKE_CURRENT_SOURCE_DIR}/${BOOST_PPRINT_GDB_GEN_INPUT}"
            "${CMAKE_CURRENT_SOURCE_DIR}/${BOOST_PPRINT_GDB_GEN_OUTPUT}"
            ${BOOST_PPRINT_GDB_GEN_FLAGS}
        COMMENT "Generating ${BOOST_PPRINT_GDB_GEN_OUTPUT}")

    if(NOT BOOST_PPRINT_GDB_GEN_EXCLUDE_FROM_ALL)
        set(isInAll ALL)
    endif()
    add_custom_target(${BOOST_PPRINT_GDB_GEN_TARGET}
        ${isInAll}
        DEPENDS "${BOOST_PPRINT_GDB_GEN_OUTPUT}")
endfunction()


function(boost_pretty_printers_test_gdb_printers)
    set(options EXCLUDE_FROM_ALL)
    set(oneValueArgs TEST PROGRAM)
    set(multiValueArgs SOURCES)
    cmake_parse_arguments(BOOST_PPRINT_TEST_GDB
        "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})
    foreach(kw TEST SOURCES)
        if(NOT DEFINED "BOOST_PPRINT_TEST_GDB_${kw}")
            message(FATAL_ERROR "Argument ${kw} is required for function \
                boost_pretty_printers_test_gdb_printers.")
        endif()
    endforeach()

    if(NOT DEFINED BOOST_PPRINT_TEST_GDB_PROGRAM)
        set(BOOST_PPRINT_TEST_GDB_PROGRAM ${BOOST_PPRINT_TEST_GDB_TEST})
    endif()
    if(BOOST_PPRINT_TEST_GDB_EXCLUDE_FROM_ALL)
        set(excludeFromAll EXCLUDE_FROM_ALL)
    else()
        set(includeInAll ALL)
    endif()


    set(sources)
    foreach(src ${BOOST_PPRINT_TEST_GDB_SOURCES})
        get_filename_component(
            real_src "${src}" ABSOLUTE ${CMAKE_CURRENT_SOURCE_DIR})
        LIST(APPEND sources "${real_src}")
    endforeach()

    add_custom_command(
        OUTPUT "${BOOST_PPRINT_TEST_GDB_TEST}.py"
        DEPENDS ${sources}
        COMMAND
            "${Python3_EXECUTABLE}"
            "${BoostPrettyPrinters_GDB_TEST_SCRIPT}"
            ${sources}
            -o "${BOOST_PPRINT_TEST_GDB_TEST}.py"
        COMMENT "Generating ${BOOST_PPRINT_TEST_GDB_TEST}.py")

    add_custom_target(${BOOST_PPRINT_TEST_GDB_TEST}_runner
        ${includeInAll}
        DEPENDS "${BOOST_PPRINT_TEST_GDB_TEST}.py")

    add_executable(${BOOST_PPRINT_TEST_GDB_PROGRAM}
        ${excludeFromAll}
        ${BOOST_PPRINT_TEST_GDB_SOURCES})
    add_dependencies(
        ${BOOST_PPRINT_TEST_GDB_PROGRAM}
        ${BOOST_PPRINT_TEST_GDB_TEST}_runner)

    add_test(
        NAME ${BOOST_PPRINT_TEST_GDB_TEST}
        COMMAND "${BoostPrettyPrinters_GDB}"
            --batch-silent
            -x "${BOOST_PPRINT_TEST_GDB_TEST}.py"
            $<TARGET_FILE:${BOOST_PPRINT_TEST_GDB_PROGRAM}>)
endfunction()
