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
@doc("Describes an identity resource.")
model Identity is TrackedResource<UserAssignedIdentityProperties> {
  @doc("The name of the identity resource.")
  @path
  @key("resourceName")
  @segment("userAssignedIdentities")
  name: string;
}

@armResourceOperations
interface Identities {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the identity.")
  @operationId("UserAssignedIdentities_Get")
  get is ArmResourceRead<Identity>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update an identity in the specified subscription and resource group.")
  @operationId("UserAssignedIdentities_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Identity>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update an identity in the specified subscription and resource group.")
  @operationId("UserAssignedIdentities_Update")
  update is ArmCustomPatchSync<Identity, IdentityUpdate>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes the identity.")
  @operationId("UserAssignedIdentities_Delete")
  delete is ArmResourceDeleteSync<Identity>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists all the userAssignedIdentities available under the specified ResourceGroup.")
  @operationId("UserAssignedIdentities_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<Identity>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists all the userAssignedIdentities available under the specified subscription.")
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
