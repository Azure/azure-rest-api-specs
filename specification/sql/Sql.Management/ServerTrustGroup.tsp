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

@armResourceOperations
interface ServerTrustGroups {
  /**
   * Gets a server trust group.
   */
  get is ArmResourceRead<ServerTrustGroup>;

  /**
   * Creates or updates a server trust group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    ServerTrustGroup,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists a server trust group.
   */
  listByLocation is ArmResourceListByParent<ServerTrustGroup>;
}

@@doc(ServerTrustGroup.name, "The name of the server trust group.");
@@doc(ServerTrustGroup.properties, "Resource properties.");
@@doc(ServerTrustGroups.createOrUpdate::parameters.resource,
  "The server trust group parameters."
);
