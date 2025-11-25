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
@parentResource(VpnServerConfiguration)
model VpnServerConfigurationPolicyGroup
  is Azure.ResourceManager.ProxyResource<VpnServerConfigurationPolicyGroupProperties> {
  ...ResourceNameParameter<
    Resource = VpnServerConfigurationPolicyGroup,
    KeyName = "configurationPolicyGroupName",
    SegmentName = "configurationPolicyGroups",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface VpnServerConfigurationPolicyGroups {
  /**
   * Retrieves the details of a ConfigurationPolicyGroup.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConfigurationPolicyGroups_Get")
  get is ArmResourceRead<VpnServerConfigurationPolicyGroup, Error = CloudError>;

  /**
   * Creates a ConfigurationPolicyGroup if it doesn't exist else updates the existing one.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConfigurationPolicyGroups_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<VpnServerConfigurationPolicyGroup, Error = CloudError>;

  /**
   * Deletes a ConfigurationPolicyGroup.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("ConfigurationPolicyGroups_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<VpnServerConfigurationPolicyGroup,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,  Error = CloudError>;

  /**
   * Lists all the configurationPolicyGroups in a resource group for a vpnServerConfiguration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("configurationPolicyGroups_ListByVpnServerConfiguration")
  listByVpnServerConfiguration is ArmResourceListByParent<VpnServerConfigurationPolicyGroup,
    Response = ArmResponse<ListVpnServerConfigurationPolicyGroupsResult>
  , Error = CloudError>;
}

@@doc(VpnServerConfigurationPolicyGroup.name,
  "The name of the ConfigurationPolicyGroup being retrieved."
);
@@doc(VpnServerConfigurationPolicyGroup.properties,
  "Properties of the VpnServerConfigurationPolicyGroup."
);
@@doc(VpnServerConfigurationPolicyGroups.createOrUpdate::parameters.resource,
  "Parameters supplied to create or update a VpnServerConfiguration PolicyGroup."
);
