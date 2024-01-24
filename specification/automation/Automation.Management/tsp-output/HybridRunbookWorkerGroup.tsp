import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AutomationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Automation;
/**
 * Definition of hybrid runbook worker group.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(AutomationAccount)
@Azure.ResourceManager.Private.armResourceInternal(
  HybridRunbookWorkerGroupProperties
)
@includeInapplicableMetadataInPayload(false)
model HybridRunbookWorkerGroup extends ProxyResourceBase {
  /**
   * The hybrid runbook worker group name
   */
  @path
  @key("hybridRunbookWorkerGroupName")
  @segment("hybridRunbookWorkerGroups")
  name: string;

  /**
   * Gets or sets the hybrid worker group properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: HybridRunbookWorkerGroupProperties;
}

@armResourceOperations
interface HybridRunbookWorkerGroups {
  /**
   * Retrieve a hybrid runbook worker group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("HybridRunbookWorkerGroup_Get")
  get is ArmResourceRead<HybridRunbookWorkerGroup>;

  /**
   * Create a hybrid runbook worker group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("HybridRunbookWorkerGroup_Create")
  create is ArmResourceCreateOrReplaceSync<HybridRunbookWorkerGroup>;

  /**
   * Update a hybrid runbook worker group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("HybridRunbookWorkerGroup_Update")
  update is ArmCustomPatchSync<
    HybridRunbookWorkerGroup,
    HybridRunbookWorkerGroupCreateOrUpdateParameters
  >;

  /**
   * Delete a hybrid runbook worker group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("HybridRunbookWorkerGroup_Delete")
  delete is ArmResourceDeleteSync<HybridRunbookWorkerGroup>;

  /**
   * Retrieve a list of hybrid runbook worker groups.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("HybridRunbookWorkerGroup_ListByAutomationAccount")
  listByAutomationAccount is ArmResourceListByParent<
    HybridRunbookWorkerGroup,
    {
      ...BaseParameters<HybridRunbookWorkerGroup>;

      /**
       * The filter to apply on the operation.
       */
      @query("$filter")
      $filter?: string;
    }
  >;
}

@@projectedName(HybridRunbookWorkerGroups.create::parameters.resource,
  "json",
  "HybridRunbookWorkerGroupCreationParameters"
);
@@extension(HybridRunbookWorkerGroups.create::parameters.resource,
  "x-ms-client-name",
  "HybridRunbookWorkerGroupCreationParameters"
);
@@doc(HybridRunbookWorkerGroups.create::parameters.resource,
  "The create or update parameters for hybrid runbook worker group."
);
@@projectedName(HybridRunbookWorkerGroups.update::parameters.properties,
  "json",
  "HybridRunbookWorkerGroupUpdationParameters"
);
@@extension(HybridRunbookWorkerGroups.update::parameters.properties,
  "x-ms-client-name",
  "HybridRunbookWorkerGroupUpdationParameters"
);
@@doc(HybridRunbookWorkerGroups.update::parameters.properties,
  "The hybrid runbook worker group"
);
