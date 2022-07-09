#Create containerA 
$ctx1 = New-AzStorageContext -StorageAccountName inbstorageaccount0 -UseConnectedAccount
New-AzStorageContainer -Name containertest -Context $ctx1 -Permission Blob
#Create containerB 
$ctx1 = New-AzStorageContext -StorageAccountName inbstorageaccount1 -UseConnectedAccount
New-AzStorageContainer -Name containertest -Context $ctx1 -Permission Blob

#Create 100 blobs
function Create100BlobsInNewFolder 
{
    Write-Output "                              START CREATE BLOB"
    #ToDo: create folder
    New-Item -ItemType Directory -Force -Path 100_Blobs
    for( $num = 0; $num -le 100  ; $num++ )
    {
        Write-Output $num
        $fileToCreate = ".\100_Blobs\0$num.txt"
        Set-Content $fileToCreate 'Blob'
        Write-Output $fileToCreate
        #Upload the New Blob into ContainerA 
        #Set-AzStorageAccount -ResourceGroupName myResourceGroupInbal06 -Name inbstorageaccount0 | Set-AzStorageBlobContent -Container containertest -File .\100_Blobs\0.txt -Blob blob\0$num
        Set-AzStorageAccount -ResourceGroupName myResourceGroupInbal06 -Name inbstorageaccount0 | Set-AzStorageBlobContent -Container containertest -File $fileToCreate 
    }
    Write-Output "finish blob"
}
Create100BlobsInNewFolder


$srcStorageKey = Get-AzStorageAccountKey -Name inbstorageaccount0 -ResourceGroupName myResourceGroupInbal06  
$destStorageKey = Get-AzStorageAccountKey -Name inbstorageaccount1 -ResourceGroupName myResourceGroupInbal06
$srcContext = New-AzStorageContext -StorageAccountName inbstorageaccount0 -StorageAccountKey $srcStorageKey.Value[0]
$destContext = New-AzStorageContext -StorageAccountName inbstorageaccount1 -StorageAccountKey $destStorageKey.Value[0]
#$srcBlob = Get-AzStorageBlob -Container $containerName -Blob $blobName  -Context $ctx 
#$destBlob =  $srcBlob | Copy-AzStorageBlob  -DestContainer "destcontainername" -DestBlob "destblobname"
function copyFromAtoB { 

    for( $n = 0; $n -le 100  ; $n++ )
    {
        Start-AzStorageBlobCopy -SrcBlob $srcBlob -SrcContainer blob -Context $srcContext -DestBlob $destBlob -DestContainer blob -DestContext $destContext
    }
}
#copyFromAtoB
