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
        ...ApiVersionParameter;
        ...SubscriptionIdParameter;
        ...ResourceGroupParameter;
        ...Azure.ResourceManager.Legacy.Provider;

        /** Name of the app. */
        @path
        @segment("sites")
        @key
        name: string;
      },
      {
        /** Name of the Last Known Good resource. Must be "default". */
        @path
        @segment("lastKnownGood")
        @key
        @pattern("^default$")
        lkgName: string;
      }
    > {}

@added(Versions.v2026_06_01_preview)
@tag("WebApps")
@armResourceOperations(#{ omitTags: true })
interface LastKnownGoods {
  /**
   * Get the current Last Known Good revision for a web app.
   */
  @summary("Get the current Last Known Good revision for a web app.")
  getLastKnownGood is LastKnownGoodOps.Read<
    LastKnownGoodResource,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Mark the current site state as Last Known Good.
   */
  @summary("Mark the current site state as Last Known Good.")
  @action("mark")
  markLastKnownGood is LastKnownGoodOps.ActionSync<
    LastKnownGoodResource,
    void,
    ArmResponse<LastKnownGoodResource>,
    OverrideErrorType = DefaultErrorResponse
  >;
}

@@doc(LastKnownGoodResource.name,
  "Name of the Last Known Good resource."
);
@@doc(LastKnownGoodResource.properties,
  "LastKnownGood resource specific properties"
);
