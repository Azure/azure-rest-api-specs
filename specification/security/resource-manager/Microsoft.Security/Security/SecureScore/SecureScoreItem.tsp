import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Common;

namespace Microsoft.Security;
/**
 * Secure score item data model
 */
@subscriptionResource
model SecureScoreItem
  is Azure.ResourceManager.ProxyResource<SecureScoreItemProperties> {
  ...ResourceNameParameter<
    Resource = SecureScoreItem,
    KeyName = "secureScoreName",
    SegmentName = "secureScores",
    NamePattern = ""
  >;
}

@armResourceOperations(#{ omitTags: true })
interface SecureScoreItems {
  /**
   * Get secure score for a specific Microsoft Defender for Cloud initiative within your current scope. For the ASC Default initiative, use 'ascScore'.
   */
  @tag("Secure Score")
  get is ArmResourceRead<
    SecureScoreItem,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Error = CloudError
  >;

  /**
   * List secure scores for all your Microsoft Defender for Cloud initiatives within your current scope.
   */
  @tag("Secure Score")
  list is ArmResourceListByParent<
    SecureScoreItem,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResponse<SecureScoresList>,
    Error = CloudError
  >;

  /**
   * Get all security controls for a specific initiative within a scope
   */
  @tag("Secure Score")
  @list
  @get
  @action("secureScoreControls")
  listBySecureScore is ArmResourceActionSync<
    SecureScoreItem,
    void,
    ArmResponse<SecureScoreControlList>,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Error = CloudError,
    Parameters = {
      /**
       * OData expand. Optional.
       */
      @query("$expand")
      $expand?: ExpandControlsEnum;
    }
  >;
}

@@doc(SecureScoreItem.name,
  "The initiative name. For the ASC Default initiative, use 'ascScore' as in the sample request below."
);
@@doc(SecureScoreItem.properties, "Secure score item");


