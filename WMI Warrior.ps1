
   
<###
WMI WARRIOR V1
V1
- Added Filter Definitions
- Added Consumer Definitions
####>


$FILDEF = " Filter,	Description,
__AbsoluteTimerInstruction,	Causes an event to be generated on a specific date at a specific time,
__ACE,	Represents an access control entry (ACE),
__AggregateEvent,	Represents an aggregate event of several individual intrinsic or extrinsic events,
__ArbitratorConfiguration,	Configuration class that limits the internal resources that are used by operations initiated by WMI clients,
__CacheControl,	Determines when WMI should release a Component Object Model (COM) object,
__CIMOMIdentification,	Describes the local installation of WMI,
__ClassCreationEvent,	Represents a class creation event, which is a type of intrinsic event generated when a new class is added to the namespace,
__ClassDeletionEvent,	Represents a class deletion event, which is a type of intrinsic event generated when a class is removed from the namespace,
__ClassModificationEvent,	Represents a class modification event, which is a type of intrinsic event generated when a class is changed in the namespace,
__ClassOperationEvent,	A base class for all intrinsic events that relate to a class,
__ClassProviderRegistration,	Registers class providers in WMI,
__ConsumerFailureEvent,	Represents the occurrence of some other event that is being dropped because of the failure of an event consumer,
__Event,	An abstract base class that serves as the parent class for all intrinsic and extrinsic events,
__EventConsumer,	An abstract base class that is used in the registration of a permanent event consumer,
__EventConsumerProviderCacheControl,	Determines when WMI should release an event consumer provider,
__EventConsumerProviderRegistration,	Registers event consumer providers with WMI,
__EventDroppedEvent,	Represents the occurrence of an event that is dropped. A dropped event is an event that is not delivered to an event consumer,
__EventFilter,	Registration of a permanent event consumer requires an instance of the __EventFilter system class,
__EventGenerator,	Serves as a parent class for classes that control the generation of events, such as timer events,
__EventProviderCacheControl,	Controls when an event provider is unloaded,
__EventProviderRegistration,	Registers event providers with WMI,
__EventQueueOverflowEvent,	Reports when an event is dropped as a result of delivery queue overflow,
__EventSinkCacheControl,	Used to determine when WMI releases an event consumer provider's IWbemUnboundObjectSink pointer,
__ExtendedStatus,	Used to report detailed status and error information,
__ExtrinsicEvent,	Serves as a parent class for all user-defined event types, also known as extrinsic events,
__FilterToConsumerBinding,	Used in the registration of permanent event consumers to relate an instance of the of __EventConsumer to an instance of __EventFilter,
__IndicationRelated,	Serves as a parent class for all event-related classes,
__InstanceCreationEvent,	Reports an instance creation event, which is a type of intrinsic event that is generated when a new instance is added to the namespace,
__InstanceDeletionEvent,	Reports an instance deletion event, which is a type of intrinsic event generated when an instance is deleted from the namespace,
__InstanceModificationEvent,	Reports an instance modification event, which is a type of intrinsic event generated when an instance changes in the namespace,
__InstanceOperationEvent,	Serves as a base class for all intrinsic events that relate to an instance,
__InstanceProviderRegistration,	Registers instance providers in WMI,
__IntervalTimerInstruction,	Generates events at intervals, similar to a WM_TIMER message in Windows programming,
__MethodInvocationEvent,	This class is not implemented,
__MethodProviderRegistration,	Registers method providers with WMI,
__Namespace,	Represents a WMI namespace,
__NamespaceCreationEvent,	Reports a namespace creation event, which is a type of intrinsic event generated when a new namespace is added to the current namespace,
__NamespaceDeletionEvent,	Reports a namespace deletion event, which is a type of intrinsic event that is generated when a sub-namespace is removed from the current namespace,
__NamespaceModificationEvent,	Reports a namespace modification event, which is a type of intrinsic event that is generated when a namespace is modified,
__NamespaceOperationEvent,	A base class for all intrinsic events that relate to a namespace,
__NotifyStatus,	Serves as the parent class for provider-defined error classes,
__NTLMUser9X,	Controls remote access to a computer running unsupported versions of Windows,
__ObjectProviderCacheControl,	Controls when a class or instance provider is unloaded,
__ObjectProviderRegistration,	Serves as the parent for classes that are used to register class and instance providers in WMI,
__PARAMETERS,	Defines the input and output parameters for methods,
__PropertyProviderCacheControl,	Controls the cache when a property provider is unloaded,
__PropertyProviderRegistration,	Registers property providers in WMI,
__Provider,	Serves as the parent class for the __Win32Provider system class,
__ProviderHostQuotaConfiguration,	Allows limits to be set on host process usage of system resources,
__ProviderRegistration,	Serves as the parent class for registration classes for various types of providers,
__SecurityDescriptor,	Represents a security descriptor,
__SecurityRelatedClass,	Serves as a parent class for all types of security classes,
__SystemClass,	Base class from which most system classes derive,
__SystemEvent,	Represents a system event,
__SystemSecurity,	Contains methods that let you access and modify the security settings for a namespace,
__thisNAMESPACE,	Holds the security rights for the namespace in the form of a security descriptor,
__TimerEvent,	Reports an event generated by WMI in response to a consumer's request for an interval timer event or an absolute timer event,
__TimerInstruction,	Specifies instructions on how timer events should be generated for consumers,
__TimerNextFiring,	Reserved for operating system use,
__Trustee,	Represents a trustee. Either a name or a SID (byte array) can be used,
__Win32Provider,	Registers information about a provider's physical implementation in WMI"

