CFLAGS = -std=c++17 -O2
LDFLAGS = -lglfw -lvulkan -ldl -lpthread -lX11 -lXxf86vm -lXrandr -lXi

vulkan-goof-off: main.cpp shaders/vert.spv shaders/frag.spv
	g++ $(CFLAGS) -o vulkan-goof-off main.cpp $(LDFLAGS)

release: main.cpp
	g++ -std=c++17 -Ofast -D NDEBUG -o vulkan-goof-off-release main.cpp $(LDFLAGS)

shaders/vert.spv: shaders/shader.vert
	glslc shaders/shader.vert -o shaders/vert.spv -O

shaders/frag.spv: shaders/shader.frag
	glslc shaders/shader.frag -o shaders/frag.spv -O

.PHONY: test clean

test: vulkan-goof-off
	./vulkan-goof-off

clean:
	rm -f vulkan-goof-off
	rm -f shaders/*.spv
