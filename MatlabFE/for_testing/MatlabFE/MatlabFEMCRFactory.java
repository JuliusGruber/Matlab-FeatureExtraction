/*
 * MATLAB Compiler: 6.1 (R2015b)
 * Date: Wed Apr 13 18:08:42 2016
 * Arguments: "-B" "macro_default" "-W" "java:MatlabFE,Fe" "-T" "link:lib" "-d" 
 * "C:\\Users\\Julius Gruber\\Dropbox\\Master\\matlab\\MatlabFE\\for_testing" 
 * "class{Fe:C:\\Users\\Julius 
 * Gruber\\Dropbox\\Master\\matlab\\functions\\feAndDimensionReduction.m,C:\\Users\\Julius 
 * Gruber\\Dropbox\\Master\\matlab\\functions\\feAndDimensionReduction1.m,C:\\Users\\Julius 
 * Gruber\\Dropbox\\Master\\matlab\\functions\\feAndDimensionReduction2.m,C:\\Users\\Julius 
 * Gruber\\Dropbox\\Master\\matlab\\functions\\feAndDimensionReduction3.m}" 
 */

package MatlabFE;

import com.mathworks.toolbox.javabuilder.*;
import com.mathworks.toolbox.javabuilder.internal.*;

/**
 * <i>INTERNAL USE ONLY</i>
 */
public class MatlabFEMCRFactory
{
   
    
    /** Component's uuid */
    private static final String sComponentId = "MatlabFE_83A6F484907FED7424D4E5BD5A4A0890";
    
    /** Component name */
    private static final String sComponentName = "MatlabFE";
    
   
    /** Pointer to default component options */
    private static final MWComponentOptions sDefaultComponentOptions = 
        new MWComponentOptions(
            MWCtfExtractLocation.EXTRACT_TO_CACHE, 
            new MWCtfClassLoaderSource(MatlabFEMCRFactory.class)
        );
    
    
    private MatlabFEMCRFactory()
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
            MatlabFEMCRFactory.class, 
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
