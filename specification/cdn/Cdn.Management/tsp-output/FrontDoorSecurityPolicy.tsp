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
@doc("SecurityPolicy association for AzureFrontDoor profile")
@parentResource(Profile)
model FrontDoorSecurityPolicy is ProxyResource<SecurityPolicyDetails> {
  @doc("Name of the security policy under the profile.")
  @path
  @key("securityPolicyName")
  @segment("securityPolicies")
  name: string;
}

@armResourceOperations
interface FrontDoorSecurityPolicies {
  @doc("Gets an existing security policy within a profile.")
  get is ArmResourceRead<FrontDoorSecurityPolicy>;

  @doc("Creates a new security policy within the specified profile.")
  create is ArmResourceCreateOrUpdateAsync<
    FrontDoorSecurityPolicy,
    BaseParameters<FrontDoorSecurityPolicy>,
    ArmAsyncOperationHeader
  >;

  @doc("Updates an existing security policy within a profile.")
  patch is ArmCustomPatchAsync<
    FrontDoorSecurityPolicy,
    SecurityPolicyUpdateParameters,
    BaseParameters<FrontDoorSecurityPolicy>,
    ArmAsyncOperationHeader
  >;

  @doc("Deletes an existing security policy within profile.")
  delete is ArmResourceDeleteAsync<
    FrontDoorSecurityPolicy,
    BaseParameters<FrontDoorSecurityPolicy>,
    ArmAsyncOperationHeader
  >;

  @doc("Lists security policies associated with the profile")
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
