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
@doc("The authorization policy resource format.")
@parentResource(Hub)
model AuthorizationPolicyResourceFormat is ProxyResource<AuthorizationPolicy> {
  @doc("The name of the policy.")
  @path
  @key("authorizationPolicyName")
  @segment("authorizationPolicies")
  name: string;
}

@armResourceOperations
interface AuthorizationPolicyResourceFormats {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets an authorization policy in the hub.")
  @operationId("AuthorizationPolicies_Get")
  get is ArmResourceRead<AuthorizationPolicyResourceFormat>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates an authorization policy or updates an existing authorization policy.")
  @operationId("AuthorizationPolicies_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<AuthorizationPolicyResourceFormat>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets all the authorization policies in a specified hub.")
  @operationId("AuthorizationPolicies_ListByHub")
  listByHub is ArmResourceListByParent<AuthorizationPolicyResourceFormat>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Regenerates the primary policy key of the specified authorization policy.")
  @operationId("AuthorizationPolicies_RegeneratePrimaryKey")
  regeneratePrimaryKey is ArmResourceActionSync<
    AuthorizationPolicyResourceFormat,
    void,
    AuthorizationPolicy
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Regenerates the secondary policy key of the specified authorization policy.")
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
