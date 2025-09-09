import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * Publishing Credentials Policies parameters.
 */
@singleton("ftp")
@parentResource(Site)
model CsmPublishingCredentialsPoliciesEntity
  is Azure.ResourceManager.ProxyResource<CsmPublishingCredentialsPoliciesEntityProperties> {
  ...ResourceNameParameter<
    Resource = CsmPublishingCredentialsPoliciesEntity,
    KeyName = "basicPublishingCredentialsPolicy",
    SegmentName = "basicPublishingCredentialsPolicies",
    NamePattern = ""
  >;
}

@armResourceOperations
interface CsmPublishingCredentialsPoliciesEntityOps
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
        /** undefined */
        @path
        @segment("basicPublishingCredentialsPolicies")
        @key
        ftp: "ftp",
      }
    > {}

@armResourceOperations
interface CsmPublishingCredentialsPoliciesEntities {
  /**
   * Description for Returns whether FTP is allowed on the site or not.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetFtpAllowed")
  getFtpAllowed is CsmPublishingCredentialsPoliciesEntityOps.Read<
    CsmPublishingCredentialsPoliciesEntity,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Updates whether FTP is allowed on the site or not.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_UpdateFtpAllowed")
  updateFtpAllowed is CsmPublishingCredentialsPoliciesEntityOps.CreateOrUpdateSync<
    CsmPublishingCredentialsPoliciesEntity,
    Response = ArmResourceUpdatedResponse<CsmPublishingCredentialsPoliciesEntity>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Returns whether Scm basic auth is allowed and whether Ftp is allowed for a given site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListBasicPublishingCredentialsPolicies")
  @segment("basicPublishingCredentialsPolicies")
  listBasicPublishingCredentialsPolicies is CsmPublishingCredentialsPoliciesEntityOps.List<
    CsmPublishingCredentialsPoliciesEntity,
    Response = ArmResponse<PublishingCredentialsPoliciesCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;
}
@armResourceOperations
interface CsmPublishingCredentialsPoliciesEntityOperationGroupOps
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
        /** undefined */
        @path
        @segment("basicPublishingCredentialsPolicies")
        @key
        scm: "scm",
      }
    > {}

@armResourceOperations
interface CsmPublishingCredentialsPoliciesEntityOperationGroup {
  /**
   * Description for Returns whether Scm basic auth is allowed on the site or not.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetScmAllowed")
  getScmAllowed is CsmPublishingCredentialsPoliciesEntityOperationGroupOps.Read<
    CsmPublishingCredentialsPoliciesEntity,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Updates whether user publishing credentials are allowed on the site or not.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_UpdateScmAllowed")
  updateScmAllowed is CsmPublishingCredentialsPoliciesEntityOperationGroupOps.CreateOrUpdateSync<
    CsmPublishingCredentialsPoliciesEntity,
    Response = ArmResourceUpdatedResponse<CsmPublishingCredentialsPoliciesEntity>,
    OverrideErrorType = DefaultErrorResponse
  >;
}
@armResourceOperations
interface FtpAllowedSlotOps
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

        #suppress "@azure-tools/typespec-azure-core/documentation-required" ""
        @path
        @segment("slots")
        @key
        slot: string,
      },
      {
        #suppress "@azure-tools/typespec-azure-core/documentation-required" ""
        @path
        @segment("basicPublishingCredentialsPolicies")
        @key
        ftp: "ftp",
      }
    > {}

@armResourceOperations
interface CsmPublishingCredentialsPoliciesEntityFtpAllowedSlot {
  /**
   * Description for Returns whether FTP is allowed on the site or not.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetFtpAllowedSlot")
  getFtpAllowedSlot is FtpAllowedSlotOps.Read<
    CsmPublishingCredentialsPoliciesEntity,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Updates whether FTP is allowed on the site or not.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_UpdateFtpAllowedSlot")
  updateFtpAllowedSlot is FtpAllowedSlotOps.CreateOrUpdateSync<
    CsmPublishingCredentialsPoliciesEntity,
    Response = ArmResourceUpdatedResponse<CsmPublishingCredentialsPoliciesEntity>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Returns whether Scm basic auth is allowed and whether Ftp is allowed for a given site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListBasicPublishingCredentialsPoliciesSlot")
  @segment("basicPublishingCredentialsPolicies")
  listBasicPublishingCredentialsPoliciesSlot is FtpAllowedSlotOps.List<
    CsmPublishingCredentialsPoliciesEntity,
    Response = ArmResponse<PublishingCredentialsPoliciesCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;
}
@armResourceOperations
interface ScmAllowedSlotOps
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

        #suppress "@azure-tools/typespec-azure-core/documentation-required" ""
        @path
        @segment("slots")
        @key
        slot: string,
      },
      {
        /** undefined */
        @path
        @segment("basicPublishingCredentialsPolicies")
        @key
        scm: "scm",
      }
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" ""
@armResourceOperations
interface CsmPublishingCredentialsPoliciesEntityScmAllowedSlot {
  /**
   * Description for Returns whether Scm basic auth is allowed on the site or not.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetScmAllowedSlot")
  getScmAllowedSlot is ScmAllowedSlotOps.Read<
    CsmPublishingCredentialsPoliciesEntity,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Updates whether user publishing credentials are allowed on the site or not.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_UpdateScmAllowedSlot")
  updateScmAllowedSlot is ScmAllowedSlotOps.CreateOrUpdateSync<
    CsmPublishingCredentialsPoliciesEntity,
    Response = ArmResourceUpdatedResponse<CsmPublishingCredentialsPoliciesEntity>,
    OverrideErrorType = DefaultErrorResponse
  >;
}

@@doc(CsmPublishingCredentialsPoliciesEntity.name, "");
@@doc(CsmPublishingCredentialsPoliciesEntity.properties,
  "CsmPublishingCredentialsPoliciesEntity resource specific properties"
);
@@doc(CsmPublishingCredentialsPoliciesEntities.updateFtpAllowed::parameters.resource,
  ""
);
@@doc(CsmPublishingCredentialsPoliciesEntityOperationGroup.updateScmAllowed::parameters.resource,
  ""
);
@@doc(CsmPublishingCredentialsPoliciesEntityFtpAllowedSlot.updateFtpAllowedSlot::parameters.resource,
  ""
);
@@doc(CsmPublishingCredentialsPoliciesEntityScmAllowedSlot.updateScmAllowedSlot::parameters.resource,
  ""
);
