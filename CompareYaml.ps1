function Compare-Yaml {
    <#
        .Synopsis
        Deeply compare two yaml documents
    #>
    param(
        [Parameter(Mandatory)]        
        $File1,        
        [Parameter(Mandatory)]        
        $File2,
        $Pattern        
    )
    
    if (!(Test-YQInstalled)) {
        Write-Error "YQ is not installed"
    }

    yq compare $File1 $File2 $Pattern
}