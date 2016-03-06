Release Zip creates single zip package from multiple projects in Solutions. The content of the zip package is defined by json configuration file in the project, thus allow full control of zip structure. 

**Release Zip for Visual Studio Team Service**
-----------
This extensions contains custom VS Team Service "tasks" (or "build tasks") that will read JSON configuration file, that define source and structure of desired zip archive. The JSON filename also serve as base filename of the zip output file. For example if you name the configuration, MyPackage.json, then the output zip file will be MyPackage.zip.

Using this task you will be able to create zip package from the projects in your solution. The task can perform following:

1. Create Zip release package with versioned filename.
2. Structure zip content based on configured rules.
3. Search content using minimatch pattern, and include in zip file.

**JSON Configuration**
-------
```Javascript
{
  "targetroot": "",
  "content": [
    {
      "source": "ConsoleApplication1/bin/**",
      "target": "/"
    },
    {
      "source": "**/VsoAgentTest/bin/**/*.*",
      "target": "/secondfolder"
    }
  ]
}
```
<span style="color:blue">**targetroot**</span>, Root folder in the Zip archive. Default : *(empty)*
<span style="color:blue">**content**</span>, Content of the Zip archive whics is array of *source* and *target*
<span style="color:blue">**source**</span>, Minimatch pattern of the source
<span style="color:blue">**target**</span>, Target folder in the Zip



**Quick Start**
-----------

1. After installing the extension, upload your project to VSTS Online or On-premise (Git or TFS)
2. Go to your VSTS or TFS project, click on **Build** tab, and create a new build definition (the "+" icon).
3. Click **Add build step..** and select **Release Zip** from the **Build** category.
4. Configure the build step.

>**Note:** *Be sure that you are running version 0.3.10 or higher of the cross-platform agent and the latest Windows agent as these are required for VS Team Services extension to function.* 

**Contact Us**
-------

+ [Contact our support team](https://itszap.freshdesk.com)
+ [File an issue on GitHub](https://github.com/ItsZap/vso-agent/issues)
+ [View or contribute to the source code](https://github.com/ItsZap/vso-agent)