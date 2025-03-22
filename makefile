CFLAGS = -std=c++17 -O2
LDFLAGS = -lglfw -lvulkan -ldl -lpthread -lX11 -lXxf86vm -lXrandr -lXi

vulkan-goof-off: main.cpp shaders/vert.spv shaders/frag.spv
	g++ $(CFLAGS) -o vulkan-goof-off main.cpp $(LDFLAGS)

shaders/vert.spv: shaders/shader.vert
	glslc shaders/shader.vert -o shaders/vert.spv

shaders/frag.spv: shaders/shader.frag
	glslc shaders/shader.frag -o shaders/frag.spv

.PHONY: test clean

test: vulkan-goof-off
	./vulkan-goof-off

clean:
	rm -f vulkan-goof-off
	rm -f shaders/*.spv
