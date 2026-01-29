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
 * Container App.
 */
model ContainerApp
  is Azure.ResourceManager.TrackedResource<ContainerAppProperties> {
  ...ResourceNameParameter<
    Resource = ContainerApp,
    KeyName = "containerAppName",
    SegmentName = "containerApps",
    NamePattern = ""
  >;

  /**
   * The complex type of the extended location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  extendedLocation?: ExtendedLocation;

  ...Azure.ResourceManager.ManagedServiceIdentityProperty;

  /**
   * The fully qualified resource ID of the resource that manages this resource. Indicates if this resource is managed by another Azure resource. If this is present, complete mode deployment will not delete the resource if it is removed from the template since it is managed by another resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  managedBy?: string;

  /**
   * Metadata to represent the container app kind, representing if a container app is workflowapp or functionapp.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  kind?: Kind;
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ContainerApp>;

  /**
   * Patches a Container App using JSON Merge Patch
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<ContainerApp, PatchModel = ContainerApp>;

  /**
   * Delete a Container App.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    ContainerApp,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Get the Container Apps in a given resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    ContainerApp,
    Response = ArmResponse<ContainerAppCollection>
  >;

  /**
   * Get the Container Apps in a given subscription.
   */
  listBySubscription is ArmListBySubscription<
    ContainerApp,
    Response = ArmResponse<ContainerAppCollection>
  >;

  /**
   * Analyzes a custom hostname for a Container App
   */
  listCustomHostNameAnalysis is ArmResourceActionSync<
    ContainerApp,
    void,
    ArmResponse<CustomHostnameAnalysisResult>,
    Parameters = {
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
  @list
  listSecrets is ArmResourceActionSync<
    ContainerApp,
    void,
    ArmResponse<SecretsCollection>
  >;

  /**
   * Get auth token for a container app
   */
  @action("getAuthtoken")
  getAuthToken is ArmResourceActionSync<
    ContainerApp,
    void,
    ArmResponse<ContainerAppAuthToken>
  >;

  /**
   * Start a container app
   */
  start is ArmResourceActionAsync<
    ContainerApp,
    void,
    ArmResponse<ContainerApp>
  >;

  /**
   * Stop a container app
   */
  stop is ArmResourceActionAsync<ContainerApp, void, ArmResponse<ContainerApp>>;
}

@@doc(ContainerApp.name, "Name of the Container App.");
@@doc(ContainerApp.properties, "ContainerApp resource specific properties");
@@doc(ContainerApps.createOrUpdate::parameters.resource,
  "Properties used to create a container app"
);
@@doc(ContainerApps.update::parameters.properties,
  "Properties of a Container App that need to be updated"
);
