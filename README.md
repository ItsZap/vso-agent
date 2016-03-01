Visual Studio Online Agent by **ItsZap Inc.**

## Overview
This repo contains Visual Studio Online / Visual Studio Team Service custom build task agent. 

Current build task agent available:

1. **Release Packager for Visual Studio Team Service**  
   This extensions contains custom VS Team Service "tasks" (or "build tasks") that will read *.nuspec and *.partial.nuspec file across solutions. The tasks then combine the *.nuspec (main definition file) and *.partial.nuspec (partial definition file) and build a Release Package as a nuget.

## Quick Start

1. Install the extension from Visual Studio Online Marketplace
2. Go to your VSTS or TFS project, click on **Build** or **Release** tab and create new build or release definition (the "+" icon)
3. Add the new build step
4. Configure the build step

## Supports / Maintainer

1. [Riwut Libinuko](cakriwut@gmail.com)
