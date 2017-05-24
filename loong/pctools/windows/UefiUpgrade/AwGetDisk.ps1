function AllwinnerGetDiskNumber()
{
        $pwd = $PSScriptRoot
	$objs = get-disk | select-object Number,Model,Manufacturer,PartitionStyle
	foreach ($n in $objs)
	{
		if (($n.PartitionStyle.Contains("GPT")) -and ($n.Model.Contains("USB Storage")))
		{
			#Write-host  $n.Number
 			$parts = get-partition | select-object DiskNumber,PartitionNumber
			foreach ($part in $parts)
			{
				if (($n.Number -eq $part.DiskNumber) -and ($part.PartitionNumber -eq 2))
				{
					#Write-host $part.DiskNumber $part.PartitionNumber
					$index = $part.DiskNumber
					$num = $part.PartitionNumber
				        & $pwd"\dd" if=\\?\device\harddisk$index\partition$num of=$pwd\temp.txt count=1
					$file = get-content $pwd\temp.txt
				    	$content = $file.Substring(0,14)
					#Write-host $content
					rm $pwd\temp.txt
				    	if($content.Contains("sunxi-package"))
				    	{
						#Write-host $n.Number
						return $n.Number
				    	}
				}
			}		
		}
	}
	return -1
}
