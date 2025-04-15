import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.PortalServices;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Available values for the Multi-factor authentication enforcement behavior.")
union MfaEnforcement {
  string,

  @doc("Use the default Multi-factor authentication enforcement behavior.")
  "Default",

  @doc("This tenant is opted out of Multi-factor authentication enforcement.")
  "OptOut",

  @doc("Multi-factor authentication is required.")
  "Enforce",
}

@doc("Available values for a Feedback Control Policy state.")
union FeedbackControlPolicyState {
  string,

  @doc("Enabled state is not explicitly specified. This is the default state.")
  NotConfigured: "NotConfigured",

  @doc("Control Policy has been explicitly enabled by an admin.")
  Enabled: "Enabled",

  @doc("Control Policy has been explicitly disabled by an admin.")
  Disabled: "Disabled",
}

@doc("Multi-Factor Authentication settings.")
model MultiFactorAuthenticationSettings {
  @doc("The setting for Multi-Factor Authentication enforcement when signing into this tenant.")
  portalEnforcement?: MfaEnforcement;

  @doc("Justification for the value set for portalEnforcement. Required when portalEnforcement is set to a value other than 'Default'. Maximum length is 500 characters.")
  portalJustification?: string;

  @doc("The date and time when the enforcement setting in portalEnforcement should be applied.")
  portalEnforcementDate?: utcDateTime;

  @added(Versions.v2025_04_01_preview)
  @doc("The UTC date and time in ISO8601 format when multi-factor authentication will be required to use ARM APIs in the tenant.")
  armEnforcementDate?: utcDateTime;

  @added(Versions.v2025_04_01_preview)
  @doc("Optional justification for the date and time set in armEnforcementDate. Maximum length is 500 characters.")
  armJustification?: string;
}

@doc("Settings related to feedback control policies.")
model FeedbackControlPolicySettings {
  @doc("Allow Microsoft feedback data from users in the tenant to be used in connected experiences, such as AI analysis on feedback.")
  connectedExperiences?: FeedbackControlPolicyState;

  @doc("Allow users to submit feedback to Microsoft.")
  policyAllowFeedback?: FeedbackControlPolicyState;

  @doc("Allow Microsoft to issue survey prompts to users.")
  policyAllowSurvey?: FeedbackControlPolicyState;

  @doc("Allow users to include screenshots, screen recordings, and attachments when submitting feedback to Microsoft.")
  policyAllowScreenshot?: FeedbackControlPolicyState;

  @doc("Allow Microsoft to follow up with users on submitted feedback.")
  policyAllowContact?: FeedbackControlPolicyState;

  @doc("Allow users to include additional log files and content samples with submitted feedback.")
  policyAllowContent?: FeedbackControlPolicyState;

  @doc("A value indicating whether email collection is selected by default when the user launches feedback experiences. This setting is only applicable when policyAllowContact is not set to Disabled.")
  policyEmailCollectionDefault?: FeedbackControlPolicyState;

  @doc("A value indicating whether the screenshot checkbox is selected by default when the user launches feedback experiences. This setting is only applicable when policyAllowScreenshot is not set to Disabled.")
  policyScreenshotDefault?: FeedbackControlPolicyState;

  @doc("A value indicating whether the content samples checkbox is selected by default when the user launches feedback experiences. This setting is not applicable when policyAllowContent is set to Disabled.")
  policyContentSamplesDefault?: FeedbackControlPolicyState;
}

@doc("The Azure Portal tenant-level settings properties.")
model SettingsProperties {
  @added(Versions.v2024_09_01_preview)
  @doc("Multi-factor authentication settings for all Azure Portal users in the tenant.")
  multiFactorAuthentication?: MultiFactorAuthenticationSettings;

  @added(Versions.v2024_09_01_preview)
  @doc("Settings related to feedback control policies for all Azure Portal users in the tenant.")
  feedbackControlPolicy?: FeedbackControlPolicySettings;

  @doc("The status of the last provisioning operation performed on the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}
