$VM = $args[0]
$CPU = $args[1]
$RAM = $args[2]

new-item "D:\$VM" -itemtype directory
new-item "D:\$VM\Virtual Hard Disks" -itemtype directory
$Path = "D:\" + $VM
$Source = 'E:\ExportVM\template_CentOS8\Virtual Machines\62573581-509A-42FE-A5BF-57A15FE3452F.vmcx'
$Import = Import-VM -Path $Source -Copy -GenerateNewId -VirtualMachinePath $Path -VhdDestinationPath "D:\$VM\Virtual Hard Disks" -SnapshotFilePath $Path
Foreach ($Import in $Import)
{
    $oldName = $Import.Name
    Rename-VM $oldName -NewName $VM
}

SET-VMProcessor -VMname "$VM" -count $CPU
Set-VMMemory $VM -StartupBytes $RAM

Start-VM -Name $VM
