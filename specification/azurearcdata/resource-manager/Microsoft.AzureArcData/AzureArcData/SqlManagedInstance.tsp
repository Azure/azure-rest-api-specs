import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureArcData;
/**
 * A SqlManagedInstance.
 */
model SqlManagedInstance is Azure.ResourceManager.TrackedResource<
  SqlManagedInstanceProperties,
  false
> {
  ...ResourceNameParameter<
    Resource = SqlManagedInstance,
    KeyName = "sqlManagedInstanceName",
    SegmentName = "sqlManagedInstances",
    NamePattern = ""
  >;

  /**
   * The extendedLocation of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  extendedLocation?: ExtendedLocation;

  /**
   * Resource sku.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: SqlManagedInstanceSku;
}

@armResourceOperations
interface SqlManagedInstances {
  /**
   * Retrieves a SQL Managed Instance resource
   */
  get is ArmResourceRead<SqlManagedInstance>;

  /**
   * Creates or replaces a SQL Managed Instance resource
   */
  create is ArmResourceCreateOrReplaceAsync<SqlManagedInstance>;

  /**
   * Updates a SQL Managed Instance resource
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    SqlManagedInstance,
    PatchModel = SqlManagedInstanceUpdate
  >;

  /**
   * Deletes a SQL Managed Instance resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    SqlManagedInstance,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all sqlManagedInstances in a resource group.
   */
  @summary("List sqlManagedInstance resources in the resource group")
  listByResourceGroup is ArmResourceListByParent<
    SqlManagedInstance,
    Response = ArmResponse<SqlManagedInstanceListResult>
  >;

  /**
   * List sqlManagedInstance resources in the subscription
   */
  @summary("List sqlManagedInstance resources in the subscription")
  list is ArmListBySubscription<
    SqlManagedInstance,
    Response = ArmResponse<SqlManagedInstanceListResult>
  >;
}

@@doc(SqlManagedInstance.name, "Name of SQL Managed Instance");
@@doc(SqlManagedInstance.properties, "null");
@@doc(
  SqlManagedInstances.create::parameters.resource,
  "The SQL Managed Instance to be created or updated."
);
@@doc(
  SqlManagedInstances.update::parameters.properties,
  "The SQL Managed Instance."
);
