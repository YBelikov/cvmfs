# Find the osxfuse includes and library
#
#  OSXFUSE_INCLUDE_DIR - where to find fuse.h, etc.
#  OSXFUSE_LIBRARIES   - List of libraries when using osxfuse.
#  OSXFUSE_FOUND       - True if osxfuse lib is found.

# MACOS_FUSE_INCLUDE_DIR - where to find fuse.h, etc.
# MACOS_FUSE_LIBRARIES   - List of libraries when using macFuse or FUSE-T
# MACOS_FUSE_FOUND       - True if either FUSE-T or macFUSE lib is found.

# find includes
FIND_PATH (MACOS_FUSE_INCLUDE_DIR fuse.h
        /usr/local/include
        /usr/include
        /usr/local/include/osxfuse
)

# currently set it manually to include necessary directories
SET(MACOS_FUSE_INCLUDE_DIR ${MACOS_FUSE_INCLUDE_DIR} /usr/local/include/fuse /usr/local/include)

# find FUSE-T lib as the primary lib
SET(MACOS_FUSE_LIB_NAMES fuse-t)
FIND_LIBRARY(MACOS_FUSE_LIBRARY 
        NAMES ${MACOS_FUSE_LIB_NAMES} 
        PATHS /usr/lib /usr/local/lib NO_DEFAULT_PATH
)

# macFUSE fallback when FUSE-T is not installed
IF (NOT MACOS_FUSE_LIBRARY AND NOT MACOS_FUSE_FIND_QUIETLY)
        MESSAGE(STATUS "FUSE-T library is not found. Trying to look for macFUSE")
        SET(MACOS_FUSE_LIB_NAMES  osxfuse.2 osxfuse)
        FIND_LIBRARY(MACOS_FUSE_LIBRARY 
                NAMES ${MACOS_FUSE_LIB_NAMES} 
                PATHS /usr/lib /usr/local/lib NO_DEFAULT_PATH
        )
ENDIF (NOT MACOS_FUSE_LIBRARY AND NOT MACOS_FUSE_FIND_QUIETLY)

# check if lib was found and include is present
IF (MACOS_FUSE_INCLUDE_DIR AND MACOS_FUSE_LIBRARY)
        SET (MACOS_FUSE_FOUND TRUE)
        SET (MACOS_FUSE_LIBRARIES ${MACOS_FUSE_LIBRARY})
ELSE (MACOS_FUSE_INCLUDE_DIR AND MACOS_FUSE_LIBRARY)
        SET (MACOS_FUSE_FOUND FALSE)
        SET (MACOS_FUSE_LIBRARIES)
ENDIF (MACOS_FUSE_INCLUDE_DIR AND MACOS_FUSE_LIBRARY)

# let world know the results
IF (MACOS_FUSE_FOUND)
        IF (NOT MACOS_FUSE_FIND_QUIETLY)
                MESSAGE(STATUS "Found FUSE library for macOS: ${MACOS_FUSE_LIBRARY}")
        ENDIF (NOT MACOS_FUSE_FIND_QUIETLY)
ELSE (MACOS_FUSE_FOUND)
        IF (MACOS_FUSE_FIND_QUIETLY)
                MESSAGE(STATUS "Looked for FUSE libraries named ${MACOS_FUSE_LIB_NAMES}.")
                MESSAGE(FATAL_ERROR "Could NOT find FUSE library")
        ENDIF (MACOS_FUSE_FIND_QUIETLY)
ENDIF (MACOS_FUSE_FOUND)

mark_as_advanced (MACOS_FUSE_INCLUDE_DIR MACOS_FUSE_LIBRARIES)