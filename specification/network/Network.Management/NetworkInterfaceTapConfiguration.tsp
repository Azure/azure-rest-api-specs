import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkInterface.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Tap configuration in a Network Interface.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(NetworkInterface)
@Http.Private.includeInapplicableMetadataInPayload(false)
model NetworkInterfaceTapConfiguration extends SubResourceModel {
  properties?: NetworkInterfaceTapConfigurationPropertiesFormat;

  /**
   * The name of the resource that is unique within a resource group. This name can be used to access the resource.
   */
  @visibility(Lifecycle.Read)
  @path
  @key("tapConfigurationName")
  @segment("tapConfigurations")
  name: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

@armResourceOperations
interface NetworkInterfaceTapConfigurations {
  /**
   * Get the specified tap configuration on a network interface.
   */
  get is ArmResourceRead<NetworkInterfaceTapConfiguration, Error = CloudError>;

  /**
   * Creates or updates a Tap configuration in the specified NetworkInterface.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    NetworkInterfaceTapConfiguration,
    Error = CloudError
  >;

  /**
   * Deletes the specified tap configuration from the NetworkInterface.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    NetworkInterfaceTapConfiguration,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Get all Tap configurations in a network interface.
   */
  list is ArmResourceListByParent<
    NetworkInterfaceTapConfiguration,
    Error = CloudError
  >;
}

@@doc(NetworkInterfaceTapConfiguration.name,
  "The name of the resource that is unique within a resource group. This name can be used to access the resource."
);
@@doc(NetworkInterfaceTapConfiguration.properties,
  "Properties of the Virtual Network Tap configuration."
);
@@doc(NetworkInterfaceTapConfigurations.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update tap configuration operation."
);
