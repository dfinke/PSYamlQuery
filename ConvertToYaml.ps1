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
        if (!(Test-YQInstalled)) {
            Write-Error "YQ is not installed"
        }

        $t = @()
    }

    Process {
        if ($target -is [PSCustomObject]) {
            $t += $target
        }
    }

    End {
    
        if ($target -is [String]) {
            $target | yq r - --prettyPrint $Pattern
        }
        elseif ($target -is [PSCustomObject]) {
            $t | ConvertTo-Json -Depth $Depth | yq r - --prettyPrint $Pattern
        }
    }
}
