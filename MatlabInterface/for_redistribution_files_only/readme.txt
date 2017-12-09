MATLAB Java Package Read Me

1. Prerequisites for Deployment 

. Verify the MATLAB Runtime is installed and ensure you    
  have installed version 9.0 (R2015b). 

. If the MATLAB Runtime is not installed, do the following:
  (1) enter
  
      >>mcrinstaller
      
      at MATLAB prompt. The MCRINSTALLER command displays the 
      location of the MATLAB Runtime installer.

  (2) run the MATLAB Runtime Installer.

Or download the Windows 64-bit version of the MATLAB Runtime for R2015b 
from the MathWorks Web site by navigating to

   http://www.mathworks.com/products/compiler/mcr/index.html
   
 
For more information about the MATLAB Runtime and the MATLAB Runtime installer, see 
Package and Distribute in the MATLAB Compiler SDK documentation  
in the MathWorks Documentation Center. 

. Ensure you have the version 1.7 of the Java Development Kit (JDK) to integrate the 
  component. 

. MatlabInterface.jar must be included in your CLASSPATH.

. javabuilder.jar must be included in your CLASSPATH. javabuilder.jar 
  can be found in: 
  
  <mcr_root>*\toolbox\javabuilder\jar\win64\javabuilder.jar
  

NOTE: You will need administrator rights to run MCRInstaller. 
 
2. Files to Deploy and Package

-MatlabInterface.jar
-MCRInstaller.exe 
   - if end users are unable to download the MATLAB Runtime using the above  
     link, include it when building your component by clicking 
     the "Runtime downloaded from web" link in the Deployment Tool
-Javadoc   
   - javadoc for MatlabInterface is in the doc directory. While  
     distributing the javadoc, this entire directory should be distributed.
-This readme file


3. Resources

   - To learn more about Deploying Java applications on the Web, see Web Deployment in 
     the MATLAB Java Package documentation in the MathWorks Documentation Center.   


4. Definitions

For information on deployment terminology, go to 
http://www.mathworks.com/help. Select MATLAB Compiler >   
Getting Started > About Application Deployment > 
Deployment Product Terms in the MathWorks Documentation 
Center.


* NOTE: <mcr_root> is the directory where the MATLAB Runtime is installed on the target 
        machine.


5. Appendix 

A. Linux x86-64 systems:   
In the following directions, replace MCR_ROOT by the directory where the MATLAB Runtime 
   is installed on the target machine.

(1) Set the environment variable XAPPLRESDIR to this value:

    MCR_ROOT/v90/X11/app-defaults


(2) If the environment variable LD_LIBRARY_PATH is undefined, set it to the concatenation 
   of the following strings:

    MCR_ROOT/v90/runtime/glnxa64:
    MCR_ROOT/v90/bin/glnxa64:
    MCR_ROOT/v90/sys/os/glnxa64:
    MCR_ROOT/v90/sys/opengl/lib/glnxa64

    If it is defined, set it to the concatenation of these strings:

    ${LD_LIBRARY_PATH}: 
    MCR_ROOT/v90/runtime/glnxa64:
    MCR_ROOT/v90/bin/glnxa64:
    MCR_ROOT/v90/sys/os/glnxa64:
    MCR_ROOT/v90/sys/opengl/lib/glnxa64
 
B. Mac systems: 
In the following directions, replace MCR_ROOT by the directory where the MATLAB Runtime 
   is installed on the target machine.

If the environment variable DYLD_LIBRARY_PATH is undefined, set it to the concatenation 
   of the following strings:

    MCR_ROOT/v90/runtime/maci64:
    MCR_ROOT/v90/sys/os/maci64:
    MCR_ROOT/v90/bin/maci64

If it is defined, set it to the concatenation of these strings:

    ${LD_LIBRARY_PATH}: 
    MCR_ROOT/v90/runtime/maci64:
    MCR_ROOT/v90/sys/os/maci64:
    MCR_ROOT/v90/bin/maci64

   For more detail information about setting the MATLAB Runtime paths, see Package and 
   Distribute in the MATLAB Compiler SDK documentation in the MathWorks Documentation 
   Center.


       
        NOTE: To make these changes persistent after logout on Linux or 
              Mac machines, modify the .cshrc file to include this  
              setenv command.
        NOTE: On Windows, the environment variable syntax utilizes 
              backslashes (\), delimited by semi-colons (;). 
              On Linux or Mac, the environment variable syntax utilizes   
              forward slashes (/), delimited by colons (:).  
        NOTE: On Maci64, ensure you are using 64-bit JVM.
