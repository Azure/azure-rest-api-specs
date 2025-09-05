import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./StaticSiteARMResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * Static Site Linked Backend ARM resource.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" ""
@parentResource(StaticSiteARMResource)
model StaticSiteLinkedBackendARMResource
  is Azure.ResourceManager.ProxyResource<StaticSiteLinkedBackendARMResourceProperties> {
  ...ResourceNameParameter<
    Resource = StaticSiteLinkedBackendARMResource,
    KeyName = "linkedBackendName",
    SegmentName = "linkedBackends",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" ""
@armResourceOperations
interface StaticSiteLinkedBackendARMResourceOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the static site */
        @path
        @segment("staticSites")
        @key
        name: string,
      },
      {
        /** Name of the linked backend that should be retrieved */
        @path
        @segment("linkedBackends")
        @key
        linkedBackendName: string,
      }
    > {}

#suppress "@azure-tools/typespec-azure-core/casing-style" ""
@armResourceOperations
interface StaticSiteLinkedBackendARMResources {
  /**
   * Returns the details of a linked backend linked to a static site by name
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_GetLinkedBackend")
  getLinkedBackend is StaticSiteLinkedBackendARMResourceOps.Read<StaticSiteLinkedBackendARMResource>;

  /**
   * Link backend to a static site
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("StaticSites_LinkBackend")
  linkBackend is StaticSiteLinkedBackendARMResourceOps.CreateOrUpdateAsync<
    StaticSiteLinkedBackendARMResource,
    Response = ArmResourceUpdatedResponse<StaticSiteLinkedBackendARMResource> &
      ArmLroLocationHeader<FinalResult = StaticSiteLinkedBackendARMResource>,
    LroHeaders = ArmLroLocationHeader<FinalResult = StaticSiteLinkedBackendARMResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Unlink a backend from a static site
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_UnlinkBackend")
  unlinkBackend is StaticSiteLinkedBackendARMResourceOps.DeleteSync<
    StaticSiteLinkedBackendARMResource,
    Parameters = {
      /**
       * Decides if Easy Auth configuration will be removed from backend configuration
       */
      @query("isCleaningAuthConfig")
      isCleaningAuthConfig?: boolean;
    }
  >;

  /**
   * Returns details of all backends linked to a static site
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_GetLinkedBackends")
  getLinkedBackends is StaticSiteLinkedBackendARMResourceOps.List<
    StaticSiteLinkedBackendARMResource,
    Response = ArmResponse<StaticSiteLinkedBackendsCollection>
  >;

  /**
   * Validates that a backend can be linked to a static site
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_ValidateBackend")
  @action("validate")
  validateBackend is StaticSiteLinkedBackendARMResourceOps.ActionAsync<
    StaticSiteLinkedBackendARMResource,
    StaticSiteLinkedBackendARMResource,
    NoContentResponse
  >;
}
#suppress "@azure-tools/typespec-azure-core/casing-style" ""
@armResourceOperations
interface StaticSiteLinkedBackendARMResourceOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the static site */
        @path
        @segment("staticSites")
        @key
        name: string,

        /** The stage site identifier */
        @path
        @segment("builds")
        @key
        environmentName: string,
      },
      {
        /** Name of the linked backend that should be retrieved */
        @path
        @segment("linkedBackends")
        @key
        linkedBackendName: string,
      }
    > {}

#suppress "@azure-tools/typespec-azure-core/casing-style" ""
@armResourceOperations
interface StaticSiteLinkedBackendARMResourceOperationGroup {
  /**
   * Returns the details of a linked backend linked to a static site build by name
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_GetLinkedBackendForBuild")
  getLinkedBackendForBuild is StaticSiteLinkedBackendARMResourceOperationGroupOps.Read<StaticSiteLinkedBackendARMResource>;

  /**
   * Link backend to a static site build
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("StaticSites_LinkBackendToBuild")
  linkBackendToBuild is StaticSiteLinkedBackendARMResourceOperationGroupOps.CreateOrUpdateAsync<
    StaticSiteLinkedBackendARMResource,
    Response = ArmResourceUpdatedResponse<StaticSiteLinkedBackendARMResource> &
      ArmLroLocationHeader<FinalResult = StaticSiteLinkedBackendARMResource>,
    LroHeaders = ArmLroLocationHeader<FinalResult = StaticSiteLinkedBackendARMResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Unlink a backend from a static site build
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_UnlinkBackendFromBuild")
  unlinkBackendFromBuild is StaticSiteLinkedBackendARMResourceOperationGroupOps.DeleteSync<
    StaticSiteLinkedBackendARMResource,
    Parameters = {
      /**
       * Decides if auth will be removed from backend configuration
       */
      @query("isCleaningAuthConfig")
      isCleaningAuthConfig?: boolean;
    }
  >;

  /**
   * Returns details of all backends linked to a static site build
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_GetLinkedBackendsForBuild")
  getLinkedBackendsForBuild is StaticSiteLinkedBackendARMResourceOperationGroupOps.List<
    StaticSiteLinkedBackendARMResource,
    Response = ArmResponse<StaticSiteLinkedBackendsCollection>
  >;

  /**
   * Validates that a backend can be linked to a static site build
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_ValidateBackendForBuild")
  @action("validate")
  validateBackendForBuild is StaticSiteLinkedBackendARMResourceOperationGroupOps.ActionAsync<
    StaticSiteLinkedBackendARMResource,
    StaticSiteLinkedBackendARMResource,
    NoContentResponse
  >;
}

@@doc(StaticSiteLinkedBackendARMResource.name,
  "Name of the linked backend that should be retrieved"
);
@@doc(StaticSiteLinkedBackendARMResource.properties,
  "StaticSiteLinkedBackendARMResource resource specific properties"
);
@@doc(StaticSiteLinkedBackendARMResources.linkBackend::parameters.resource,
  "A JSON representation of the linked backend request properties"
);
@@doc(StaticSiteLinkedBackendARMResources.validateBackend::parameters.body,
  "A JSON representation of the linked backend request properties"
);
@@doc(StaticSiteLinkedBackendARMResourceOperationGroup.linkBackendToBuild::parameters.resource,
  "A JSON representation of the linked backend request properties"
);
@@doc(StaticSiteLinkedBackendARMResourceOperationGroup.validateBackendForBuild::parameters.body,
  "A JSON representation of the linked backend request properties"
);
