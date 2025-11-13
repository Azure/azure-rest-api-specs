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
model AzureFirewall
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<AzureFirewallPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = AzureFirewall,
    KeyName = "azureFirewallName",
    SegmentName = "azureFirewalls",
    NamePattern = ""
  >;

  /**
   * The extended location of type local virtual network gateway.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  extendedLocation?: ExtendedLocation;

  ...Azure.ResourceManager.AvailabilityZonesProperty;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface AzureFirewalls {
  /**
   * Gets the specified Azure Firewall.
   */
  get is ArmResourceRead<AzureFirewall>;

  /**
   * Creates or updates the specified Azure Firewall.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AzureFirewall>;

  /**
   * Updates tags of an Azure Firewall resource.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchAsync<
    AzureFirewall,
    PatchModel = TagsObject,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = AzureFirewall> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes the specified Azure Firewall.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    AzureFirewall,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all Azure Firewalls in a resource group.
   */
  list is ArmResourceListByParent<AzureFirewall>;

  /**
   * Gets all the Azure Firewalls in a subscription.
   */
  listAll is ArmListBySubscription<AzureFirewall>;

  /**
   * Retrieves a list of all IP prefixes that azure firewall has learned to not SNAT.
   */
  @action("learnedIPPrefixes")
  listLearnedPrefixes is ArmResourceActionAsync<
    AzureFirewall,
    void,
    ArmResponse<IPPrefixesList>
  >;

  /**
   * Runs a packet capture on AzureFirewall.
   */
  packetCapture is ArmResourceActionAsyncBase<
    AzureFirewall,
    FirewallPacketCaptureParameters,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<AzureFirewall>
  >;

  /**
   * Runs a packet capture operation on AzureFirewall.
   */
  packetCaptureOperation is ArmResourceActionAsync<
    AzureFirewall,
    FirewallPacketCaptureParameters,
    ArmResponse<AzureFirewallPacketCaptureResponse>
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
