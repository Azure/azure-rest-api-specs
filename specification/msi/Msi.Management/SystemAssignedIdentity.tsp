import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedIdentity;
/**
 * Describes a system assigned identity resource.
 */
@singleton("default")
@extensionResource
model SystemAssignedIdentity
  is Azure.ResourceManager.ExtensionResource<SystemAssignedIdentityProperties> {
  ...ResourceNameParameter<
    Resource = SystemAssignedIdentity,
    KeyName = "identity",
    SegmentName = "identities",
    NamePattern = ""
  >;

  /**
   * The geo-location where the resource lives
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: string;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

@armResourceOperations
interface SystemAssignedIdentities {
  /**
   * Gets the systemAssignedIdentity available under the specified RP scope.
   */
  getByScope is ArmResourceRead<
    SystemAssignedIdentity,
    BaseParameters = Azure.ResourceManager.Foundations.ExtensionBaseParameters,
    Parameters = {
      /**
       * The resource provider scope of the resource. Parent resource being extended by Managed Identities.
       */
      @path
      scope: string;
    }
  >;
}

@@doc(SystemAssignedIdentity.name, "");
@@doc(SystemAssignedIdentity.properties,
  "The properties associated with the identity."
);
