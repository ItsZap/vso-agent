Release Packager creates versioned release package from multiple projects in Solutions. The versioned release package allows Release Manager to better control the release and enable more granullar deliveries.  

**Release Packager for Visual Studio Team Service**
-----------
This extensions contains custom VS Team Service "tasks" (or "build tasks") that will read *.nuspec and *.partial.nuspec file across solutions. The tasks then combine the *.nuspec (main definition file) and *.partial.nuspec (partial definition file) and build a Release Package as a nuget.

Using this task you will be able to create versioned release package of your solution. You can also add dependencies to the release package so that you can create complex Release Package that combines dependencies from one or more small Release Packages.

The task can perform following:
1. Create Release Package (in nuget format) with incremental versioning
2. Combine one or more *.nuspec / *.partial.nuspec to create single package
3. Enable creation of complex package that combines multiple dependencies packages

**Quick Start**
-----------

1. After installing the extension, upload your project to VSTS Online or On-premise (Git or TFS)
2. Go to your VSTS or TFS project, click on **Build** tab, and create a new build definition (the "+" icon).
3. Click **Add build step..** and select **Release Packager** from the **Build** category.
4. Configure the build step.

>**Note:** *Be sure that you are running version 0.3.10 or higher of the cross-platform agent and the latest Windows agent as these are required for VS Team Services extension to function.* 

**Contact Us**
-------

+ [Contact our support team](https://itszap.freshdesk.com)
+ [File an issue on GitHub](https://github.com/ItsZap/vso-agent/issues)
+ [View or contribute to the source code](https://github.com/ItsZap/vso-agent)