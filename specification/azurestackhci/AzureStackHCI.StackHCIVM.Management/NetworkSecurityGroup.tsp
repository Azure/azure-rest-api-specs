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

namespace Microsoft.AzureStackHCI;
@doc("NetworkSecurityGroup resource.")
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  NetworkSecurityGroupPropertiesFormat
)
model NetworkSecurityGroup extends TrackedResourceBase {
  @doc("Name of the network security group")
  @maxLength(80)
  @minLength(1)
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,78}[_a-zA-Z0-9]$")
  @path
  @key("networkSecurityGroupName")
  @segment("networkSecurityGroups")
  @visibility("read")
  name: string;

  @doc("A unique read-only string that changes whenever the resource is updated.")
  @visibility("read")
  etag?: string;

  @doc("Properties of the network security group.")
  @extension("x-ms-client-flatten", true)
  properties?: NetworkSecurityGroupPropertiesFormat;
}

@armResourceOperations
interface NetworkSecurityGroups {
  @doc("Gets the specified network security group.")
  get is ArmResourceRead<NetworkSecurityGroup>;

  @doc("Creates or updates a network security group in the specified resource group.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    NetworkSecurityGroup,
    BaseParameters<NetworkSecurityGroup>,
    ArmAsyncOperationHeader
  >;

  @doc("Updates a network security group tags.")
  @parameterVisibility("read")
  updateTags is ArmCustomPatchSync<NetworkSecurityGroup, TagsObject>;

  @doc("Deletes the specified network security group.")
  delete is ArmResourceDeleteWithoutOkAsync<
    NetworkSecurityGroup,
    BaseParameters<NetworkSecurityGroup>,
    ArmAsyncOperationHeader
  >;

  @doc("Gets all network security groups in a resource group.")
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NetworkSecurityGroups_List")
  list is ArmResourceListByParent<NetworkSecurityGroup>;

  @doc("Gets all network security groups in a subscription.")
  listAll is ArmListBySubscription<NetworkSecurityGroup>;

  @doc("Get the specified network security rule.")
  // FIXME: SecurityRules_Get could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SecurityRules_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/networkSecurityGroups/{networkSecurityGroupName}/securityRules/{securityRuleName}")
  @get
  getNSG is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("Name of the network security group")
      @maxLength(80)
      @minLength(1)
      @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,78}[_a-zA-Z0-9]$")
      @path
      networkSecurityGroupName: string;

      @doc("Name of the network security rule")
      @maxLength(80)
      @minLength(1)
      @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,78}[_a-zA-Z0-9]$")
      @path
      securityRuleName: string;
    },
    SecurityRule
  >;

  @doc("Gets all security rules in a network security group.")
  // FIXME: SecurityRules_List could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SecurityRules_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/networkSecurityGroups/{networkSecurityGroupName}/securityRules")
  @get
  listNSGs is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("Name of the network security group")
      @maxLength(80)
      @minLength(1)
      @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,78}[_a-zA-Z0-9]$")
      @path
      networkSecurityGroupName: string;
    },
    SecurityRuleListResult
  >;

  @doc("Gets all default security rules in a network security group.")
  // FIXME: DefaultSecurityRules_List could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DefaultSecurityRules_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/networkSecurityGroups/{networkSecurityGroupName}/defaultSecurityRules")
  @get
  listDefaultNSG is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("Name of the network security group")
      @maxLength(80)
      @minLength(1)
      @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,78}[_a-zA-Z0-9]$")
      @path
      networkSecurityGroupName: string;
    },
    SecurityRuleListResult
  >;

  @doc("Get the specified default network security rule.")
  // FIXME: DefaultSecurityRules_Get could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DefaultSecurityRules_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/networkSecurityGroups/{networkSecurityGroupName}/defaultSecurityRules/{defaultSecurityRuleName}")
  @get
  getDefaultNSG is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("Name of the network security group")
      @maxLength(80)
      @minLength(1)
      @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,78}[_a-zA-Z0-9]$")
      @path
      networkSecurityGroupName: string;

      @doc("Name of the default security rule.")
      @maxLength(80)
      @minLength(1)
      @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,78}[_a-zA-Z0-9]$")
      @path
      defaultSecurityRuleName: string;
    },
    SecurityRule
  >;
}

@@projectedName(NetworkSecurityGroups.createOrUpdate::parameters.resource,
  "json",
  "networkSecurityGroups"
);
@@extension(NetworkSecurityGroups.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "networkSecurityGroups"
);
@@doc(NetworkSecurityGroups.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update network security group operation."
);
@@projectedName(NetworkSecurityGroups.updateTags::parameters.properties,
  "json",
  "parameters"
);
@@extension(NetworkSecurityGroups.updateTags::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(NetworkSecurityGroups.updateTags::parameters.properties,
  "Parameters supplied to update network security group tags."
);
