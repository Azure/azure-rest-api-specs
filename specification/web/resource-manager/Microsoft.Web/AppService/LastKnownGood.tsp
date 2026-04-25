import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Web;

/**
 * Represents the Last Known Good (LKG) revision status for a site.
 */
@added(Versions.v2026_06_01_preview)
@parentResource(Site)
model LastKnownGoodResource
  is Azure.ResourceManager.ProxyResource<LastKnownGoodProperties> {
  ...ResourceNameParameter<
    Resource = LastKnownGoodResource,
    KeyName = "lkgName",
    SegmentName = "lastKnownGood",
    NamePattern = "^default$"
  >;

  /** Kind of resource. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing pattern in Microsoft.Web"
  kind?: string;
}

@added(Versions.v2026_06_01_preview)
@armResourceOperations
interface LastKnownGoodOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the app. */
        @path
        @segment("sites")
        @key
        name: string,
      },
      {
        /** Name of the Last Known Good resource. Must be "default". */
        @path
        @segment("lastKnownGood")
        @key
        @pattern("^default$")
        lkgName: string,
      }
    > {}

@added(Versions.v2026_06_01_preview)
@tag("WebApps")
@armResourceOperations(#{ omitTags: true })
interface LastKnownGoods {
  /**
   * Returns the current Last Known Good revision status for the specified web app.
   */
  @summary("Get the current Last Known Good revision for a web app.")
  get is LastKnownGoodOps.Read<
    LastKnownGoodResource,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Marks the current site revision as Last Known Good so it can be used as a rollback target.
   */
  @summary("Mark the current site state as Last Known Good.")
  @action("mark")
  mark is LastKnownGoodOps.ActionSync<
    LastKnownGoodResource,
    void,
    ArmResponse<LastKnownGoodResource>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Returns a paginated list of Last Known Good resources for the specified web app.
   */
  @summary("List Last Known Good resources for a web app.")
  list is LastKnownGoodOps.List<
    LastKnownGoodResource,
    Response = ArmResponse<LastKnownGoodCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;
}

@@doc(LastKnownGoodResource.name, "Name of the Last Known Good resource.");
@@doc(LastKnownGoodResource.properties,
  "LastKnownGood resource specific properties"
);
