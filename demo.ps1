# Define colors
$HeaderColor = "Cyan"
$BoldColor = "Yellow"
$CodeColor = "Green"
$DefaultColor = "White"

# Function to print colored text
function Write-ColoredText {
    param (
        [string]$Text,
        [string]$Color
    )
    Write-Host $Text -ForegroundColor $Color
}

# Read the Markdown file
$MarkdownFile = ".\file.md"
$Content = Get-Content $MarkdownFile

# Process each line
foreach ($line in $Content) {
    if ($line -match '^# ') {
        # Header level 1
        Write-ColoredText $line $HeaderColor
    } elseif ($line -match '^## ') {
        # Header level 2
        Write-ColoredText $line $HeaderColor
    } elseif ($line -match '^### ') {
        # Header level 3
        Write-ColoredText $line $HeaderColor
    } elseif ($line -match '\*\*(.+?)\*\*') {
        # Bold text
        $boldText = $line -replace '\*\*(.+?)\*\*', "$1"
        Write-ColoredText $boldText $BoldColor
    } elseif ($line -match '```') {
        # Code block
        Write-ColoredText $line $CodeColor
    } else {
        # Default text
        Write-ColoredText $line $DefaultColor
    }
}