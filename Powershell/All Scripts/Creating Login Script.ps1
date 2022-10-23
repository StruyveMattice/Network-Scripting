#Creating Login Script
if (Test-Path -Path "\\DC01\NETLOGON\login.bat") 
{
    "File already exists"
} 

else
{
    New-Item -Path "\\DC01\NETLOGON" -Name "login.bat" -ItemType "file" -Value "@echo off `nnet use p: \\MS\Profiles"
}
