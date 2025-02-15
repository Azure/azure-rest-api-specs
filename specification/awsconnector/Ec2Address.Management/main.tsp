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

//---------------------------------------------- Ec2Addresses ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "EC2 Address",
    plural: "EC2 Addresses",
  },
  keywords: ["Microsoft.AwsConnector", "EC2", "Address"],
})
@doc("A Microsoft.AwsConnector resource")
model Ec2Address is TrackedResource<Ec2AddressProperties> {
  @doc("Name of Ec2Address")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("ec2Addresses")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Ec2Address")
model Ec2AddressProperties {
  @doc("AWS Properties")
  awsProperties?: AwsEc2AddressProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsEc2Address")
model AwsEc2AddressProperties {
  @doc("<p>The ID representing the allocation of the address.</p>")
  allocationId?: string;

  @doc("<p>The ID representing the association of the address with an instance.</p>")
  associationId?: string;

  @doc("<p>The carrier IP address associated. This option is only available for network interfaces which reside in a subnet in a Wavelength Zone (for example an EC2 instance). </p>")
  carrierIp?: string;

  @doc("<p>The customer-owned IP address.</p>")
  customerOwnedIp?: string;

  @doc("<p>The ID of the customer-owned address pool.</p>")
  customerOwnedIpv4Pool?: string;

  @doc("<p>The network (<code>vpc</code>).</p>")
  domain?: DomainTypeEnumValue;

  @doc("<p>The ID of the instance that the address is associated with (if any).</p>")
  instanceId?: string;

  @doc("<p>The name of the unique set of Availability Zones, Local Zones, or Wavelength Zones from which Amazon Web Services advertises IP addresses.</p>")
  networkBorderGroup?: string;

  @doc("<p>The ID of the network interface.</p>")
  networkInterfaceId?: string;

  @doc("<p>The ID of the Amazon Web Services account that owns the network interface.</p>")
  networkInterfaceOwnerId?: string;

  @doc("<p>The private IP address associated with the Elastic IP address.</p>")
  privateIpAddress?: string;

  @doc("<p>The Elastic IP address.</p>")
  publicIp?: string;

  @doc("<p>The ID of an address pool.</p>")
  publicIpv4Pool?: string;

  @doc("<p>Any tags assigned to the Elastic IP address.</p>")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];
}

@doc("DomainType enum")
union DomainType {
  @doc("DomainType enum standard")
  Standard: "standard",

  @doc("DomainType enum vpc")
  Vpc: "vpc",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DomainTypeEnumValue")
model DomainTypeEnumValue {
  @doc("Property value")
  value?: DomainType;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("<p>The key of the tag.</p> <p>Constraints: Tag keys are case-sensitive and accept a maximum of 127 Unicode characters. May not begin with <code>aws:</code>.</p>")
  key?: string;

  @doc("<p>The value of the tag.</p> <p>Constraints: Tag values are case-sensitive and accept a maximum of 256 Unicode characters.</p>")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface Ec2Addresses {
  get is ArmResourceRead<Ec2Address>;
  @doc("Create a Ec2Address. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<Ec2Address>;
  update is ArmCustomPatchAsync<
    Ec2Address,
    Azure.ResourceManager.Foundations.TagsUpdateModel<Ec2Address>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Ec2Address>;
  listByResourceGroup is ArmResourceListByParent<Ec2Address>;
  listBySubscription is ArmListBySubscription<Ec2Address>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\ec2\ec2-2016-11-15.normal.json
// AWS Shape: Address
//
// Related information for backend service:
// AWS Servcie : EC2
// Product Version : 3.7.798.0
// SDK Version : 3.7.325.2
//--------------------------------------------------------------------------------------------
