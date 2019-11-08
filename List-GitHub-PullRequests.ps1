# This script is based on a script at https://github.com/Stravaig-Projects/List-GitHub-PullRequests

[CmdletBinding()]
param
(
    [string[]] $RepositoryUris,

    [string]$DateFormat = "dddd, d, MMMM yyyy HH:mm:ss"
)

###
### Ensure that the PowerShell module is installed
###

if ($null -eq (Get-Module -Name PowerShellForGitHub))
{
    Write-Host "The required module was not found. Installing `"PowerShellForGitHub`".";
    Install-Module -Name PowerShellForGitHub -Scope CurrentUser -Force;
    Import-Module -Name PowerShellForGitHub
}
else 
{
    Write-Verbose "The module `"PowerSehllForGitHub`" already installed."
}

###
### Ensure that the user is configured
###

if ((Test-GitHubAuthenticationConfigured) -eq $false)
{
    Write-Warning "You must call Set-GitHubAuthentication prior to running this script. For more details, see: https://github.com/Stravaig-Projects/List-GitHub-PullRequests#github-personal-access-token";
    Exit 1;
}
else 
{
    Write-Verbose "The GitHub authentication token has been set."    
}

$isFirst = $true;
foreach($repositoryUri in $repositoryUris)
{
    if ($isFirst)
    {
        $isFirst = $false
    }
    else 
    {
        Write-Host "";
        Write-Host ([string]::New('*',80));
    }
    $pullRequests = Get-GitHubPullRequest -uri $repositoryUri -State Open -NoStatus;
    if ($null -eq $pullRequests)
    {
        Write-Host "There are no open PR(s) on $repositoryUri."
        continue;
    }
    if ($pullRequests.GetType().Name -eq "PSCustomObject")
    {
        # Always be an array
        $pullRequests = @($pullRequests);
    }
    $isFirstPr = $true;
    foreach($pullRequest in $pullRequests)
    {
        if ($isFirstPr)
        {
            $repoName = $pullRequest.head.repo.full_name;
            $count = $pullRequests.Length;
            Write-Host "There is/are $count open PR(s) on $repoName.";
            $isFirstPr = $false;
        }

        $pullRequest = Get-GitHubPullRequest -uri $repositoryUri -PullRequest $pullRequest.number -State Open -NoStatus;

        $number = $pullRequest.number;
        $prUrl = $pullRequest.html_url;
        $title = $pullRequest.title;
        $userName = $pullRequest.user.login;
        $createdAt = $pullRequest.created_at;
        $mergeState = $pullRequest.mergeable_state;
        $createdDate = (Get-Date $createdAt -Format $DateFormat)

        $colour = "White";
        if ($mergeState -eq "dirty" -or $mergeState -eq "behind"){
            $colour = "Yellow" # Needs rebased
        }
        if ($mergeState -eq "unstable" -or $mergeState -eq "blocked") {
            $colour = "Red" # Failing status check or otherwise blocked.
        }

        Write-Host " * #$number : $title" -ForegroundColor $colour;
        Write-Host "   Opened by: $userName on $createdDate" -ForegroundColor $colour;
        Write-Host "   Link: $prUrl" -ForegroundColor $colour;
        Write-Host "   Merge state: $mergeState" -ForegroundColor $colour;
    }
}
