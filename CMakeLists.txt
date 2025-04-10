cmake_minimum_required(VERSION 3.16)
project(VulkanGoofOff)

#[[set(CMAKE_PREFIX_PATH
    ${LINUX_VENDOR_BINARIES_DIR}/vulkan-loader
    ${PLATFORM_AGNOSTIC_VENDOR_BINARIES_DIR}/vulkan-headers)
find_package(VulkanLoader REQUIRED)
find_package(VulkanHeaders REQUIRED CONFIG)]]

set(CMAKE_CXX_STANDARD 17)
#[[set(Vulkan_LIBRARY ${CMAKE_CURRENT_SOURCE_DIR}/vulkan/1.4.309.0/x86_64/lib/libvulkan.so)
set(Vulkan_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/vulkan/1.4.309.0/x86_64/include)]]
find_package(Vulkan REQUIRED)

add_subdirectory(lib/glfw)
SET(GLM_TEST_ENABLE OFF CACHE BOOL "GLM Build unit tests")
add_subdirectory(lib/glm     EXCLUDE_FROM_ALL)

add_executable(${PROJECT_NAME} main.cpp)

add_custom_target(shaders)
set(GLSL_SHADER_FILES shaders/shader.vert shaders/shader.frag)

foreach(FILE ${GLSL_SHADER_FILES})
    get_filename_component(shadertypewithdot ${FILE} LAST_EXT)
    string(REGEX REPLACE "^\\." "" shadertype ${shadertypewithdot})
    make_directory(${CMAKE_BINARY_DIR}/shaders)
    add_custom_command(TARGET shaders
                       PRE_BUILD
                       COMMAND glslc ${FILE} -o ${CMAKE_BINARY_DIR}/shaders/${shadertype}.spv -O
                       COMMENT "GLSL ${FILE}"
                       WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
                       VERBATIM)
endforeach(FILE)

add_custom_target(textures)
add_custom_command(TARGET textures
                   PRE_BUILD
                   COMMAND cp textures ${CMAKE_BINARY_DIR}/textures -r
                   COMMENT "Textures copied"
                   WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
                   VERBATIM
                   )

add_dependencies(${PROJECT_NAME} shaders textures)
target_link_libraries(${PROJECT_NAME} glfw ${GLFW_LIBRARIES} Vulkan::Vulkan #[[Vulkan::Headers Vulkan::Loader]] glm)
if(CMAKE_BUILD_TYPE EQUAL "Release")
    target_compile_definitions(${PROJECT_NAME} PRIVATE
                               -DNDEBUG)
endif()
