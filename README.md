# List-GitHub-PullRequests

This is a PowerShell script that lists the currently open PRs on a given set of Repository URLs.

## Usage

```
.\List-GitHub-PullRequests.ps1 -RepositoryUris @("https://github.com/microsoft/PowerShellForGitHub", "https://github.com/cake-build/cake", "https://github.com/BrighterCommand/Brighter")
```

## Prerequisites

### PowerShellForGitHub

This script relies on the [PowerShellForGitHub](https://github.com/microsoft/PowerShellForGitHub) module. The script should automatically download and import the module for you if you don't have it, setting the scope to the current user only. If you want to set the scope machine wide then you need to install that yourself.

### GitHub Personal Access Token

You will need to create a personal access token on GitHub to use with this script.

To create a token:
* Go to [your "personal access token" settings on GitHub.com](https://github.com/settings/tokens).
* Click on "Generate new token".
* Give the token a "note"
* Select the "repo" group
* Click on "Generate token"

You should then be back to the "Personal access tokens" page, with a new token displaying. **You need to copy this now, it won't be available again**

You can then authenticate using the command `Set-GitHubAuthentication`. It will pop-up a dialog box asking for a username and password. The Personal Access Token should go in the password box. You can enter anything you like as the user (but you must enter something).

