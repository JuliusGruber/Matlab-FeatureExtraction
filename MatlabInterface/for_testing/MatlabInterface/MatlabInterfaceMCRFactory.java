/*
 * MATLAB Compiler: 6.1 (R2015b)
 * Date: Wed Apr 13 17:08:48 2016
 * Arguments: "-B" "macro_default" "-W" "java:MatlabInterface,MatlabInterface" "-T" 
 * "link:lib" "-d" "C:\\Users\\Julius 
 * Gruber\\Dropbox\\Master\\matlab\\MatlabInterface\\for_testing" 
 * "class{MatlabInterface:C:\\Users\\Julius 
 * Gruber\\Dropbox\\Master\\matlab\\functions\\feAndDimensionReduction.m,C:\\Users\\Julius 
 * Gruber\\Dropbox\\Master\\matlab\\functions\\feAndDimensionReduction1.m,C:\\Users\\Julius 
 * Gruber\\Dropbox\\Master\\matlab\\functions\\feAndDimensionReduction2.m,C:\\Users\\Julius 
 * Gruber\\Dropbox\\Master\\matlab\\functions\\feAndDimensionReduction3.m,C:\\Users\\Julius 
 * Gruber\\Dropbox\\Master\\matlab\\functions\\getAllFileNames.m}" 
 */

package MatlabInterface;

import com.mathworks.toolbox.javabuilder.*;
import com.mathworks.toolbox.javabuilder.internal.*;

/**
 * <i>INTERNAL USE ONLY</i>
 */
public class MatlabInterfaceMCRFactory
{
   
    
    /** Component's uuid */
    private static final String sComponentId = "MatlabInterf_29382A1417B1192DD251C4260944C707";
    
    /** Component name */
    private static final String sComponentName = "MatlabInterface";
    
   
    /** Pointer to default component options */
    private static final MWComponentOptions sDefaultComponentOptions = 
        new MWComponentOptions(
            MWCtfExtractLocation.EXTRACT_TO_CACHE, 
            new MWCtfClassLoaderSource(MatlabInterfaceMCRFactory.class)
        );
    
    
    private MatlabInterfaceMCRFactory()
    {
        // Never called.
    }
    
    public static MWMCR newInstance(MWComponentOptions componentOptions) throws MWException
    {
        if (null == componentOptions.getCtfSource()) {
            componentOptions = new MWComponentOptions(componentOptions);
            componentOptions.setCtfSource(sDefaultComponentOptions.getCtfSource());
        }
        return MWMCR.newInstance(
            componentOptions, 
            MatlabInterfaceMCRFactory.class, 
            sComponentName, 
            sComponentId,
            new int[]{9,0,0}
        );
    }
    
    public static MWMCR newInstance() throws MWException
    {
        return newInstance(sDefaultComponentOptions);
    }
}
