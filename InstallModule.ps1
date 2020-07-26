$fullPath = 'C:\Program Files\WindowsPowerShell\Modules\PSYamlQuery'
Robocopy . $fullPath /mir /XD .vscode .git CI __tests__ data mdHelp /XF appveyor.yml azure-pipelines.yml .gitattributes .gitignore filelist.txt install.ps1 InstallModule.ps1
