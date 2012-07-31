<#
.SYNOPSIS
    Save current local sts profile

.DESCRIPTION
    Save the current local sts profile into a new file with the name specified in ProfileName parameter.
    You can use this saved profile with the command Set-LocalSTSProfile

.PARAMETER ProfileName
    Specifies the new profile name for current local sts configuration.
#>
function Save-CurrentLocalSTSProfile
{
    [CmdletBinding(DefaultParameterSetName = 'ProfileName')] 
    param (
        [parameter(ParameterSetName = 'ProfileName',Mandatory=$true)]
        [string] $ProfileName
    )
    
    $project = Get-Project;
    $path = Split-Path $project.FullName;
    
    
    if ( Test-Path $path ){
    
        $filename = "LocalSTS.exe.config"
        $currentpath = Join-Path $path $filename
        Save-Copy $currentpath $ProfileName
        
    }
    else{
    
        Write-Host "No LocalSTS.exe.config is located in current project. For more information about Identity and Access Tool see http://blogs.msdn.com/b/vbertocci/archive/2012/03/15/windows-identity-foundation-tools-for-visual-studio-11-part-i-using-the-local-development-sts.aspx";
        
    }
    
}
<#
.SYNOPSIS
    Save current local sts profile

.DESCRIPTION
    Save the current local sts profile into a new file with the name specified in ProfileName parameter.
    You can use this saved profile with the command Set-LocalSTSProfile

.PARAMETER ProfileName
    Specifies the new profile name for current local sts configuration.
#>
function Set-LocalSTSProfile
{
    [CmdletBinding(DefaultParameterSetName = 'ProfileName')] 
    param (
        [parameter(ParameterSetName = 'ProfileName',Mandatory=$true)]
        [string] $ProfileName
    )
   
    Write-Host "Stoping LocalSTS process" ;
    
    stop-process -processname localsts 
    
    $project = Get-Project;
    $path = Split-Path $project.FullName;
    
    $profilepath = Join-Path $path ($ProfileName + ".stsprofile");
    $localstspath = Join-Path $path "LocalSTS.exe.config";
    
    if ( Test-Path $profilepath ){
    
        Copy-Item $profilePath $localstspath
        
        Write-Host "The  profile " $ProfileName " is now configured in LocalSTS";
    }
    else{
   
        Write-Host "The profile not exist";
        Write-Host "Please use Get-LocalSTSProfiles for get a list of current stored local sts profiles";
    }
    
    
    
}

<#
.SYNOPSIS
    Get the saved local sts profiles

.DESCRIPTION
    Get all saved local sts profiles
#>
function Get-LocalSTSProfiles
{
    $project = Get-Project;
    $path = Split-Path $project.FullName;
    
    $files = [IO.Directory]::GetFiles($path,"*.stsprofile");
    Write-Host "Stored Local STS Profiles"
    Write-Host " ---------------------   "
    Write-Host
    foreach($item in $files)
    {
        $profile =  [IO.Path]::GetFileNameWithoutExtension($item);
        
        Write-Host $profile;
    }
    Write-Host
    Write-Host " ---------------------   "
}



function Save-Copy($Current,$ProfileName)
{
    $newpath = Split-Path $Current
    $newpath = Join-Path $newpath ($ProfileName + ".stsprofile")
    Copy-Item $Current $newpath
    
    Write-Host "The new profile is saved.You can view all saved profiles with Get-localSTSProfiles"
}

Export-ModuleMember @( 'Save-CurrentLocalSTSProfile','Get-LocalSTSProfiles', 'Set-LocalSTSProfile')