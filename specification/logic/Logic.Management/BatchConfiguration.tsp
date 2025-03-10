import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./IntegrationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Logic;
@doc("The batch configuration resource definition.")
@parentResource(IntegrationAccount)
model BatchConfiguration
  is Azure.ResourceManager.TrackedResource<
    BatchConfigurationProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = BatchConfiguration,
    KeyName = "batchConfigurationName",
    SegmentName = "batchConfigurations",
    NamePattern = ""
  >;
}

@armResourceOperations
interface BatchConfigurations {
  @doc("Get a batch configuration for an integration account.")
  get is ArmResourceRead<BatchConfiguration>;

  @doc("Create or update a batch configuration for an integration account.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<BatchConfiguration>;

  @doc("Delete a batch configuration for an integration account.")
  delete is ArmResourceDeleteSync<BatchConfiguration>;

  @doc("List the batch configurations for an integration account.")
  list is ArmResourceListByParent<
    BatchConfiguration,
    Response = ArmResponse<BatchConfigurationCollection>
  >;
}

@@doc(BatchConfiguration.name, "The batch configuration name.");
@@doc(BatchConfiguration.properties, "The batch configuration properties.");
@@doc(BatchConfigurations.createOrUpdate::parameters.resource,
  "The batch configuration."
);
