import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "../shared/main.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;
using Azure.Core;
using Azure.ClientGenerator.Core;
using Azure.ResourceManager;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Supress missing operations endpoint as the same is defined ../operations/main.tsp."
@armProviderNamespace
@service({
  title: "Microsoft.AwsConnector",
})
@doc("Microsoft.AwsConnector Resource Provider management API.")
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.AwsConnector;

/** Api versions */
enum Versions {
  /** 2024-08-01-preview api version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  `2024-08-01-preview`,
}

//---------------------------------------------- LightsailInstances ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@doc("A Microsoft.AwsConnector resource")
model LightsailInstance is TrackedResource<LightsailInstanceProperties> {
  @doc("Name of LightsailInstance")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("lightsailInstances")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LightsailInstance")
model LightsailInstanceProperties {
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsLightsailInstanceProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsLightsailInstance")
model AwsLightsailInstanceProperties {
  @doc("Gets and sets the property addOns. An array of objects representing the add-ons to enable for the new instance.")
  @extension("x-ms-identifiers", [])
  addOns?: AddOn[];

  @doc("Gets and sets the property availabilityZone. The Availability Zone in which to create your instance. Use the following format: us-east-2a (case sensitive). Be sure to add the include Availability Zones parameter to your request.")
  availabilityZone?: string;

  @doc("Gets and sets the property blueprintId. The ID for a virtual private server image (e.g., app_wordpress_4_4 or app_lamp_7_0 ). Use the get blueprints operation to return a list of available images (or blueprints ).")
  blueprintId?: string;

  @doc("Gets and sets the property bundleId. The bundle of specification information for your virtual private server (or instance ), including the pricing plan (e.g., micro_1_0 ).")
  bundleId?: string;

  @doc("Gets and sets the property hardware. Hardware of the Instance.")
  hardware?: Hardware;

  @doc("Gets and sets the property instanceArn.")
  instanceArn?: string;

  @doc("Gets and sets the property instanceName. The names to use for your new Lightsail instance.")
  instanceName?: string;

  @doc("Gets and sets the property isStaticIp. Is the IP Address of the Instance is the static IP")
  isStaticIp?: boolean;

  @doc("Gets and sets the property keyPairName. The name of your key pair.")
  keyPairName?: string;

  @doc("Gets and sets the property location. Location of a resource.")
  location?: Location;

  @doc("Gets and sets the property networking. Networking of the Instance.")
  networking?: Networking;

  @doc("Gets and sets the property privateIpAddress. Private IP Address of the Instance")
  privateIpAddress?: string;

  @doc("Gets and sets the property publicIpAddress. Public IP Address of the Instance")
  publicIpAddress?: string;

  @doc("Gets and sets the property resourceType. Resource type of Lightsail instance.")
  resourceType?: string;

  @doc("Gets and sets the property sshKeyName. SSH Key Name of the  Lightsail instance.")
  sshKeyName?: string;

  @doc("Gets and sets the property state. Current State of the Instance.")
  state?: State;

  @doc("Gets and sets the property supportCode. Support code to help identify any issues")
  supportCode?: string;

  @doc("Gets and sets the property tags. An array of key-value pairs to apply to this resource.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("Gets and sets the property userData. A launch script you can create that configures a server with additional user data. For example, you might want to run apt-get -y update.")
  userData?: string;

  @doc("Gets and sets the property userName. Username of the  Lightsail instance.")
  userName?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AddOn")
model AddOn {
  @doc("Gets and sets the property addOnType. The add-on type")
  addOnType?: string;

  @doc("Gets and sets the property autoSnapshotAddOnRequest. An object that represents additional parameters when enabling or modifying the automatic snapshot add-on")
  autoSnapshotAddOnRequest?: AutoSnapshotAddOn;

  @doc("Gets and sets the property status. Status of the Addon")
  status?: AddOnStatus;
}

@doc("AddOnStatus enum")
union AddOnStatus {
  @doc("AddOnStatus enum Disabled")
  Disabled: "Disabled",

  @doc("AddOnStatus enum Disabling")
  Disabling: "Disabling",

  @doc("AddOnStatus enum Enabled")
  Enabled: "Enabled",

  @doc("AddOnStatus enum Enabling")
  Enabling: "Enabling",

  @doc("AddOnStatus enum Failed")
  Failed: "Failed",

  @doc("AddOnStatus enum Terminated")
  Terminated: "Terminated",

  @doc("AddOnStatus enum Terminating")
  Terminating: "Terminating",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Hardware")
model Hardware {
  @doc("Gets and sets the property cpuCount. CPU count of the Instance.")
  cpuCount?: int32;

  @doc("Gets and sets the property disks. Disks attached to the Instance.")
  @extension("x-ms-identifiers", [])
  disks?: Disk[];

  @doc("Gets and sets the property ramSizeInGb. RAM Size of the Instance.")
  ramSizeInGb?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Location")
model Location {
  @doc("Gets and sets the property availabilityZone. The Availability Zone in which to create your instance. Use the following format: us-east-2a (case sensitive). Be sure to add the include Availability Zones parameter to your request.")
  availabilityZone?: string;

  @doc("Gets and sets the property regionName. The Region Name in which to create your instance.")
  regionName?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Networking")
model Networking {
  @doc("Gets and sets the property monthlyTransfer. Monthly Transfer of the Instance.")
  monthlyTransfer?: MonthlyTransfer;

  @doc("Gets and sets the property ports. Ports to the Instance.")
  @extension("x-ms-identifiers", [])
  ports?: Port[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of State")
model State {
  @doc("Gets and sets the property code. Status code of the Instance.")
  code?: int32;

  @doc("Gets and sets the property name. Status code of the Instance.")
  name?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("Gets and sets the property key. The key name of the tag. You can specify a value that is 1 to 128 Unicode characters in length and cannot be prefixed with aws:. You can use any of the following characters: the set of Unicode letters, digits, whitespace, _, ., /, =, +, and -.")
  key?: string;

  @doc("Gets and sets the property value. The value for the tag. You can specify a value that is 0 to 256 Unicode characters in length and cannot be prefixed with aws:. You can use any of the following characters: the set of Unicode letters, digits, whitespace, _, ., /, =, +, and -.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AutoSnapshotAddOn")
model AutoSnapshotAddOn {
  @doc("Gets and sets the property snapshotTimeOfDay. The daily time when an automatic snapshot will be created.")
  snapshotTimeOfDay?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Disk")
model Disk {
  @doc("Gets and sets the property attachedTo. Instance attached to the disk.")
  attachedTo?: string;

  @doc("Gets and sets the property attachmentState. Attachment state of the disk.")
  attachmentState?: string;

  @doc("Gets and sets the property diskName. The names to use for your new Lightsail disk.")
  diskName?: string;

  @doc("Gets and sets the property iops. IOPS of disk.")
  iops?: int32;

  @doc("Gets and sets the property isSystemDisk. Is the Attached disk is the system disk of the Instance.")
  isSystemDisk?: boolean;

  @doc("Gets and sets the property path. Path of the disk attached to the instance.")
  path?: string;

  @doc("Gets and sets the property sizeInGb. Size of the disk attached to the Instance.")
  sizeInGb?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of MonthlyTransfer")
model MonthlyTransfer {
  @doc("Gets and sets the property gbPerMonthAllocated. GbPerMonthAllocated of the Instance.")
  gbPerMonthAllocated?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Port")
model Port {
  @doc("Gets and sets the property accessDirection. Access Direction for Protocol of the Instance(inbound/outbound).")
  accessDirection?: string;

  @doc("Gets and sets the property accessFrom. Access From Protocol of the Instance.")
  accessFrom?: string;

  @doc("Gets and sets the property accessType. Access Type Protocol of the Instance.")
  accessType?: string;

  @doc("Gets and sets the property cidrListAliases. cidr List Aliases")
  @extension("x-ms-identifiers", [])
  cidrListAliases?: string[];

  @doc("Gets and sets the property cidrs. cidrs")
  @extension("x-ms-identifiers", [])
  cidrs?: string[];

  @doc("Gets and sets the property commonName. CommonName for Protocol of the Instance.")
  commonName?: string;

  @doc("Gets and sets the property fromPort. From Port of the Instance.")
  fromPort?: int32;

  @doc("Gets and sets the property ipv6Cidrs. IPv6 Cidrs")
  @extension("x-ms-identifiers", [])
  ipv6Cidrs?: string[];

  @doc("Gets and sets the property protocol. Port Protocol of the Instance.")
  protocol?: string;

  @doc("Gets and sets the property toPort. To Port of the Instance.")
  toPort?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface LightsailInstances {
  get is ArmResourceRead<LightsailInstance>;
  @doc("Create a LightsailInstance. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<LightsailInstance>;
  update is ArmCustomPatchAsync<
    LightsailInstance,
    Azure.ResourceManager.Foundations.TagsUpdateModel<LightsailInstance>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<LightsailInstance>;
  listByResourceGroup is ArmResourceListByParent<LightsailInstance>;
  listBySubscription is ArmListBySubscription<LightsailInstance>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::Lightsail::Instance
//--------------------------------------------------------------------------------------------
