# Run as Administrator
$report = "C:\NetToolkit\reports\health_$(Get-Date -Format 'yyyyMMdd_HHmm').txt"

"===== NETWORK HEALTH CHECK =====" | Out-File $report
"Date: $(Get-Date)" | Out-File $report -Append

"`n[ADAPTERS]" | Out-File $report -Append
Get-NetAdapter | Format-Table Name, Status, LinkSpeed, MacAddress | Out-File $report -Append

"`n[IP ADDRESSES]" | Out-File $report -Append
Get-NetIPAddress | Where-Object {$_.AddressFamily -eq "IPv4"} | 
    Format-Table InterfaceAlias, IPAddress, PrefixLength | Out-File $report -Append

"`n[DNS SERVERS]" | Out-File $report -Append
Get-DnsClientServerAddress | Format-Table InterfaceAlias, ServerAddresses | Out-File $report -Append

"`n[OPEN PORTS]" | Out-File $report -Append
Get-NetTCPConnection -State Listen | 
    Sort-Object LocalPort | 
    Format-Table LocalAddress, LocalPort, OwningProcess | Out-File $report -Append

"`n[CONNECTIVITY TESTS]" | Out-File $report -Append
$targets = @("8.8.8.8","1.1.1.1","google.com","microsoft.com")
foreach ($t in $targets) {
    $result = Test-Connection $t -Count 2 -Quiet
    "  $t : $(if ($result) {'REACHABLE'} else {'UNREACHABLE'})" | Out-File $report -Append
}

Write-Host "Report saved to $report" -ForegroundColor Green
Invoke-Item $report