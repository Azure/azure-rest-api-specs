import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ResourceGuardResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.DataProtection;
// FIXME: DppBaseResource has no properties property
/**
 * Base resource under Microsoft.DataProtection provider namespace
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(ResourceGuardResource)
model DppBaseResource is Azure.ResourceManager.ProxyResource<{}> {
  ...ResourceNameParameter<
    Resource = DppBaseResource,
    KeyName = "requestName",
    NamePattern = ""
  >;
}

@armResourceOperations
interface DppBaseResourceOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = ResourceGuardResource,
          KeyName = "resourceGuardsName",
          SegmentName = "resourceGuards",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = DppBaseResource,
        KeyName = "requestName",
        SegmentName = "disableSoftDeleteRequests",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface ResourceGuardOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = ResourceGuardResource,
          KeyName = "resourceGuardsName",
          SegmentName = "resourceGuards",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = DppBaseResource,
        KeyName = "requestName",
        SegmentName = "deleteResourceGuardProxyRequests",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface ResourceGuards {
  /**
   * Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.
   */
  getDefaultDeleteResourceGuardProxyRequestsObject is ResourceGuardOps.Read<
    Resource = DppBaseResource,
    OverrideErrorType = CloudError
  >;

  /**
   * Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.
   */
  @action("deleteResourceGuardProxyRequests")
  getDeleteResourceGuardProxyRequestsObjects is ResourceGuardOps.List<
    DppBaseResource,
    Response = ArmResponse<DppBaseResourceList>,
    OverrideErrorType = CloudError
  >;
}
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface DppBaseResourceGetBackupSecurityPINOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = ResourceGuardResource,
          KeyName = "resourceGuardsName",
          SegmentName = "resourceGuards",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = DppBaseResource,
        KeyName = "requestName",
        SegmentName = "getBackupSecurityPINRequests",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface DppBaseResourceDeleteProtectedItemOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = ResourceGuardResource,
          KeyName = "resourceGuardsName",
          SegmentName = "resourceGuards",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = DppBaseResource,
        KeyName = "requestName",
        SegmentName = "deleteProtectedItemRequests",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface DppBaseResourceUpdateProtectionPolicyOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = ResourceGuardResource,
          KeyName = "resourceGuardsName",
          SegmentName = "resourceGuards",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = DppBaseResource,
        KeyName = "requestName",
        SegmentName = "updateProtectionPolicyRequests",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface DppBaseResourceUpdateProtectedItemOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = ResourceGuardResource,
          KeyName = "resourceGuardsName",
          SegmentName = "resourceGuards",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = DppBaseResource,
        KeyName = "requestName",
        SegmentName = "updateProtectedItemRequests",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface DppBaseResourceOperationGroup {
  /**
   * Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ResourceGuards_GetDefaultDisableSoftDeleteRequestsObject")
  getDefaultDisableSoftDeleteRequestsObject is DppBaseResourceOps.Read<
    Resource = DppBaseResource,
    OverrideErrorType = CloudError
  >;

  /**
   * Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ResourceGuards_GetDisableSoftDeleteRequestsObjects")
  @action("disableSoftDeleteRequests")
  getDisableSoftDeleteRequestsObjects is DppBaseResourceOps.List<
    DppBaseResource,
    Response = ArmResponse<DppBaseResourceList>,
    OverrideErrorType = CloudError
  >;
  /**
   * Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ResourceGuards_GetDefaultUpdateProtectedItemRequestsObject")
  getDefaultUpdateProtectedItemRequestsObject is DppBaseResourceUpdateProtectedItemOperationGroupOps.Read<
    Resource = DppBaseResource,
    OverrideErrorType = CloudError
  >;

  /**
   * Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("updateProtectedItemRequests")
  @operationId("ResourceGuards_GetUpdateProtectedItemRequestsObjects")
  getUpdateProtectedItemRequestsObjects is DppBaseResourceUpdateProtectedItemOperationGroupOps.List<
    DppBaseResource,
    Response = ArmResponse<DppBaseResourceList>,
    OverrideErrorType = CloudError
  >;

  /**
   * Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ResourceGuards_GetDefaultUpdateProtectionPolicyRequestsObject")
  getDefaultUpdateProtectionPolicyRequestsObject is DppBaseResourceUpdateProtectionPolicyOperationGroupOps.Read<
    Resource = DppBaseResource,
    OverrideErrorType = CloudError
  >;

  /**
   * Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("updateProtectionPolicyRequests")
  @operationId("ResourceGuards_GetUpdateProtectionPolicyRequestsObjects")
  getUpdateProtectionPolicyRequestsObjects is DppBaseResourceUpdateProtectionPolicyOperationGroupOps.List<
    DppBaseResource,
    Response = ArmResponse<DppBaseResourceList>,
    OverrideErrorType = CloudError
  >;

  /**
   * Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ResourceGuards_GetDefaultDeleteProtectedItemRequestsObject")
  getDefaultDeleteProtectedItemRequestsObject is DppBaseResourceDeleteProtectedItemOperationGroupOps.Read<
    Resource = DppBaseResource,
    OverrideErrorType = CloudError
  >;

  /**
   * Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ResourceGuards_GetDeleteProtectedItemRequestsObjects")
  @action("deleteProtectedItemRequests")
  getDeleteProtectedItemRequestsObjects is DppBaseResourceDeleteProtectedItemOperationGroupOps.List<
    DppBaseResource,
    Response = ArmResponse<DppBaseResourceList>,
    OverrideErrorType = CloudError
  >;

  /**
   * Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("ResourceGuards_GetDefaultBackupSecurityPINRequestsObject")
  getDefaultBackupSecurityPINRequestsObject is DppBaseResourceGetBackupSecurityPINOperationGroupOps.Read<
    Resource = DppBaseResource,
    OverrideErrorType = CloudError
  >;

  /**
   * Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("getBackupSecurityPINRequests")
  @operationId("ResourceGuards_GetBackupSecurityPINRequestsObjects")
  getBackupSecurityPINRequestsObjects is DppBaseResourceGetBackupSecurityPINOperationGroupOps.List<
    DppBaseResource,
    Response = ArmResponse<DppBaseResourceList>,
    OverrideErrorType = CloudError
  >;
}

@@doc(DppBaseResource.name, "");
