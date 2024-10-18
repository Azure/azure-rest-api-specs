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

//---------------------------------------------- SageMakerApps ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Sage Maker App",
    plural: "Sage Maker Apps",
  },
  keywords: ["Microsoft.AwsConnector", "Sage", "Maker", "App"],
})
@doc("A Microsoft.AwsConnector resource")
model SageMakerApp is TrackedResource<SageMakerAppProperties> {
  @doc("Name of SageMakerApp")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("sageMakerApps")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SageMakerApp")
model SageMakerAppProperties {
  @doc("AWS Properties")
  awsProperties?: AwsSageMakerAppProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsSageMakerApp")
model AwsSageMakerAppProperties {
  @doc("The Amazon Resource Name (ARN) of the app.")
  appArn?: string;

  @doc("The name of the app.")
  appName?: string;

  @doc("The type of app.")
  appType?: AppType;

  @doc("The domain ID.")
  domainId?: string;

  @doc("The instance type and the Amazon Resource Name (ARN) of the SageMaker image created on the instance.")
  resourceSpec?: ResourceSpec;

  @doc("A list of tags to apply to the app.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("The user profile name.")
  userProfileName?: string;
}

@doc("AppType enum")
union AppType {
  @doc("AppType enum Canvas")
  Canvas: "Canvas",

  @doc("AppType enum JupyterServer")
  JupyterServer: "JupyterServer",

  @doc("AppType enum KernelGateway")
  KernelGateway: "KernelGateway",

  @doc("AppType enum RSessionGateway")
  RSessionGateway: "RSessionGateway",

  @doc("AppType enum RStudioServerPro")
  RStudioServerPro: "RStudioServerPro",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ResourceSpec")
model ResourceSpec {
  @doc("The instance type that the image version runs on.")
  instanceType?: ResourceSpecInstanceType;

  @doc("The ARN of the SageMaker image that the image version belongs to.")
  sageMakerImageArn?: string;

  @doc("The ARN of the image version created on the instance.")
  sageMakerImageVersionArn?: string;
}

@doc("ResourceSpecInstanceType enum")
union ResourceSpecInstanceType {
  @doc("ResourceSpecInstanceType enum ml.c5.12xlarge")
  MlC512xlarge: "ml.c5.12xlarge",

  @doc("ResourceSpecInstanceType enum ml.c5.18xlarge")
  MlC518xlarge: "ml.c5.18xlarge",

  @doc("ResourceSpecInstanceType enum ml.c5.24xlarge")
  MlC524xlarge: "ml.c5.24xlarge",

  @doc("ResourceSpecInstanceType enum ml.c5.2xlarge")
  MlC52xlarge: "ml.c5.2xlarge",

  @doc("ResourceSpecInstanceType enum ml.c5.4xlarge")
  MlC54xlarge: "ml.c5.4xlarge",

  @doc("ResourceSpecInstanceType enum ml.c5.9xlarge")
  MlC59xlarge: "ml.c5.9xlarge",

  @doc("ResourceSpecInstanceType enum ml.c5.large")
  MlC5Large: "ml.c5.large",

  @doc("ResourceSpecInstanceType enum ml.c5.xlarge")
  MlC5Xlarge: "ml.c5.xlarge",

  @doc("ResourceSpecInstanceType enum ml.g4dn.12xlarge")
  MlG4dn12xlarge: "ml.g4dn.12xlarge",

  @doc("ResourceSpecInstanceType enum ml.g4dn.16xlarge")
  MlG4dn16xlarge: "ml.g4dn.16xlarge",

  @doc("ResourceSpecInstanceType enum ml.g4dn.2xlarge")
  MlG4dn2xlarge: "ml.g4dn.2xlarge",

  @doc("ResourceSpecInstanceType enum ml.g4dn.4xlarge")
  MlG4dn4xlarge: "ml.g4dn.4xlarge",

  @doc("ResourceSpecInstanceType enum ml.g4dn.8xlarge")
  MlG4dn8xlarge: "ml.g4dn.8xlarge",

  @doc("ResourceSpecInstanceType enum ml.g4dn.xlarge")
  MlG4dnXlarge: "ml.g4dn.xlarge",

  @doc("ResourceSpecInstanceType enum ml.g5.12xlarge")
  MlG512xlarge: "ml.g5.12xlarge",

  @doc("ResourceSpecInstanceType enum ml.g5.16xlarge")
  MlG516xlarge: "ml.g5.16xlarge",

  @doc("ResourceSpecInstanceType enum ml.g5.24xlarge")
  MlG524xlarge: "ml.g5.24xlarge",

  @doc("ResourceSpecInstanceType enum ml.g5.2xlarge")
  MlG52xlarge: "ml.g5.2xlarge",

  @doc("ResourceSpecInstanceType enum ml.g5.48xlarge")
  MlG548xlarge: "ml.g5.48xlarge",

  @doc("ResourceSpecInstanceType enum ml.g5.4xlarge")
  MlG54xlarge: "ml.g5.4xlarge",

  @doc("ResourceSpecInstanceType enum ml.g5.8xlarge")
  MlG58xlarge: "ml.g5.8xlarge",

  @doc("ResourceSpecInstanceType enum ml.g5.xlarge")
  MlG5Xlarge: "ml.g5.xlarge",

  @doc("ResourceSpecInstanceType enum ml.geospatial.interactive")
  MlGeospatialInteractive: "ml.geospatial.interactive",

  @doc("ResourceSpecInstanceType enum ml.m5.12xlarge")
  MlM512xlarge: "ml.m5.12xlarge",

  @doc("ResourceSpecInstanceType enum ml.m5.16xlarge")
  MlM516xlarge: "ml.m5.16xlarge",

  @doc("ResourceSpecInstanceType enum ml.m5.24xlarge")
  MlM524xlarge: "ml.m5.24xlarge",

  @doc("ResourceSpecInstanceType enum ml.m5.2xlarge")
  MlM52xlarge: "ml.m5.2xlarge",

  @doc("ResourceSpecInstanceType enum ml.m5.4xlarge")
  MlM54xlarge: "ml.m5.4xlarge",

  @doc("ResourceSpecInstanceType enum ml.m5.8xlarge")
  MlM58xlarge: "ml.m5.8xlarge",

  @doc("ResourceSpecInstanceType enum ml.m5.large")
  MlM5Large: "ml.m5.large",

  @doc("ResourceSpecInstanceType enum ml.m5.xlarge")
  MlM5Xlarge: "ml.m5.xlarge",

  @doc("ResourceSpecInstanceType enum ml.m5d.12xlarge")
  MlM5d12xlarge: "ml.m5d.12xlarge",

  @doc("ResourceSpecInstanceType enum ml.m5d.16xlarge")
  MlM5d16xlarge: "ml.m5d.16xlarge",

  @doc("ResourceSpecInstanceType enum ml.m5d.24xlarge")
  MlM5d24xlarge: "ml.m5d.24xlarge",

  @doc("ResourceSpecInstanceType enum ml.m5d.2xlarge")
  MlM5d2xlarge: "ml.m5d.2xlarge",

  @doc("ResourceSpecInstanceType enum ml.m5d.4xlarge")
  MlM5d4xlarge: "ml.m5d.4xlarge",

  @doc("ResourceSpecInstanceType enum ml.m5d.8xlarge")
  MlM5d8xlarge: "ml.m5d.8xlarge",

  @doc("ResourceSpecInstanceType enum ml.m5d.large")
  MlM5dLarge: "ml.m5d.large",

  @doc("ResourceSpecInstanceType enum ml.m5d.xlarge")
  MlM5dXlarge: "ml.m5d.xlarge",

  @doc("ResourceSpecInstanceType enum ml.p3.16xlarge")
  MlP316xlarge: "ml.p3.16xlarge",

  @doc("ResourceSpecInstanceType enum ml.p3.2xlarge")
  MlP32xlarge: "ml.p3.2xlarge",

  @doc("ResourceSpecInstanceType enum ml.p3.8xlarge")
  MlP38xlarge: "ml.p3.8xlarge",

  @doc("ResourceSpecInstanceType enum ml.p3dn.24xlarge")
  MlP3dn24xlarge: "ml.p3dn.24xlarge",

  @doc("ResourceSpecInstanceType enum ml.p4d.24xlarge")
  MlP4d24xlarge: "ml.p4d.24xlarge",

  @doc("ResourceSpecInstanceType enum ml.p4de.24xlarge")
  MlP4de24xlarge: "ml.p4de.24xlarge",

  @doc("ResourceSpecInstanceType enum ml.r5.12xlarge")
  MlR512xlarge: "ml.r5.12xlarge",

  @doc("ResourceSpecInstanceType enum ml.r5.16xlarge")
  MlR516xlarge: "ml.r5.16xlarge",

  @doc("ResourceSpecInstanceType enum ml.r5.24xlarge")
  MlR524xlarge: "ml.r5.24xlarge",

  @doc("ResourceSpecInstanceType enum ml.r5.2xlarge")
  MlR52xlarge: "ml.r5.2xlarge",

  @doc("ResourceSpecInstanceType enum ml.r5.4xlarge")
  MlR54xlarge: "ml.r5.4xlarge",

  @doc("ResourceSpecInstanceType enum ml.r5.8xlarge")
  MlR58xlarge: "ml.r5.8xlarge",

  @doc("ResourceSpecInstanceType enum ml.r5.large")
  MlR5Large: "ml.r5.large",

  @doc("ResourceSpecInstanceType enum ml.r5.xlarge")
  MlR5Xlarge: "ml.r5.xlarge",

  @doc("ResourceSpecInstanceType enum ml.t3.2xlarge")
  MlT32xlarge: "ml.t3.2xlarge",

  @doc("ResourceSpecInstanceType enum ml.t3.large")
  MlT3Large: "ml.t3.large",

  @doc("ResourceSpecInstanceType enum ml.t3.medium")
  MlT3Medium: "ml.t3.medium",

  @doc("ResourceSpecInstanceType enum ml.t3.micro")
  MlT3Micro: "ml.t3.micro",

  @doc("ResourceSpecInstanceType enum ml.t3.small")
  MlT3Small: "ml.t3.small",

  @doc("ResourceSpecInstanceType enum ml.t3.xlarge")
  MlT3Xlarge: "ml.t3.xlarge",

  @doc("ResourceSpecInstanceType enum ml.trn1.2xlarge")
  MlTrn12xlarge: "ml.trn1.2xlarge",

  @doc("ResourceSpecInstanceType enum ml.trn1.32xlarge")
  MlTrn132xlarge: "ml.trn1.32xlarge",

  @doc("ResourceSpecInstanceType enum ml.trn1n.32xlarge")
  MlTrn1n32xlarge: "ml.trn1n.32xlarge",

  @doc("ResourceSpecInstanceType enum system")
  system: "system",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("Property key")
  key?: string;

  @doc("Property value")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface SageMakerApps {
  get is ArmResourceRead<SageMakerApp>;
  @doc("Create a SageMakerApp. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<SageMakerApp>;
  update is ArmCustomPatchAsync<
    SageMakerApp,
    Azure.ResourceManager.Foundations.TagsUpdateModel<SageMakerApp>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<SageMakerApp>;
  listByResourceGroup is ArmResourceListByParent<SageMakerApp>;
  listBySubscription is ArmListBySubscription<SageMakerApp>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::SageMaker::App
//--------------------------------------------------------------------------------------------
