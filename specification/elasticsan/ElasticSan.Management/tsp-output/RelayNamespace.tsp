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
@doc("Description of a namespace resource.")
model RelayNamespace is TrackedResource<RelayNamespaceProperties> {
  @doc("The namespace name")
  @maxLength(50)
  @minLength(6)
  @path
  @key("namespaceName")
  @segment("namespaces")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface RelayNamespaces {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns the description for the specified namespace.")
  @operationId("Namespaces_Get")
  get is ArmResourceRead<RelayNamespace>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create Azure Relay namespace.")
  @operationId("Namespaces_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<RelayNamespace>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates or updates a namespace. Once created, this namespace's resource manifest is immutable. This operation is idempotent.")
  @operationId("Namespaces_Update")
  update is ArmCustomPatchSync<RelayNamespace, RelayUpdateParameters>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes an existing namespace. This operation also removes all associated resources under the namespace.")
  @operationId("Namespaces_Delete")
  delete is ArmResourceDeleteAsync<RelayNamespace>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists all the available namespaces within the ResourceGroup.")
  @operationId("Namespaces_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<RelayNamespace>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists all the available namespaces within the subscription regardless of the resourceGroups.")
  @operationId("Namespaces_List")
  list is ArmListBySubscription<RelayNamespace>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Check the specified namespace name availability.")
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
