import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
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
interface ManagedDatabaseSensitivityLabels {
  @doc("Gets the sensitivity label of a given column")
  get is ArmResourceRead<SensitivityLabel>;
  @doc("Creates or updates the sensitivity label of a given column")
  createOrUpdate is ArmResourceCreateOrReplaceSync<SensitivityLabel>;
  @doc("Deletes the sensitivity label of a given column")
  delete is ArmResourceDeleteSync<SensitivityLabel>;
}
