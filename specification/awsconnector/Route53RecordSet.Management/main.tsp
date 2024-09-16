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

//---------------------------------------------- Route53RecordSets ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Route53 Record Set",
    plural: "Route53 Record Sets",
  },
  keywords: ["Microsoft.AwsConnector", "Route53", "Record", "Set"],
})
@doc("A Microsoft.AwsConnector resource")
model Route53RecordSet is TrackedResource<Route53RecordSetProperties> {
  @doc("Name of Route53RecordSet")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("route53RecordSets")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Route53RecordSet")
model Route53RecordSetProperties {
  @doc("AWS Properties")
  awsProperties?: AwsRoute53RecordSetProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsRoute53RecordSet")
model AwsRoute53RecordSetProperties {
  @doc("Property aliasTarget")
  aliasTarget?: AliasTarget;

  @doc("Property cidrRoutingConfig")
  cidrRoutingConfig?: CidrRoutingConfig;

  @doc("Property comment")
  comment?: string;

  @doc("Property failover")
  failover?: string;

  @doc("Property geoLocation")
  geoLocation?: GeoLocation;

  @doc("Property geoProximityLocation")
  geoProximityLocation?: GeoProximityLocation;

  @doc("Property healthCheckId")
  healthCheckId?: string;

  @doc("Property hostedZoneId")
  hostedZoneId?: string;

  @doc("Property hostedZoneName")
  hostedZoneName?: string;

  @doc("Property id")
  id?: string;

  @doc("Property multiValueAnswer")
  multiValueAnswer?: boolean;

  @doc("Property name")
  name?: string;

  @doc("Property region")
  region?: string;

  @doc("Property resourceRecords")
  @extension("x-ms-identifiers", [])
  resourceRecords?: string[];

  @doc("Property setIdentifier")
  setIdentifier?: string;

  @doc("Property ttl")
  ttl?: string;

  @doc("Property type")
  type?: string;

  @doc("Property weight")
  weight?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AliasTarget")
model AliasTarget {
  @doc("Property dnsName")
  dnsName?: string;

  @doc("Property evaluateTargetHealth")
  evaluateTargetHealth?: boolean;

  @doc("Property hostedZoneId")
  hostedZoneId?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CidrRoutingConfig")
model CidrRoutingConfig {
  @doc("Property collectionId")
  collectionId?: string;

  @doc("Property locationName")
  locationName?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of GeoLocation")
model GeoLocation {
  @doc("Property continentCode")
  continentCode?: string;

  @doc("Property countryCode")
  countryCode?: string;

  @doc("Property subdivisionCode")
  subdivisionCode?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of GeoProximityLocation")
model GeoProximityLocation {
  @doc("Property awsRegion")
  awsRegion?: string;

  @doc("Property bias")
  bias?: int32;

  @doc("Property coordinates")
  coordinates?: Coordinates;

  @doc("Property localZoneGroup")
  localZoneGroup?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Coordinates")
model Coordinates {
  @doc("Property latitude")
  latitude?: string;

  @doc("Property longitude")
  longitude?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface Route53RecordSets {
  get is ArmResourceRead<Route53RecordSet>;
  @doc("Create a Route53RecordSet. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Route53RecordSet>;
  update is ArmCustomPatchAsync<
    Route53RecordSet,
    Azure.ResourceManager.Foundations.TagsUpdateModel<Route53RecordSet>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Route53RecordSet>;
  listByResourceGroup is ArmResourceListByParent<Route53RecordSet>;
  listBySubscription is ArmListBySubscription<Route53RecordSet>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::Route53::RecordSet
//--------------------------------------------------------------------------------------------
