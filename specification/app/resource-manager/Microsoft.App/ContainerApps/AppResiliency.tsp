import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;
/**
 * Configuration to setup App Resiliency
 */
model AppResiliency
  is Azure.ResourceManager.ProxyResource<AppResiliencyProperties> {
  ...ResourceNameParameter<
    Resource = AppResiliency,
    KeyName = "name",
    SegmentName = "resiliencyPolicies",
    NamePattern = "^[-\\w\\._\\(\\)]+$"
  >;
}

alias AppResiliencyOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of the Container App. */
    @path
    @segment("containerApps")
    @key
    @pattern("^[-\\w\\._\\(\\)]+$")
    appName: string;
  },
  {
    /** Name of the resiliency policy. */
    @path
    @segment("resiliencyPolicies")
    @key
    @pattern("^[-\\w\\._\\(\\)]+$")
    name: string;
  },
  ErrorType = DefaultErrorResponse
>;

@armResourceOperations
@tag("AppResiliency")
interface AppResiliencies {
  /**
   * Get container app resiliency policy.
   */
  @summary("Get an application's resiliency policy.")
  get is AppResiliencyOps.Read<AppResiliency>;

  /**
   * Create or update container app resiliency policy.
   */
  @summary("Create or update an application's resiliency policy.")
  createOrUpdate is AppResiliencyOps.CreateOrUpdateSync<AppResiliency>;

  /**
   * Update container app resiliency policy.
   */
  @patch(#{ implicitOptionality: false })
  @summary("Update an application's resiliency policy.")
  update is AppResiliencyOps.CustomPatchSync<
    AppResiliency,
    PatchModel = AppResiliency
  >;

  /**
   * Delete container app resiliency policy.
   */
  @summary("Delete an application's resiliency policy.")
  delete is AppResiliencyOps.DeleteSync<AppResiliency>;

  /**
   * List container app resiliency policies.
   */
  @summary("List an application's resiliency policies.")
  list is AppResiliencyOps.List<
    AppResiliency,
    Response = ArmResponse<AppResiliencyCollection>
  >;
}

@@doc(AppResiliency.name, "Name of the resiliency policy.");
@@doc(AppResiliency.properties, "App Resiliency resource specific properties");
@@doc(AppResiliencies.createOrUpdate::parameters.resource,
  "The resiliency policy to create or update."
);
@@doc(AppResiliencies.update::parameters.properties,
  "The resiliency policy to update."
);
