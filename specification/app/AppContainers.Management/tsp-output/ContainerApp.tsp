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

namespace Microsoft.App;
/**
 * Container App.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(ContainerAppProperties)
model ContainerApp extends TrackedResourceBase {
  /**
   * Name of the Container App.
   */
  @path
  @key("containerAppName")
  @segment("containerApps")
  @visibility("read")
  name: string;

  /**
   * The complex type of the extended location.
   */
  extendedLocation?: ExtendedLocation;

  /**
   * The fully qualified resource ID of the resource that manages this resource. Indicates if this resource is managed by another Azure resource. If this is present, complete mode deployment will not delete the resource if it is removed from the template since it is managed by another resource.
   */
  @visibility("read", "create", "update")
  managedBy?: string;

  /**
   * ContainerApp resource specific properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: ContainerAppProperties;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface ContainerApps {
  /**
   * Get the properties of a Container App.
   */
  get is ArmResourceRead<ContainerApp>;

  /**
   * Create or update a Container App.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ContainerApp,
    BaseParameters<ContainerApp>,
    ArmAsyncOperationHeader
  >;

  /**
   * Patches a Container App using JSON Merge Patch
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<ContainerApp, ContainerApp>;

  /**
   * Delete a Container App.
   */
  delete is ArmResourceDeleteAsync<
    ContainerApp,
    BaseParameters<ContainerApp>,
    ArmLroLocationHeader
  >;

  /**
   * Get the Container Apps in a given resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ContainerApps_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<ContainerApp>;

  /**
   * Get the Container Apps in a given subscription.
   */
  listBySubscription is ArmListBySubscription<ContainerApp>;

  /**
   * Analyzes a custom hostname for a Container App
   */
  listCustomHostNameAnalysis is ArmResourceActionSync<
    ContainerApp,
    void,
    CustomHostnameAnalysisResult,
    {
      ...BaseParameters<ContainerApp>;

      /**
       * Custom hostname.
       */
      @query("customHostname")
      customHostname?: string;
    }
  >;

  /**
   * List secrets for a container app
   */
  listSecrets is ArmResourceActionSync<ContainerApp, void, SecretsCollection>;

  /**
   * Get auth token for a container app
   */
  getAuthToken is ArmResourceActionSync<
    ContainerApp,
    void,
    ContainerAppAuthToken
  >;

  /**
   * Start a container app
   */
  start is ArmResourceActionAsync<
    ContainerApp,
    void,
    ContainerApp,
    BaseParameters<ContainerApp>,
    ArmLroLocationHeader
  >;

  /**
   * Stop a container app
   */
  stop is ArmResourceActionAsync<
    ContainerApp,
    void,
    ContainerApp,
    BaseParameters<ContainerApp>,
    ArmLroLocationHeader
  >;
}

@@projectedName(ContainerApps.createOrUpdate::parameters.resource,
  "json",
  "containerAppEnvelope"
);
@@extension(ContainerApps.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "containerAppEnvelope"
);
@@doc(ContainerApps.createOrUpdate::parameters.resource,
  "Properties used to create a container app"
);
@@projectedName(ContainerApps.update::parameters.properties,
  "json",
  "containerAppEnvelope"
);
@@extension(ContainerApps.update::parameters.properties,
  "x-ms-client-name",
  "containerAppEnvelope"
);
@@doc(ContainerApps.update::parameters.properties,
  "Properties of a Container App that need to be updated"
);
