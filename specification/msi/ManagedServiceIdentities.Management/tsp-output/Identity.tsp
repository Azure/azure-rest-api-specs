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

namespace Microsoft.ManagedIdentity;
/**
 * Describes an identity resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  UserAssignedIdentityProperties
)
model Identity extends TrackedResourceBase {
  /**
   * The name of the identity resource.
   */
  @path
  @key("resourceName")
  @segment("userAssignedIdentities")
  @visibility("read")
  name: string;

  /**
   * The properties associated with the identity.
   */
  @extension("x-ms-client-flatten", true)
  properties?: UserAssignedIdentityProperties;
}

@armResourceOperations
interface Identities {
  /**
   * Gets the identity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("UserAssignedIdentities_Get")
  get is ArmResourceRead<Identity>;

  /**
   * Create or update an identity in the specified subscription and resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("UserAssignedIdentities_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Identity>;

  /**
   * Update an identity in the specified subscription and resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("UserAssignedIdentities_Update")
  update is ArmCustomPatchSync<Identity, IdentityUpdate>;

  /**
   * Deletes the identity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("UserAssignedIdentities_Delete")
  delete is ArmResourceDeleteSync<Identity>;

  /**
   * Lists all the userAssignedIdentities available under the specified ResourceGroup.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("UserAssignedIdentities_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<Identity>;

  /**
   * Lists all the userAssignedIdentities available under the specified subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("UserAssignedIdentities_ListBySubscription")
  listBySubscription is ArmListBySubscription<Identity>;
}

@@projectedName(Identities.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(Identities.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Identities.createOrUpdate::parameters.resource,
  "Parameters to create or update the identity"
);
@@projectedName(Identities.update::parameters.properties, "json", "parameters");
@@extension(Identities.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Identities.update::parameters.properties,
  "Parameters to update the identity"
);
