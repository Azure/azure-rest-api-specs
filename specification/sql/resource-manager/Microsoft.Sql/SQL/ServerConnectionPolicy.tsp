import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A server connection policy
 */
@parentResource(Server)
model ServerConnectionPolicy
  is Azure.ResourceManager.ProxyResource<ServerConnectionPolicyProperties> {
  ...ResourceNameParameter<
    Resource = ServerConnectionPolicy,
    KeyName = "connectionPolicyName",
    SegmentName = "connectionPolicies",
    NamePattern = "",
    Type = ConnectionPolicyName
  >;

  /**
   * Resource location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * Metadata used for the Azure portal experience.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  kind?: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface ServerConnectionPolicies {
  /**
   * Gets a server connection policy
   */
  get is ArmResourceRead<ServerConnectionPolicy>;

  /**
   * Updates a server connection policy
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ServerConnectionPolicy,
    Response = ArmResourceUpdatedResponse<ServerConnectionPolicy> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ServerConnectionPolicy> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Lists connection policy
   */
  listByServer is ArmResourceListByParent<ServerConnectionPolicy>;
}

@@doc(ServerConnectionPolicy.name, "The name of the connection policy.");
@@doc(ServerConnectionPolicy.properties, "Resource properties.");
@@doc(ServerConnectionPolicies.createOrUpdate::parameters.resource,
  "The required parameters for updating a server connection policy."
);
