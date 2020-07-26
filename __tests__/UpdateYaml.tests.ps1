Import-Module $PSScriptRoot\..\PSYamlQuery.psd1 -Force

Describe "Test Upate-Yaml" {
  It "Should update the yaml" {
    $file = "$PSScriptRoot\yaml\sample-to-update.yml"
    $actual = Update-Yaml $file b.c cat
    $expected = @'
b:
  c: cat
'@
    ($actual -join "`r`n") | Should -BeExactly $expected
  }
    
  It "Should update the yaml" {
    $actual = Update-Yaml .\__tests__\yaml\sample-to-update.yml b.d[+] 'new thing'

    $expected = @'
b:
  c: 2
  d:
    - new thing
'@

    ($actual -join "`r`n") | Should -BeExactly $expected
  }

  It "Should update the first doc of the yaml" {
    $actual = Update-Yaml .\__tests__\yaml\multidoc.yml b.c 5 -DocNumber 0
    $expected = @'
something: else
b:
  c: 5
---
b:
  c: 2
'@
    ($actual -join "`r`n") | Should -BeExactly $expected
  }

  It "Should update the second doc of the yaml" {
    $actual = Update-Yaml .\__tests__\yaml\multidoc.yml b.c 5 -DocNumber 1
    $expected = @'
something: else
---
b:
  c: 5
'@
    ($actual -join "`r`n") | Should -BeExactly $expected
  }

  It "Should update both docs of the yaml" {
    $actual = Update-Yaml .\__tests__\yaml\multidoc.yml b.c 5
    $expected = @'
something: else
b:
  c: 5
---
b:
  c: 5
'@
    ($actual -join "`r`n") | Should -BeExactly $expected
  }  
}