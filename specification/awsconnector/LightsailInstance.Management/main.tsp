import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-portal-core";
import "../shared/main.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;
using Azure.Core;
using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using Azure.Portal;

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
  /** 2024-12-01 api version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  `2024-12-01`,
}

//---------------------------------------------- LightsailInstances ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Lightsail Instance",
    plural: "Lightsail Instances",
  },
  keywords: ["Microsoft.AwsConnector", "Lightsail", "Instance"],
})
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
  @doc("AWS Properties")
  awsProperties?: AwsLightsailInstanceProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsLightsailInstance")
model AwsLightsailInstanceProperties {
  @doc("An array of objects representing the add-ons to enable for the new instance.")
  @extension("x-ms-identifiers", [])
  addOns?: AddOn[];

  @doc("The Availability Zone in which to create your instance. Use the following format: us-east-2a (case sensitive). Be sure to add the include Availability Zones parameter to your request.")
  availabilityZone?: string;

  @doc("The ID for a virtual private server image (e.g., app_wordpress_4_4 or app_lamp_7_0 ). Use the get blueprints operation to return a list of available images (or blueprints ).")
  blueprintId?: string;

  @doc("The bundle of specification information for your virtual private server (or instance ), including the pricing plan (e.g., micro_1_0 ).")
  bundleId?: string;

  @doc("Hardware of the Instance.")
  hardware?: Hardware;

  @doc("Property instanceArn")
  instanceArn?: string;

  @doc("The names to use for your new Lightsail instance.")
  instanceName?: string;

  @doc("Is the IP Address of the Instance is the static IP")
  isStaticIp?: boolean;

  @doc("The name of your key pair.")
  keyPairName?: string;

  @doc("Location of a resource.")
  location?: Location;

  @doc("Networking of the Instance.")
  networking?: Networking;

  @doc("Private IP Address of the Instance")
  privateIpAddress?: string;

  @doc("Public IP Address of the Instance")
  publicIpAddress?: string;

  @doc("Resource type of Lightsail instance.")
  resourceType?: string;

  @doc("SSH Key Name of the  Lightsail instance.")
  sshKeyName?: string;

  @doc("Current State of the Instance.")
  state?: State;

  @doc("Support code to help identify any issues")
  supportCode?: string;

  @doc("An array of key-value pairs to apply to this resource.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("A launch script you can create that configures a server with additional user data. For example, you might want to run apt-get -y update.")
  userData?: string;

  @doc("Username of the  Lightsail instance.")
  userName?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AddOn")
model AddOn {
  @doc("The add-on type")
  addOnType?: string;

  @doc("An object that represents additional parameters when enabling or modifying the automatic snapshot add-on")
  autoSnapshotAddOnRequest?: AutoSnapshotAddOn;

  @doc("Status of the Addon")
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
  @doc("CPU count of the Instance.")
  cpuCount?: int32;

  @doc("Disks attached to the Instance.")
  @extension("x-ms-identifiers", [])
  disks?: Disk[];

  @doc("RAM Size of the Instance.")
  ramSizeInGb?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Location")
model Location {
  @doc("The Availability Zone in which to create your instance. Use the following format: us-east-2a (case sensitive). Be sure to add the include Availability Zones parameter to your request.")
  availabilityZone?: string;

  @doc("The Region Name in which to create your instance.")
  regionName?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Networking")
model Networking {
  @doc("Monthly Transfer of the Instance.")
  monthlyTransfer?: MonthlyTransfer;

  @doc("Ports to the Instance.")
  @extension("x-ms-identifiers", [])
  ports?: Port[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of State")
model State {
  @doc("Status code of the Instance.")
  code?: int32;

  @doc("Status code of the Instance.")
  name?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("The key name of the tag. You can specify a value that is 1 to 128 Unicode characters in length and cannot be prefixed with aws:. You can use any of the following characters: the set of Unicode letters, digits, whitespace, _, ., /, =, +, and -.")
  key?: string;

  @doc("The value for the tag. You can specify a value that is 0 to 256 Unicode characters in length and cannot be prefixed with aws:. You can use any of the following characters: the set of Unicode letters, digits, whitespace, _, ., /, =, +, and -.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AutoSnapshotAddOn")
model AutoSnapshotAddOn {
  @doc("The daily time when an automatic snapshot will be created.")
  snapshotTimeOfDay?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Disk")
model Disk {
  @doc("Instance attached to the disk.")
  attachedTo?: string;

  @doc("Attachment state of the disk.")
  attachmentState?: string;

  @doc("The names to use for your new Lightsail disk.")
  diskName?: string;

  @doc("IOPS of disk.")
  iops?: int32;

  @doc("Is the Attached disk is the system disk of the Instance.")
  isSystemDisk?: boolean;

  @doc("Path of the disk attached to the instance.")
  path?: string;

  @doc("Size of the disk attached to the Instance.")
  sizeInGb?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of MonthlyTransfer")
model MonthlyTransfer {
  @doc("GbPerMonthAllocated of the Instance.")
  gbPerMonthAllocated?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Port")
model Port {
  @doc("Access Direction for Protocol of the Instance(inbound/outbound).")
  accessDirection?: string;

  @doc("Access From Protocol of the Instance.")
  accessFrom?: string;

  @doc("Access Type Protocol of the Instance.")
  accessType?: string;

  @doc("cidr List Aliases")
  @extension("x-ms-identifiers", [])
  cidrListAliases?: string[];

  @doc("Property cidrs")
  @extension("x-ms-identifiers", [])
  cidrs?: string[];

  @doc("CommonName for Protocol of the Instance.")
  commonName?: string;

  @doc("From Port of the Instance.")
  fromPort?: int32;

  @doc("IPv6 Cidrs")
  @extension("x-ms-identifiers", [])
  ipv6Cidrs?: string[];

  @doc("Port Protocol of the Instance.")
  protocol?: string;

  @doc("To Port of the Instance.")
  toPort?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface LightsailInstances {
  get is ArmResourceRead<LightsailInstance>;
  @doc("Create a LightsailInstance. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<LightsailInstance>;
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
