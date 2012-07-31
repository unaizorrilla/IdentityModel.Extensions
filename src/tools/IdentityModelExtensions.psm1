<#
.SYNOPSIS
    Enables Code First Migrations in a project.

.DESCRIPTION
    Enables Migrations by scaffolding a migrations configuration class in the project. If the
    target database was created by an initializer, an initial migration will be created (unless
    automatic migrations are enabled via the EnableAutomaticMigrations parameter).

.PARAMETER ProfileName
    Specifies the new profile name for current local sts configuration.
#>
function Save-CurrentLocalSTSProfile
{
    [CmdletBinding(DefaultParameterSetName = 'ProfileName')] 
    param (
        [parameter(ParameterSetName = 'ProfileName')]
        [string] $ProfileName
    )

   Write-Host "executed save-CurrentLocalSTSProfile with " + $ProfileName + "as the profile name";
}

Export-ModuleMember @( 'Save-CurrentLocalSTSProfile')