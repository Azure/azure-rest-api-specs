import "@azure-tools/typespec-azure-core";
import "../../../operationsTemp.tsp";
import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.Core.Traits;
using OpenAPI;

@doc("Gets or sets the list of server machine inventory.")
@pagedResult
model ServerPropertiesCollection {
  @extension("x-ms-identifiers", [])
  @doc("Gets or sets the list of server machine inventory.")
  serverList?: ServerProperties[];

  @doc("The link to fetch more models.")
  @nextLink
  nextLink?: string;
}

@doc("Server REST resource.")
model ServerProperties {
  @doc("""
Gets the Display name of the machine.
            For server entity hydrated
FQDN is set as display name
            as the server id and server name are
same.
""")
  @visibility("read")
  displayName?: string;

  @doc("Gets or sets tags on the Server machine.")
  tags?: Record<Object>;

  @doc("Gets or sets the FQDN/IPAddress of the server.")
  fqdn?: string;

  @doc("Gets or sets the network adapters of the server.")
  @extension("x-ms-identifiers", [])
  networkAdapters?: ServerNetworkAdapter[];

  @doc("Gets or sets the FQDN of machine which can be changed.")
  hydratedFqdn?: string;

  @doc("Gets or sets the disk details of server.")
  disks?: ServerDisk[];

  @doc("Gets or sets the validation required for the machine.")
  validationRequired?: string;

  @doc("Gets or sets the firmware.")
  firmware?: string;

  @doc("""
Operating System Details extracted from the guest
            bu executing
script inside the guest VM.
""")
  @visibility("read")
  guestOsDetails?: GuestOsDetails;

  @doc("Number of applications installed in the guest VM.")
  @visibility("read")
  numberOfApplications?: int32;

  @doc("""
The last time at which the Guest Details was discovered
            or the
error while discovering guest details based discovery
            of the
machine.
""")
  @visibility("read")
  guestDetailsDiscoveryTimestamp?: utcDateTime;

  @doc("""
Whether Refresh Fabric Layout Guest Details has been completed once.
         
  Portal will show discovery in progress, if this value is true.
""")
  @visibility("read")
  isGuestDetailsDiscoveryInProgress?: boolean;

  @doc("""
Gets or sets if dependency mapping feature is enabled or not
            for
the VM.
""")
  @visibility("read")
  dependencyMapping?: string;

  @doc("Gets or sets when dependency mapping collection is last started.")
  @visibility("read")
  dependencyMappingStartTime?: utcDateTime;

  @doc("Gets or sets when dependency mapping collection was last disabled.")
  @visibility("read")
  dependencyMappingEndTime?: string;

  @doc("Gets or sets the run as account ID of the machine.")
  runAsAccountId?: string;

  @doc("Gets the appliance names.")
  @visibility("read")
  applianceNames?: string[];

  @doc("Errors for machine.")
  @visibility("read")
  errors?: HealthErrorDetails[];

  @doc("Gets the data related to application discovery.")
  @visibility("read")
  applicationDiscovery?: ApplicationDiscovery;

  @doc("Gets the data related to dependency map discovery.")
  @visibility("read")
  dependencyMapDiscovery?: DependencyMapDiscovery;

  @doc("Gets the data related to static discovery.")
  @visibility("read")
  staticDiscovery?: StaticDiscovery;

  @doc("Gets the data related to SQL discovery.")
  @visibility("read")
  sqlDiscovery?: SqlDiscovery;

  @doc("Gets the data related to Web application discovery.")
  @visibility("read")
  webAppDiscovery?: WebAppDiscovery;

  @doc("Gets the data related to Oracle discovery.")
  @visibility("read")
  oracleDiscovery?: OracleDiscovery;

  @doc("Gets the data related to SpringBoot discovery.")
  @visibility("read")
  springBootDiscovery?: SpringBootDiscovery;

  @doc("Apps And Roles of the Server.")
  @visibility("read")
  appsAndRoles?: AppsAndRoles;

  @doc("""
Gets or sets the Number of Processor Cores 
            allocated for the
machine.
""")
  numberOfProcessorCore?: int32;

  @doc("Gets or sets the allocated Memory in MB.")
  allocatedMemoryInMb?: float32;

  @doc("Gets or sets the Operating System Details installed on the machine.")
  operatingSystemDetails?: OperatingSystem;

  @doc("Gets or sets the Machine BIOS serial number.")
  biosSerialNumber?: string;

  @doc("Gets or sets the BIOS GUID.")
  biosGuid?: string;

  @doc("Value indicating whether VM is deleted.")
  @visibility("read")
  isDeleted?: boolean;

  @doc("Gets the marking machine creation.")
  @visibility("read")
  createdTimestamp?: string;

  @doc("Gets the timestamp marking last updated on the machine.")
  @visibility("read")
  updatedTimestamp?: string;

  @doc("Provisioning state of the server resource.")
  provisioningState?: ProvisioningState;
}

@doc("Second level object represented in responses as part of Machine REST resource.")
model ServerNetworkAdapter {
  @doc("Gets or sets the NIC Id.")
  nicId?: string;

  @doc("Gets or sets Mac address of the NIC.")
  macAddress?: string;

  @doc("Gets IP addresses for the machine.")
  @visibility("read")
  ipAddressList?: string[];

  @doc("Gets or sets Network Name.")
  networkName?: string;

  @doc("Gets or sets Type of the IP address.")
  ipAddressType?: string;
}

@doc("Server disk details.")
model ServerDisk {
  @doc("Gets or sets Id of the disk.")
  id?: string;

  @doc("Gets or sets generated Id of the disk.")
  generatedId?: string;

  @doc("Gets or sets Bytes allocated for the disk.")
  maxSizeInBytes?: int32;

  @doc("Gets or sets Name of the disk.")
  name?: string;

  @doc("Gets or sets Type of the disk.")
  diskType?: string;

  @doc("Gets or sets LUN of the disk.")
  lun?: int32;

  @doc("Gets or sets Path of the disk.")
  path?: string;
}
