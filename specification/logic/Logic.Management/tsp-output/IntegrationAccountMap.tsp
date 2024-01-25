import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./IntegrationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Logic;
/**
 * The integration account map.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(IntegrationAccount)
@includeInapplicableMetadataInPayload(false)
model IntegrationAccountMap extends Resource {
  /**
   * The integration account map name.
   */
  @path
  @key("mapName")
  @segment("maps")
  @visibility("read")
  name: string;

  /**
   * The integration account map properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: IntegrationAccountMapProperties;
}

@armResourceOperations
interface IntegrationAccountMaps {
  /**
   * Gets an integration account map.
   */
  get is ArmResourceRead<IntegrationAccountMap>;

  /**
   * Creates or updates an integration account map. If the map is larger than 4 MB, you need to store the map in an Azure blob and use the blob's Shared Access Signature (SAS) URL as the 'contentLink' property value.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<IntegrationAccountMap>;

  /**
   * Deletes an integration account map.
   */
  delete is ArmResourceDeleteSync<IntegrationAccountMap>;

  /**
   * Gets a list of integration account maps.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IntegrationAccountMaps_List")
  list is ArmResourceListByParent<
    IntegrationAccountMap,
    {
      ...BaseParameters<IntegrationAccountMap>;

      /**
       * The number of items to be included in the result.
       */
      @query("$top")
      $top?: int32;

      /**
       * The filter to apply on the operation. Options for filters include: MapType.
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * Get the content callback url.
   */
  listContentCallbackUrl is ArmResourceActionSync<
    IntegrationAccountMap,
    GetCallbackUrlParameters,
    WorkflowTriggerCallbackUrl
  >;
}

@@projectedName(IntegrationAccountMaps.createOrUpdate::parameters.resource,
  "json",
  "map"
);
@@extension(IntegrationAccountMaps.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "map"
);
@@doc(IntegrationAccountMaps.createOrUpdate::parameters.resource,
  "The integration account map."
);
@@projectedName(IntegrationAccountMaps.listContentCallbackUrl::parameters.body,
  "json",
  "listContentCallbackUrl"
);
@@extension(IntegrationAccountMaps.listContentCallbackUrl::parameters.body,
  "x-ms-client-name",
  "listContentCallbackUrl"
);
@@doc(IntegrationAccountMaps.listContentCallbackUrl::parameters.body, "");
