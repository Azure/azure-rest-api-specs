import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.AppConfiguration;

// Local Network Security Perimeter types, introduced in 2026-09-01-preview.
// Earlier versions continue to use the ARM common-types v5 NSP shape via
// @typeChangedFrom on NetworkSecurityPerimeterConfiguration.properties.

/**
 * Direction of Access Rule
 */
@added(Versions.v2026_09_01_preview)
union AccessRuleDirection {
  string,

  /**
   * Applies to inbound network traffic to the secured resources.
   */
  Inbound: "Inbound",

  /**
   * Applies to outbound network traffic from the secured resources
   */
  Outbound: "Outbound",
}

/**
 * Provisioning state of a network security perimeter configuration that is being created or updated.
 */
@added(Versions.v2026_09_01_preview)
union NetworkSecurityPerimeterConfigurationProvisioningState {
  string,

  /**
   * The configuration was provisioned successfully.
   */
  Succeeded: "Succeeded",

  /**
   * The configuration is being created.
   */
  Creating: "Creating",

  /**
   * The configuration is being updated.
   */
  Updating: "Updating",

  /**
   * The configuration is being deleted.
   */
  Deleting: "Deleting",

  /**
   * The configuration request was accepted and provisioning has not started yet.
   */
  Accepted: "Accepted",

  /**
   * The configuration failed to provision.
   */
  Failed: "Failed",

  /**
   * The configuration provisioning was canceled.
   */
  Canceled: "Canceled",
}

/**
 * Type of issue
 */
@added(Versions.v2026_09_01_preview)
union IssueType {
  string,

  /**
   * Unknown issue type
   */
  Unknown: "Unknown",

  /**
   * An error occurred while applying the network security perimeter (NSP) configuration.
   */
  ConfigurationPropagationFailure: "ConfigurationPropagationFailure",

  /**
   * A network connectivity issue is happening on the resource which could be addressed either by adding new resources to the network security perimeter (NSP) or by modifying access rules.
   */
  MissingPerimeterConfiguration: "MissingPerimeterConfiguration",

  /**
   * An managed identity hasn't been associated with the resource. The resource will still be able to validate inbound traffic from the network security perimeter (NSP) or matching inbound access rules, but it won't be able to perform outbound access as a member of the NSP.
   */
  MissingIdentityConfiguration: "MissingIdentityConfiguration",
}

/**
 * Severity of the issue.
 */
@added(Versions.v2026_09_01_preview)
union Severity {
  string,

  /**
   * The issue is a warning and does not prevent the configuration from being applied.
   */
  Warning: "Warning",

  /**
   * The issue is an error and prevents the configuration from being applied.
   */
  Error: "Error",
}

/**
 * Access mode of the resource association
 */
@added(Versions.v2026_09_01_preview)
union ResourceAssociationAccessMode {
  string,

  /**
   * Enforced access mode - traffic to the resource that failed access checks is blocked
   */
  Enforced: "Enforced",

  /**
   * Learning access mode - traffic to the resource is enabled for analysis but not blocked
   */
  Learning: "Learning",

  /**
   * Audit access mode - traffic to the resource that fails access checks is logged but not blocked
   */
  Audit: "Audit",
}

/**
 * Access rule in a network security perimeter configuration profile
 */
@added(Versions.v2026_09_01_preview)
model AccessRule {
  /**
   * Name of the access rule
   */
  name?: string;

  /**
   * Properties of the access rule
   */
  properties?: AccessRuleProperties;
}

/**
 * Properties of Access Rule
 */
