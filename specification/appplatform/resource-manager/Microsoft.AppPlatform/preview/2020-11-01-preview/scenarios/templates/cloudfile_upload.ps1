$uploadUri=$args[0]
$localFilePath=$args[1]

function CloudFileUpload([string]$toUri, [string]$fromPath) {
  $CloudFile = [Microsoft.WindowsAzure.Storage.File.CloudFile]::New($toUri)
  $UploadTask = $CloudFile.UploadFromFileAsync($fromPath)
  $UploadTask
}

CloudFileUpload $uploadUri $localFilePath