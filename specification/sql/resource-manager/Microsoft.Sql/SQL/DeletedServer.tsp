import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Sql;
/**
 * A deleted server.
 */
@subscriptionResource
model DeletedServer
  is Azure.ResourceManager.ProxyResource<DeletedServerProperties> {
  ...ResourceNameParameter<
    Resource = DeletedServer,
    KeyName = "deletedServerName",
    SegmentName = "deletedServers",
    NamePattern = ""
  >;

  /**
   * Resource location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "location represents the geographic location of the original server, not an ARM envelope location"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "DeletedServer has no create operation; x-ms-mutability must be read-only to satisfy LocationMustHaveXmsMutability without implying a create path"
  @added(Versions.v2025_08_01_preview)
  @visibility(Lifecycle.Read)
  @extension("x-ms-mutability", #["read"])
  location?: string;
}

alias DeletedServersOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the region where the resource is located. */
    @path
    @segment("locations")
    @key
    locationName: Azure.Core.azureLocation;
  },
  {
    /** The name of the deleted server. */
    @path
    @segment("deletedServers")
    @key
    deletedServerName: string;
  }
>;

@armResourceOperations
interface DeletedServers {
  /**
   * Gets a deleted server.
   */
  get is DeletedServersOps.Read<DeletedServer>;

  /**
   * Gets a list of deleted servers for a location.
   */
  listByLocation is DeletedServersOps.List<DeletedServer>;

  /**
   * Recovers a deleted server.
   */
  recover is DeletedServersOps.ActionAsync<
    DeletedServer,
    void,
    void,
    Response = ArmResponse<DeletedServer> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = DeletedServer>>
  >;
}

@@doc(DeletedServer.name, "The name of the deleted server.");
@@doc(DeletedServer.properties, "Resource properties.");
