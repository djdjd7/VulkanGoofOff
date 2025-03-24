CFLAGS = -std=c++17 -O2
LDFLAGS = -lglfw -lvulkan -ldl -lpthread -lX11 -lXxf86vm -lXrandr -lXi

vulkan-goof-off: main.cpp shaders/vert.spv shaders/frag.spv stb_image.h
	g++ $(CFLAGS) -o vulkan-goof-off main.cpp $(LDFLAGS)

stb_image.h:
	wget https://raw.githubusercontent.com/nothings/stb/refs/heads/master/stb_image.h

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
	rm -f stb_image.h
