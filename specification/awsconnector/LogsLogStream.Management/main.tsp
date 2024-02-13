import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "../shared/main.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;
using Azure.Core;
using Azure.ResourceManager;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Supress missing operations endpoint as the same is defined ../operations/main.tsp."
@armProviderNamespace
@service({
  title: "Microsoft.AwsConnector",
  version: "2024-08-01-preview",
})
@doc("Microsoft.AwsConnector Resource Provider management API.")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.AwsConnector;

//---------------------------------------------- LogsLogStreams ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@doc("A Microsoft.AwsConnector resource")
model LogsLogStream is TrackedResource<LogsLogStreamProperties> {
  @doc("Name of LogsLogStream")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("logsLogStreams")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of LogsLogStream")
model LogsLogStreamProperties {
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsLogsLogStreamProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of awsLogsLogStream")
model AwsLogsLogStreamProperties {
  @doc("Gets and sets the property logGroupName. The name of the log group where the log stream is created.")
  logGroupName?: string;

  @doc("Gets and sets the property logStreamName. The name of the log stream. The name must be unique wihtin the log group.")
  logStreamName?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface LogsLogStreams {
  get is ArmResourceRead<LogsLogStream>;
  @doc("Create a LogsLogStream. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<LogsLogStream>;
  update is ArmCustomPatchAsync<
    LogsLogStream,
    Azure.ResourceManager.Foundations.TagsUpdateModel<LogsLogStream>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<LogsLogStream>;
  listByResourceGroup is ArmResourceListByParent<LogsLogStream>;
  listBySubscription is ArmListBySubscription<LogsLogStream>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::Logs::LogStream
//--------------------------------------------------------------------------------------------
