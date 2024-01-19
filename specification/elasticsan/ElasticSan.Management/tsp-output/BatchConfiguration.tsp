import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./IntegrationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Logic;
@doc("The batch configuration resource definition.")
@parentResource(IntegrationAccount)
model BatchConfiguration is TrackedResource<BatchConfigurationProperties> {
  @doc("The batch configuration name.")
  @path
  @key("batchConfigurationName")
  @segment("batchConfigurations")
  name: string;
}

@armResourceOperations
interface BatchConfigurations {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a batch configuration for an integration account.")
  @operationId("IntegrationAccountBatchConfigurations_Get")
  get is ArmResourceRead<BatchConfiguration>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update a batch configuration for an integration account.")
  @operationId("IntegrationAccountBatchConfigurations_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<BatchConfiguration>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a batch configuration for an integration account.")
  @operationId("IntegrationAccountBatchConfigurations_Delete")
  delete is ArmResourceDeleteSync<BatchConfiguration>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List the batch configurations for an integration account.")
  @operationId("IntegrationAccountBatchConfigurations_List")
  list is ArmResourceListByParent<BatchConfiguration>;
}

@@projectedName(BatchConfigurations.createOrUpdate::parameters.resource,
  "json",
  "batchConfiguration"
);
@@extension(BatchConfigurations.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "batchConfiguration"
);
@@doc(BatchConfigurations.createOrUpdate::parameters.resource,
  "The batch configuration."
);
