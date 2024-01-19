import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./RelayNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Relay;
@doc("Single item in a List or Get AuthorizationRule operation")
@parentResource(RelayNamespace)
model AuthorizationRule is ProxyResource<AuthorizationRuleProperties> {
  @doc("The authorization rule name.")
  @minLength(1)
  @path
  @key("authorizationRuleName")
  @segment("authorizationRules")
  name: string;
}

@armResourceOperations
interface AuthorizationRules {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Authorization rule for a namespace by name.")
  @operationId("Namespaces_GetAuthorizationRule")
  getAuthorizationRule is ArmResourceRead<AuthorizationRule>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates or updates an authorization rule for a namespace.")
  @operationId("Namespaces_CreateOrUpdateAuthorizationRule")
  createOrUpdateAuthorizationRule is ArmResourceCreateOrReplaceSync<AuthorizationRule>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes a namespace authorization rule.")
  @operationId("Namespaces_DeleteAuthorizationRule")
  deleteAuthorizationRule is ArmResourceDeleteSync<AuthorizationRule>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Authorization rules for a namespace.")
  @operationId("Namespaces_ListAuthorizationRules")
  listAuthorizationRules is ArmResourceListByParent<AuthorizationRule>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Primary and secondary connection strings to the namespace.")
  @operationId("Namespaces_ListKeys")
  listKeys is ArmResourceActionSync<AuthorizationRule, void, AccessKeys>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Regenerates the primary or secondary connection strings to the namespace.")
  @operationId("Namespaces_RegenerateKeys")
  regenerateKeys is ArmResourceActionSync<
    AuthorizationRule,
    RegenerateAccessKeyParameters,
    AccessKeys
  >;
}

@@projectedName(AuthorizationRules.createOrUpdateAuthorizationRule::parameters.resource,
  "json",
  "parameters"
);
@@extension(AuthorizationRules.createOrUpdateAuthorizationRule::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(AuthorizationRules.createOrUpdateAuthorizationRule::parameters.resource,
  "The authorization rule parameters."
);
@@projectedName(AuthorizationRules.regenerateKeys::parameters.body,
  "json",
  "parameters"
);
@@extension(AuthorizationRules.regenerateKeys::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(AuthorizationRules.regenerateKeys::parameters.body,
  "Parameters supplied to regenerate authorization rule."
);
