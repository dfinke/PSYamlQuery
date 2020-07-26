Import-Module $PSScriptRoot\..\PSYamlQuery.psd1 -Force

Describe "Test Compare-Yaml"  {
    It "Should compare and no changes" {
        $file1 = "$PSScriptRoot\yaml\sample-docker-compose.yml"
        $file2 = "$PSScriptRoot\yaml\sample-docker-compose.yml"

        $actual = Compare-Yaml $file1 $file2
        $actual | Should -BeNullOrEmpty
    }

    It "Should compare and have changes" -Skip {
        $file1 = "$PSScriptRoot\yaml\animals.yml"
        $file2 = "$PSScriptRoot\yaml\different-animals.yml"

        Compare-Yaml $file1 $file2 | Tee-Object -Variable actual
                
        $expected = @'
 animals:
   - cats
-  - dog
+  - bird
   - cheetah
'@
        $actual | Should -BeExactly $expected
    }

}