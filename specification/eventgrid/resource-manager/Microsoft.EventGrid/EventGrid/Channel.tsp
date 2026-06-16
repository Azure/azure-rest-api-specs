import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PartnerNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.EventGrid;
/**
 * Channel info.
 */
@parentResource(PartnerNamespace)
model Channel is Azure.ResourceManager.ProxyResource<ChannelProperties> {
  ...ResourceNameParameter<
    Resource = Channel,
    KeyName = "channelName",
    SegmentName = "channels",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Channels {
  /**
   * Get properties of a channel.
   */
  @summary("Get a channel.")
  get is ArmResourceRead<Channel>;

  /**
   * Synchronously creates or updates a new channel with the specified parameters.
   */
  @summary("Create or update a channel.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Channel>;

  /**
   * Synchronously updates a channel with the specified parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Update a Channel.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    Channel,
    PatchModel = ChannelUpdateParameters,
    Response = OkResponse
  >;

  /**
   * Delete an existing channel.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Delete a channel.")
  delete is ArmResourceDeleteWithoutOkAsync<
    Channel,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List all the channels in a partner namespace.
   */
  @summary("List channels.")
  listByPartnerNamespace is ArmResourceListByParent<
    Channel,
    Parameters = {
      /**
       * The query used to filter the search results using OData syntax. Filtering is permitted on the 'name' property only and with limited number of OData operations. These operations are: the 'contains' function as well as the following logical operations: not, and, or, eq (for equal), and ne (for not equal). No arithmetic operations are supported. The following is a valid filter example: $filter=contains(namE, 'PATTERN') and name ne 'PATTERN-1'. The following is not a valid filter example: $filter=location eq 'westus'.
       */
      @query("$filter")
      $filter?: string;

      /**
       * The number of results to return per page for the list operation. Valid range for top parameter is 1 to 100. If not specified, the default number of results to be returned is 20 items per page.
       */
      @query("$top")
      $top?: int32;
    },
    Response = ArmResponse<ChannelsListResult>
  >;

  /**
   * Get the full endpoint URL of a partner destination channel.
   */
  @summary("Get full URL of partner destination channel.")
  getFullUrl is ArmResourceActionSync<
    Channel,
    void,
    ArmResponse<EventSubscriptionFullUrl>
  >;
}

@@doc(Channel.name, "Name of the channel.");
@@doc(Channel.properties, "Properties of the Channel.");
@@doc(Channels.createOrUpdate::parameters.resource, "Channel information.");
@@doc(Channels.update::parameters.properties, "Channel update information.");
