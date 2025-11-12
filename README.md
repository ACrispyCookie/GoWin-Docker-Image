# GoWin IDE Docker image
This project provides a complete Docker setup to run the GoWin FPGA IDE, which is officially only supported on older Linux distributions like Ubuntu 22.04.

It uses a Docker container with all the correct dependencies and safely forwards the GUI and USB devices to your host machine.

## Project Structure
Your project folder should contain:

```
.
├── docker-compose.yml      # Manages container settings (GUI, USB, volumes)
├── projects/               # Default save location for your IDE projects
└── build/
    ├── Dockerfile              # Defines the Ubuntu 22.04 container
    ├── run_gowin.sh            # Applies runtime fixes inside the container
    └── Gowin_V1.9.11.03_Education_Linux.tar.gz  # <-- Your downloaded IDE
```

## Prerequisites
1. **Docker & Docker Compose:** Ensure you have both installed on your system.
2. **GoWin IDE Archive:** You must download the **Linux** version of the GoWin IDE from the [official website](https://www.gowinsemi.com/en/support/download_eda/).

## Setup & Build Instructions
Follow these steps from a terminal in your project's root directory.

### 1. Download the IDE and verify file name
Place the ``Gowin_V1.9.x.xx...tar.gz`` file you downloaded into the ``build/`` directory.
The Dockerfile assumes the filename is ``Gowin_V1.9.11.03_Education_Linux.tar.gz``.
You can change this by changing the build argument ``GOWIN_ARCHIVE`` inside the Dockerfile.

### 2. (Optional) Create your project directory (on Host)
If you want to use a different project directory than the default you need to create the directory using:
```
mkdir -p ~/myown_projects_dir
```
You also need to change the appropriate volume on the ``docker-compose.yml``.

### 3. Build the Docker image
Run the following command to build the image, installing Ubuntu 22.04 and all dependencies. This only needs to be done once (or when you change the Dockerfile).
```
docker build -t gowin-ide ./build
```

## Running the IDE

### 1. Allow GUI access
You must grant Docker permission to display windows on your desktop. Run this once per host reboot:
```
xhost +local:docker
```

### 2. Run with Docker Compose
Now you can start the IDE from your project's root directory.
```
docker-compose up
```

### **3. Stopping the IDE**
To stop the IDE, simply press Ctrl+C in the terminal where docker-compose up is running.
