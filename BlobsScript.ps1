#Create containerA 
$ctx1 = New-AzStorageContext -StorageAccountName inbstorageaccount1 -UseConnectedAccount
New-AzStorageContainer -Name containera -Context $ctx1 -Permission Blob
#Create containerB 
$ctx2 = New-AzStorageContext -StorageAccountName inbstorageaccount2 -UseConnectedAccount
New-AzStorageContainer -Name containerb -Context $ctx2 -Permission Blob

#Create 100 blobs
function Create100BlobsInNewFolder 
{
    Write-Output "                              START CREATE BLOB"
    #ToDo: create folder
    New-Item -ItemType Directory -Force -Path 100_Blobs
    for( $num = 0; $num -le 99  ; $num++ )
    {
        Write-Output $num
        $fileToCreate = ".\100_Blobs\0$num.txt"
        Set-Content $fileToCreate 'BlobBlob'
        Write-Output $fileToCreate
        #Upload the New Blob into ContainerA
        Set-AzStorageAccount -ResourceGroupName myResourceGroupInbal -Name inbstorageaccount1 | Set-AzStorageBlobContent -Container containera -File $fileToCreate 
        #Option 2: Set-AzStorageAccount -ResourceGroupName myResourceGroupInbal -Name inbstorageaccount1 | Set-AzStorageBlobContent -Container containera -File .\100_Blobs\0.txt -Blob blob\0$num
    }
    Write-Output "                             Finish create & upload blob"
}
Create100BlobsInNewFolder




$SrcStorageKey = Get-AzStorageAccountKey -Name inbstorageaccount1 -ResourceGroupName myResourceGroupInbal
$SrcContext = New-AzStorageContext -StorageAccountName inbstorageaccount1 -StorageAccountKey $SrcStorageKey.Value[0]

$DestStorageKey = Get-AzStorageAccountKey -Name inbstorageaccount2 -ResourceGroupName myResourceGroupInbal
$DestContext = New-AzStorageContext -StorageAccountName inbstorageaccount2 -StorageAccountKey $DestStorageKey.Value[0]

function copyFromAtoB
{ 
    for( $n = 0; $n -le 99  ; $n++ )
    {
        $SrcBloboption1 = Get-AzStorageBlob -Container containera -Blob 0$n.txt -Context $SrcContext
        Start-AzStorageBlobCopy -SrcBlob 0$n.txt -DestContainer containerb -SrcContainer containera -Context $SrcContext -DestContext $DestContext
    }
}
copyFromAtoB

