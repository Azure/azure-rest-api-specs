import "@azure-tools/typespec-client-generator-core";
import "./common.tsp";
import "./main.tsp";
import "./routes.tsp";

using Azure.ClientGenerator.Core;

@TypeSpec.Versioning.useDependency(Azure.Core.Versions.v1_0_Preview_2)
namespace JavaClient;

@@override(Azure.Batch.Applications.getApplication, getApplication, "java");

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
#suppress "@azure-tools/typespec-azure-core/rpc-operation-needs-route" ""
op getApplication is Azure.Core.RpcOperation<
  {
    ...Azure.Batch.getApplicationParameters;

    @doc("Options for this operation")
    options?: Azure.Batch.BatchCommonReadParameters;
  },
  Azure.Batch.BatchApplication & Azure.Batch.BatchResponseHeaders,
  {},
  Azure.Batch.BatchError
>;

// op ReadOperationWithOptions<
//   TParameters extends TypeSpec.Reflection.Model,
//   TExtraOptions extends TypeSpec.Reflection.Model,
//   TResource
// > is Azure.Core.RpcOperation<
//   {
//     ...TParameters;

//     @doc("Options for this operation")
//     options?: Azure.Batch.BatchCommonReadParameters & TExtraOptions;
//   },
//   TResource & Azure.Batch.BatchResponseHeaders,
//   {},
//   Azure.Batch.BatchError
// >;
