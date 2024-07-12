function Ping-Ip {
    param (
        [string]$ip
    )
    
    $output = ping -n 1 -w 1000 $ip
    
    if ($output -match "Reply from") {
        return "Alive"
    } else {
        return "Dead"
    }
}

function Check-IpsFromFile {
    param (
        [string]$filename
    )

    $ips = Get-Content -Path $filename
    $results = @()

    # Initialize the progress bar
    $totalIps = $ips.Count
    $currentIpIndex = 0

    foreach ($ip in $ips) {
        $status = Ping-Ip -ip $ip
        $results += [PSCustomObject]@{IP = $ip; Status = $status}
        
        $currentIpIndex++
        $percentComplete = [math]::Floor(($currentIpIndex / $totalIps) * 100)
        Write-Progress -Activity "Pinging IPs" -Status "$currentIpIndex of $totalIps" -PercentComplete $percentComplete

        Start-Sleep -Milliseconds 100
    }

    return $results
}

function Display-Results {
    param (
        [array]$results
    )

    Write-Host "`nPing Results:`n-------------"
    foreach ($result in $results) {
        switch ($result.Status) {
            "Alive" {
                $color = "Green"
            }
            "Dead" {
                $color = "Red"
            }
            default {
                $color = "Yellow"
            }
        }
        Write-Host ("{0,-15} {1}" -f $result.IP, $result.Status) -ForegroundColor $color
    }
}

# Main script
$inputFile = "ip.txt"
$results = Check-IpsFromFile -filename $inputFile
Display-Results -results $results