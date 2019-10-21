##---------------------------------------------------------------------------##
## File  : flibcpp/cmake/FlibcppVersion.cmake
#[=======================================================================[.rst:

FlibcppVersion
--------------

.. command:: flibcpp_find_version

  Get the project version using Git descriptions to ensure the version numbers
  are always synchronized between Git and CMake::

    flibcpp_find_version(<projname> <git-version-file>)


  ``<projname>``
  Name of the project.

  This command sets the following variables in the parent package::

    ${PROJNAME}_VERSION
    ${PROJNAME}_VERSION_STRING

  The project version string uses PEP-440 semantic versioning, and will look
  like v0.1.2 if the version is actually a tagged release, or v0.1.3+abcdef if
  it's not.

  If a non-tagged version is exported, or an untagged shallow git clone is used,
  it's impossible to determine the version from the tag, so a warning will be
  issued and the version will be set to 0.0.0.

#]=======================================================================]

if (CMAKE_SCRIPT_MODE_FILE)
  cmake_minimum_required(VERSION 3.8)
endif()

function(flibcpp_find_version PROJNAME GIT_VERSION_FILE)
  # Get a possible Git version generated using git-archive (see the
  # .gitattributes file)
  file(STRINGS "${GIT_VERSION_FILE}" _TEXTFILE)

  if (_TEXTFILE MATCHES "\\$Format:")
    # Not a "git archive": use live git information
    set(_CACHE_VAR "${PROJNAME}_GIT_DESCRIBE")
    set(_CACHED_VERSION "${${_CACHE_VAR}}")
    if (NOT _CACHED_VERSION)
      # Building from a git checkout rather than a distribution
      find_package(Git QUIET REQUIRED)
      execute_process(
        COMMAND "${GIT_EXECUTABLE}" "describe" "--tags" "--match" "v*"
        WORKING_DIRECTORY "${CMAKE_CURRENT_LIST_DIR}"
        ERROR_VARIABLE _GIT_ERR
        OUTPUT_VARIABLE _VERSION_STRING
        RESULT_VARIABLE _GIT_RESULT
        OUTPUT_STRIP_TRAILING_WHITESPACE
      )
      if (NOT _GIT_RESULT EQUAL "0")
        message(WARNING "Failed to get ${PROJNAME} version from git: "
          "${_GIT_ERR}")
      elseif (NOT _VERSION_STRING)
        message(WARNING "Failed to get ${PROJNAME} version from git: "
          "git describe returned an empty string")
      else()
        # Process description tag: e.g. v0.4.0-2-gc4af497 or v0.4.0
        string(REGEX MATCH "v([0-9.]+)(-[0-9]+-g([0-9a-f]+))?" _MATCH
          "${_VERSION_STRING}"
        )
        if (_MATCH)
          set(_VERSION_STRING "${CMAKE_MATCH_1}")
          if (CMAKE_MATCH_2)
            # *not* a tagged release
            set(_VERSION_HASH "${CMAKE_MATCH_3}")
          endif()
        endif()
      endif()
      if (NOT _VERSION_STRING)
        execute_process(
          COMMAND "${GIT_EXECUTABLE}" "log" "-1" "--format=%h" "HEAD"
          WORKING_DIRECTORY "${CMAKE_CURRENT_LIST_DIR}"
          OUTPUT_VARIABLE _VERSION_HASH
          OUTPUT_STRIP_TRAILING_WHITESPACE
        )
      endif()
      set(_CACHED_VERSION "${_VERSION_STRING}" "${_VERSION_HASH}")
      set("${_CACHE_VAR}" "${_CACHED_VERSION}" CACHE INTERNAL
        "Version string and hash for ${PROJNAME}")
    endif()
    list(GET _CACHED_VERSION 0 _VERSION_STRING)
    list(GET _CACHED_VERSION 1 _VERSION_HASH)
  else()
    # First line are decorators, second is hash.
    list(GET _TEXTFILE 0 _TAG)
    string(REGEX MATCH "tag: *v([0-9.]+)" _MATCH "${_TAG}")
    if (_MATCH)
      set(_VERSION_STRING "${CMAKE_MATCH_1}")
    else()
      # *not* a tagged release
      list(GET _TEXTFILE 1 _HASH)
      string(REGEX MATCH " *([0-9a-f]+)" _MATCH "${_HASH}")
      if (_MATCH)
        set(_VERSION_HASH "${CMAKE_MATCH_1}")
      endif()
    endif()
  endif()

  if (NOT _VERSION_STRING)
    message(WARNING "Could not determine version number for ${PROJNAME}: "
      "perhaps a non-release archive?")
    set(_VERSION_STRING "0.0.0")
  endif()

  if (_VERSION_HASH)
    set(_FULL_VERSION_STRING "v${_VERSION_STRING}+${_VERSION_HASH}")
  else()
    set(_FULL_VERSION_STRING "v${_VERSION_STRING}")
  endif()

  set(${PROJNAME}_VERSION "${_VERSION_STRING}" PARENT_SCOPE)
  set(${PROJNAME}_VERSION_STRING "${_FULL_VERSION_STRING}" PARENT_SCOPE)
endfunction()

if (CMAKE_SCRIPT_MODE_FILE)
  # This script is being run from the command line. Useful for debugging.
  if (NOT DEFINED GIT_VERSION_FILE)
    message(FATAL_ERROR "Run this script with "
      "cmake -D GIT_VERSION_FILE=git-version.txt -P FlibcppVersion.cmake")
  endif()
  flibcpp_find_version(local ${GIT_VERSION_FILE})
  message(STATUS "${LOCAL_VERSION}")
  message(STATUS "${LOCAL_VERSION_STRING}")
endif()

##---------------------------------------------------------------------------##
## end of flibcpp/cmake/FlibcppVersion.cmake
##---------------------------------------------------------------------------##
