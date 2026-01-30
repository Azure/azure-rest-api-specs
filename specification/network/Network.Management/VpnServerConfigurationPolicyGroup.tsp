import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VpnServerConfiguration.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * VpnServerConfigurationPolicyGroup Resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
@parentResource(VpnServerConfiguration)
@Http.Private.includeInapplicableMetadataInPayload(false)
model VpnServerConfigurationPolicyGroup extends SubResourceModel {
  properties?: VpnServerConfigurationPolicyGroupProperties;

  /**
   * The name of the resource that is unique within a resource group. This name can be used to access the resource.
   */
  @visibility(Lifecycle.Read)
  @path
  @key("configurationPolicyGroupName")
  @segment("configurationPolicyGroups")
  name: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

@armResourceOperations
interface VpnServerConfigurationPolicyGroups {
  /**
   * Retrieves the details of a ConfigurationPolicyGroup.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("ConfigurationPolicyGroups_Get")
  get is ArmResourceRead<VpnServerConfigurationPolicyGroup, Error = CloudError>;

  /**
   * Creates a ConfigurationPolicyGroup if it doesn't exist else updates the existing one.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("ConfigurationPolicyGroups_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    VpnServerConfigurationPolicyGroup,
    Error = CloudError
  >;

  /**
   * Deletes a ConfigurationPolicyGroup.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("ConfigurationPolicyGroups_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    VpnServerConfigurationPolicyGroup,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Lists all the configurationPolicyGroups in a resource group for a vpnServerConfiguration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("configurationPolicyGroups_ListByVpnServerConfiguration")
  listByVpnServerConfiguration is ArmResourceListByParent<
    VpnServerConfigurationPolicyGroup,
    Response = ArmResponse<ListVpnServerConfigurationPolicyGroupsResult>,
    Error = CloudError
  >;
}

@@doc(VpnServerConfigurationPolicyGroup.name,
  "The name of the resource that is unique within a resource group. This name can be used to access the resource."
);
@@doc(VpnServerConfigurationPolicyGroup.properties,
  "Properties of the VpnServerConfigurationPolicyGroup."
);
@@doc(VpnServerConfigurationPolicyGroups.createOrUpdate::parameters.resource,
  "Parameters supplied to create or update a VpnServerConfiguration PolicyGroup."
);
