#Create containerA with context to the storage accounts(Container permmision? -Permission Container)
$ctx1 = New-AzStorageContext -StorageAccountName inbstorageaccount1 -UseConnectedAccount
New-AzStorageContainer -Name inbalcontainera -Context $ctx1 -Permission Container
#Create containerB with context to the storage accounts(Container permmision? -Permission Container)
$ctx2 = New-AzStorageContext -StorageAccountName inbstorageaccount0 -UseConnectedAccount
New-AzStorageContainer -Name inbalcontainerb -Context $ctx2

#Create 100 blobs
function Create100BlobsInNewFolder 
{
    Write-Output "                              start blob"
    #ToDo: create folder
    New-Item -ItemType Directory -Force -Path 100_Blobs
    for( $num = 0; $num -le 1  ; $num++ )
    {
        Write-Output $num
        $fileToCreate = ".\100_Blobs\$File$num.txt"
        Set-Content $fileToCreate 'Blob'
        #Upload the New Blob into ContainerA 
        Set-AzStorageBlobContent -Container inbalcontainera -File $fileToCreate -Context $ctx1
        #az storage blob directory upload --Container inbalcontainera -account-name inbstorageaccount1 -s $fileToCreate -d . --recursive
    }
    Write-Output "finish blob"
}
Create100BlobsInNewFolder


#copy from A to B
#need a loop to copy each one of the blobs
#Copy a blob synchronously.     
#Copy-AzStorageBlob -SrcContainer $SrcContainer -DestContainer $DestContainer