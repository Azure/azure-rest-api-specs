import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using global.Azure.Core.Foundations;
using TypeSpec.Http;

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
): void;

@@override(Azure.Batch.Applications.getApplication,
    getApplicationCustomization,
    "java"
  );

@@access(JavaClient.GetApplicationOptions, Access.public, "java");

  