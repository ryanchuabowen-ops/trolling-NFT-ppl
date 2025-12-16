###how to piss off NFT consooomers the even faster way
do{
$input = Read-Host -Prompt "[o_o] Input opensea link with art NFT"
write-host "[o_o] Art NFT links will be saved in [C:\Users\Public\Documents\NFT\NFT-links.txt]"
$saveInput = read-host -prompt "[O_o] Save art NFT images in [C:\Users\Public\Pictures] (True/False)?"
$scraped = Invoke-WebRequest -uri $input -UseBasicParsing

$list = @("0")
@($scraped.Content -split '"').ForEach({
if($_ -match "https://lh3.googleusercontent.com" -and $_ -notmatch $list[0..-1]){
$list += $_
}
})

$list = $list -replace "=s120", "" -replace "=w1400-k", "" -replace "=s60", "" -replace "=s100", "" -replace "=s2500", ""

$cleanlist = $list | select -Unique | Where-Object {$_ -ne "0"} | Where-Object {$_ -notcontains "https://lh3.googleusercontent.com"}

if((Get-ChildItem -Path "C:\Users\Public\Documents\" -Filter "*NFT*" | where {$_.Name -like "*NFT*"} | Select-Object Name).Name -eq "NFT" -and (Get-ChildItem -Path "C:\Users\Public\Documents\NFT\" -Filter "*NFT-links*.*" | where {$_.Name -like "*NFT-links*.*"} | Select-Object Name).Name -eq "NFT-links.txt"){
Set-Content -Path "C:\Users\Public\Documents\NFT\NFT-links.txt" -Value ((Get-Content -Path "C:\Users\Public\Documents\NFT\NFT-links.txt") + $cleanlist)
if($saveInput -eq "True"){
 @($cleanlist).ForEach({
Invoke-WebRequest -Uri $_ -OutFile ("C:\Users\Public\Pictures\" + ($_ -replace "https://lh3.googleusercontent.com/", "") + ".gif")
})
}
Write-Host "[^_^] Job done!"
$agree = Read-Host "[O_o] Repeat process[Y/N]?"
}
else{
New-Item -Path "C:\Users\Public\Documents" -Name "NFT" -ItemType "Directory"
New-Item -Path "C:\Users\Public\Documents\NFT" -Name "NFT-links.txt" -ItemType "file" 
Set-Content -Path "C:\Users\Public\Documents\NFT\NFT-links.txt" -Value $cleanlist
if($saveInput -eq "True"){
 @($cleanlist).ForEach({
Invoke-WebRequest -Uri $_ -OutFile ("C:\Users\Public\Pictures\" + ($_ -replace "https://lh3.googleusercontent.com/", "") + ".gif")
})
}
Write-Host "[^_^] Job done!"
$agree = Read-Host "[O_o] Repeat process[Y/N]?"
}
}while($agree -eq "Y")



