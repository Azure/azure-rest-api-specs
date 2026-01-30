import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AutomationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Automation;
/**
 * Definition of hybrid runbook worker group.
 */
@parentResource(AutomationAccount)
model HybridRunbookWorkerGroup
  is Azure.ResourceManager.TrackedResource<HybridRunbookWorkerGroupProperties> {
  ...ResourceNameParameter<
    Resource = HybridRunbookWorkerGroup,
    KeyName = "hybridRunbookWorkerGroupName",
    SegmentName = "hybridRunbookWorkerGroups",
    NamePattern = ""
  >;
}

@armResourceOperations
interface HybridRunbookWorkerGroups {
  /**
   * Retrieve a hybrid runbook worker group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/hybridrunbookworkergroupoperations")
  get is ArmResourceRead<HybridRunbookWorkerGroup>;

  /**
   * Create a hybrid runbook worker group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/hybridrunbookworkergroupoperations")
  create is Azure.ResourceManager.Legacy.CreateOrUpdateSync<
    HybridRunbookWorkerGroup,
    Request = HybridRunbookWorkerGroupCreateOrUpdateParameters
  >;

  /**
   * Update a hybrid runbook worker group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/hybridrunbookworkergroupoperations")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    HybridRunbookWorkerGroup,
    PatchModel = HybridRunbookWorkerGroupCreateOrUpdateParameters
  >;

  /**
   * Delete a hybrid runbook worker group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/hybridrunbookworkergroupoperations")
  delete is ArmResourceDeleteSync<
    HybridRunbookWorkerGroup,
    Response = ArmDeletedResponse
  >;

  /**
   * Retrieve a list of hybrid runbook worker groups.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/hybridrunbookworkergroupoperations")
  listByAutomationAccount is ArmResourceListByParent<
    HybridRunbookWorkerGroup,
    Parameters = {
      /**
       * The filter to apply on the operation.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<HybridRunbookWorkerGroupsListResult>
  >;
}

@@doc(HybridRunbookWorkerGroup.name, "The hybrid runbook worker group name");
@@doc(HybridRunbookWorkerGroup.properties,
  "Gets or sets the hybrid worker group properties."
);
@@doc(HybridRunbookWorkerGroups.create::parameters.resource,
  "The create or update parameters for hybrid runbook worker group."
);
@@doc(HybridRunbookWorkerGroups.update::parameters.properties,
  "The hybrid runbook worker group"
);
