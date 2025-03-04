import "./common.tsp";
import "./main.tsp";
import "./routes.tsp";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/http";

using global.Azure.Core.Foundations;
using Azure.ClientGenerator.Core;
using TypeSpec.Http;

@TypeSpec.Versioning.useDependency(Azure.Core.Versions.v1_0_Preview_2)
@TypeSpec.Versioning.useDependency(Azure.Batch.Versions.v2024_07_01)
namespace JavaClient;

// Get Application Operation
@doc("Optional parameters for Get Application operation.")
model GetApplicationOptions {
  ...Azure.Batch.BatchClientRequestHeaders;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Get Application operation.")
@route("/applications/{applicationId}")
op getApplicationCustomization is Azure.Batch.ReadOperationNew<
  {
    ...Azure.Batch.GetApplicationRequiredParameters,

    @doc("Optional parameters for Get Application operation.")
    options?: GetApplicationOptions,
  },
  Azure.Batch.BatchApplication
>;

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
