cmake_minimum_required(VERSION 3.15)
set(PROJECT_NAME "definitely_not_window")
set(PARENT_PROJECT_NAME,"definitely_not_window")
project(${PROJECT_NAME} LANGUAGES CXX)

set(PLUGIN_NAME "${PROJECT_NAME}_plugin")

add_library(${PLUGIN_NAME} STATIC
  "definitely_not_window.cpp"
  "api.cpp"
  "definitely_not_window_plugin.cpp"
)
apply_standard_settings(${PLUGIN_NAME})
set_target_properties(${PLUGIN_NAME} PROPERTIES
  CXX_VISIBILITY_PRESET hidden)
target_compile_definitions(${PLUGIN_NAME} PRIVATE FLUTTER_PLUGIN_IMPL)
target_include_directories(${PLUGIN_NAME} INTERFACE
  "${CMAKE_CURRENT_SOURCE_DIR}/include")
target_link_libraries(${PLUGIN_NAME} PRIVATE flutter flutter_wrapper_plugin Dwmapi Comctl32)

# List of absolute paths to libraries that should be bundled with the plugin
set(definitely_not_window_bundled_libraries
  ""
  PARENT_SCOPE
)
