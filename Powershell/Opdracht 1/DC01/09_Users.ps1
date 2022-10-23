#Creating Users via CSV file

#Declaring Path
$path = 'C:\Users\Administrator\Documents\CSV Files\UserAccounts.csv'

#Declaring Pswd, never do this in a real environment!
$Secure_String_Pwd = ConvertTo-SecureString "P@ssw0rd" -AsPlainText -Force

#Checking if the file is there
if (Test-Path -Path $path)
{
    $users = Import-Csv -Path $path -Delimiter(';')
    #Running throug the csv file and adding all the users
    foreach($item in $users)
    {
        New-ADUser -Name $item.Name -SamAccountName $item.SamAccountName -GivenName $item.GivenName -Surname $item.Surname -DisplayName $item.DisplayName -AccountPassword $Secure_String_Pwd -HomeDrive $item.HomeDrive -HomeDirectory $item.HomeDirectory -ScriptPath $item.ScriptPath -Path $item.Path -PasswordNeverExpires $true -Enabled $true
        Write-Host (“{0} was added” -f $item.name)
    }
} 

else
{
    Write-Host "File Not Found"
}
