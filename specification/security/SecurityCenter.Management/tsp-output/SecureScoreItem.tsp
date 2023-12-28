import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.SecurityCenter;
@doc("Secure score item data model")
@subscriptionResource
model SecureScoreItem is ProxyResource<SecureScoreItemProperties> {
  @doc("The initiative name. For the ASC Default initiative, use 'ascScore' as in the sample request below.")
  @key("secureScoreName")
  @segment("secureScores")
  name: string;
}

@armResourceOperations
interface SecureScores {
  @doc("Get secure score for a specific Microsoft Defender for Cloud initiative within your current scope. For the ASC Default initiative, use 'ascScore'.")
  get is ArmResourceRead<SecureScoreItem>;
  @doc("List secure scores for all your Microsoft Defender for Cloud initiatives within your current scope.")
  list is ArmResourceListByParent<SecureScoreItem>;
}

@armResourceOperations
interface SecureScoreControls {
  @doc("Get all security controls for a specific initiative within a scope")
  // FIXME: SecureScoreControls_ListBySecureScore could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Security/secureScores/{secureScoreName}/secureScoreControls")
  @get
  ListBySecureScore is Azure.Core.Foundations.Operation<
    {
      @doc("Azure subscription ID")
      @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
      @path
      subscriptionId: string;

      @doc("The initiative name. For the ASC Default initiative, use 'ascScore' as in the sample request below.")
      @path
      secureScoreName: string;

      @doc("OData expand. Optional.")
      @query("$expand")
      $expand?: ExpandControlsEnum;
    },
    SecureScoreControlList
  >;
}
