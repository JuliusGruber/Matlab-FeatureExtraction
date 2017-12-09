/*
 * MATLAB Compiler: 6.1 (R2015b)
 * Date: Thu Mar 31 12:24:17 2016
 * Arguments: "-B" "macro_default" "-W" "java:feDimRed,MatlabInterface" "-T" "link:lib" 
 * "-d" "C:\\Users\\Julius Gruber\\Dropbox\\Master\\matlab\\feDimRed\\for_testing" 
 * "class{MatlabInterface:C:\\Users\\Julius 
 * Gruber\\Dropbox\\Master\\matlab\\functions\\feAndDimensionReduction.m}" 
 */

package feDimRed;

import com.mathworks.toolbox.javabuilder.*;
import com.mathworks.toolbox.javabuilder.internal.*;

/**
 * <i>INTERNAL USE ONLY</i>
 */
public class FeDimRedMCRFactory
{
   
    
    /** Component's uuid */
    private static final String sComponentId = "feDimRed_B4C478936B7DD151EAF4B54C3848600B";
    
    /** Component name */
    private static final String sComponentName = "feDimRed";
    
   
    /** Pointer to default component options */
    private static final MWComponentOptions sDefaultComponentOptions = 
        new MWComponentOptions(
            MWCtfExtractLocation.EXTRACT_TO_CACHE, 
            new MWCtfClassLoaderSource(FeDimRedMCRFactory.class)
        );
    
    
    private FeDimRedMCRFactory()
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
            FeDimRedMCRFactory.class, 
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
