/*
 * MATLAB Compiler: 6.1 (R2015b)
 * Date: Wed Apr 06 20:32:31 2016
 * Arguments: "-B" "macro_default" "-W" "java:Short,Short" "-T" "link:lib" "-d" 
 * "C:\\Users\\Julius Gruber\\Dropbox\\Master\\matlab\\Short\\for_testing" 
 * "class{Short:C:\\Users\\Julius 
 * Gruber\\Dropbox\\Master\\matlab\\functions\\shortFunction.m}" 
 */

package Short;

import com.mathworks.toolbox.javabuilder.*;
import com.mathworks.toolbox.javabuilder.internal.*;

/**
 * <i>INTERNAL USE ONLY</i>
 */
public class ShortMCRFactory
{
   
    
    /** Component's uuid */
    private static final String sComponentId = "Short_60D82DC9EEE55C564DC6EB8668C9D38A";
    
    /** Component name */
    private static final String sComponentName = "Short";
    
   
    /** Pointer to default component options */
    private static final MWComponentOptions sDefaultComponentOptions = 
        new MWComponentOptions(
            MWCtfExtractLocation.EXTRACT_TO_CACHE, 
            new MWCtfClassLoaderSource(ShortMCRFactory.class)
        );
    
    
    private ShortMCRFactory()
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
            ShortMCRFactory.class, 
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