$FILDEFTAB = ConvertFrom-Csv -InputObject $FILDEF -Delimiter "," ##Filter Definition Table
 
$CONDEF = "Consumer,  Description,
ActiveScriptEventConsumer,	Executes a predefined script in an arbitrary scripting language when an event is delivered to it - Example: Running a Script Based on an Event,
CommandLineEventConsumer,	Launches an arbitrary process in the local system context when an event is delivered to it - Example: Running a Program from the Command Line Based on an Event,
LogFileEventConsumer,	Writes customized strings to a text log file when events are delivered to it - Example: Writing to a Log File Based on an Event,
NTEventLogEventConsumer,	Logs a specific message to the Windows event log when an event is delivered to it - Example: Logging to NT Event Log Based on an Event,
ScriptingStandardConsumerSetting,	Provides registration data common to all instances of the ActiveScriptEventConsumer class,
SMTPEventConsumer,	Sends an email message using SMTP each time an event is delivered to it - Example: Sending Email Based on an Event"

$CONDEFTAB = ConvertFrom-Csv $CONDEF #Consumer Definition Table

$Result = @{}

Foreach($Consumer in (get-wmiobject -namespace root\subscription -Class __EventConsumer).__class){
        Write-host $Consumer
        if($Consumer -in ($CONDEFTAB.Consumer)){$TEST.Add("Consumer",$Consumer,"True")} 
                             }

(get-wmiobject -namespace root\subscription -Class __Filtertoconsumerbinding) | % {$_.Consumer.Substring(30).trim('"'), $_.Filter.Substring(30).trim('"')}
  
  
[System.Collections.ArrayList]$kak=@() #creating arraylist

gm -InputObject $kak #testing arraylist

<#  gwmi win32_process | select-object name,processid,path,commandline,@{name="Hash"; expr={
                if($_.path) {
                        (certutil.exe -hashfile $_.path SHA256)[1] -replace " ", ""
                } else {
                    ""
                } 
            } #expr
            }, #hash hashtable
            @{name="Process_Owner"; expr={$_.getowner().domain + "\" + $_.getowner().user}
            } -First 10 | Format-Table

 
  gci | ? {$_.extension} | select-object name,@{name="Hash"; expr={
  (certutil.exe -hashfile $_.fullname SHA256)[1] -replace " ", ""}},IsReadOnly
                           
<#
 get-WmiObject -query "select * from MSFT_SCMEventLogEvent"  ## ex. of running WMI queries
 get-WmiObject -query "select * from Win32_Bios"             ## ex. of running WMI queries

 Get-WmiObject -list

 foreach($s in (Get-WmiObject -list | Where Name -Like *temp*).Name[0..2+4,7,8]){get-WmiObject -query "select * from $s"}

 ((ConvertFrom-Csv $food).Consumer).contains("SMTPEventConsumer") ## Returns Boolean 
 ((ConvertFrom-Csv $food).Consumer) -like "*SMTP*"                ## Returns String
 ((ConvertFrom-Csv $food).Consumer) | Select-String "SMTP" -Quiet ## Returns Boolean

$tab.Consumer.contains((get-wmiobject -namespace root\subscription -Class __EventConsumer).__class) ## Determines if Event consumer is a part of the Satandard  Consumer Classes


$ans = (get-WmiObject @wmiarg).Filter

 get-wmiobject @wmiarg
 $table.Contains($ans.Substring(19).trim('"'))

 $wmiarg = @{ 
          Namespace = 'root\Subscription'
          Class = '__EventConsumer'
               }  ## This is how to pass aruments to a command using a hashtable


   $TEST = [PSCustomObject]@{RowNumber = 1; EmployeeId = 1; Value = 1 }
   $TEST += @{RowNumber = 2; EmployeeId = 2; Value = 2 }

$account = @()
$account += New-Object -TypeName psobject -Property @{User="Jimbo"; Password="1234"}
$account += New-Object -TypeName psobject -Property @{User="Jimbo2"; Password="abcd"}
$account += New-Object -TypeName psobject -Property @{User="Jimbo3"; Password="idontusepwds"}
$account += New-Object -TypeName psobject -Property @{User="Filetre"; Password="idontusepwds"; Email="test@gmail.com"}


$serverList= @() 
$serverList+= @{ServerName= 'blabla1'; OSType='Windows XP'}
$serverList+= @{ServerName= 'blabla2'; OSType='Windows XP Profesional'}

#display as table
$account | % { new-object PSObject -Property $_}
#>