@added(Versions.v2026_09_01_preview)
model AccessRuleProperties {
  /**
   * Direction of the access rule
   */
  direction?: AccessRuleDirection;

  /**
   * Address prefixes in the CIDR format for inbound rules
   */
  addressPrefixes?: string[];

  /**
   * Subscriptions for inbound rules
   */
  subscriptions?: {
    /**
     * The fully qualified Azure resource ID of the subscription e.g. ('/subscriptions/00000000-0000-0000-0000-000000000000')
     */
    id?: Azure.Core.armResourceIdentifier;
  }[];

  /**
   * Network security perimeters for inbound rules
   */
  networkSecurityPerimeters?: NetworkSecurityPerimeter[];

  /**
   * Fully qualified domain names (FQDN) for outbound rules
   */
  fullyQualifiedDomainNames?: string[];

  /**
   * Email addresses for outbound rules
   */
  emailAddresses?: string[];

  /**
   * Phone numbers for outbound rules
   */
  phoneNumbers?: string[];

  /**
   * Inbound rules of type service tag. This access rule type is currently unavailable for use.
   */
  serviceTags?: string[];
}

/**
 * Information about a network security perimeter (NSP)
 */
@added(Versions.v2026_09_01_preview)
model NetworkSecurityPerimeter {
  /**
   * Fully qualified Azure resource ID of the NSP resource
   */
  id?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/networkSecurityPerimeters";
    }
  ]>;

  /**
   * Universal unique ID (UUID) of the network security perimeter
   */
  perimeterGuid?: string;

  /**
   * Location of the network security perimeter
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;
}

/**
 * Describes a provisioning issue for a network security perimeter configuration
 */
@added(Versions.v2026_09_01_preview)
model ProvisioningIssue {
  /**
   * Name of the issue
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Details of the provisioning issue
   */
  @visibility(Lifecycle.Read)
  properties?: ProvisioningIssueProperties;
}

/**
 * Details of a provisioning issue for a network security perimeter (NSP) configuration. Resource providers should generate separate provisioning issue elements for each separate issue detected, and include a meaningful and distinctive description, as well as any appropriate suggestedResourceIds and suggestedAccessRules
 */
@added(Versions.v2026_09_01_preview)
model ProvisioningIssueProperties {
  /**
   * Type of issue
   */
  @visibility(Lifecycle.Read)
  issueType?: IssueType;

  /**
   * Severity of the issue.
   */
  @visibility(Lifecycle.Read)
  severity?: Severity;

  /**
   * Description of the issue
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * Fully qualified resource IDs of suggested resources that can be associated to the network security perimeter (NSP) to remediate the issue.
   */
  @visibility(Lifecycle.Read)
  suggestedResourceIds?: Azure.Core.armResourceIdentifier[];

  /**
   * Access rules that can be added to the network security profile (NSP) to remediate the issue.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  suggestedAccessRules?: AccessRule[];
}

/**
 * Information about resource association
 */
@added(Versions.v2026_09_01_preview)
model ResourceAssociation {
  /**
   * Name of the resource association
   */
  name?: string;

  /**
   * Access mode of the resource association
   */
  accessMode?: ResourceAssociationAccessMode;
}

/**
 * Network security perimeter configuration profile
 */
@added(Versions.v2026_09_01_preview)
model NetworkSecurityProfile {
  /**
   * Name of the profile
   */
  name?: string;

  /**
   * Current access rules version
   */
  accessRulesVersion?: string;

  /**
   * List of Access Rules
   */
  @identifiers(#["name"])
  accessRules?: AccessRule[];

  /**
   * Current diagnostic settings version
   */
  diagnosticSettingsVersion?: string;

  /**
   * List of log categories that are enabled
   */
  enabledLogCategories?: string[];
}

/**
 * Network security configuration properties.
 */
@added(Versions.v2026_09_01_preview)
model NetworkSecurityPerimeterConfigurationProperties {
  /**
   * Provisioning state of the network security perimeter configuration
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkSecurityPerimeterConfigurationProvisioningState;

  /**
   * List of provisioning issues, if any
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  provisioningIssues?: ProvisioningIssue[];

  /**
   * Information about the network security perimeter (NSP)
   */
  networkSecurityPerimeter?: NetworkSecurityPerimeter;

  /**
   * Information about the resource association
   */
  resourceAssociation?: ResourceAssociation;

  /**
   * Network security perimeter configuration profile
   */
  profile?: NetworkSecurityProfile;
}
