import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@access(Azure.Batch.Ops.ListOperation, Access.internal, "java");
@@access(Azure.Batch.Ops.ReadOperation, Access.internal, "java");
@@access(Azure.Batch.Ops.DeleteOperation, Access.internal, "java");
@@access(Azure.Batch.Ops.CreateOperation, Access.internal, "java");
@@access(Azure.Batch.Ops.UpdateOperation, Access.internal, "java");
@@access(Azure.Batch.Ops.ReplaceOperation, Access.internal, "java");
@@access(Azure.Batch.Ops.PostOperation, Access.internal, "java");
@@access(Azure.Batch.Ops.ResourceInfoOperation, Access.internal, "java");
@@access(Azure.Batch.Ops.ResourceInfoOperationWithAdditionalResponse,
  Access.internal,
  "java"
);
