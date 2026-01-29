import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VirtualHub.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * IpConfigurations.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
@parentResource(VirtualHub)
@Http.Private.includeInapplicableMetadataInPayload(false)
model HubIpConfiguration extends SubResourceModel {
  properties?: HubIPConfigurationPropertiesFormat;

  /**
   * The name of the resource that is unique within a resource group. This name can be used to access the resource.
   */
  @visibility(Lifecycle.Read)
  @path
  @key("ipConfigName")
  @segment("ipConfigurations")
  name: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

@armResourceOperations
interface HubIpConfigurations {
  /**
   * Retrieves the details of a Virtual Hub Ip configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("VirtualHubIpConfiguration_Get")
  get is ArmResourceRead<HubIpConfiguration, Error = CloudError>;

  /**
   * Creates a VirtualHubIpConfiguration resource if it doesn't exist else updates the existing VirtualHubIpConfiguration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("VirtualHubIpConfiguration_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    HubIpConfiguration,
    Error = CloudError
  >;

  /**
   * Deletes a VirtualHubIpConfiguration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("VirtualHubIpConfiguration_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    HubIpConfiguration,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Retrieves the details of all VirtualHubIpConfigurations.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("VirtualHubIpConfiguration_List")
  list is ArmResourceListByParent<
    HubIpConfiguration,
    Response = ArmResponse<ListVirtualHubIpConfigurationResults>,
    Error = CloudError
  >;
}

@@doc(HubIpConfiguration.name, "The name of the ipconfig.");
@@doc(HubIpConfiguration.name,
  "The name of the resource that is unique within a resource group. This name can be used to access the resource."
);
@@doc(HubIpConfiguration.properties,
  "The properties of the Virtual Hub IPConfigurations."
);
@@doc(HubIpConfigurations.createOrUpdate::parameters.resource,
  "Hub Ip Configuration parameters."
);
