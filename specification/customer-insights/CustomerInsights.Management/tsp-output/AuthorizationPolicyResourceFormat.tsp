import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Hub.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CustomerInsights;
/**
 * The authorization policy resource format.
 */
@parentResource(Hub)
model AuthorizationPolicyResourceFormat is ProxyResource<AuthorizationPolicy> {
  /**
   * The name of the policy.
   */
  @path
  @key("authorizationPolicyName")
  @segment("authorizationPolicies")
  name: string;
}

@armResourceOperations
interface AuthorizationPolicyResourceFormats {
  /**
   * Gets an authorization policy in the hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AuthorizationPolicies_Get")
  get is ArmResourceRead<AuthorizationPolicyResourceFormat>;

  /**
   * Creates an authorization policy or updates an existing authorization policy.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AuthorizationPolicies_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<AuthorizationPolicyResourceFormat>;

  /**
   * Gets all the authorization policies in a specified hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AuthorizationPolicies_ListByHub")
  listByHub is ArmResourceListByParent<AuthorizationPolicyResourceFormat>;

  /**
   * Regenerates the primary policy key of the specified authorization policy.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AuthorizationPolicies_RegeneratePrimaryKey")
  regeneratePrimaryKey is ArmResourceActionSync<
    AuthorizationPolicyResourceFormat,
    void,
    AuthorizationPolicy
  >;

  /**
   * Regenerates the secondary policy key of the specified authorization policy.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AuthorizationPolicies_RegenerateSecondaryKey")
  regenerateSecondaryKey is ArmResourceActionSync<
    AuthorizationPolicyResourceFormat,
    void,
    AuthorizationPolicy
  >;
}

@@projectedName(AuthorizationPolicyResourceFormats.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(AuthorizationPolicyResourceFormats.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(AuthorizationPolicyResourceFormats.createOrUpdate::parameters.resource,
  "Parameters supplied to the CreateOrUpdate authorization policy operation."
);
