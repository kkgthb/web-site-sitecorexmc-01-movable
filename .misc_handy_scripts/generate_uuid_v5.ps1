$parent_uuidv5_namespace = Read-Host -Prompt "Enter the parent namespace UUID (v5)"
$parent_uuidv5_doublechecker = [System.Guid]$parent_uuidv5_namespace
# Use [System.Guid]::TryParse to safely check if the string casts without throwing an error
While ($parent_uuidv5_namespace -ne [String]$parent_uuidv5_doublechecker) {
    Write-Host "Invalid UUID format. Please try again." -ForegroundColor 'Red'
    $parent_uuidv5_namespace = Read-Host -Prompt "Enter the parent namespace UUID (v5)"
    $parent_uuidv5_doublechecker = [System.Guid]$parent_uuidv5_namespace
}
Write-Host "Using parent UUIDv5: $parent_uuidv5_namespace" -ForegroundColor 'Cyan'
$fresh_name = Read-Host -Prompt "Enter the fresh name to append to it"
While (-not $fresh_name) {
    Write-Host "Name may not be blank.  Please try again." -ForegroundColor 'Red'
    $fresh_name = Read-Host -Prompt "Enter the fresh name to append to it"
}
Write-Host "Using fresh name: $fresh_name" -ForegroundColor 'Cyan'
$fresh_name_base64 = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($fresh_name));
$fresh_guid = (Invoke-RestMethod "https://www.uuidtools.com/api/generate/v5/namespace/$parent_uuidv5_namespace/name/base64:$fresh_name_base64")
$fresh_guid | Set-Clipboard
Write-Host "Fresh UUID v5 is: $fresh_guid and is now on your clipboard." -ForegroundColor 'Green'
Write-Host $fresh_guid
