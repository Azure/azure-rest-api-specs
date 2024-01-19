import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
@doc("A sensitivity label.")
model SensitivityLabel is ProxyResource<SensitivityLabelProperties> {
  @doc("The source of the sensitivity label.")
  @path
  @key("sensitivityLabelSource")
  @segment("sensitivityLabels")
  name: SensitivityLabelSource;

  ...Azure.ResourceManager.ManagedBy;
}

@armResourceOperations
interface SensitivityLabels {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the sensitivity label of a given column")
  @operationId("ManagedDatabaseSensitivityLabels_Get")
  get is ArmResourceRead<SensitivityLabel>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates or updates the sensitivity label of a given column")
  @operationId("ManagedDatabaseSensitivityLabels_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<SensitivityLabel>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes the sensitivity label of a given column")
  @operationId("ManagedDatabaseSensitivityLabels_Delete")
  delete is ArmResourceDeleteSync<SensitivityLabel>;
}

@@projectedName(SensitivityLabels.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(SensitivityLabels.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(SensitivityLabels.createOrUpdate::parameters.resource,
  "The column sensitivity label resource."
);
