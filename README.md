# pasteAsKeyPress.ps1

>Version: 1.0

>Date: 2025-07-23

>written by: sim756

>GitHub: https://github.com/sim756/pasteAsKeyPress

>License: MIT License
>This script is provided "as is" without warranty of any kind, either expressed or implied.

<img width="1362" height="762" alt="image" src="https://github.com/user-attachments/assets/dbdc010b-6600-4cae-bb84-a7c631faa496" />

## Description
PowerShell script, reads the current clipboard text content and simulates key presses for each character.

## Use Case
Some applications/web-application do not support pasting text directly from the clipboard for security
purposes forcing users to type manually, such as password fields or secure input fields. This can be
inconvenient and time consuming, especially for long strong password strings.

## Usage
1. Copy text to clipboard.
2. Run this script in PowerShell.
3. Enter wait time or continue with default value, 5 seconds. It will wait for this specified time before
   starting to paste.
4. The script will simulate key presses for each character in the clipboard text.

## Requirements
- PowerShell 5.0 or later
- .NET installed (for Windows Forms)

**Note:** This script is intended for use in a Windows environment where the clipboard and SendKeys
functionality are available.

## Important
- Use this script responsibly. Simulating key presses can interfere with other applications.
- Ensure you have the necessary permissions to access the clipboard and send key presses.
- Ensure you run this script in a context where it can access the clipboard and send key presses.
- Ensure you have the necessary permissions to run scripts in PowerShell.

## Disclaimer
The author is not responsible for any unintended consequences of using this script.
