# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.
#
# - Try to find the ZLIB library
# Once done this will define
#
# ZLIB_FOUND - system has ZLIB
# ZLIB_INCLUDE_DIR - the ZLIB include directory
# ZLIB_ZLIB_LIBRARIES - ZLIB library
#
# Written by Ziemowit Laski (zlaski@ziemas.net)

if(NOT ZLIB_MIN_VERSION)
  SET(ZLIB_MIN_VERSION 1.2.12)
endif(NOT ZLIB_MIN_VERSION)

# Construct search.
SET(FLI_MODULE ZLIB)
SET(FLI_INCLUDE_FILES zlib.h)
SET(FLI_LIBRARY_NAMES zlib zlib1)

include(SearchLibsIncludes)

# how can we find ZLIB version?
MESSAGE(STATUS "Ensure your ZLIB installed version is at least ${ZLIB_MIN_VERSION}")
SET(ZLIB_INSTALLED_VERSION ${ZLIB_MIN_VERSION})

