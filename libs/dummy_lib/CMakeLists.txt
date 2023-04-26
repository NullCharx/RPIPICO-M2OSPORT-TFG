add_library(dummy_lib STATIC dummy_lib.c)
target_include_directories(dummy_lib PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})