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

//---------------------------------------------- Route53DomainsDomainSummaries ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Route 53  Domains Domain Summary",
    plural: "Route 53  Domains Domain Summaries",
  },
  keywords: [
    "Microsoft.AwsConnector",
    "Route 53 ",
    "Domains",
    "Domain",
    "Summary"
  ],
})
@doc("A Microsoft.AwsConnector resource")
model Route53DomainsDomainSummary
  is TrackedResource<Route53DomainsDomainSummaryProperties> {
  @doc("Name of Route53DomainsDomainSummary")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("route53DomainsDomainSummaries")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Route53DomainsDomainSummary")
model Route53DomainsDomainSummaryProperties {
  @doc("AWS Properties")
  awsProperties?: AwsRoute53DomainsDomainSummaryProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsRoute53DomainsDomainSummary")
model AwsRoute53DomainsDomainSummaryProperties {
  @doc("<p>Indicates whether the domain is automatically renewed upon expiration.</p>")
  autoRenew?: boolean;

  @doc("<p>The name of the domain that the summary information applies to.</p>")
  domainName?: string;

  @doc("<p>Expiration date of the domain in Unix time format and Coordinated Universal Time (UTC).</p>")
  expiry?: utcDateTime;

  @doc("<p>Indicates whether a domain is locked from unauthorized transfer to another party.</p>")
  transferLock?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface Route53DomainsDomainSummaries {
  get is ArmResourceRead<Route53DomainsDomainSummary>;
  @doc("Create a Route53DomainsDomainSummary. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<Route53DomainsDomainSummary>;
  update is ArmCustomPatchAsync<
    Route53DomainsDomainSummary,
    Azure.ResourceManager.Foundations.TagsUpdateModel<Route53DomainsDomainSummary>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Route53DomainsDomainSummary>;
  listByResourceGroup is ArmResourceListByParent<Route53DomainsDomainSummary>;
  listBySubscription is ArmListBySubscription<Route53DomainsDomainSummary>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\route53domains\route53domains-2014-05-15.normal.json
// AWS Shape: DomainSummary
//
// Related information for backend service:
// AWS Servcie : Route 53 Domains
// Product Version : 3.7.798.0
// SDK Version : 3.7.301.35
//--------------------------------------------------------------------------------------------
