import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Azure Firewall resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.firewall)
@Http.Private.includeInapplicableMetadataInPayload(false)
model AzureFirewall extends Resource {
  properties?: AzureFirewallPropertiesFormat;

  @visibility(Lifecycle.Read)
  @path
  @key("azureFirewallName")
  @segment("azureFirewalls")
  name: string;

  /**
   * The extended location of type local virtual network gateway.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  extendedLocation?: ExtendedLocation;

  /** A list of availability zones denoting where the resource needs to come from. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  zones?: string[];

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.firewall)
@armResourceOperations
interface AzureFirewalls {
  /**
   * Gets the specified Azure Firewall.
   */
  get is ArmResourceRead<AzureFirewall, Error = CloudError>;

  /**
   * Creates or updates the specified Azure Firewall.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AzureFirewall,
    Error = CloudError
  >;

  /**
   * Updates tags of an Azure Firewall resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchAsync<
    AzureFirewall,
    PatchModel = TagsObject,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = AzureFirewall> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = CloudError
  >;

  /**
   * Deletes the specified Azure Firewall.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    AzureFirewall,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Lists all Azure Firewalls in a resource group.
   */
  list is ArmResourceListByParent<AzureFirewall, Error = CloudError>;

  /**
   * Gets all the Azure Firewalls in a subscription.
   */
  listAll is ArmListBySubscription<AzureFirewall, Error = CloudError>;

  /**
   * Retrieves a list of all IP prefixes that azure firewall has learned to not SNAT.
   */
  @action("learnedIPPrefixes")
  listLearnedPrefixes is ArmResourceActionAsync<
    AzureFirewall,
    void,
    IPPrefixesList,
    Error = CloudError
  >;

  /**
   * Runs a packet capture on AzureFirewall.
   */
  packetCapture is ArmResourceActionAsyncBase<
    AzureFirewall,
    Request = FirewallPacketCaptureParameters,
    Response = ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<AzureFirewall>,
    Error = CloudError
  >;

  /**
   * Runs a packet capture operation on AzureFirewall.
   */
  packetCaptureOperation is ArmResourceActionAsync<
    AzureFirewall,
    FirewallPacketCaptureParameters,
    AzureFirewallPacketCaptureResponse,
    Error = CloudError
  >;
}

@@doc(AzureFirewall.name, "The name of the Azure Firewall.");
@@doc(AzureFirewall.properties, "Properties of the azure firewall.");
@@doc(AzureFirewalls.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update Azure Firewall operation."
);
@@doc(AzureFirewalls.updateTags::parameters.properties,
  "Parameters supplied to update azure firewall tags."
);
@@doc(AzureFirewalls.packetCapture::parameters.body,
  "Parameters supplied to run packet capture on azure firewall."
);
@@doc(AzureFirewalls.packetCaptureOperation::parameters.body,
  "Parameters supplied to run packet capture on azure firewall."
);
