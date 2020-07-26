function Merge-Yaml {
    <#
        .Synopsis
        Merge multiple yaml files into a one
        .Description
        Yaml files can be merged using the 'merge' command. Each additional file merged with the first file will set values for any key not existing already or where the key has no value.    
    #>
    param(
        [parameter(mandatory=$false, position=1, ValueFromRemainingArguments=$true)]
        $Files,
        [Switch]$Append
    )
    
    yq merge --append=$Append $Files
}