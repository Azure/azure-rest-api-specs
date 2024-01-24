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

namespace Microsoft.HybridConnectivity;
/**
 * The endpoint for the target resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(EndpointProperties)
@includeInapplicableMetadataInPayload(false)
model EndpointResource extends ExtensionResourceBase {
  /**
   * The endpoint name.
   */
  @path
  @key("endpointName")
  @segment("endpoints")
  name: string;

  /**
   * The endpoint properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: EndpointProperties;
}

@armResourceOperations
interface EndpointResources {
  /**
   * Gets the endpoint to the resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Endpoints_Get")
  get is ArmResourceRead<
    EndpointResource,
    {
      ...BaseParameters<EndpointResource>;

      /**
       * The fully qualified Azure Resource manager identifier of the resource to be connected.
       */
      @path
      scope: string;
    }
  >;

  /**
   * Create or update the endpoint to the target resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Endpoints_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    EndpointResource,
    {
      ...BaseParameters<EndpointResource>;

      /**
       * The fully qualified Azure Resource manager identifier of the resource to be connected.
       */
      @path
      scope: string;
    }
  >;

  /**
   * Update the endpoint to the target resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Endpoints_Update")
  update is ArmCustomPatchSync<
    EndpointResource,
    EndpointResource,
    {
      ...BaseParameters<EndpointResource>;

      /**
       * The fully qualified Azure Resource manager identifier of the resource to be connected.
       */
      @path
      scope: string;
    }
  >;

  /**
   * Deletes the endpoint access to the target resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Endpoints_Delete")
  delete is ArmResourceDeleteSync<
    EndpointResource,
    {
      ...BaseParameters<EndpointResource>;

      /**
       * The fully qualified Azure Resource manager identifier of the resource to be connected.
       */
      @path
      scope: string;
    }
  >;

  /**
   * List of endpoints to the target resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Endpoints_List")
  list is ArmResourceListByParent<
    EndpointResource,
    {
      ...BaseParameters<EndpointResource>;

      /**
       * The fully qualified Azure Resource manager identifier of the resource to be connected.
       */
      @path
      scope: string;
    }
  >;

  /**
   * Gets the endpoint access credentials to the resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Endpoints_ListCredentials")
  listCredentials is ArmResourceActionSync<
    EndpointResource,
    void,
    TargetResourceEndpointAccess,
    {
      ...BaseParameters<EndpointResource>;

      /**
       * The fully qualified Azure Resource manager identifier of the resource to be connected.
       */
      @path
      scope: string;

      /**
       * The is how long the endpoint access token is valid (in seconds).
       */
      @maxValue(10800)
      @minValue(600)
      @query("expiresin")
      expiresin?: int64 = 10800;
    }
  >;
}

@@projectedName(EndpointResources.createOrUpdate::parameters.resource,
  "json",
  "EndpointResource"
);
@@extension(EndpointResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "EndpointResource"
);
@@doc(EndpointResources.createOrUpdate::parameters.resource,
  "Endpoint details"
);
@@projectedName(EndpointResources.update::parameters.properties,
  "json",
  "EndpointResource"
);
@@extension(EndpointResources.update::parameters.properties,
  "x-ms-client-name",
  "EndpointResource"
);
@@doc(EndpointResources.update::parameters.properties, "Endpoint details");
