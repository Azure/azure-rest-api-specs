$uploadUri = ${Env:uploadUrl}
$blobUri = ${Env:blobUrl}
$localFilePath = '/tmp/temp.file'
function DownloadJarFromBlob([string]$blobUri, [string]$localOutputFilePath) {
	$BlobFile = [Microsoft.WindowsAzure.Storage.Blob.CloudBlob]::new($blobUri)
	$DownLoadTask = $BlobFile.DownloadToFileAsync($localOutputFilePath, 4)
	$DownLoadTask
}

function UploadToFileShare([string]$uploadUri, [string]$localFilePath) {
	$CloudFile = [Microsoft.WindowsAzure.Storage.File.CloudFile]::New($uploadUri)
	$UploadTask = $CloudFile.UploadFromFileAsync($localFilePath)
	$UploadTask
}

Connect-AzAccount -Identity
DownloadJarFromBlob $blobUri $localFilePath
UploadToFileShare $uploadUri $localFilePath