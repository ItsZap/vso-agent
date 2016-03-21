Visual Studio Online Agent by **ItsZap Inc.**

## Overview
This repo contains Visual Studio Online / Visual Studio Team Service custom build task agent. 

Current build task agent available:

1. **[Release Packager for Visual Studio Team Service](https://github.com/ItsZap/vso-agent/tree/master/Tasks/ReleasePackager)**  
   This extensions contains custom VS Team Service "tasks" (or "build tasks") that will read *.nuspec and *.partial.nuspec file across solutions. The tasks then combine the *.nuspec (main definition file) and *.partial.nuspec (partial definition file) and build a Release Package as a nuget.

2. **[Release Zip for Visual Studio Team Service](https://github.com/ItsZap/vso-agent/tree/master/Tasks/ReleaseZip)**   
   This extensions contains custom VS Team Service "tasks" (or "build tasks") that will read JSON configuration file, that define source and structure of desired zip archive. The JSON filename also serve as base filename of the zip output file. For example if you name the configuration, MyPackage.json, then the output zip file will be MyPackage.zip.


## Quick Start

1. Install the extension from Visual Studio Online Marketplace
2. Go to your VSTS or TFS project, click on **Build** or **Release** tab and create new build or release definition (the "+" icon)
3. Add the new build step
4. Configure the build step

## Supports / Maintainer

1. [Riwut Libinuko](cakriwut@gmail.com)
