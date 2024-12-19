
<h3 align="center" >
  <a href="https://github.com/nickesc/client-enhanced"><img alt="Source: Github" src="https://img.shields.io/badge/source-github-brightgreen?style=for-the-badge&logo=github&labelColor=%23505050"></a>
  <br><br>
  <img src="config/fancymenu/assets/minecraft_title.png">

  <h3 align="center">
    <code>Minecraft Client-Enhanced Modpack</code>
  </h3>
  <h5 align="center">
    
  </h5>
  <h6 align="center">
    by <a href="https://nickesc.github.io">N. Escobar</a> / <a href="https://github.com/nickesc">nickesc</a>
  </h6>
  <h6 align="center">
    a client side Minecraft modpack that aims<br>
    to overhaul and modernize the experience
  </h6>
</h3>

## About

Client-Enhanced is an overhaul of the current Minecraft client.

Mods like [Camera Overhaul](https://modrinth.com/mod/cameraoverhaul) and [Shoulder Surfing Reloaded](https://modrinth.com/mod/shoulder-surfing-reloaded) update the way it feels to move around and the way the camera controls. 

And mods like [Sodium](https://modrinth.com/mod/sodium) and [Lithium](https://modrinth.com/mod/lithium) are used to optimize the experience for all kinds of hardware (with the addition of a version of the modpack made for [VulkanMod](https://modrinth.com/mod/vulkanmod)). 

The pack also includes mods like [Roughly Enough Resources](https://modrinth.com/mod/rei) and [JourneyMap](https://modrinth.com/mod/journeymap) that add common-sense UI elements like item/recipe lookup and a minimap. 

Resource packs like [3D Default](https://modrinth.com/resourcepack/3d-default) and [Fresh Animations](https://modrinth.com/resourcepack/fresh-animations) are also used to add 3D detail to models and revamp animations.

And shaders like [MakeUp - Ultra Fast](https://modrinth.com/shader/makeup-ultra-fast-shaders) and [LITE](https://modrinth.com/shader/lite-shaders) are able to breath new life into the visuals and make the world look much more impressive through [Iris](https://modrinth.com/mod/iris) while maintaining reasonable framerates.


## Installation

### Requirements:
- Minecraft 1.21.4
- Git
- Apple Silicon (M1, M2, etc.) and macOS -- **Untested** on other platforms

### Instructions

1. Install Fabric the normal way: [Installing Fabric - Fabric Documentation](https://docs.fabricmc.net/players/installing-fabric)
> Make sure to check `Create Profile` when you install Fabric

1. In a terminal, navigate to the folder you want to install the modpack to:
Ex.:
```sh
cd modpack/directory/path
```

1. Choose your modpack version and clone the repository:

#### Main version:
The complete, fully featured modpack. Includes all enhancements, including shaders.

Execute the following commands in the terminal:
```sh
git clone -b main --single-branch https://github.com/nickesc/client-enhanced && \
  client-enhanced/scripts/physics-download.sh
```

#### Vulkan Version
A somewhat paired-back version of the modpack made to run with a Vulkan renderer. Any mods that conflict with the [Vulkan mod](https://modrinth.com/mod/vulkanmod) have been removed.

Delivers **significant** performance boosts on some systems (Apple Silicon especially), but the main feature missing in the Vulkan version is shader support. The minimap is also somewhat broken (acts like a radar -- does not display the map, only entities) and is turned off by default.

Execute the following command in the terminal:
```sh
git clone -b vulkan --single-branch https://github.com/nickesc/client-enhanced
```

4. Move the profile the Fabric installer made to the modpack folder using the Minecraft Launcher: [How to change your Game Directory in Minecraft](https://minecrafthopper.net/help/guides/changing-game-directory/)

5. Launch the Fabric profile from the launcher and enjoy!

## Development:
Development steps are the same as installation until choosing a version.

Instead, clone the repository and install Physics as normal:
```sh
git https://github.com/nickesc/client-enhanced && \
  client-enhanced/scripts/physics-download.sh
```

To work on the Vulkan branch:
```sh
git checkout vulkan
```

And to change back to the Main branch:
```sh
git checkout main && \
  client-enhanced/scripts/physics-download.sh
```

Then proceed with installation instructions.

## Mod List

<details> 
  <summary>Libraries</summary>
  
Mod | Version | Used By | Link | Vulkan Status |
-|-|-|-|-|
Fabric API |
Cloth Config API |
Mod Menu |
Yet Another Config Lib | 
Fabric Language Kotlin | 
ukulib | 
Collective | 
libIPN |
Architechtury API | 
UniLib | 
Balm | 
CICADA | 
SuperMartijn642's Config Lib | 

https://modrinth.com/mod/konkrete
https://modrinth.com/mod/melody
https://modrinth.com/mod/tcdcommons
https://modrinth.com/mod/mru
https://modrinth.com/mod/forge-config-api-port
https://modrinth.com/mod/supermartijn642s-config-lib
https://modrinth.com/mod/cicada
https://modrinth.com/mod/balm
https://modrinth.com/mod/unilib
https://modrinth.com/mod/architectury-api
https://modrinth.com/mod/libipn
https://modrinth.com/mod/collective
https://modrinth.com/mod/ukulib
https://modrinth.com/mod/fabric-language-kotlin
https://modrinth.com/mod/yacl
https://modrinth.com/mod/modmenu
https://modrinth.com/mod/cloth-config


  <table></table>
</details>
