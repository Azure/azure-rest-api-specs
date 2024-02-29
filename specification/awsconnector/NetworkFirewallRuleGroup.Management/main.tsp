import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "../shared/main.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;
using Azure.Core;
using Azure.ResourceManager;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Supress missing operations endpoint as the same is defined ../operations/main.tsp."
@armProviderNamespace
@service({
  title: "Microsoft.AwsConnector",
  version: "2024-08-01-preview",
})
@doc("Microsoft.AwsConnector Resource Provider management API.")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.AwsConnector;

//---------------------------------------------- NetworkFirewallRuleGroups ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
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
@doc("Definition of NetworkFirewallRuleGroup")
model NetworkFirewallRuleGroupProperties {
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsNetworkFirewallRuleGroupProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of awsNetworkFirewallRuleGroup")
model AwsNetworkFirewallRuleGroupProperties {
  @doc("Gets and sets the property capacity.")
  capacity?: int32;

  @doc("Gets and sets the property description.")
  description?: string;

  @doc("Gets and sets the property ruleGroup.")
  ruleGroup?: RuleGroup;

  @doc("Gets and sets the property ruleGroupArn. A resource ARN.")
  ruleGroupArn?: string;

  @doc("Gets and sets the property ruleGroupId.")
  ruleGroupId?: string;

  @doc("Gets and sets the property ruleGroupName.")
  ruleGroupName?: string;

  @doc("Gets and sets the property tags.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("Gets and sets the property type.")
  type?: Type;
}

@doc("Type enum")
enum Type {
  @doc("Type enum STATEFUL")
  STATEFUL: "STATEFUL",

  @doc("Type enum STATELESS")
  STATELESS: "STATELESS",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of RuleGroup")
model RuleGroup {
  @doc("Gets and sets the property referenceSets.")
  referenceSets?: ReferenceSets;

  @doc("Gets and sets the property ruleVariables.")
  ruleVariables?: RuleVariables;

  @doc("Gets and sets the property rulesSource.")
  rulesSource?: RulesSource;

  @doc("Gets and sets the property statefulRuleOptions.")
  statefulRuleOptions?: StatefulRuleOptions;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of Tag")
model Tag {
  @doc("Gets and sets the property key.")
  key?: string;

  @doc("Gets and sets the property value.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of ReferenceSets")
model ReferenceSets {
  @doc("Gets and sets the property iPSetReferences.")
  iPSetReferences?: Record<IPSetReference>;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of RuleVariables")
model RuleVariables {
  @doc("Gets and sets the property iPSets.")
  iPSets?: Record<IPSet>;

  @doc("Gets and sets the property portSets.")
  portSets?: Record<PortSet>;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of RulesSource")
model RulesSource {
  @doc("Gets and sets the property rulesSourceList.")
  rulesSourceList?: RulesSourceList;

  @doc("Gets and sets the property rulesString.")
  rulesString?: string;

  @doc("Gets and sets the property statefulRules.")
  @extension("x-ms-identifiers", [])
  statefulRules?: StatefulRule[];

  @doc("Gets and sets the property statelessRulesAndCustomActions.")
  statelessRulesAndCustomActions?: StatelessRulesAndCustomActions;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of StatefulRuleOptions")
model StatefulRuleOptions {
  @doc("Gets and sets the property ruleOrder.")
  ruleOrder?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of IPSetReference")
model IPSetReference {
  @doc("Gets and sets the property referenceArn. A resource ARN.")
  referenceArn?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of IPSet")
model IPSet {
  @doc("Gets and sets the property definition.")
  @extension("x-ms-identifiers", [])
  definition?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of PortSet")
model PortSet {
  @doc("Gets and sets the property definition.")
  @extension("x-ms-identifiers", [])
  definition?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of RulesSourceList")
model RulesSourceList {
  @doc("Gets and sets the property generatedRulesType.")
  generatedRulesType?: string;

  @doc("Gets and sets the property targetTypes.")
  @extension("x-ms-identifiers", [])
  targetTypes?: string[];

  @doc("Gets and sets the property targets.")
  @extension("x-ms-identifiers", [])
  targets?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of StatefulRule")
model StatefulRule {
  @doc("Gets and sets the property action.")
  action?: StatefulRuleAction;

  @doc("Gets and sets the property header.")
  header?: Header;

  @doc("Gets and sets the property ruleOptions.")
  @extension("x-ms-identifiers", [])
  ruleOptions?: RuleOption[];
}

@doc("StatefulRuleAction enum")
enum StatefulRuleAction {
  @doc("StatefulRuleAction enum ALERT")
  ALERT: "ALERT",

  @doc("StatefulRuleAction enum DROP")
  DROP: "DROP",

  @doc("StatefulRuleAction enum PASS")
  PASS: "PASS",

  @doc("StatefulRuleAction enum REJECT")
  REJECT: "REJECT",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of StatelessRulesAndCustomActions")
model StatelessRulesAndCustomActions {
  @doc("Gets and sets the property customActions.")
  @extension("x-ms-identifiers", [])
  customActions?: CustomAction[];

  @doc("Gets and sets the property statelessRules.")
  @extension("x-ms-identifiers", [])
  statelessRules?: StatelessRule[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of Header")
model Header {
  @doc("Gets and sets the property destination.")
  destination?: string;

  @doc("Gets and sets the property destinationPort.")
  destinationPort?: string;

  @doc("Gets and sets the property direction.")
  direction?: HeaderDirection;

  @doc("Gets and sets the property protocol.")
  protocol?: HeaderProtocol;

  @doc("Gets and sets the property source.")
  source?: string;

  @doc("Gets and sets the property sourcePort.")
  sourcePort?: string;
}

@doc("HeaderDirection enum")
enum HeaderDirection {
  @doc("HeaderDirection enum ANY")
  ANY: "ANY",

  @doc("HeaderDirection enum FORWARD")
  FORWARD: "FORWARD",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of RuleOption")
model RuleOption {
  @doc("Gets and sets the property keyword.")
  keyword?: string;

  @doc("Gets and sets the property settings.")
  @extension("x-ms-identifiers", [])
  settings?: string[];
}

@doc("HeaderProtocol enum")
enum HeaderProtocol {
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
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of CustomAction")
model CustomAction {
  @doc("Gets and sets the property actionDefinition.")
  actionDefinition?: ActionDefinition;

  @doc("Gets and sets the property actionName.")
  actionName?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of StatelessRule")
model StatelessRule {
  @doc("Gets and sets the property priority.")
  priority?: int32;

  @doc("Gets and sets the property ruleDefinition.")
  ruleDefinition?: RuleDefinition;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of ActionDefinition")
model ActionDefinition {
  @doc("Gets and sets the property publishMetricAction.")
  publishMetricAction?: PublishMetricAction;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of RuleDefinition")
model RuleDefinition {
  @doc("Gets and sets the property actions.")
  @extension("x-ms-identifiers", [])
  actions?: string[];

  @doc("Gets and sets the property matchAttributes.")
  matchAttributes?: MatchAttributes;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of PublishMetricAction")
model PublishMetricAction {
  @doc("Gets and sets the property dimensions.")
  @extension("x-ms-identifiers", [])
  dimensions?: Dimension[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of MatchAttributes")
model MatchAttributes {
  @doc("Gets and sets the property destinationPorts.")
  @extension("x-ms-identifiers", [])
  destinationPorts?: PortRange[];

  @doc("Gets and sets the property destinations.")
  @extension("x-ms-identifiers", [])
  destinations?: Address[];

  @doc("Gets and sets the property protocols.")
  @extension("x-ms-identifiers", [])
  protocols?: int32[];

  @doc("Gets and sets the property sourcePorts.")
  @extension("x-ms-identifiers", [])
  sourcePorts?: PortRange[];

  @doc("Gets and sets the property sources.")
  @extension("x-ms-identifiers", [])
  sources?: Address[];

  @doc("Gets and sets the property tCPFlags.")
  @extension("x-ms-identifiers", [])
  tCPFlags?: TCPFlagField[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of Dimension")
model Dimension {
  @doc("Gets and sets the property value.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of PortRange")
model PortRange {
  @doc("Gets and sets the property fromPort.")
  fromPort?: int32;

  @doc("Gets and sets the property toPort.")
  toPort?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of Address")
model Address {
  @doc("Gets and sets the property addressDefinition.")
  addressDefinition?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of TCPFlagField")
model TCPFlagField {
  @doc("Gets and sets the property flags.")
  @extension("x-ms-identifiers", [])
  flags?: string[];

  @doc("Gets and sets the property masks.")
  @extension("x-ms-identifiers", [])
  masks?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface NetworkFirewallRuleGroups {
  get is ArmResourceRead<NetworkFirewallRuleGroup>;
  @doc("Create a NetworkFirewallRuleGroup. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<NetworkFirewallRuleGroup>;
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
