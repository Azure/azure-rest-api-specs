import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./LabDetails.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Education;
/**
 * join requests.
 */
@parentResource(LabDetails)
model JoinRequestDetails
  is Azure.ResourceManager.ProxyResource<JoinRequestProperties> {
  ...ResourceNameParameter<
    Resource = JoinRequestDetails,
    KeyName = "joinRequestName",
    SegmentName = "joinRequests",
    NamePattern = ""
  >;
}

@armResourceOperations
interface JoinRequests {
  /**
   * get student join requests
   */
  get is ArmResourceRead<JoinRequestDetails>;

  /**
   * get student join requests
   */
  list is ArmResourceListByParent<
    JoinRequestDetails,
    Parameters = {
      /**
       * Include denied
       */
      @query("includeDenied")
      includeDenied?: boolean;
    },
    Response = ArmResponse<JoinRequestList>
  >;

  /**
   * Approve student joining the redeemable lab
   */
  approve is ArmResourceActionSync<JoinRequestDetails, void, OkResponse>;

  /**
   * Deny student joining the redeemable lab
   */
  deny is ArmResourceActionSync<JoinRequestDetails, void, OkResponse>;
}

@@doc(JoinRequestDetails.name,
  "The ID that uniquely identifies a join request."
);
@@doc(JoinRequestDetails.properties, "join request properties.");
