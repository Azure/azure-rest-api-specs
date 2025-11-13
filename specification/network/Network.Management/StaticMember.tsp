import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * StaticMember Item.
 */
@parentResource(NetworkGroup)
model StaticMember
  is Azure.ResourceManager.ProxyResource<StaticMemberProperties> {
  ...ResourceNameParameter<
    Resource = StaticMember,
    KeyName = "staticMemberName",
    SegmentName = "staticMembers",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface StaticMembers {
  /**
   * Gets the specified static member.
   */
  get is ArmResourceRead<StaticMember>;

  /**
   * Creates or updates a static member.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<StaticMember>;

  /**
   * Deletes a static member.
   */
  delete is ArmResourceDeleteSync<StaticMember>;

  /**
   * Lists the specified static member.
   */
  list is ArmResourceListByParent<
    StaticMember,
    Parameters = {
      /**
       * An optional query parameter which specifies the maximum number of records to be returned by the server.
       */
      @maxValue(20)
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * SkipToken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls.
       */
      @query("$skipToken")
      $skipToken?: string;
    }
  >;
}

@@doc(StaticMember.name, "The name of the static member.");
@@doc(StaticMember.properties, "The Static Member properties");
@@doc(StaticMembers.createOrUpdate::parameters.resource,
  "Parameters supplied to the specify the static member to create"
);
