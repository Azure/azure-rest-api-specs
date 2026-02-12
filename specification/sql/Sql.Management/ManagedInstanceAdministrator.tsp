import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * An Azure SQL managed instance administrator.
 */
@parentResource(ManagedInstance)
model ManagedInstanceAdministrator
  is Azure.ResourceManager.ProxyResource<ManagedInstanceAdministratorProperties> {
  ...ResourceNameParameter<
    Resource = ManagedInstanceAdministrator,
    KeyName = "administratorName",
    SegmentName = "administrators",
    NamePattern = "",
    Type = AdministratorName
  >;
}

@armResourceOperations
interface ManagedInstanceAdministrators {
  /**
   * Gets a managed instance administrator.
   */
  get is ArmResourceRead<ManagedInstanceAdministrator>;

  /**
   * Creates or updates a managed instance administrator.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ManagedInstanceAdministrator,
    Response = ArmResourceUpdatedResponse<ManagedInstanceAdministrator> | ArmResourceCreatedResponse<
      ManagedInstanceAdministrator,
      ArmLroLocationHeader<FinalResult = ManagedInstanceAdministrator> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Deletes a managed instance administrator.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    ManagedInstanceAdministrator,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse
  >;

  /**
   * Gets a list of managed instance administrators.
   */
  listByInstance is ArmResourceListByParent<ManagedInstanceAdministrator>;
}

@@doc(ManagedInstanceAdministrator.name, "");
@@doc(ManagedInstanceAdministrator.properties, "Resource properties.");
@@doc(ManagedInstanceAdministrators.createOrUpdate::parameters.resource,
  "The requested administrator parameters."
);
