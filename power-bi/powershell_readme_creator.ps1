# PowerShell script to create README.md files in report folders
# Run this from your power-bi directory

param(
    [Parameter(Mandatory=$true)]
    [string]$WorkspaceName,
    
    [Parameter(Mandatory=$true)]
    [string]$BasePath,
    
    [Parameter(Mandatory=$false)]
    [string]$Status = "Development"
)

# Get current date
$currentDate = Get-Date -Format "yyyy-MM-dd"

# README template
$readmeTemplate = @"
# {REPORT_NAME}

## Source Information
- **PowerBI Workspace**: $WorkspaceName
- **Date Migrated**: $currentDate

## Status
- **Current Status**: $Status
- **Active Use**: Unknown

## Notes
- Migrated during workspace cleanup
- Review for current relevance and data sources

## Next Steps
- [ ] Review for production readiness
- [ ] Document data sources
- [ ] Update if needed
"@

# Get all subdirectories in the specified path
$folders = Get-ChildItem -Path $BasePath -Directory -Recurse

foreach ($folder in $folders) {
    $readmePath = Join-Path $folder.FullName "README.md"
    
    # Only create if README.md doesn't already exist
    if (-not (Test-Path $readmePath)) {
        # Replace {REPORT_NAME} with folder name
        $readmeContent = $readmeTemplate -replace '{REPORT_NAME}', $folder.Name
        
        # Create the README.md file
        Set-Content -Path $readmePath -Value $readmeContent
        Write-Host "Created README.md in: $($folder.FullName)" -ForegroundColor Green
    } else {
        Write-Host "README.md already exists in: $($folder.FullName)" -ForegroundColor Yellow
    }
}

Write-Host "`nCompleted! Created README.md files for workspace: $WorkspaceName" -ForegroundColor Cyan