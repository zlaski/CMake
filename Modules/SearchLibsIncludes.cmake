# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.
#
# This is a universal helper module for searching for include paths
# a libraries for module ${FLI_MODULE}
#
# Written by Ziemowit Laski (zlaski@ziemas.net)

MESSAGE(STATUS "Looking for module ${FLI_MODULE} . . .")

string(TOUPPER ${FLI_MODULE}_INCLUDE_DIR INC)
string(TOUPPER ${FLI_MODULE}_LIBRARIES LIB)

# MESSAGE(STATUS "CMAKE_SOURCE_DIR is ${CMAKE_SOURCE_DIR}")

# MESSAGE(STATUS "INC is ${INC}")
# MESSAGE(STATUS "LIB is ${LIB}")

IF(WITH_${FLI_MODULE} AND (NOT ${INC} OR NOT ${LIB}))

    if(WIN32)
        if("$ENV{PROCESSOR_ARCHITEW6432}" STREQUAL "")
          if("$ENV{PROCESSOR_ARCHITECTURE}" STREQUAL "x86")
		      # 32-bit process running on a 32-bit system
              set(MODULE_PATH
                  PATHS "${FLI_MODULE}"
                        "${CMAKE_SOURCE_DIR}/../${FLI_MODULE}"
                        "$ENV{ProgramFiles}/${FLI_MODULE}"
						"$ENV{ProgramFiles}/GnuWin32/${FLI_MODULE}"
                        "$ENV{VCPKG_ROOT}/installed/x86-windows-static"
                        "$ENV{VCPKG_ROOT}/installed/x86-windows")
          else()
		      # 64-bit process running on a 64-bit system
              set(MODULE_PATH
                  PATHS "${FLI_MODULE}"
                        "${CMAKE_SOURCE_DIR}/${FLI_MODULE}"
                        "$ENV{ProgramFiles}/../${FLI_MODULE}"
                        "$ENV{VCPKG_ROOT}/installed/x64-windows-static"
                        "$ENV{VCPKG_ROOT}/installed/x64-windows")
          endif()
        else()
          if("$ENV{PROCESSOR_ARCHITECTURE}" STREQUAL "x86")
		      # 32-bit process running on a 64-bit system
		      set(_x86 "ProgramFiles(x86)")
              set(MODULE_PATH
                  PATHS "${FLI_MODULE}"
                        "${CMAKE_SOURCE_DIR}/../${FLI_MODULE}"
                        "$ENV{${_x86}}/${FLI_MODULE}"
                        "$ENV{${_x86}}/GnuWin32/${FLI_MODULE}"
                        "$ENV{VCPKG_ROOT}/installed/x86-windows-static"
                        "$ENV{VCPKG_ROOT}/installed/x86-windows")
			  set(_x86)
          endif()
        endif()
    else()
        set(MODULE_PATH /usr/local/${FLI_MODULE} /usr/${FLI_MODULE} /usr/local /usr)
    endif()

    # if a <module>_ROOT variable has been defined, prepend it to our search path
    if (${FLI_MODULE}_ROOT) 
	    set(MODULE_PATH ${${FLI_MODULE}_ROOT} ${MODULE_PATH})
	endif()

    if(BUILD_SHARED_LIBS)
        FIND_LIBRARY(${LIB} NAMES ${FLI_LIBRARY_NAMES} PATHS ${MODULE_PATH} PATH_SUFFIXES bin lib NO_DEFAULT_PATH)
    else()
        FIND_LIBRARY(${LIB} NAMES ${FLI_LIBRARY_NAMES} PATHS ${MODULE_PATH} PATH_SUFFIXES lib bin NO_DEFAULT_PATH)
    endif()

    FIND_PATH(${INC} NAMES ${FLI_INCLUDE_FILES} PATHS ${MODULE_PATH} PATH_SUFFIXES include)
 
endif()

IF(${INC} AND ${LIB})
    SET(${FLI_MODULE}_FOUND TRUE)
ELSE()	
    SET(${FLI_MODULE}_FOUND FALSE)
ENDIF()

MESSAGE (STATUS "Library found: ${${LIB}}")
MESSAGE (STATUS "Include path found: ${${INC}}")
MESSAGE (STATUS "${FLI_MODULE}_FOUND: ${${FLI_MODULE}_FOUND}")

# MESSAGE (STATUS "Libraries found: ${${LIB}}")
# MESSAGE (STATUS "Include paths found: ${${INC}}")

MARK_AS_ADVANCED(${INC} ${LIB} ${FLI_MODULE}_FOUND)

SET(INC)
SET(LIB)
SET(MODULE_PATH)
