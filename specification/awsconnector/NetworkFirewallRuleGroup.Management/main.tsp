import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-portal-core";
import "../shared/main.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;
using Azure.Core;
using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using Azure.Portal;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Supress missing operations endpoint as the same is defined ../operations/main.tsp."
@armProviderNamespace
@service({
  title: "Microsoft.AwsConnector",
})
@doc("Microsoft.AwsConnector Resource Provider management API.")
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.AwsConnector;

/** Api versions */
enum Versions {
  /** 2024-12-01 api version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  `2024-12-01`,
}

//---------------------------------------------- NetworkFirewallRuleGroups ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Network Firewall Rule Group",
    plural: "Network Firewall Rule Groups",
  },
  keywords: ["Microsoft.AwsConnector", "Network", "Firewall", "Rule", "Group"],
})
@doc("A Microsoft.AwsConnector resource")
model NetworkFirewallRuleGroup
  is TrackedResource<NetworkFirewallRuleGroupProperties> {
  @doc("Name of NetworkFirewallRuleGroup")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("networkFirewallRuleGroups")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of NetworkFirewallRuleGroup")
model NetworkFirewallRuleGroupProperties {
  @doc("AWS Properties")
  awsProperties?: AwsNetworkFirewallRuleGroupProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsNetworkFirewallRuleGroup")
model AwsNetworkFirewallRuleGroupProperties {
  @doc("Property capacity")
  capacity?: int32;

  @doc("Property description")
  description?: string;

  @doc("Property ruleGroup")
  ruleGroup?: RuleGroup;

  @doc("A resource ARN.")
  ruleGroupArn?: string;

  @doc("Property ruleGroupId")
  ruleGroupId?: string;

  @doc("Property ruleGroupName")
  ruleGroupName?: string;

  @doc("Property tags")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("Property type")
  type?: Type;
}

@doc("Type enum")
union Type {
  @doc("Type enum STATEFUL")
  STATEFUL: "STATEFUL",

  @doc("Type enum STATELESS")
  STATELESS: "STATELESS",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RuleGroup")
model RuleGroup {
  @doc("Property referenceSets")
  referenceSets?: ReferenceSets;

  @doc("Property ruleVariables")
  ruleVariables?: RuleVariables;

  @doc("Property rulesSource")
  rulesSource?: RulesSource;

  @doc("Property statefulRuleOptions")
  statefulRuleOptions?: StatefulRuleOptions;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("Property key")
  key?: string;

  @doc("Property value")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ReferenceSets")
model ReferenceSets {
  @doc("Property ipSetReferences")
  ipSetReferences?: Record<IPSetReference>;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RuleVariables")
model RuleVariables {
  @doc("Property ipSets")
  ipSets?: Record<IPSet>;

  @doc("Property portSets")
  portSets?: Record<PortSet>;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RulesSource")
model RulesSource {
  @doc("Property rulesSourceList")
  rulesSourceList?: RulesSourceList;

  @doc("Property rulesString")
  rulesString?: string;

  @doc("Property statefulRules")
  @extension("x-ms-identifiers", [])
  statefulRules?: StatefulRule[];

  @doc("Property statelessRulesAndCustomActions")
  statelessRulesAndCustomActions?: StatelessRulesAndCustomActions;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of StatefulRuleOptions")
model StatefulRuleOptions {
  @doc("Property ruleOrder")
  ruleOrder?: StatefulRuleOptionsRuleOrder;
}

@doc("StatefulRuleOptionsRuleOrder enum")
union StatefulRuleOptionsRuleOrder {
  @doc("StatefulRuleOptionsRuleOrder enum DEFAULT_ACTION_ORDER")
  DEFAULT_ACTION_ORDER: "DEFAULT_ACTION_ORDER",

  @doc("StatefulRuleOptionsRuleOrder enum STRICT_ORDER")
  STRICT_ORDER: "STRICT_ORDER",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of IPSetReference")
model IPSetReference {
  @doc("A resource ARN.")
  referenceArn?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of IPSet")
model IPSet {
  @doc("Property definition")
  @extension("x-ms-identifiers", [])
  definition?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PortSet")
model PortSet {
  @doc("Property definition")
  @extension("x-ms-identifiers", [])
  definition?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RulesSourceList")
model RulesSourceList {
  @doc("Property generatedRulesType")
  generatedRulesType?: RulesSourceListGeneratedRulesType;

  @doc("Property targetTypes")
  @extension("x-ms-identifiers", [])
  targetTypes?: string[];

  @doc("Property targets")
  @extension("x-ms-identifiers", [])
  targets?: string[];
}

@doc("RulesSourceListGeneratedRulesType enum")
union RulesSourceListGeneratedRulesType {
  @doc("RulesSourceListGeneratedRulesType enum ALLOWLIST")
  ALLOWLIST: "ALLOWLIST",

  @doc("RulesSourceListGeneratedRulesType enum DENYLIST")
  DENYLIST: "DENYLIST",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of StatefulRule")
model StatefulRule {
  @doc("Property action")
  action?: StatefulRuleAction;

  @doc("Property header")
  header?: Header;

  @doc("Property ruleOptions")
  @extension("x-ms-identifiers", [])
  ruleOptions?: RuleOption[];
}

@doc("StatefulRuleAction enum")
union StatefulRuleAction {
  @doc("StatefulRuleAction enum ALERT")
  ALERT: "ALERT",

  @doc("StatefulRuleAction enum DROP")
  DROP: "DROP",

  @doc("StatefulRuleAction enum PASS")
  PASS: "PASS",

  @doc("StatefulRuleAction enum REJECT")
  REJECT: "REJECT",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of StatelessRulesAndCustomActions")
model StatelessRulesAndCustomActions {
  @doc("Property customActions")
  @extension("x-ms-identifiers", [])
  customActions?: CustomAction[];

  @doc("Property statelessRules")
  @extension("x-ms-identifiers", [])
  statelessRules?: StatelessRule[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Header")
model Header {
  @doc("Property destination")
  destination?: string;

  @doc("Property destinationPort")
  destinationPort?: string;

  @doc("Property direction")
  direction?: HeaderDirection;

  @doc("Property protocol")
  protocol?: HeaderProtocol;

  @doc("Property source")
  source?: string;

  @doc("Property sourcePort")
  sourcePort?: string;
}

@doc("HeaderDirection enum")
union HeaderDirection {
  @doc("HeaderDirection enum ANY")
  ANY: "ANY",

  @doc("HeaderDirection enum FORWARD")
  FORWARD: "FORWARD",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RuleOption")
model RuleOption {
  @doc("Property keyword")
  keyword?: string;

  @doc("Property settings")
  @extension("x-ms-identifiers", [])
  settings?: string[];
}

@doc("HeaderProtocol enum")
union HeaderProtocol {
  @doc("HeaderProtocol enum DCERPC")
  DCERPC: "DCERPC",

  @doc("HeaderProtocol enum DHCP")
  DHCP: "DHCP",

  @doc("HeaderProtocol enum DNS")
  DNS: "DNS",

  @doc("HeaderProtocol enum FTP")
  FTP: "FTP",

  @doc("HeaderProtocol enum HTTP")
  HTTP: "HTTP",

  @doc("HeaderProtocol enum ICMP")
  ICMP: "ICMP",

  @doc("HeaderProtocol enum IKEV2")
  IKEV2: "IKEV2",

  @doc("HeaderProtocol enum IMAP")
  IMAP: "IMAP",

  @doc("HeaderProtocol enum IP")
  IP: "IP",

  @doc("HeaderProtocol enum KRB5")
  KRB5: "KRB5",

  @doc("HeaderProtocol enum MSN")
  MSN: "MSN",

  @doc("HeaderProtocol enum NTP")
  NTP: "NTP",

  @doc("HeaderProtocol enum SMB")
  SMB: "SMB",

  @doc("HeaderProtocol enum SMTP")
  SMTP: "SMTP",

  @doc("HeaderProtocol enum SSH")
  SSH: "SSH",

  @doc("HeaderProtocol enum TCP")
  TCP: "TCP",

  @doc("HeaderProtocol enum TFTP")
  TFTP: "TFTP",

  @doc("HeaderProtocol enum TLS")
  TLS: "TLS",

  @doc("HeaderProtocol enum UDP")
  UDP: "UDP",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CustomAction")
model CustomAction {
  @doc("Property actionDefinition")
  actionDefinition?: ActionDefinition;

  @doc("Property actionName")
  actionName?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of StatelessRule")
model StatelessRule {
  @doc("Property priority")
  priority?: int32;

  @doc("Property ruleDefinition")
  ruleDefinition?: RuleDefinition;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ActionDefinition")
model ActionDefinition {
  @doc("Property publishMetricAction")
  publishMetricAction?: PublishMetricAction;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RuleDefinition")
model RuleDefinition {
  @doc("Property actions")
  @extension("x-ms-identifiers", [])
  actions?: string[];

  @doc("Property matchAttributes")
  matchAttributes?: MatchAttributes;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PublishMetricAction")
model PublishMetricAction {
  @doc("Property dimensions")
  @extension("x-ms-identifiers", [])
  dimensions?: Dimension[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of MatchAttributes")
model MatchAttributes {
  @doc("Property destinationPorts")
  @extension("x-ms-identifiers", [])
  destinationPorts?: PortRange[];

  @doc("Property destinations")
  @extension("x-ms-identifiers", [])
  destinations?: Address[];

  @doc("Property protocols")
  @extension("x-ms-identifiers", [])
  protocols?: int32[];

  @doc("Property sourcePorts")
  @extension("x-ms-identifiers", [])
  sourcePorts?: PortRange[];

  @doc("Property sources")
  @extension("x-ms-identifiers", [])
  sources?: Address[];

  @doc("Property tcpFlags")
  @extension("x-ms-identifiers", [])
  tcpFlags?: TCPFlagField[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Dimension")
model Dimension {
  @doc("Property value")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PortRange")
model PortRange {
  @doc("Property fromPort")
  fromPort?: int32;

  @doc("Property toPort")
  toPort?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Address")
model Address {
  @doc("Property addressDefinition")
  addressDefinition?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of TCPFlagField")
model TCPFlagField {
  @doc("Property flags")
  @extension("x-ms-identifiers", [])
  flags?: string[];

  @doc("Property masks")
  @extension("x-ms-identifiers", [])
  masks?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface NetworkFirewallRuleGroups {
  get is ArmResourceRead<NetworkFirewallRuleGroup>;
  @doc("Create a NetworkFirewallRuleGroup. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<NetworkFirewallRuleGroup>;
  update is ArmCustomPatchAsync<
    NetworkFirewallRuleGroup,
    Azure.ResourceManager.Foundations.TagsUpdateModel<NetworkFirewallRuleGroup>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<NetworkFirewallRuleGroup>;
  listByResourceGroup is ArmResourceListByParent<NetworkFirewallRuleGroup>;
  listBySubscription is ArmListBySubscription<NetworkFirewallRuleGroup>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::NetworkFirewall::RuleGroup
//--------------------------------------------------------------------------------------------
