$uploadUrl = ${Env:uploadUrl}
$BlobUri = ${Env:blobUrl}
$localFilePath = './helloWorld.jar'
function DownloadJarFromBlob([string]$blobUri, [string]$localOutputFilePath) {
	$Uri = [System.Uri]::New($blobUri.Split('?')[0])
	$SasToken = $blobUri.Split('?')[-1]

	$StorageCredentials = [Microsoft.WindowsAzure.Storage.Auth.StorageCredentials]::New($SasToken)
	$BlobFile = [Microsoft.WindowsAzure.Storage.Blob.CloudBlob]::new($Uri, $StorageCredentials)
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
DownloadJarFromBlob $BlobUri $localFilePath
UploadToFileShare $uploadUrl $localFilePath