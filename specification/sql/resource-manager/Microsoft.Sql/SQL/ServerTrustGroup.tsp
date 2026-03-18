import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A server trust group.
 */
@parentResource(ResourceGroupLocationResource)
model ServerTrustGroup
  is Azure.ResourceManager.ProxyResource<ServerTrustGroupProperties> {
  ...ResourceNameParameter<
    Resource = ServerTrustGroup,
    KeyName = "serverTrustGroupName",
    SegmentName = "serverTrustGroups",
    NamePattern = ""
  >;
}

alias ServerTrustGroupsOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the region where the resource is located. */
    @path
    @segment("locations")
    @key
    locationName: string;
  },
  {
    /** The name of the server trust group. */
    @path
    @segment("serverTrustGroups")
    @key
    serverTrustGroupName: string;
  }
>;

@armResourceOperations
interface ServerTrustGroups {
  /**
   * Gets a server trust group.
   */
  get is ServerTrustGroupsOps.Read<ServerTrustGroup>;

  /**
   * Creates or updates a server trust group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ServerTrustGroupsOps.CreateOrUpdateAsync<
    ServerTrustGroup,
    Response = ArmResourceUpdatedResponse<ServerTrustGroup> | ArmResourceCreatedResponse<
      ServerTrustGroup,
      ArmLroLocationHeader<FinalResult = ServerTrustGroup> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Deletes a server trust group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ServerTrustGroupsOps.DeleteWithoutOkAsync<
    ServerTrustGroup,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists a server trust group.
   */
  listByLocation is ServerTrustGroupsOps.List<ServerTrustGroup>;
}

@@doc(ServerTrustGroup.name, "The name of the server trust group.");
@@doc(ServerTrustGroup.properties, "Resource properties.");
@@doc(ServerTrustGroups.createOrUpdate::parameters.resource,
  "The server trust group parameters."
);
