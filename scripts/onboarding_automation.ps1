<#
.SYNOPSIS
    TechCorp Automated User Onboarding Script
.DESCRIPTION
    This script simulates the "Joiner" process. It reads new hire data from a CSV,
    generates a secure temporary password, and calculates the correct access groups
    based on the user's department.
.AUTHOR
    Lee-roy Breat Chimuka
.DATE
    2025-10-26
#>

# 1. Define the Input Data Source (Simulating HR System Export)
$csvFilePath = ".\new_hires.csv"

# Check if file exists
if (-not (Test-Path $csvFilePath)) {
    Write-Host "Error: HR Data file not found!" -ForegroundColor Red
    exit
}

# Importing the data
$newHires = Import-Csv $csvFilePath

Write-Host "--- TechCorp IAM Automation Started ---" -ForegroundColor Cyan
Write-Host "Processing $($newHires.Count) new records..." -ForegroundColor Yellow

foreach ($user in $newHires) {
    # 2. Generate User Principal Name (UPN) standard: firstname.lastname@techcorp.com
    $upn = "$($user.FirstName).$($user.LastName)@techcorp.com".ToLower()
    
    # 3. Security Logic: Generate a random temporary password. In a real scenario, this would be emailed to the manager or sent via SMS
    $randomPass = -join ((65..90) + (97..122) + (48..57) | Get-Random -Count 12 | % {[char]$_})
    
    # 4. Access Control Logic (RBAC)
    # Assign groups based on Department attribute
    $assignedGroups = @("All_Employees") # Everyone gets this
    
    switch ($user.Department) {
        "IT" { $assignedGroups += "Privileged_Access_Users"; $assignedGroups += "Server_Admins" }
        "Sales" { $assignedGroups += "Salesforce_Users"; $assignedGroups += "External_Email_Access" }
        "Finance" { $assignedGroups += "Finance_Sensitive_Data" }
        Default { $assignedGroups += "General_Access" }
    }

    # 5. Output the Action (Simulation). In a real AD environment, we would use: New-ADUser -Name $user.FirstName ...
    
    Write-Host "--------------------------------" -ForegroundColor Gray
    Write-Host "Creating Identity: $upn" -ForegroundColor Green
    Write-Host "Department: $($user.Department)"
    Write-Host "Location: $($user.Location)"
    Write-Host "Security Action: Password generated & set to force change on login."
    Write-Host "Provisioning Access Groups:" -ForegroundColor Cyan
    foreach ($group in $assignedGroups) {
        Write-Host "  [+] Added to $group" -ForegroundColor Cyan
    }
}

Write-Host "--------------------------------" -ForegroundColor Gray
Write-Host "--- Onboarding Complete. Logs saved to Audit Trail. ---" -ForegroundColor Cyan
