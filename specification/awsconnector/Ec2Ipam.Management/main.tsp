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

//---------------------------------------------- Ec2Ipams ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "EC2 Ipam",
    plural: "EC2 Ipams",
  },
  keywords: ["Microsoft.AwsConnector", "EC2", "Ipam"],
})
@doc("A Microsoft.AwsConnector resource")
model Ec2Ipam is TrackedResource<Ec2IpamProperties> {
  @doc("Name of Ec2Ipam")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("ec2Ipams")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Ec2Ipam")
model Ec2IpamProperties {
  @doc("AWS Properties")
  awsProperties?: AwsEc2IpamProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsEc2Ipam")
model AwsEc2IpamProperties {
  @doc("<p>The IPAM's default resource discovery association ID.</p>")
  defaultResourceDiscoveryAssociationId?: string;

  @doc("<p>The IPAM's default resource discovery ID.</p>")
  defaultResourceDiscoveryId?: string;

  @doc("<p>The description for the IPAM.</p>")
  description?: string;

  @doc("<p>The Amazon Resource Name (ARN) of the IPAM.</p>")
  ipamArn?: string;

  @doc("<p>The ID of the IPAM.</p>")
  ipamId?: string;

  @doc("<p>The Amazon Web Services Region of the IPAM.</p>")
  ipamRegion?: string;

  @doc("<p>The operating Regions for an IPAM. Operating Regions are Amazon Web Services Regions where the IPAM is allowed to manage IP address CIDRs. IPAM only discovers and monitors resources in the Amazon Web Services Regions you select as operating Regions.</p> <p>For more information about operating Regions, see <a href='https://docs.aws.amazon.com/vpc/latest/ipam/create-ipam.html'>Create an IPAM</a> in the <i>Amazon VPC IPAM User Guide</i>.</p>")
  @extension("x-ms-identifiers", [])
  operatingRegions?: IpamOperatingRegion[];

  @doc("<p>The Amazon Web Services account ID of the owner of the IPAM.</p>")
  ownerId?: string;

  @doc("<p>The ID of the IPAM's default private scope.</p>")
  privateDefaultScopeId?: string;

  @doc("<p>The ID of the IPAM's default public scope.</p>")
  publicDefaultScopeId?: string;

  @doc("<p>The IPAM's resource discovery association count.</p>")
  resourceDiscoveryAssociationCount?: int32;

  @doc("<p>The number of scopes in the IPAM. The scope quota is 5. For more information on quotas, see <a href='https://docs.aws.amazon.com/vpc/latest/ipam/quotas-ipam.html'>Quotas in IPAM</a> in the <i>Amazon VPC IPAM User Guide</i>. </p>")
  scopeCount?: int32;

  @doc("<p>The state of the IPAM.</p>")
  state?: IpamStateEnumValue;

  @doc("<p>The state message.</p>")
  stateMessage?: string;

  @doc("<p>The key/value combination of a tag assigned to the resource. Use the tag key in the filter name and the tag value as the filter value. For example, to find all resources that have a tag with the key <code>Owner</code> and the value <code>TeamA</code>, specify <code>tag:Owner</code> for the filter name and <code>TeamA</code> for the filter value.</p>")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("<p>IPAM is offered in a Free Tier and an Advanced Tier. For more information about the features available in each tier and the costs associated with the tiers, see <a href='http://aws.amazon.com/vpc/pricing/'>Amazon VPC pricing &gt; IPAM tab</a>.</p>")
  tier?: IpamTierEnumValue;
}

@doc("IpamState enum")
union IpamState {
  @doc("IpamState enum create-complete")
  CreateComplete: "create-complete",

  @doc("IpamState enum create-failed")
  CreateFailed: "create-failed",

  @doc("IpamState enum create-in-progress")
  CreateInProgress: "create-in-progress",

  @doc("IpamState enum delete-complete")
  DeleteComplete: "delete-complete",

  @doc("IpamState enum delete-failed")
  DeleteFailed: "delete-failed",

  @doc("IpamState enum delete-in-progress")
  DeleteInProgress: "delete-in-progress",

  @doc("IpamState enum isolate-complete")
  IsolateComplete: "isolate-complete",

  @doc("IpamState enum isolate-in-progress")
  IsolateInProgress: "isolate-in-progress",

  @doc("IpamState enum modify-complete")
  ModifyComplete: "modify-complete",

  @doc("IpamState enum modify-failed")
  ModifyFailed: "modify-failed",

  @doc("IpamState enum modify-in-progress")
  ModifyInProgress: "modify-in-progress",

  @doc("IpamState enum restore-in-progress")
  RestoreInProgress: "restore-in-progress",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of IpamStateEnumValue")
model IpamStateEnumValue {
  @doc("Property value")
  value?: IpamState;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of IpamOperatingRegion")
model IpamOperatingRegion {
  @doc("<p>The name of the operating Region.</p>")
  regionName?: string;
}

@doc("IpamTier enum")
union IpamTier {
  @doc("IpamTier enum advanced")
  Advanced: "advanced",

  @doc("IpamTier enum free")
  Free: "free",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of IpamTierEnumValue")
model IpamTierEnumValue {
  @doc("Property value")
  value?: IpamTier;
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
interface Ec2Ipams {
  get is ArmResourceRead<Ec2Ipam>;
  @doc("Create a Ec2Ipam. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<Ec2Ipam>;
  update is ArmCustomPatchAsync<
    Ec2Ipam,
    Azure.ResourceManager.Foundations.TagsUpdateModel<Ec2Ipam>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Ec2Ipam>;
  listByResourceGroup is ArmResourceListByParent<Ec2Ipam>;
  listBySubscription is ArmListBySubscription<Ec2Ipam>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\ec2\ec2-2016-11-15.normal.json
// AWS Shape: Ipam
//
// Related information for backend service:
// AWS Servcie : EC2
// Product Version : 3.7.798.0
// SDK Version : 3.7.325.2
//--------------------------------------------------------------------------------------------
