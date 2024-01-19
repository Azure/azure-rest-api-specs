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

namespace Microsoft.Security;

model JitNetworkAccessPolicy
  is ProxyResource<JitNetworkAccessPolicyProperties> {
  @doc("Name of a Just-in-Time access configuration policy.")
  @path
  @key("jitNetworkAccessPolicyName")
  @segment("jitNetworkAccessPolicies")
  name: string;
}

@armResourceOperations
interface JitNetworkAccessPolicies {
  @doc("Policies for protecting resources using Just-in-Time access control for the subscription, location")
  get is ArmResourceRead<JitNetworkAccessPolicy>;

  @doc("Create a policy for protecting resources using Just-in-Time access control")
  createOrUpdate is ArmResourceCreateOrReplaceSync<JitNetworkAccessPolicy>;

  @doc("Delete a Just-in-Time access control policy.")
  delete is ArmResourceDeleteSync<JitNetworkAccessPolicy>;

  @doc("Policies for protecting resources using Just-in-Time access control for the subscription, location")
  listByResourceGroupAndRegion is ArmResourceListByParent<JitNetworkAccessPolicy>;

  @doc("Policies for protecting resources using Just-in-Time access control.")
  list is ArmListBySubscription<JitNetworkAccessPolicy>;

  @doc("Initiate a JIT access from a specific Just-in-Time policy configuration.")
  initiate is ArmResourceActionNoContentSync<
    JitNetworkAccessPolicy,
    JitNetworkAccessPolicyInitiateRequest,
    {
      ...BaseParameters<JitNetworkAccessPolicy>;

      @doc("Type of the action to do on the Just-in-Time access policy.")
      @path
      jitNetworkAccessPolicyInitiateType: "initiate";
    }
  >;
}

@@projectedName(JitNetworkAccessPolicies.createOrUpdate::parameters.resource,
  "json",
  "body"
);
@@extension(JitNetworkAccessPolicies.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(JitNetworkAccessPolicies.createOrUpdate::parameters.resource, "");
@@doc(JitNetworkAccessPolicies.initiate::parameters.body, "");
