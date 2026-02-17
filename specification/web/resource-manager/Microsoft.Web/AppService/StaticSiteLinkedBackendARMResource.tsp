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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(StaticSiteARMResource)
model StaticSiteLinkedBackendARMResource
  is Azure.ResourceManager.ProxyResource<StaticSiteLinkedBackendARMResourceProperties> {
  ...ResourceNameParameter<
    Resource = StaticSiteLinkedBackendARMResource,
    KeyName = "linkedBackendName",
    SegmentName = "linkedBackends",
    NamePattern = ""
  >;

  /**
   * Kind of resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface StaticSiteLinkedBackendARMResources {
  /**
   * Returns the details of a linked backend linked to a static site by name
   */
  @summary("Returns the details of a linked backend linked to a static site by name")
  getLinkedBackend is StaticSiteLinkedBackendARMResourceOps.Read<
    StaticSiteLinkedBackendARMResource,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Link backend to a static site
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Link backend to a static site")
  linkBackend is StaticSiteLinkedBackendARMResourceOps.CreateOrUpdateAsync<
    StaticSiteLinkedBackendARMResource,
    Response = ArmResourceUpdatedResponse<StaticSiteLinkedBackendARMResource> &
      ArmLroLocationHeader<FinalResult = StaticSiteLinkedBackendARMResource>,
    LroHeaders = ArmLroLocationHeader<FinalResult = StaticSiteLinkedBackendARMResource> &
      Azure.Core.Foundations.RetryAfterHeader,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Unlink a backend from a static site
   */
  @summary("Unlink a backend from a static site")
  unlinkBackend is StaticSiteLinkedBackendARMResourceOps.DeleteSync<
    StaticSiteLinkedBackendARMResource,
    Parameters = {
      /**
       * Decides if Easy Auth configuration will be removed from backend configuration
       */
      @query("isCleaningAuthConfig")
      isCleaningAuthConfig?: boolean;
    },
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Returns details of all backends linked to a static site
   */
  @summary("Returns details of all backends linked to a static site")
  getLinkedBackends is StaticSiteLinkedBackendARMResourceOps.List<
    StaticSiteLinkedBackendARMResource,
    Response = ArmResponse<StaticSiteLinkedBackendsCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Validates that a backend can be linked to a static site
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Validates that a backend can be linked to a static site")
  @action("validate")
  validateBackend is StaticSiteLinkedBackendARMResourceOps.ActionAsync<
    StaticSiteLinkedBackendARMResource,
    StaticSiteLinkedBackendARMResource,
    NoContentResponse,
    OverrideErrorType = DefaultErrorResponse,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;
}
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface StaticSiteLinkedBackendARMResourceOperationGroup {
  /**
   * Returns the details of a linked backend linked to a static site build by name
   */
  @summary("Returns the details of a linked backend linked to a static site build by name")
  getLinkedBackendForBuild is StaticSiteLinkedBackendARMResourceOperationGroupOps.Read<
    StaticSiteLinkedBackendARMResource,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Link backend to a static site build
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Link backend to a static site build")
  linkBackendToBuild is StaticSiteLinkedBackendARMResourceOperationGroupOps.CreateOrUpdateAsync<
    StaticSiteLinkedBackendARMResource,
    Response = ArmResourceUpdatedResponse<StaticSiteLinkedBackendARMResource> &
      ArmLroLocationHeader<FinalResult = StaticSiteLinkedBackendARMResource>,
    LroHeaders = ArmLroLocationHeader<FinalResult = StaticSiteLinkedBackendARMResource> &
      Azure.Core.Foundations.RetryAfterHeader,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Unlink a backend from a static site build
   */
  @summary("Unlink a backend from a static site build")
  unlinkBackendFromBuild is StaticSiteLinkedBackendARMResourceOperationGroupOps.DeleteSync<
    StaticSiteLinkedBackendARMResource,
    Parameters = {
      /**
       * Decides if auth will be removed from backend configuration
       */
      @query("isCleaningAuthConfig")
      isCleaningAuthConfig?: boolean;
    },
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Returns details of all backends linked to a static site build
   */
  @summary("Returns details of all backends linked to a static site build")
  getLinkedBackendsForBuild is StaticSiteLinkedBackendARMResourceOperationGroupOps.List<
    StaticSiteLinkedBackendARMResource,
    Response = ArmResponse<StaticSiteLinkedBackendsCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Validates that a backend can be linked to a static site build
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Validates that a backend can be linked to a static site build")
  @action("validate")
  validateBackendForBuild is StaticSiteLinkedBackendARMResourceOperationGroupOps.ActionAsync<
    StaticSiteLinkedBackendARMResource,
    StaticSiteLinkedBackendARMResource,
    NoContentResponse,
    OverrideErrorType = DefaultErrorResponse,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
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
