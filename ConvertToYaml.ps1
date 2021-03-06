function ConvertTo-Yaml {
    <#
        .Synopsis
        Converts PowerShell|Json to Yaml
    #>
    param(    
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [AllowEmptyString()]
        $target,
        $Pattern,
        $Depth = 1
    )

    Begin {        
        $t = @()
    }

    Process {
        if ($target -is [PSCustomObject]) {
            $t += $target
        }
    }

    End {
    
        if ($target -is [String]) {
            $target | &$script:yq r - --prettyPrint $Pattern
        }
        elseif ($target -is [PSCustomObject]) {
            $t | ConvertTo-Json -Depth $Depth | &$script:yq r - --prettyPrint $Pattern
        }
    }
}
