FROM gitpod/workspace-full-vnc

RUN sudo apt-get update && \
    sudo apt-get install -y libx11-dev libxkbfile-dev libsecret-1-dev libnss3 libgconf-2-4 vulkan-tools libvulkan-dev vulkan-validationlayers libxxf86vm-dev libxi-dev libglfw3-dev libglm-dev && \
    sudo rm -rf /var/lib/apt/lists/* && \
    git clone https://github.com/google/shaderc && \
    cd shaderc && \
    ./utils/git-sync-deps && \
    mkdir build && \
    cd build && \
    cmake -GNinja -DCMAKE_BUILD_TYPE=Release .. && \
    ninja && \
    ctest && \
    sudo cp glslc/glslc /usr/local/bin && \
    cd ../.. && \
    rm -rf shaderc
