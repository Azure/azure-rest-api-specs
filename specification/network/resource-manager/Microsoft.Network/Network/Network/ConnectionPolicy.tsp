import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./VirtualHub.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;
using Common;

namespace Microsoft.Network;
/**
 * ConnectionPolicy resource defined for VirtualHub.
 */
@added(Versions.v2025_07_01)
@featureFile(Features.virtualWAN)
@parentResource(VirtualHub)
model ConnectionPolicy is ProxyResourceInstance<ConnectionPolicyProperties> {
  /**
   * The name of the ConnectionPolicy that is unique within a VirtualHub. This name can be used to access the resource.
   */
  @visibility(Lifecycle.Read)
  @path
  @key("connectionPolicyName")
  @segment("connectionPolicies")
  @pattern("^(?![.-])[a-zA-Z0-9_.-]{1,128}$")
  name: string;
}

@added(Versions.v2025_07_01)
@featureFile(Features.virtualWAN)
@armResourceOperations(#{ omitTags: true })
interface ConnectionPolicies {
  /**
   * Retrieves the details of a ConnectionPolicy.
   */
  get is ArmResourceRead<ConnectionPolicy, Error = CloudError>;

  /**
   * Creates a ConnectionPolicy if it doesn't exist else updates the existing one.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ConnectionPolicy,
    Error = CloudError
  >;

  /**
   * Deletes a ConnectionPolicy.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    ConnectionPolicy,
    Error = CloudError
  >;

  /**
   * Retrieves the details of all ConnectionPolicies.
   */
  list is ArmResourceListByParent<
    ConnectionPolicy,
    Response = ArmResponse<ListConnectionPoliciesResult>,
    Error = CloudError
  >;
}

@@doc(
  ConnectionPolicy.name,
  "The name of the ConnectionPolicy that is unique within a VirtualHub. This name can be used to access the resource."
);
@@doc(
  ConnectionPolicy.properties,
  "Properties of the ConnectionPolicy resource."
);
@@doc(
  ConnectionPolicies.createOrUpdate::parameters.resource,
  "Parameters supplied to create or update a ConnectionPolicy."
);
