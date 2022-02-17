$wmiarg = @{ 
          Namespace = 'root\Subscription'
          Class = '__EventConsumer'
               }

$table = import-Csv -LiteralPath "C:\Users\black\Documents\Eventfilters.csv"
$ans = (get-WmiObject @wmiarg).Filter

 get-wmiobject @wmiarg
 $table.Contains($ans.Substring(19).trim('"'))

 get-WmiObject -query "select * from MSFT_SCMEventLogEvent"
 get-WmiObject -query "select * from Win32_Bios"

 Get-WmiObject -list

 foreach( $s in (Get-WmiObject -list | Where Name -Like *temp*).Name[0..2+4,7,8]){get-WmiObject -query "select * from $s"}