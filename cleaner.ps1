###########################################################################
###########################################################################
$desktop = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::Desktop)
$archiveMaster = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::Desktop) + "\Archive"
$month = Get-Date -UFormat %B
$year = Get-Date -format yyyy
$monthYear = "$month $year"
$fullPath = "$archiveMaster\$monthYear"
###########################################################################
$imageFolder = $archiveMaster + "\" + $monthYear +"\Images"
$documentsFolder = $archiveMaster + "\" + $monthYear +"\Documents"
$scriptsFolder = $archiveMaster + "\" + $monthYear +"\Scripts" 
###########################################################################
###########################################################################

if(!(Test-Path $fullPath)){
    Write-Host "Folder Doesn't Exist"
    New-Item -Path $archiveMaster -Name "$monthYear" -ItemType "directory" -ErrorAction Stop | Out-Null
    New-Item -Path $fullPath -Name "Images" -ItemType "directory" -ErrorAction Stop | Out-Null
    New-Item -Path $fullPath -Name "Documents" -ItemType "directory" -ErrorAction Stop | Out-Null
    New-Item -Path $fullPath -Name "Scripts" -ItemType "directory" -ErrorAction Stop | Out-Null
    Write-Host "$monthYear has been created!"
}else{
    Write-Host "Folder Exists"
    $alreadyExists = $true
}

if ($alreadyExists){
    if(!(Test-Path $imageFolder)){
        Write-Host "Images Folder Doesn't Exist - Creating!"
        New-Item -Path $fullPath -Name "Images" -ItemType "directory" -ErrorAction Stop | Out-Null
    }
    if(!(Test-Path $documentsFolder)){
        Write-Host "Documents Folder Doesn't Exist - Creating!"
        New-Item -Path $fullPath -Name "Documents" -ItemType "directory" -ErrorAction Stop | Out-Null
    }
    if(!(Test-Path $scriptsFolder)){
        Write-Host "Scripts Folder Doesn't Exist - Creating!"
        New-Item -Path $fullPath -Name "Scripts" -ItemType "directory" -ErrorAction Stop | Out-Null
    }
    
}

$desktopImages = Get-ChildItem -Path $desktop | ? {$_.Name -like "*.png" -or $_.Name -like "*.jpg" -or $_.Name -like "*.jpeg" -or $_.Name -like "*.psd"}
$desktopDocuments = Get-ChildItem -Path $desktop | ? {$_.Name -like "*.txt" -or $_.Name -like "*.docx" -or $_.Name -like "*.pdf" -or $_.Name -like "*.csv"}
$desktopScripts = Get-ChildItem -Path $desktop | ? {$_.Name -like "*.ps1" -or $_.Name -like "*.py"}

foreach($image in $desktopImages){
    $imageVar = $image.Name
    Move-Item "$desktop\$imageVar" -Destination "$imageFolder"
}

foreach($document in $desktopDocuments){
    $documentVar = $document.Name
    Move-Item "$desktop\$documentVar" -Destination "$documentsFolder"
}

foreach($script in $desktopScripts){
    $scriptVar = $script.Name
    Move-Item "$desktop\$scriptVar" -Destination "$scriptsFolder"
}
###########################################################################
###########################################################################

Write-Host "`n`nScript has successfully completed!"
