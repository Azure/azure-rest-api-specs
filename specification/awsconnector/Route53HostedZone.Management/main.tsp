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

//---------------------------------------------- Route53HostedZones ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@doc("A Microsoft.AwsConnector resource")
model Route53HostedZone is TrackedResource<Route53HostedZoneProperties> {
  @doc("Name of Route53HostedZone")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("route53HostedZones")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Route53HostedZone")
model Route53HostedZoneProperties {
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsRoute53HostedZoneProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsRoute53HostedZone")
model AwsRoute53HostedZoneProperties {
  @doc("Gets and sets the property hostedZoneConfig. A complex type that contains an optional comment.If you don't want to specify a comment, omit the HostedZoneConfig and Comment elements.")
  hostedZoneConfig?: HostedZoneConfig;

  @doc("Gets and sets the property hostedZoneTags. Adds, edits, or deletes tags for a health check or a hosted zone.For information about using tags for cost allocation, see Using Cost Allocation Tags in the AWS Billing and Cost Management User Guide.")
  @extension("x-ms-identifiers", [])
  hostedZoneTags?: HostedZoneTag[];

  @doc("Gets and sets the property id.")
  id?: string;

  @doc("Gets and sets the property name. The name of the domain. Specify a fully qualified domain name, for example, www.example.com. The trailing dot is optional; Amazon Route 53 assumes that the domain name is fully qualified. This means that Route 53 treats www.example.com (without a trailing dot) and www.example.com. (with a trailing dot) as identical.If you're creating a public hosted zone, this is the name you have registered with your DNS registrar. If your domain name is registered with a registrar other than Route 53, change the name servers for your domain to the set of NameServers that are returned by the Fn::GetAtt intrinsic function.")
  name?: string;

  @doc("Gets and sets the property nameServers.")
  @extension("x-ms-identifiers", [])
  nameServers?: string[];

  @doc("Gets and sets the property queryLoggingConfig. A complex type that contains information about a configuration for DNS query logging.")
  queryLoggingConfig?: QueryLoggingConfig;

  @doc("Gets and sets the property vpCs. A complex type that contains information about the VPCs that are associated with the specified hosted zone.")
  @extension("x-ms-identifiers", [])
  vpCs?: VPC[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of HostedZoneConfig")
model HostedZoneConfig {
  @doc("Gets and sets the property comment. Any comments that you want to include about the hosted zone.")
  comment?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of HostedZoneTag")
model HostedZoneTag {
  @doc("Gets and sets the property key. The key name of the tag.")
  key?: string;

  @doc("Gets and sets the property value. The value for the tag.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of QueryLoggingConfig")
model QueryLoggingConfig {
  @doc("Gets and sets the property cloudWatchLogsLogGroupArn. The Amazon Resource Name (ARN) of the CloudWatch Logs log group that Amazon Route 53 is publishing logs to.")
  cloudWatchLogsLogGroupArn?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of VPC")
model VPC {
  @doc("Gets and sets the property vpcId. The ID of an Amazon VPC.")
  vpcId?: string;

  @doc("Gets and sets the property vpcRegion. The region that an Amazon VPC was created in. See https://docs.aws.amazon.com/general/latest/gr/rande.html for a list of up to date regions.")
  vpcRegion?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface Route53HostedZones {
  get is ArmResourceRead<Route53HostedZone>;
  @doc("Create a Route53HostedZone. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Route53HostedZone>;
  update is ArmCustomPatchAsync<
    Route53HostedZone,
    Azure.ResourceManager.Foundations.TagsUpdateModel<Route53HostedZone>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Route53HostedZone>;
  listByResourceGroup is ArmResourceListByParent<Route53HostedZone>;
  listBySubscription is ArmListBySubscription<Route53HostedZone>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::Route53::HostedZone
//--------------------------------------------------------------------------------------------
