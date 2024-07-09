# Function to print a table with colored headers
function Print-Table {
    param (
        [string[]]$Headers,
        [string[][]]$Rows
    )

    # Set colors
    $HeaderColor = "White"
    $RowColor = "White"

    # Print headers
    $HeaderLine = ""
    foreach ($header in $Headers) {
        $HeaderLine += "{0,-20}" -f $header
    }
    Write-Host $HeaderLine -ForegroundColor $HeaderColor

    # Print rows
    foreach ($row in $Rows) {
        $RowLine = ""
        foreach ($cell in $row) {
            $RowLine += "{0,-20}" -f $cell
        }
        Write-Host $RowLine -ForegroundColor $RowColor
    }
}

# Example headers and rows
$headers = @("Name", "Age", "City")
$rows = @(
    @("Alice", "30", "New York"),
    @("Bob", "25", "Los Angeles"),
    @("Charlie", "35", "Chicago")
)

# Print the table
Print-Table -Headers $headers -Rows $rows