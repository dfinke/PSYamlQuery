function Update-Yaml {
    <#
        .Synopsis
        Updates all the matching nodes of path expression in a yaml file to the supplied value.        
    #>
    param(
        $File,
        $Pattern,
        $NewValue,
        #process document index number
        $DocNumber = "*"
    )

    $d = "-d$($DocNumber)"
    &$script:yq w $File $Pattern $NewValue $d
}