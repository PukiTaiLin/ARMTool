#Create containerA 
$ctx1 = New-AzStorageContext -StorageAccountName inbstorageaccount1 -UseConnectedAccount
New-AzStorageContainer -Name containertesta -Context $ctx1 -Permission Blob
#Create containerB 
$ctx2 = New-AzStorageContext -StorageAccountName inbstorageaccount2 -UseConnectedAccount
New-AzStorageContainer -Name containertestb -Context $ctx2 -Permission Blob

#Create 100 blobs
function Create100BlobsInNewFolder 
{
    Write-Output "                              START CREATE BLOB"
    #ToDo: create folder
    New-Item -ItemType Directory -Force -Path 100_Blobs
    for( $num = 0; $num -le 2  ; $num++ )
    {
        Write-Output $num
        $fileToCreate = ".\100_Blobs\0$num.txt"
        Set-Content $fileToCreate 'BlobBlob'
        Write-Output $fileToCreate
        #Upload the New Blob into ContainerA
        Set-AzStorageAccount -ResourceGroupName myResourceGroupInbal -Name inbstorageaccount1 | Set-AzStorageBlobContent -Container containerA -File $fileToCreate 
        #Option 2: Set-AzStorageAccount -ResourceGroupName myResourceGroupInbal -Name inbstorageaccount1 | Set-AzStorageBlobContent -Container containerA -File .\100_Blobs\0.txt -Blob blob\0$num
    }
    Write-Output "                             Finish create & upload blob"
}
Create100BlobsInNewFolder


$srcStorageKey = Get-AzStorageAccountKey -Name inbstorageaccount1 -ResourceGroupName myResourceGroupInbal  
$destStorageKey = Get-AzStorageAccountKey -Name inbstorageaccount2 -ResourceGroupName myResourceGroupInbal
$srcContext = New-AzStorageContext -StorageAccountName inbstorageaccount1 -StorageAccountKey $srcStorageKey.Value[0]
$destContext = New-AzStorageContext -StorageAccountName inbstorageaccount2 -StorageAccountKey $destStorageKey.Value[0]
#$srcBlob = Get-AzStorageBlob -Container $containerName -Blob $blobName  -Context $ctx 
#$destBlob =  $srcBlob | Copy-AzStorageBlob  -DestContainer "destcontainername" -DestBlob "destblobname"
function copyFromAtoB { 

    for( $n = 0; $n -le 100  ; $n++ )
    {
        Start-AzStorageBlobCopy -SrcBlob $srcBlob -SrcContainer blob -Context $srcContext -DestBlob $destBlob -DestContainer blob -DestContext $destContext
    }
}
#copyFromAtoB
