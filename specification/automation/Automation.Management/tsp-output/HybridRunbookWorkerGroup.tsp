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
@doc("Definition of hybrid runbook worker group.")
@parentResource(AutomationAccount)
model HybridRunbookWorkerGroup
  is ProxyResource<HybridRunbookWorkerGroupProperties> {
  @doc("The hybrid runbook worker group name")
  @path
  @key("hybridRunbookWorkerGroupName")
  @segment("hybridRunbookWorkerGroups")
  name: string;
}

@armResourceOperations
interface HybridRunbookWorkerGroups {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve a hybrid runbook worker group.")
  @operationId("HybridRunbookWorkerGroup_Get")
  get is ArmResourceRead<HybridRunbookWorkerGroup>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a hybrid runbook worker group.")
  @operationId("HybridRunbookWorkerGroup_Create")
  create is ArmResourceCreateOrReplaceSync<HybridRunbookWorkerGroup>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update a hybrid runbook worker group.")
  @operationId("HybridRunbookWorkerGroup_Update")
  update is ArmCustomPatchSync<
    HybridRunbookWorkerGroup,
    HybridRunbookWorkerGroupCreateOrUpdateParameters
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a hybrid runbook worker group.")
  @operationId("HybridRunbookWorkerGroup_Delete")
  delete is ArmResourceDeleteSync<HybridRunbookWorkerGroup>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve a list of hybrid runbook worker groups.")
  @operationId("HybridRunbookWorkerGroup_ListByAutomationAccount")
  listByAutomationAccount is ArmResourceListByParent<
    HybridRunbookWorkerGroup,
    {
      ...BaseParameters<HybridRunbookWorkerGroup>;

      @doc("The filter to apply on the operation.")
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
