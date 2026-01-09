import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Profile.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Cdn;
/**
 * SecurityPolicy association for AzureFrontDoor profile
 */
@parentResource(Profile)
model FrontDoorSecurityPolicy is ProxyResource<SecurityPolicyDetails> {
  /**
   * Name of the security policy under the profile.
   */
  @path
  @key("securityPolicyName")
  @segment("securityPolicies")
  name: string;
}

@armResourceOperations
interface FrontDoorSecurityPolicies {
  /**
   * Gets an existing security policy within a profile.
   */
  get is ArmResourceRead<FrontDoorSecurityPolicy>;

  /**
   * Creates a new security policy within the specified profile.
   */
  create is ArmResourceCreateOrReplaceAsync<
    FrontDoorSecurityPolicy,
    BaseParameters<FrontDoorSecurityPolicy>,
    ArmAsyncOperationHeader
  >;

  /**
   * Updates an existing security policy within a profile.
   */
  @parameterVisibility("read")
  patch is ArmCustomPatchAsync<
    FrontDoorSecurityPolicy,
    SecurityPolicyUpdateParameters,
    BaseParameters<FrontDoorSecurityPolicy>,
    ArmAsyncOperationHeader
  >;

  /**
   * Deletes an existing security policy within profile.
   */
  delete is ArmResourceDeleteAsync<
    FrontDoorSecurityPolicy,
    BaseParameters<FrontDoorSecurityPolicy>,
    ArmAsyncOperationHeader
  >;

  /**
   * Lists security policies associated with the profile
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FrontDoorSecurityPolicies_ListByProfile")
  listByProfile is ArmResourceListByParent<FrontDoorSecurityPolicy>;
}

@@projectedName(FrontDoorSecurityPolicies.create::parameters.resource,
  "json",
  "securityPolicy"
);
@@extension(FrontDoorSecurityPolicies.create::parameters.resource,
  "x-ms-client-name",
  "securityPolicy"
);
@@doc(FrontDoorSecurityPolicies.create::parameters.resource,
  "The security policy properties."
);
@@projectedName(FrontDoorSecurityPolicies.patch::parameters.properties,
  "json",
  "securityPolicyUpdateProperties"
);
@@extension(FrontDoorSecurityPolicies.patch::parameters.properties,
  "x-ms-client-name",
  "securityPolicyUpdateProperties"
);
@@doc(FrontDoorSecurityPolicies.patch::parameters.properties,
  "Security policy update properties"
);
