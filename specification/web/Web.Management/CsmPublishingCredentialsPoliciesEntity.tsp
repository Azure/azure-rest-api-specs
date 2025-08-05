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
        ftp: string,
      }
    > {}

@armResourceOperations
interface CsmPublishingCredentialsPoliciesEntities {
  /**
   * Description for Returns whether FTP is allowed on the site or not.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetFtpAllowed")
  getFtpAllowed is CsmPublishingCredentialsPoliciesEntityOps.Read<CsmPublishingCredentialsPoliciesEntity>;

  /**
   * Description for Updates whether FTP is allowed on the site or not.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_UpdateFtpAllowed")
  updateFtpAllowed is CsmPublishingCredentialsPoliciesEntityOps.CreateOrUpdateSync<
    CsmPublishingCredentialsPoliciesEntity,
    Response = ArmResourceUpdatedResponse<CsmPublishingCredentialsPoliciesEntity>
  >;

  /**
   * Description for Returns whether Scm basic auth is allowed and whether Ftp is allowed for a given site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListBasicPublishingCredentialsPolicies")
  listBasicPublishingCredentialsPolicies is CsmPublishingCredentialsPoliciesEntityOps.List<
    CsmPublishingCredentialsPoliciesEntity,
    Response = ArmResponse<PublishingCredentialsPoliciesCollection>
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
        scm: string,
      }
    > {}

@armResourceOperations
interface CsmPublishingCredentialsPoliciesEntityOperationGroup {
  /**
   * Description for Returns whether Scm basic auth is allowed on the site or not.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetScmAllowed")
  getScmAllowed is CsmPublishingCredentialsPoliciesEntityOperationGroupOps.Read<CsmPublishingCredentialsPoliciesEntity>;

  /**
   * Description for Updates whether user publishing credentials are allowed on the site or not.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_UpdateScmAllowed")
  updateScmAllowed is CsmPublishingCredentialsPoliciesEntityOperationGroupOps.CreateOrUpdateSync<
    CsmPublishingCredentialsPoliciesEntity,
    Response = ArmResourceUpdatedResponse<CsmPublishingCredentialsPoliciesEntity>
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

        /**  */
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
        ftp: string,
      }
    > {}

@armResourceOperations
interface CsmPublishingCredentialsPoliciesEntityOperationGroup {
  /**
   * Description for Returns whether FTP is allowed on the site or not.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetFtpAllowedSlot")
  getFtpAllowedSlot is CsmPublishingCredentialsPoliciesEntityOperationGroupOps.Read<CsmPublishingCredentialsPoliciesEntity>;

  /**
   * Description for Updates whether FTP is allowed on the site or not.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_UpdateFtpAllowedSlot")
  updateFtpAllowedSlot is CsmPublishingCredentialsPoliciesEntityOperationGroupOps.CreateOrUpdateSync<
    CsmPublishingCredentialsPoliciesEntity,
    Response = ArmResourceUpdatedResponse<CsmPublishingCredentialsPoliciesEntity>
  >;

  /**
   * Description for Returns whether Scm basic auth is allowed and whether Ftp is allowed for a given site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListBasicPublishingCredentialsPoliciesSlot")
  listBasicPublishingCredentialsPoliciesSlot is CsmPublishingCredentialsPoliciesEntityOperationGroupOps.List<
    CsmPublishingCredentialsPoliciesEntity,
    Response = ArmResponse<PublishingCredentialsPoliciesCollection>
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

        /**  */
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
        scm: string,
      }
    > {}

@armResourceOperations
interface CsmPublishingCredentialsPoliciesEntityOperationGroup {
  /**
   * Description for Returns whether Scm basic auth is allowed on the site or not.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetScmAllowedSlot")
  getScmAllowedSlot is CsmPublishingCredentialsPoliciesEntityOperationGroupOps.Read<CsmPublishingCredentialsPoliciesEntity>;

  /**
   * Description for Updates whether user publishing credentials are allowed on the site or not.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_UpdateScmAllowedSlot")
  updateScmAllowedSlot is CsmPublishingCredentialsPoliciesEntityOperationGroupOps.CreateOrUpdateSync<
    CsmPublishingCredentialsPoliciesEntity,
    Response = ArmResourceUpdatedResponse<CsmPublishingCredentialsPoliciesEntity>
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
@@doc(CsmPublishingCredentialsPoliciesEntityOperationGroup.updateFtpAllowedSlot::parameters.resource,
  ""
);
@@doc(CsmPublishingCredentialsPoliciesEntityOperationGroup.updateScmAllowedSlot::parameters.resource,
  ""
);
