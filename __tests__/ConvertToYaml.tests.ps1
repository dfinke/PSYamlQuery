Import-Module $PSScriptRoot\..\PSYamlQuery.psd1 -Force

Describe "Test ConvertTo-Yaml" {
    It "Should convert PowerShell to Yaml" {
        $target = [PSCustomObject][Ordered]@{
            a = 'Easy! as one two three'
        }

        $actual = ConvertTo-Yaml -Target $target

        $actual | Should -BeExactly 'a: Easy! as one two three'
    }

    It "Should convert PowerShell to Yaml, when piping " {
        $target = [PSCustomObject][Ordered]@{
            a = 'Easy! as one two three'
        }

        $actual = $target | ConvertTo-Yaml

        $actual | Should -BeExactly 'a: Easy! as one two three'
    }

    It "Should convert JSON to Yaml" {
        $actual = ConvertTo-Yaml -target '{"a":"Easy! as one two three","b":{"c":2,"d":[3,4]}}'
        $actual = $actual -join "`r`n"
        
        $expected = @'
a: Easy! as one two three
b:
  c: 2
  d:
    - 3
    - 4
'@

        $actual | Should -BeExactly $expected
    }

    It "Should convert JSON to Yaml, when piping" {
        $actual = '{"a":"Easy! as one two three","b":{"c":2,"d":[3,4]}}' | ConvertTo-Yaml 
        $actual = $actual -join "`r`n"
        
        $expected = @'
a: Easy! as one two three
b:
  c: 2
  d:
    - 3
    - 4
'@

        $actual | Should -BeExactly $expected
    }

    It "Should handle path expressions" {
        $target = [PSCustomObject][Ordered]@{
            a = @{b = 2 }
        }

        $actual = ConvertTo-Yaml -Target $target -Pattern a.b

        $actual | Should -Be 2
    }

    It "Should handle path expressions, when piping" {
        $target = [PSCustomObject][Ordered]@{
            a = @{b = 2 }
        }

        $actual = $target | ConvertTo-Yaml -Pattern a.b

        $actual | Should -Be 2
    }

    It "Should handle depth when converting" {
        $target = @{
            services = @{
                powershellmicroservice = [ordered]@{
                    ports = @('8080:8080')
                    build = '.\powershell'
                }
            }
        }

        $actual = $target | ConvertTo-Yaml -Depth 3
        $actual = $actual -join "`r`n"

        $expected = @'
services:
  powershellmicroservice:
    ports:
      - 8080:8080
    build: .\powershell
'@            
        $actual | should -BeExactly $expected
    }
}