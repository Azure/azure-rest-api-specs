import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
import "@typespec/versioning";

using Azure.ClientGenerator.Core;
using global.Azure.Core.Foundations;
using TypeSpec.Http;
using TypeSpec.Versioning;

@TypeSpec.Versioning.useDependency(Azure.Core.Versions.v1_0_Preview_2)
@TypeSpec.Versioning.useDependency(Azure.Batch.Versions.v2024_07_01)
namespace JavaClient;

// Get Application Operation
@doc("Optional parameters for Get Application operation.")
model GetApplicationOptions {
  ...Azure.Batch.BatchClientRequestHeaders;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
@doc("Custom override for Get Application operation.")
op getApplicationCustomization(
  ...Azure.Batch.GetApplicationRequiredParameters,

  @doc("Optional parameters for Get Application operation.")
  options?: GetApplicationOptions,

  ...ApiVersionParameter,
): Azure.Batch.BatchApplication;

@@override(Azure.Batch.Applications.getApplication,
  getApplicationCustomization,
  "java"
);

@@access(JavaClient.GetApplicationOptions, Access.public, "java");
