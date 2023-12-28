import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./IntegrationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Logic;
@doc("The batch configuration resource definition.")
@parentResource(IntegrationAccount)
model BatchConfiguration is TrackedResource<BatchConfigurationProperties> {
  @doc("The batch configuration name.")
  @key("batchConfigurationName")
  @segment("batchConfigurations")
  name: string;
}

@armResourceOperations
interface IntegrationAccountBatchConfigurations {
  @doc("Get a batch configuration for an integration account.")
  get is ArmResourceRead<BatchConfiguration>;
  @doc("Create or update a batch configuration for an integration account.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<BatchConfiguration>;
  @doc("Delete a batch configuration for an integration account.")
  delete is ArmResourceDeleteSync<BatchConfiguration>;
  @doc("List the batch configurations for an integration account.")
  list is ArmResourceListByParent<BatchConfiguration>;
}
