import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;
@doc("Secure score item data model")
@subscriptionResource
model SecureScoreItem is ProxyResource<SecureScoreItemProperties> {
  @doc("The initiative name. For the ASC Default initiative, use 'ascScore' as in the sample request below.")
  @path
  @key("secureScoreName")
  @segment("secureScores")
  name: string;
}

@armResourceOperations
interface SecureScoreItems {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get secure score for a specific Microsoft Defender for Cloud initiative within your current scope. For the ASC Default initiative, use 'ascScore'.")
  @operationId("SecureScores_Get")
  get is ArmResourceRead<SecureScoreItem>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List secure scores for all your Microsoft Defender for Cloud initiatives within your current scope.")
  @operationId("SecureScores_List")
  list is ArmResourceListByParent<SecureScoreItem>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SecureScoreControls_ListBySecureScore")
  @doc("Get all security controls for a specific initiative within a scope")
  // FIXME: SecureScoreControls_ListBySecureScore could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Security/secureScores/{secureScoreName}/secureScoreControls")
  @get
  listBySecureScore is Azure.Core.Foundations.Operation<
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
