import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;

namespace Microsoft.ManagedIdentity;
/**
 * Describes an identity resource.
 */
model Identity
  is Azure.ResourceManager.TrackedResource<UserAssignedIdentityProperties> {
  ...ResourceNameParameter<
    Resource = Identity,
    KeyName = "resourceName",
    SegmentName = "userAssignedIdentities",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Identities {
  /**
   * Gets the identity.
   */
  get is ArmResourceRead<Identity, Error = CloudError>;

  /**
   * Create or update an identity in the specified subscription and resource group.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    Identity,
    Error = CloudError
  >;

  /**
   * Update an identity in the specified subscription and resource group.
   */
  update is ArmCustomPatchSync<Identity, IdentityUpdate, Error = CloudError>;

  /**
   * Deletes the identity.
   */
  delete is ArmResourceDeleteSync<Identity, Error = CloudError>;

  /**
   * Lists all the userAssignedIdentities available under the specified ResourceGroup.
   */
  listByResourceGroup is ArmResourceListByParent<
    Identity,
    Response = UserAssignedIdentitiesListResult,
    Error = CloudError
  >;

  /**
   * Lists all the userAssignedIdentities available under the specified subscription.
   */
  listBySubscription is ArmListBySubscription<
    Identity,
    Response = UserAssignedIdentitiesListResult,
    Error = CloudError
  >;
}

@@clientName(Identities.createOrUpdate::parameters.resource, "parameters");
@@clientName(Identities.update::parameters.properties, "parameters");

@@doc(Identity.name, "The name of the identity resource.");
@@doc(Identity.properties, "The properties associated with the identity.");
@@doc(Identities.createOrUpdate::parameters.resource,
  "Parameters to create or update the identity"
);
@@doc(Identities.update::parameters.properties,
  "Parameters to update the identity"
);
