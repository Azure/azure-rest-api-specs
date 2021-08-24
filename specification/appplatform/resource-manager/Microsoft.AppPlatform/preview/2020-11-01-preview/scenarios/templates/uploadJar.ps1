$uploadUrl = ${Env:uploadUrl}
$BlobUri = ${Env:blobUrl}
$storageAccountName = ${Env:storageAccountName}
$localFilePath = './helloWorld.jar'
$keyVaultName = ${Env:keyVaultName}
function DownloadJarFromBlob([string]$blobUri, [string]$storageAccountName, [string]$storageAccountKey, [string]$localOutputFilePath) {

	$StorageCredentials = [Microsoft.WindowsAzure.Storage.Auth.StorageCredentials]::new($storageAccountName, $storageAccountKey)
	$BlobFile = [Microsoft.WindowsAzure.Storage.Blob.CloudBlob]::new($BlobUri, $StorageCredentials)
	$DownLoadTask = $BlobFile.DownloadToFileAsync($localOutputFilePath, 4)
	$DownLoadTask
}

function UploadToFileShare([string]$uploadUrl, [string]$localFilePath) {
	$Uri = [System.Uri]::New($uploadUrl.Split('?')[0])

	$SasToken = $uploadUrl.Split('?')[-1]
	$StorageCredentials = [Microsoft.WindowsAzure.Storage.Auth.StorageCredentials]::New($SasToken)
	$CloudFile = [Microsoft.WindowsAzure.Storage.File.CloudFile]::New($Uri, $StorageCredentials)

	$UploadTask = $CloudFile.UploadFromFileAsync($localFilePath)
	$UploadTask
}

Connect-AzAccount -Identity
$storageAccountKey = Get-AzKeyVaultSecret -VaultName $keyVaultName  -Name 'storageAccountKey' -AsPlainText
DownloadJarFromBlob $BlobUri $storageAccountName $storageAccountKey $localFilePath
UploadToFileShare $uploadUrl $localFilePath