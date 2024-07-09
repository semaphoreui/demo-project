# Function to print a table with colored headers
function Print-Table {
    param (
        [string[]]$Headers,
        [string[][]]$Rows
    )

    # Set colors
    $HeaderColor = "Red"
    $RowColor = "White"

    # Print headers
    $HeaderLine = ""
    foreach ($header in $Headers) {
        $HeaderLine += "{0,-40}" -f $header
    }
    Write-Host $HeaderLine -ForegroundColor $HeaderColor

    # Print rows
    foreach ($row in $Rows) {
        $RowLine = ""
        foreach ($cell in $row) {
            $RowLine += "{0,-40}" -f $cell
        }
        Write-Host $RowLine -ForegroundColor $RowColor
    }
}

# Gather system statistics
$cpu = Get-WmiObject -Class Win32_Processor | Select-Object -ExpandProperty LoadPercentage
$memory = Get-WmiObject -Class Win32_OperatingSystem
$totalMemory = [math]::Round($memory.TotalVisibleMemorySize / 1MB, 2)
$freeMemory = [math]::Round($memory.FreePhysicalMemory / 1MB, 2)
$usedMemory = $totalMemory - $freeMemory
$disk = Get-WmiObject -Class Win32_LogicalDisk -Filter "DriveType=3"
$diskStats = @()
foreach ($d in $disk) {
    $diskStats += @($d.DeviceID, [math]::Round($d.Size / 1GB, 2), [math]::Round($d.FreeSpace / 1GB, 2))
}

Write-Output "-------------- System Statistics --------------"
# Create table data
$headers = @("Metric", "Value")
$rows = @(
    @("CPU Usage (%)", "$cpu%"),
    @("Total Memory (GB)", "$totalMemory GB"),
    @("Used Memory (GB)", "$usedMemory GB"),
    @("Free Memory (GB)", "$freeMemory GB"),
    @("Disk $($diskStats[0]) Total (GB)", "$($diskStats[1]) GB")
)

# Print the table
Print-Table -Headers $headers -Rows $rows