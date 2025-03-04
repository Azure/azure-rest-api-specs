import "./common.tsp";
import "./routes.tsp";
import "@azure-tools/typespec-client-generator-core";

using global.Azure.Core.Foundations;
using Azure.ClientGenerator.Core;

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

// List Applications Operation

@doc("Optional parameters for List Applications operation.")
model ListBatchApplicationsOptions {
  ...Azure.Batch.BatchCommonListHeaders;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
@doc("Custom override for List Applications operation.")
op listApplicationsCustomization(
  @doc("Optional parameters for List Applications operation.")
  options?: ListBatchApplicationsOptions,

  ...ApiVersionParameter,
): void;

@@override(Azure.Batch.Applications.listApplications,
  listApplicationsCustomization,
  "java"
);
