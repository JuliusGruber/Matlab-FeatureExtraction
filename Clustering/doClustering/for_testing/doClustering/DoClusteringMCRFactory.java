/*
 * MATLAB Compiler: 6.3 (R2016b)
 * Date: Sat Mar 11 18:12:02 2017
 * Arguments: "-B" "macro_default" "-v" "-W" "java:doClustering,Class1" "-T" "link:lib" 
 * "-d" 
 * "C:\\Users\\Julius\\Dropbox\\Master\\matlab\\Clustering\\doClustering\\for_testing" 
 * "class{Class1:C:\\Users\\Julius\\Dropbox\\Master\\matlab\\Clustering\\doClustering.m}" 
 */

package doClustering;

import com.mathworks.toolbox.javabuilder.*;
import com.mathworks.toolbox.javabuilder.internal.*;

/**
 * <i>INTERNAL USE ONLY</i>
 */
public class DoClusteringMCRFactory
{
   
    
    /** Component's uuid */
    private static final String sComponentId = "doClustering_866B23AB74B5A823869B4D599C25E9E3";
    
    /** Component name */
    private static final String sComponentName = "doClustering";
    
   
    /** Pointer to default component options */
    private static final MWComponentOptions sDefaultComponentOptions = 
        new MWComponentOptions(
            MWCtfExtractLocation.EXTRACT_TO_CACHE, 
            new MWCtfClassLoaderSource(DoClusteringMCRFactory.class)
        );
    
    
    private DoClusteringMCRFactory()
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
            DoClusteringMCRFactory.class, 
            sComponentName, 
            sComponentId,
            new int[]{9,1,0}
        );
    }
    
    public static MWMCR newInstance() throws MWException
    {
        return newInstance(sDefaultComponentOptions);
    }
}
