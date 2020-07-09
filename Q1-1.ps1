try
{
  $response = Invoke-WebRequest 'https://resonatetest.azurewebsites.net/data' -Method 'GET'

  $datas = $response | ConvertFrom-Json -AsHashtable

  $length = 0
  $sum = 0
  foreach ($data in $datas) {
    $length = $length + 1
    $sum = $sum + $data["score"]
  }

  Write-Host "The average is $($sum / $length)"


  $sql = ""
  foreach ($data in $datas) {
    $sql = "$($sql)

INSERT INTO ``dbo.Fact`` (id, user, score, verbatim)
  VALUES $($data["id"]), `"$($data["user"])`", $($data["score"]), `"$($data["verbatim"])`";"
  }

  $sql > "./Dados.sql"
}
catch
{
  Write-Host "Deu erro"
}
