###########################################################################
###########################################################################
$desktop = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::Desktop)
$archiveMaster = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::Desktop) + "\Archive"
$month = Get-Date -UFormat %B
$year = Get-Date -format yyyy
$folderCheck = Get-ChildItem -path $archiveMaster -Directory
$workingFolder = "$month $year"
###########################################################################
###########################################################################
$create = $false
foreach($folder in $folderCheck){
    if($folder.Name -like $workingFolder){
        $create = $false
    }else {
        $create = $true
    }
}

if($create){
    New-Item -Path $archiveMaster -Name "$workingFolder" -ItemType "directory" -ErrorAction Stop | Out-Null
    $transferPath = "$archiveMaster\$workingfolder"
    New-Item -Path $transferPath -Name "Images" -ItemType "directory" -ErrorAction Stop | Out-Null
    New-Item -Path $transferPath -Name "Documents" -ItemType "directory" -ErrorAction Stop | Out-Null
    New-Item -Path $transferPath -Name "Scripts" -ItemType "directory" -ErrorAction Stop | Out-Null
    Write-Host "$workingFolder has been created!"
    
}else {
    Write-Host "Working in $workingFolder directory."
}
###########################################################################
###########################################################################
$desktopImages = Get-ChildItem -Path $desktop | ? {$_.Name -like "*.png" -or $_.Name -like "*.jpg" -or $_.Name -like "*.jpeg" -or $_.Name -like "*.psd"}
$desktopDocuments = Get-ChildItem -Path $desktop | ? {$_.Name -like "*.txt" -or $_.Name -like "*.docx" -or $_.Name -like "*.pdf" -or $_.Name -like "*.csv"}
$desktopScripts = Get-ChildItem -Path $desktop | ? {$_.Name -like "*.ps1" -or $_.Name -like "*.py"}

foreach($image in $desktopImages){
    Move-Item "$desktop\$image" -Destination "$transferPath\Images"
}

foreach($document in $desktopDocuments){
    Move-Item "$desktop\$document" -Destination "$transferPath\Documents"
}

foreach($script in $desktopScripts){
    Move-Item "$desktop\$script" -Destination "$transferPath\Scripts"
}
###########################################################################
###########################################################################
Write-Host "`n`nScript has successfully completed!"
