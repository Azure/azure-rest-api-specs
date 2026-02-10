import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.KeyVault;

/**
 * Direction of Access Rule
 */
union AccessRuleDirection {
  string,

  /** Applies to inbound network traffic to the secured resources. */
  Inbound: "Inbound",

  /** Applies to outbound network traffic from the secured resources */
  Outbound: "Outbound",
}

/**
 * Provisioning state of a network security perimeter configuration that is being created or updated.
 */
union NetworkSecurityPerimeterConfigurationProvisioningState {
  string,

  /** The configuration has been successfully applied. */
  Succeeded: "Succeeded",

  /** The configuration is currently being created. */
  Creating: "Creating",

  /** The configuration is currently being updated. */
  Updating: "Updating",

  /** The configuration is currently being deleted. */
  Deleting: "Deleting",

  /** The configuration has been accepted for processing. */
  Accepted: "Accepted",

  /** The configuration operation has failed. */
  Failed: "Failed",

  /** The configuration operation has been canceled. */
  Canceled: "Canceled",
}

/**
 * Access mode of the resource association
 */
union ResourceAssociationAccessMode {
  string,

  /** Enforced access mode - traffic to the resource that failed access checks is blocked */
  Enforced: "Enforced",

  /** Learning access mode - traffic to the resource is enabled for analysis but not blocked */
  Learning: "Learning",

  /** Audit access mode - traffic to the resource that fails access checks is logged but not blocked */
  Audit: "Audit",
}

/**
 * Type of issue
 */
union IssueType {
  string,

  /** Unknown issue type */
  Unknown: "Unknown",

  /** An error occurred while applying the network security perimeter (NSP) configuration. */
  ConfigurationPropagationFailure: "ConfigurationPropagationFailure",

  /** A network connectivity issue is happening on the resource which could be addressed either by adding new resources to the network security perimeter (NSP) or by modifying access rules. */
  MissingPerimeterConfiguration: "MissingPerimeterConfiguration",

  /** An managed identity hasn't been associated with the resource. The resource will still be able to validate inbound traffic from the network security perimeter (NSP) or matching inbound access rules, but it won't be able to perform outbound access as a member of the NSP. */
  MissingIdentityConfiguration: "MissingIdentityConfiguration",
}

/**
 * Severity of the issue.
 */
union Severity {
  string,

  /** Warning level issue */
  Warning: "Warning",

  /** Error level issue */
  Error: "Error",
}

/**
 * Network security perimeter (NSP) configuration resource
 */
model NetworkSecurityPerimeterConfiguration
  extends Azure.ResourceManager.ProxyResource<
    NetworkSecurityPerimeterConfigurationProperties,
    true
  > {}

/**
 * Network security configuration properties.
 */
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
  provisioningIssues?: ProvisioningIssue[];

  /**
   * Information about the network security perimeter (NSP)
   */
  networkSecurityPerimeter?: NetworkSecurityPerimeter;

  /**
   * Information about resource association
   */
  resourceAssociation?: ResourceAssociation;

  /**
   * Network security perimeter configuration profile
   */
  profile?: NetworkSecurityProfile;
}

/**
 * Result of a list NSP (network security perimeter) configurations request.
 */
model NetworkSecurityPerimeterConfigurationListResult {
  /**
   * Array of network security perimeter results.
   */
  value?: NetworkSecurityPerimeterConfiguration[];

  /**
   * The link used to get the next page of results.
   */
  @format("uri")
  nextLink?: string;
}

/**
 * Information about a network security perimeter (NSP)
 */
model NetworkSecurityPerimeter {
  /**
   * Fully qualified Azure resource ID of the NSP resource
   */
  @format("arm-id")
  id?: string;

  /**
   * Universal unique ID (UUID) of the network security perimeter
   */
  @format("uuid")
  perimeterGuid?: string;

  /**
   * Location of the network security perimeter
   */
  location?: string;
}

/**
 * Information about resource association
 */
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
model NetworkSecurityProfile {
  /**
   * Name of the profile
   */
  name?: string;

  /**
   * Current access rules version
   */
  accessRulesVersion?: int32;

  /**
   * List of Access Rules
   */
  accessRules?: AccessRule[];

  /**
   * Current diagnostic settings version
   */
  diagnosticSettingsVersion?: int32;

  /**
   * List of log categories that are enabled
   */
  enabledLogCategories?: string[];
}

/**
 * Access rule in a network security perimeter configuration profile
 */
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
model AccessRuleProperties {
  /**
   * Direction of Access Rule
   */
  direction?: AccessRuleDirection;

  /**
   * Address prefixes in the CIDR format for inbound rules
   */
  addressPrefixes?: string[];

  /**
   * Subscriptions for inbound rules
   */
  subscriptions?: SubscriptionIdentifier[];

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
}

/**
 * Subscription identifiers
 */
model SubscriptionIdentifier {
  /**
   * The fully qualified Azure resource ID of the subscription e.g. ('/subscriptions/00000000-0000-0000-0000-000000000000')
   */
  id?: string;
}

/**
 * Describes a provisioning issue for a network security perimeter configuration
 */
model ProvisioningIssue {
  /**
   * Name of the issue
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Properties of the provisioning issue
   */
  properties?: ProvisioningIssueProperties;
}

/**
 * Details of a provisioning issue for a network security perimeter (NSP) configuration. Resource providers should generate separate provisioning issue elements for each separate issue detected, and include a meaningful and distinctive description, as well as any appropriate suggestedResourceIds and suggestedAccessRules
 */
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
  suggestedResourceIds?: string[];

  /**
   * Access rules that can be added to the network security profile (NSP) to remediate the issue.
   */
  @visibility(Lifecycle.Read)
  suggestedAccessRules?: AccessRule[];
}

@armResourceOperations
interface NetworkSecurityPerimeterConfigurations {
  /**
   * Gets the specified network security perimeter configuration.
   */
  get is ArmResourceRead<
    NetworkSecurityPerimeterConfiguration,
    Response = ArmResponse<NetworkSecurityPerimeterConfiguration> | ArmNoContentResponse,
    Error = CloudError
  >;

  /**
   * Lists the network security perimeter configurations for the specified vault.
   */
  list is ArmResourceListByParent<
    NetworkSecurityPerimeterConfiguration,
    Parameters = {},
    Error = CloudError
  >;
}
