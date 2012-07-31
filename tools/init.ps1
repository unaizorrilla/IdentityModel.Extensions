﻿param($installPath, $toolsPath, $package, $project)

$importedModule = Get-Module | ?{ $_.Name -eq 'IdentityModelExtensions' }

if ($PSVersionTable.PSVersion -ge (New-Object Version @( 3, 0 )))
{
	$thisModuleManifest = 'IdentityModelExtensions.PS3.psd1'
}
else
{
	$thisModuleManifest = 'IdentityModelExtensions.psd1'
}

$thisModule = Test-ModuleManifest (Join-Path $toolsPath $thisModuleManifest)
$shouldImport = $true

if ($importedModule)
{
    if ($importedModule.Version -le $thisModule.Version)
    {
        Remove-Module IdentityModelExtensions
    }
    else
    {
        $shouldImport = $false
    }    
}

if ($shouldImport)
{
    Import-Module $thisModule
}
