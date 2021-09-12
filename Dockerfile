FROM bandi13/gui-docker:1.01

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update -y \
    && apt-get install -y software-properties-common \
    && add-apt-repository ppa:obsproject/obs-studio \
    && apt-get update -y \
    && apt-get install -y obs-studio \
    && apt-get install -y vlc \
    && apt-get clean -y

#Add needed nvidia environment variables for https://github.com/NVIDIA/nvidia-docker
ENV NVIDIA_DRIVER_CAPABILITIES="compute,video,utility"

RUN sed -i 's/geteuid/getppid/' /usr/bin/vlc
RUN echo "?package(bash):needs=\"X11\" section=\"DockerCustom\" title=\"OBS Screencast\" command=\"obs\"" >> /usr/share/menu/custom-docker && update-menus
RUN echo "?package(bash):needs=\"X11\" section=\"DockerCustom\" title=\"VLC\" command=\"vlc\"" >> /usr/share/menu/custom-docker && update-menus
