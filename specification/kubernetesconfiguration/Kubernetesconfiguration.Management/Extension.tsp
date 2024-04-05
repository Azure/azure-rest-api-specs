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
  @visibility("read")
  @pattern("/^[a-zA-Z0-9-]{3,24}$/")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourcePlan;
}

@tag("ClusterExtensions")
@tag("Extensions")
@armResourceOperations
interface Extensions {
  /**
   * Gets Kubernetes Cluster Extension.
   */
  get is ArmResourceRead<
    Extension,
    BaseParameters = CustomBaseParameters<Extension>
  >;

  /**
   * Create a new Kubernetes Cluster Extension.
   */
  create is ArmResourceCreateOrUpdateAsync<
    Extension,
    BaseParameters = CustomBaseParameters<Extension>
  >;

  /**
   * Patch an existing Kubernetes Cluster Extension.
   */
  @parameterVisibility("read")
  update is ArmResourcePatchSync<
    Extension,
    ExtensionProperties,
    BaseParameters = CustomBaseParameters<Extension>
  >;

  /**
   * Delete a Kubernetes Cluster Extension. This will cause the Agent to Uninstall the extension from the cluster.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    Extension,
    {
      ...CustomBaseParameters<Extension>;

      /**
       * Delete the extension resource in Azure - not the normal asynchronous delete.
       */
      @query("forceDelete")
      forceDelete?: boolean;
    }
  >;

  /**
   * List all Extensions in the cluster.
   */
  list is ArmResourceListByParent<
    Extension,
    BaseParameters = CustomBaseParameters<Extension>
  >;

  /**
   * Get Async Operation status
   */
  operationStatus is ArmResourceRead<
    Extension,
    BaseParameters = CustomBaseParameters<Extension>,
    Parameters = OperationsParameter,
    Response = ArmOperationStatus
  >;
}

@@doc(Extensions.create::parameters.resource,
  "Properties necessary to Create an Extension."
);
@@doc(Extensions.update::parameters.properties,
  "Properties to Patch in an existing Extension."
);
