# Use the officially supported Ubuntu 22.04 (Jammy) as the base
FROM ubuntu:22.04

# Set non-interactive mode for apt-get to prevent prompts
ENV DEBIAN_FRONTEND=noninteractive

# === IMPORTANT ===
# You must download the GoWin IDE Linux .tar.gz file yourself
# and place it in the same directory as this Dockerfile.
# We'll assume the filename is "Gowin_V1.9.11.03_Education_Linux.tar.gz"
# If your version is different, RENAME THE FILENAME BELOW.
ARG GOWIN_ARCHIVE=Gowin_V1.9.11.03_Education_Linux.tar.gz

# Copy the archive into the container and extract it to /opt
COPY $GOWIN_ARCHIVE /tmp/
RUN mkdir -p /opt/gowin \
    && tar -xvf /tmp/$GOWIN_ARCHIVE -C /opt/gowin \
    && rm /tmp/$GOWIN_ARCHIVE

# Copy the launcher script into the container
COPY run_gowin.sh /usr/bin/run_gowin.sh
RUN chmod +x /usr/bin/run_gowin.sh

# Install all necessary dependencies for GoWin IDE
# This includes:
# - Common utilities: wget, ca-certificates
# - Qt5 GUI libraries: A whole set of libqt5* and libxcb* for the interface
# - Graphics libraries: libgl1-mesa-glx
# - Font rendering: libfreetype6 (critical for the fix)
# - USB/Hardware access: libftdi1-2, libhidapi-hidraw0, libudev1
RUN apt-get update && apt-get install -y \
    wget \
    ca-certificates \
    libftdi1-2 \
    libhidapi-hidraw0 \
    libudev1 \
    libfreetype6 \
    libnss3 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libxtst6 \
    libasound2 \
    libqt5widgets5 \
    libqt5gui5 \
    libqt5core5a \
    libqt5x11extras5 \
    libxcb1 \
    libxcb-glx0 \
    libxcb-keysyms1 \
    libxcb-image0 \
    libxcb-shm0 \
    libxcb-icccm4 \
    libxcb-sync1 \
    libxcb-xfixes0 \
    libxcb-render-util0 \
    libx11-xcb1 \
    libgl1-mesa-glx \
    --no-install-recommends \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set up a non-root user to run the IDE for better security
RUN useradd -m -s /bin/bash gowinuser
USER gowinuser
WORKDIR /home/gowinuser
RUN mkdir -p projects

# Set the default command to launch our script
CMD ["/usr/bin/run_gowin.sh"]
