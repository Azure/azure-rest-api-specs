import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./ApplicationSecurityGroup.tsp";
import "./ApplicationSecurityGroup.models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.Network;

/**
 * Address prefix set child resource of an application security group.
 */
@added(Versions.v2025_09_01)
@featureFile(Features.virtualNetwork)
@parentResource(ApplicationSecurityGroup)
model AddressPrefixSet
  is ProxyResourceInstance<AddressPrefixSetPropertiesFormat> {
  /** The name of the address prefix set. */
  @visibility(Lifecycle.Read)
  @path
  @key("addressPrefixSetName")
  @segment("addressPrefixSets")
  @pattern("^[a-zA-Z0-9]([a-zA-Z0-9_.-]{0,78}[a-zA-Z0-9_])?$")
  name: string;
}

/**
 * Properties of address prefix set.
 */
@added(Versions.v2025_09_01)
@featureFile(Features.virtualNetwork)
model AddressPrefixSetPropertiesFormat {
  /** The list of address prefixes in CIDR notation. Supports both IPv4 and IPv6 CIDR notation (e.g. '10.0.0.0/16', '2001:db8::/32'). */
  @minItems(1)
  addressPrefixes: string[];

  /** The provisioning state of the address prefix set resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2025_09_01)
@featureFile(Features.virtualNetwork)
@armResourceOperations(#{ omitTags: true })
interface AddressPrefixSets {
  /**
   * Gets the specified address prefix set.
   */
  @tag("AddressPrefixSets")
  get is ArmResourceRead<AddressPrefixSet, Error = CloudError>;

  /**
   * Creates or updates an address prefix set.
   */
  @tag("AddressPrefixSets")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AddressPrefixSet,
    Error = CloudError
  >;

  /**
   * Deletes the specified address prefix set.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Network RP delete operations use 202+204 pattern without 200, matching existing ASG and other resource delete conventions"
  @tag("AddressPrefixSets")
  delete is ArmResourceDeleteWithoutOkAsync<
    AddressPrefixSet,
    Response = ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets all address prefix sets in an application security group.
   */
  @tag("AddressPrefixSets")
  list is ArmResourceListByParent<AddressPrefixSet, Error = CloudError>;
}

@@doc(AddressPrefixSet.name, "The name of the address prefix set.");
@@doc(AddressPrefixSet.properties, "Properties of the address prefix set.");
@@doc(
  AddressPrefixSets.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update address prefix set operation."
);
