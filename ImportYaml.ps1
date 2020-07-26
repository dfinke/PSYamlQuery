function Import-Yaml {
    <#
        .Synopsis
        Returns matching nodes/values of a path expression for a given yaml document
    #>
    param(
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]        
        [AllowEmptyString()]
        $Path,
        $Pattern,
        [ValidateSet('value', 'path', 'pathvalue')]
        $PrintMode = 'value'
    )

    Begin {
        CheckYQIsInstalled
    }

    Process {
        if ($Path -is [System.IO.FileSystemInfo]) {
            $fullName = $Path.FullName            
        }
        else {
            $fullName = Resolve-Path $Path -ErrorAction SilentlyContinue
        }

        if ($fullName) {
            switch ($PrintMode) {
                "value" { yq r $fullName $Pattern --tojson | ConvertFrom-Json }
                "path" { yq r $fullName $Pattern --printMode p }
                "pathvalue" { yq r $fullName $Pattern --printMode pv }
            }
        }
    }    
}