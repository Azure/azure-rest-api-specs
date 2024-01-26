import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * An Azure SQL managed instance administrator.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ManagedInstance)
@includeInapplicableMetadataInPayload(false)
model ManagedInstanceAdministrator extends ProxyResource {
  @path
  @key("administratorName")
  @segment("administrators")
  @visibility("read")
  name: AdministratorName;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ManagedInstanceAdministratorProperties;
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ManagedInstanceAdministrator>;

  /**
   * Deletes a managed instance administrator.
   */
  delete is ArmResourceDeleteAsync<ManagedInstanceAdministrator>;

  /**
   * Gets a list of managed instance administrators.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedInstanceAdministrators_ListByInstance")
  listByInstance is ArmResourceListByParent<ManagedInstanceAdministrator>;
}

@@projectedName(ManagedInstanceAdministrators.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ManagedInstanceAdministrators.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ManagedInstanceAdministrators.createOrUpdate::parameters.resource,
  "The requested administrator parameters."
);
