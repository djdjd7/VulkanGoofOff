FROM gitpod/workspace-full-vnc

RUN sudo apt-get update && \
    sudo apt-get install -y libx11-dev libxkbfile-dev libsecret-1-dev libnss3 libgconf-2-4 vulkan-tools libvulkan-dev vulkan-validationlayers libxxf86vm-dev libxi-dev libglfw3-dev libglm-dev wine64 python3 msitools ca-certificates winbind && \
    sudo rm -rf /var/lib/apt/lists/* && \
    git clone https://github.com/google/shaderc.git && \
    cd shaderc && \
    ./utils/git-sync-deps && \
    mkdir build && \
    cd build && \
    cmake -GNinja -DCMAKE_BUILD_TYPE=Release .. && \
    ninja && \
    ctest && \
    sudo cp glslc/glslc /usr/local/bin && \
    cd ../.. && \
    rm -rf shaderc && \
    git clone https://github.com/mstorsjo/msvc-wine.git && \
    cd msvc-wine && \
    ./vsdownload.py --accept-license --dest ~/my_msvc/opt/msvc && \
    ./install.sh ~/my_msvc/opt/msvc && \
    wineserver -k || true && \
    wineserver -p && \
    wine64 wineboot && \
    echo "export PATH=~/my_msvc/opt/msvc/bin/x64:\$PATH" >> ~/.bashrc && \
    cd .. && \
    rm -rf msvc-wine
