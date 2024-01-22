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

namespace Microsoft.KubernetesConfiguration;
/**
 * The Extension object.
 */
model Extension is ProxyResource<ExtensionProperties> {
  /**
   * Name of the Extension.
   */
  @path
  @key("extensionName")
  @segment("extensions")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourcePlan;
}

@armResourceOperations
interface Extensions {
  /**
   * Gets Kubernetes Cluster Extension.
   */
  get is ArmResourceRead<Extension>;

  /**
   * Create a new Kubernetes Cluster Extension.
   */
  create is ArmResourceCreateOrReplaceAsync<
    Extension,
    BaseParameters<Extension>,
    ArmAsyncOperationHeader
  >;

  /**
   * Patch an existing Kubernetes Cluster Extension.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    Extension,
    PatchExtension,
    BaseParameters<Extension>,
    ArmAsyncOperationHeader
  >;

  /**
   * Delete a Kubernetes Cluster Extension. This will cause the Agent to Uninstall the extension from the cluster.
   */
  delete is ArmResourceDeleteAsync<
    Extension,
    {
      ...BaseParameters<Extension>;

      /**
       * Delete the extension resource in Azure - not the normal asynchronous delete.
       */
      @query("forceDelete")
      forceDelete?: boolean;
    },
    ArmAsyncOperationHeader
  >;

  /**
   * List all Extensions in the cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Extensions_List")
  list is ArmResourceListByParent<Extension>;
}

@@projectedName(Extensions.create::parameters.resource, "json", "extension");
@@extension(Extensions.create::parameters.resource,
  "x-ms-client-name",
  "extension"
);
@@doc(Extensions.create::parameters.resource,
  "Properties necessary to Create an Extension."
);
@@projectedName(Extensions.update::parameters.properties,
  "json",
  "patchExtension"
);
@@extension(Extensions.update::parameters.properties,
  "x-ms-client-name",
  "patchExtension"
);
@@doc(Extensions.update::parameters.properties,
  "Properties to Patch in an existing Extension."
);
