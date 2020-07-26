Import-Module $PSScriptRoot\..\PSYamlQuery.psd1 -Force

Describe "Test Import-Yaml" {    
    It "Should be correct number of properties" {
        $fileName = "$PSScriptRoot\yaml\sample-docker-compose.yml"
        $actual = Import-Yaml $fileName

        $names = $actual.services.psobject.properties.name
        $names.Count | Should -Be 4
    }

    It "Each service should have a build and ports property" {
        $fileName = "$PSScriptRoot\yaml\sample-docker-compose.yml"
        $actual = Import-Yaml $fileName

        $names = $actual.services.psobject.properties.name
        
        foreach ($name in $names) {
            $actual.services.$name.build | Should -Not -BeNullOrEmpty 
            $actual.services.$name.ports | Should -Not -BeNullOrEmpty 
        }
    }

    It "Should match path expression " {
        $fileName = "$PSScriptRoot\yaml\sample-docker-compose.yml"
        $actual = Import-Yaml $fileName services.*

        $actual.Count | Should -Be 4

        $actual[0].build | Should -BeExactly ".\powershell"
        $actual[0].ports | Should -BeExactly "8080:8080"

        $actual[1].build | Should -BeExactly ".\python"
        $actual[1].ports | Should -BeExactly "8081:8081"

        $actual[2].build | Should -BeExactly ".\deno"
        $actual[2].ports | Should -BeExactly "8082:8082"

        $actual[3].build | Should -BeExactly ".\dotnetcore"
        $actual[3].ports | Should -BeExactly "3000:80"
    }

    It "Should return values from expression " {
        $fileName = "$PSScriptRoot\yaml\matchingPaths.yml"
        $actual = Import-Yaml $fileName a.thing*.*

        $actual.Count | Should -Be 2

        $actual[0] | Should -BeExactly "cat"
        $actual[1] | Should -BeExactly "car"
    }

    It "Should return path from expression " {
        $fileName = "$PSScriptRoot\yaml\matchingPaths.yml"
        $actual = Import-Yaml $fileName a.thing*.* -printmode 'path'

        $actual.Count | Should -Be 2

        $actual[0] | Should -BeExactly "a.thing_a.animal"
        $actual[1] | Should -BeExactly "a.thing_b.vehicle"                
    }

    It "Should return both path value from expression " {
        $fileName = "$PSScriptRoot\yaml\matchingPaths.yml"
        $actual = Import-Yaml $fileName a.thing*.* -printmode 'pathvalue'

        $actual.Count | Should -Be 2

        $actual[0] | Should -BeExactly "a.thing_a.animal: cat"
        $actual[1] | Should -BeExactly "a.thing_b.vehicle: car"             
    }

    It "Should return correct info from complex expressions" {
        
        $fileName = "$PSScriptRoot\yaml\animals.yml"
        $actual = Import-Yaml $fileName 'animals.(.==c*)' -printmode 'pathvalue'

        $actual.Count | Should -Be 2

        $actual[0] | Should -BeExactly "animals.[0]: cats"
        $actual[1] | Should -BeExactly "animals.[2]: cheetah"
    }
}