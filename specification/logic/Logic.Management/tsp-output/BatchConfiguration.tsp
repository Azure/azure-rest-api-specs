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
/**
 * The batch configuration resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(IntegrationAccount)
@Azure.ResourceManager.Private.armResourceInternal(BatchConfigurationProperties)
@includeInapplicableMetadataInPayload(false)
model BatchConfiguration extends Resource {
  /**
   * The batch configuration name.
   */
  @path
  @key("batchConfigurationName")
  @segment("batchConfigurations")
  name: string;

  /**
   * The batch configuration properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: BatchConfigurationProperties;
}

@armResourceOperations
interface BatchConfigurations {
  /**
   * Get a batch configuration for an integration account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IntegrationAccountBatchConfigurations_Get")
  get is ArmResourceRead<BatchConfiguration>;

  /**
   * Create or update a batch configuration for an integration account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IntegrationAccountBatchConfigurations_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<BatchConfiguration>;

  /**
   * Delete a batch configuration for an integration account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IntegrationAccountBatchConfigurations_Delete")
  delete is ArmResourceDeleteSync<BatchConfiguration>;

  /**
   * List the batch configurations for an integration account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
