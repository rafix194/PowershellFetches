$UserArray = New-Object System.Collections.ArrayList

$Continue = "Y"

while ($Continue -eq "Y") {
  $User = [PSCustomObject]@{
    Name = Read-Host "Please enter your first name"
    Email = Read-Host "Please enter your email address"
  }

  $UserArray.Add($User) | Out-Null

  $Continue = Read-Host "Do you want to continue? [y/n]"
}

$UserArray | Export-Csv -Path ./users.csv

$Users = Import-Csv ./users.csv

$Server = Read-Host "Please enter your SMTP server"
$Port = Read-Host "Please enter your SMTP port"

$Credential = Get-Credential

foreach ($User in $Users) {
  Send-MailMessage -From $Credential.UserName -To "$($User.Name) <$($User.Email)>" -Subject 'Test mail' -SmtpServer $Server -Port $Port -Credential $Credential -UseSsl -BodyAsHtml "<h1>Oi</h1>"
}
