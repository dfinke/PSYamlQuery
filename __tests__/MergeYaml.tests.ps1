Import-Module $PSScriptRoot\..\PSYamlQuery.psd1 -Force

Describe "Test Merge-Yaml" {
    It "Should merge the yaml files" {
        $file1 = "$PSScriptRoot\yaml\data1.yml"
        $file2 = "$PSScriptRoot\yaml\data2.yml"

        $actual = Merge-Yaml $file1 $file2

        $actual[0] | Should -BeExactly 'a: simple'
        $actual[1] | Should -BeExactly 'b: [1, 2]'
        $actual[2] | Should -BeExactly 'c:'
        $actual[3] | Should -BeExactly '  test: 1'
    }

    It "Should merge and appebd arrayts from the yaml files" {
        $file1 = "$PSScriptRoot\yaml\data1Append.yml"
        $file2 = "$PSScriptRoot\yaml\data2Append.yml"

        $actual = Merge-Yaml $file1 $file2 -Append
        
        $actual[0] | Should -BeExactly 'a: simple'
        $actual[1] | Should -BeExactly 'b: [1, 2, 3, 4]'
        $actual[2] | Should -BeExactly 'd: hi'
        $actual[3] | Should -BeExactly 'c:'
        $actual[4] | Should -BeExactly '  test: 2'
        $actual[5] | Should -BeExactly '  other: true'
    }
}