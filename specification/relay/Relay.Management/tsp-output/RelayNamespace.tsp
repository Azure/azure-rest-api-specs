import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Relay;
/**
 * Description of a namespace resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(RelayNamespaceProperties)
@includeInapplicableMetadataInPayload(false)
model RelayNamespace extends TrackedResourceBase {
  /**
   * The namespace name
   */
  @maxLength(50)
  @minLength(6)
  @path
  @key("namespaceName")
  @segment("namespaces")
  name: string;

  /**
   * Description of Relay namespace
   */
  @extension("x-ms-client-flatten", true)
  properties?: RelayNamespaceProperties;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface RelayNamespaces {
  /**
   * Returns the description for the specified namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Namespaces_Get")
  get is ArmResourceRead<RelayNamespace>;

  /**
   * Create Azure Relay namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Namespaces_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<RelayNamespace>;

  /**
   * Creates or updates a namespace. Once created, this namespace's resource manifest is immutable. This operation is idempotent.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Namespaces_Update")
  update is ArmCustomPatchSync<RelayNamespace, RelayUpdateParameters>;

  /**
   * Deletes an existing namespace. This operation also removes all associated resources under the namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Namespaces_Delete")
  delete is ArmResourceDeleteAsync<RelayNamespace>;

  /**
   * Lists all the available namespaces within the ResourceGroup.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Namespaces_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<RelayNamespace>;

  /**
   * Lists all the available namespaces within the subscription regardless of the resourceGroups.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Namespaces_List")
  list is ArmListBySubscription<RelayNamespace>;

  /**
   * Check the specified namespace name availability.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Namespaces_CheckNameAvailability")
  checkNameAvailability is checkGlobalNameAvailability<
    CheckNameAvailability,
    CheckNameAvailabilityResult
  >;
}

@@projectedName(RelayNamespaces.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(RelayNamespaces.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(RelayNamespaces.createOrUpdate::parameters.resource,
  "Parameters supplied to create a namespace resource."
);
@@projectedName(RelayNamespaces.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(RelayNamespaces.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(RelayNamespaces.update::parameters.properties,
  "Parameters for updating a namespace resource."
);
