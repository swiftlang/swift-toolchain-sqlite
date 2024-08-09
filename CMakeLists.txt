
cmake_minimum_required(VERSION 3.12.3)

project(SQLite
  LANGUAGES C)

# Generate PIC for ELF/MachO targets.
set(CMAKE_POSITION_INDEPENDENT_CODE YES)

# Use hidden visibility for ELF/MachO targets.
set(CMAKE_C_VISIBILITY_PRESET hidden)
set(CMAKE_VISIBILITY_INLINES_HIDDEN YES)

add_library(SQLite3
  Sources/CSQLite/sqlite3.c)
if(CMAKE_SYSTEM_NAME STREQUAL Windows AND BUILD_SHARED_LIBS)
  target_compile_definitions(SQLite3 PRIVATE
    "SQLITE_API=__declspec(dllexport)")
endif()
target_include_directories(SQLite3 PUBLIC
  Sources/CSQLite/include)

add_executable(sqlite
  Sources/sqlite/shell.c)
target_compile_definitions(sqlite PRIVATE
  SQLITE_OMIT_LOAD_EXTENSION)
target_link_libraries(sqlite PRIVATE
  SQLite3)

install(TARGETS SQLite3
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION bin)
install(FILES
    Sources/CSQLite/include/sqlite3.h
    Sources/CSQLite/include/sqlite3ext.h
  DESTINATION
    include)

