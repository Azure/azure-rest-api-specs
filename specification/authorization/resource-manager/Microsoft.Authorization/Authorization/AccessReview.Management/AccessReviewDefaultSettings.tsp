import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Authorization;
/**
 * Access Review Default Settings.
 */
@singleton("default")
@subscriptionResource
model AccessReviewDefaultSettings
  is Azure.ResourceManager.ProxyResource<AccessReviewScheduleSettings> {
  ...ResourceNameParameter<
    Resource = AccessReviewDefaultSettings,
    KeyName = "accessReviewScheduleSetting",
    SegmentName = "accessReviewScheduleSettings",
    NamePattern = ""
  >;
}

alias AccessReviewDefaultSettingsOperationGroupOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Authorization";
  },
  {},
  {
    /** undefined */
    @path
    @segment("accessReviewScheduleSettings")
    @key
    default: string;
  }
>;

@armResourceOperations
interface AccessReviewDefaultSettingsOperationGroup {
  /**
   * Get access review default settings for the subscription
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AccessReviewDefaultSettings_Get")
  get is AccessReviewDefaultSettingsOperationGroupOps.Read<AccessReviewDefaultSettings>;

  /**
   * Get access review default settings for the subscription
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("AccessReviewDefaultSettings_Put")
  put is AccessReviewDefaultSettingsOperationGroupOps.CreateOrUpdateSync<
    AccessReviewDefaultSettings,
    Request = AccessReviewScheduleSettings,
    Response = ArmResourceUpdatedResponse<AccessReviewDefaultSettings>
  >;
}
alias ScopeAccessReviewDefaultSettingOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** undefined */
    @path
    @segment("")
    @key
    scope: string;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Authorization";
  },
  {},
  {
    /** undefined */
    @path
    @segment("accessReviewScheduleSettings")
    @key
    default: string;
  }
>;

@armResourceOperations
interface ScopeAccessReviewDefaultSettings {
  /**
   * Get access review default settings for the subscription
   */
  get is ScopeAccessReviewDefaultSettingOps.Read<
    Extension.ScopeParameter,
    AccessReviewDefaultSettings
  >;

  /**
   * Get access review default settings for the subscription
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  put is ScopeAccessReviewDefaultSettingOps.CreateOrUpdateSync<
    Extension.ScopeParameter,
    AccessReviewDefaultSettings,
    Request = AccessReviewScheduleSettings,
    Response = ArmResourceUpdatedResponse<AccessReviewDefaultSettings>
  >;
}

@@doc(AccessReviewDefaultSettings.name, "");
@@doc(AccessReviewDefaultSettings.properties, "Access Review properties.");
@@doc(AccessReviewDefaultSettingsOperationGroup.put::parameters.resource,
  "Access review schedule settings."
);
@@doc(ScopeAccessReviewDefaultSettings.put::parameters.resource,
  "Access review schedule settings."
);
