# List-GitHub-PullRequests

This is a PowerShell script that lists the currently open PRs on a given set of Repository URLs.

## Usage

```
.\List-GitHub-PullRequests.ps1 -RepositoryUris @("https://github.com/microsoft/PowerShellForGitHub", "https://github.com/cake-build/cake", "https://github.com/BrighterCommand/Brighter")
```

## Prerequisites

This script relies on the [PowerShellForGitHub](https://github.com/microsoft/PowerShellForGitHub) module. The script should automatically download and import the module for you if you don't have it, setting the scope to the current user only. If you want to set the scope machine wide then you need to install that yourself.

