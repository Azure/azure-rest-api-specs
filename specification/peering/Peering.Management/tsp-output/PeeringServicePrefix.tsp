import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PeeringService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Peering;
/**
 * The peering service prefix class.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(PeeringService)
@includeInapplicableMetadataInPayload(false)
model PeeringServicePrefix extends Resource {
  /**
   * The name of the prefix.
   */
  @path
  @key("prefixName")
  @segment("prefixes")
  @visibility("read")
  name: string;

  /**
   * Gets or sets the peering prefix properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: PeeringServicePrefixProperties;
}

@armResourceOperations
interface PeeringServicePrefixes {
  /**
   * Gets an existing prefix with the specified name under the given subscription, resource group and peering service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Prefixes_Get")
  get is ArmResourceRead<
    PeeringServicePrefix,
    {
      ...BaseParameters<PeeringServicePrefix>;

      /**
       * The properties to be expanded.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Creates a new prefix with the specified name under the given subscription, resource group and peering service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Prefixes_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<PeeringServicePrefix>;

  /**
   * Deletes an existing prefix with the specified name under the given subscription, resource group and peering service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Prefixes_Delete")
  delete is ArmResourceDeleteSync<PeeringServicePrefix>;

  /**
   * Lists all prefixes under the given subscription, resource group and peering service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Prefixes_ListByPeeringService")
  listByPeeringService is ArmResourceListByParent<
    PeeringServicePrefix,
    {
      ...BaseParameters<PeeringServicePrefix>;

      /**
       * The properties to be expanded.
       */
      @query("$expand")
      $expand?: string;
    }
  >;
}

@@projectedName(PeeringServicePrefixes.createOrUpdate::parameters.resource,
  "json",
  "peeringServicePrefix"
);
@@extension(PeeringServicePrefixes.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "peeringServicePrefix"
);
@@doc(PeeringServicePrefixes.createOrUpdate::parameters.resource,
  "The properties needed to create a prefix."
);
