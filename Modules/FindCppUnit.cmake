# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.
#
# - Try to find the libcppunit libraries
# Once done this will define
#
# CppUnit_FOUND - system has libcppunit
# CPPUNIT_INCLUDE_DIR - the libcppunit include directory
# CPPUNIT_LIBRARIES - libcppunit library
#
# Written by Ziemowit Laski (zlaski@ziemas.net)

if(NOT CPPUNIT_MIN_VERSION)
  SET(CPPUNIT_MIN_VERSION 1.12.0)
endif(NOT CPPUNIT_MIN_VERSION)

# Construct search.
SET(FLI_MODULE CppUnit)
SET(FLI_INCLUDE_FILES cppunit/TestRunner.h)
SET(FLI_LIBRARY_NAMES CppUnit)

include(SearchLibsIncludes)

SET(CPPUNIT_INCLUDE_DIR ${CPPUNIT_INCLUDE_DIR} ${CPPUNIT_INCLUDE_DIR}/cppunit)

# how can we find cppunit version?
MESSAGE (STATUS "Ensure your CppUnit installed version is at least ${CPPUNIT_MIN_VERSION}")
SET (CPPUNIT_INSTALLED_VERSION ${CPPUNIT_MIN_VERSION})

