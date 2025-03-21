CFLAGS = -std=c++17 -O2
LDFLAGS = -lglfw -lvulkan -ldl -lpthread -lX11 -lXxf86vm -lXrandr -lXi

vulkan-goof-off: main.cpp
	g++ $(CFLAGS) -o vulkan-goof-off main.cpp $(LDFLAGS)

.PHONY: test clean

test: vulkan-goof-off
	./vulkan-goof-off

clean:
	rm -f vulkan-goof-off
