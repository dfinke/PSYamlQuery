Import-Module $PSScriptRoot\..\PSYamlQuery.psd1 -Force

Describe "Test Merge-Yaml" {
    It "Should be true" {
        $true | Should -Be $true
    }
}