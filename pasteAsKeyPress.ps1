###############################################################################################################
# pasteAsKeyPress.ps1
# Version: 1.0
# Date: 2025-07-23
# written by: sim756
# GitHub: https://github.com/sim756/pasteAsKeyPress
# License: MIT License
# This script is provided "as is" without warranty of any kind, either expressed or implied.
#
# Description:
# This PowerShell script reads the current clipboard text content and simulates key presses for each character.
#
# Usage Case:
# Some applications/web-application do not support pasting text directly from the clipboard for security
# purposes forcing users to type manually, such as password fields or secure input fields. This can be
# inconvenient and time consuming, especially for long strong password strings.
#
# Usage:
# 1. Copy text to clipboard.
# 2. Run this script in PowerShell.
# 3. Enter wait time or continue with default value, 5 seconds. It will wait for this specified time before
#    starting to paste.
# 4. Switch to the application you want which to receive the keypresses.
# 5. The script will simulate key presses for each character in the clipboard text.
#
# Requirements:
# - PowerShell 5.0 or later
# - .NET installed (for Windows Forms)
#
# Note: This script is intended for use in a Windows environment where the clipboard and SendKeys
# functionality are available.
#
# Important:
# - Use this script responsibly. Simulating key presses can interfere with other applications.
# - Ensure you have the necessary permissions to access the clipboard and send key presses.
# - Ensure you run this script in a context where it can access the clipboard and send key presses.
# - Ensure you have the necessary permissions to run scripts in PowerShell.
#
# Disclaimer:
# The author is not responsible for any unintended consequences of using this script.
#
###############################################################################################################

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

function PasteAsKeyPress
{
    $clipboardText = [Windows.Forms.Clipboard]::GetText()
    $length = $clipboardText.Length

    if ($length -eq 0)
    {
        Write-Host "Clipboard is empty or doesn't have text type data. Exiting script." -ForegroundColor Yellow
        return
    }

    $waitSeconds = Read-Host "Enter wait time in seconds before starting (default 5)"
    if (-not $waitSeconds) 
    { 
        $waitSeconds = 5 
    }    
    $waitSeconds = [int]$waitSeconds
    
    try
    {
        for ($i = $waitSeconds; $i -ge 1; $i--)
        {
            Write-Host "Pasting in $i..." -ForegroundColor Cyan
            Start-Sleep -Seconds 1
        }
    }
    catch
    {
        Write-Host "Invalid wait time. Please enter a valid number." -ForegroundColor Red
        Write-Host "Exiting script." -ForegroundColor Yellow
        return
    }

    Write-Host "Pasting clipboard text..." -ForegroundColor Green
    [Windows.Forms.Application]::DoEvents()
    Start-Sleep -Milliseconds 150

    for ($index = 0; $index -lt $length; $index++)
    {
        $charStr = $clipboardText[$index].ToString().Replace("(", "{(}").Replace(")", "{)}")

        try
        {
            [Windows.Forms.SendKeys]::SendWait($charStr)
            [Windows.Forms.Application]::DoEvents()
            Start-Sleep -Milliseconds 10
            Write-Host "Sent: $charStr" -ForegroundColor Gray
        }
        catch
        {
            Write-Warning "Error sending key press at index $index (`"$charStr`"): $_" -ForegroundColor Red
            Write-Host "Exiting script." -ForegroundColor Yellow
            return
        }
    }

    Write-Host "`nPasted, sent clipboard text content as key-press." -ForegroundColor Green
}

PasteAsKeyPress
