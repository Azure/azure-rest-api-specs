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

//---------------------------------------------- Route53ResourceRecordSets ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Route 53 Resource Record Set",
    plural: "Route 53 Resource Record Sets",
  },
  keywords: ["Microsoft.AwsConnector", "Route 53", "Resource", "Record", "Set"],
})
@doc("A Microsoft.AwsConnector resource")
model Route53ResourceRecordSet
  is TrackedResource<Route53ResourceRecordSetProperties> {
  @doc("Name of Route53ResourceRecordSet")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("route53ResourceRecordSets")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Route53ResourceRecordSet")
model Route53ResourceRecordSetProperties {
  @doc("AWS Properties")
  awsProperties?: AwsRoute53ResourceRecordSetProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsRoute53ResourceRecordSet")
model AwsRoute53ResourceRecordSetProperties {
  @doc("<p> <i>Alias resource record sets only:</i> Information about the Amazon Web Services resource, such as a CloudFront distribution or an Amazon S3 bucket, that you want to route traffic to. </p> <p>If you're creating resource records sets for a private hosted zone, note the following:</p> <ul> <li> <p>You can't create an alias resource record set in a private hosted zone to route traffic to a CloudFront distribution.</p> </li> <li> <p>For information about creating failover resource record sets in a private hosted zone, see <a href='https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/dns-failover-private-hosted-zones.html'>Configuring Failover in a Private Hosted Zone</a> in the <i>Amazon Route 53 Developer Guide</i>.</p> </li> </ul>")
  aliasTarget?: AliasTarget;

  @doc("Property cidrRoutingConfig")
  cidrRoutingConfig?: CidrRoutingConfig;

  @doc("<p> <i>Failover resource record sets only:</i> To configure failover, you add the <code>Failover</code> element to two resource record sets. For one resource record set, you specify <code>PRIMARY</code> as the value for <code>Failover</code>; for the other resource record set, you specify <code>SECONDARY</code>. In addition, you include the <code>HealthCheckId</code> element and specify the health check that you want Amazon Route 53 to perform for each resource record set.</p> <p>Except where noted, the following failover behaviors assume that you have included the <code>HealthCheckId</code> element in both resource record sets:</p> <ul> <li> <p>When the primary resource record set is healthy, Route 53 responds to DNS queries with the applicable value from the primary resource record set regardless of the health of the secondary resource record set.</p> </li> <li> <p>When the primary resource record set is unhealthy and the secondary resource record set is healthy, Route 53 responds to DNS queries with the applicable value from the secondary resource record set.</p> </li> <li> <p>When the secondary resource record set is unhealthy, Route 53 responds to DNS queries with the applicable value from the primary resource record set regardless of the health of the primary resource record set.</p> </li> <li> <p>If you omit the <code>HealthCheckId</code> element for the secondary resource record set, and if the primary resource record set is unhealthy, Route 53 always responds to DNS queries with the applicable value from the secondary resource record set. This is true regardless of the health of the associated endpoint.</p> </li> </ul> <p>You can't create non-failover resource record sets that have the same values for the <code>Name</code> and <code>Type</code> elements as failover resource record sets.</p> <p>For failover alias resource record sets, you must also include the <code>EvaluateTargetHealth</code> element and set the value to true.</p> <p>For more information about configuring failover for Route 53, see the following topics in the <i>Amazon Route 53 Developer Guide</i>: </p> <ul> <li> <p> <a href='https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/dns-failover.html'>Route 53 Health Checks and DNS Failover</a> </p> </li> <li> <p> <a href='https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/dns-failover-private-hosted-zones.html'>Configuring Failover in a Private Hosted Zone</a> </p> </li> </ul>")
  failover?: ResourceRecordSetFailoverEnumValue;

  @doc("<p> <i>Geolocation resource record sets only:</i> A complex type that lets you control how Amazon Route 53 responds to DNS queries based on the geographic origin of the query. For example, if you want all queries from Africa to be routed to a web server with an IP address of <code>192.0.2.111</code>, create a resource record set with a <code>Type</code> of <code>A</code> and a <code>ContinentCode</code> of <code>AF</code>.</p> <p>If you create separate resource record sets for overlapping geographic regions (for example, one resource record set for a continent and one for a country on the same continent), priority goes to the smallest geographic region. This allows you to route most queries for a continent to one resource and to route queries for a country on that continent to a different resource.</p> <p>You can't create two geolocation resource record sets that specify the same geographic location.</p> <p>The value <code>*</code> in the <code>CountryCode</code> element matches all geographic locations that aren't specified in other geolocation resource record sets that have the same values for the <code>Name</code> and <code>Type</code> elements.</p> <important> <p>Geolocation works by mapping IP addresses to locations. However, some IP addresses aren't mapped to geographic locations, so even if you create geolocation resource record sets that cover all seven continents, Route 53 will receive some DNS queries from locations that it can't identify. We recommend that you create a resource record set for which the value of <code>CountryCode</code> is <code>*</code>. Two groups of queries are routed to the resource that you specify in this record: queries that come from locations for which you haven't created geolocation resource record sets and queries from IP addresses that aren't mapped to a location. If you don't create a <code>*</code> resource record set, Route 53 returns a 'no answer' response for queries from those locations.</p> </important> <p>You can't create non-geolocation resource record sets that have the same values for the <code>Name</code> and <code>Type</code> elements as geolocation resource record sets.</p>")
  geoLocation?: GeoLocation;

  @doc("<p> <i> GeoproximityLocation resource record sets only:</i> A complex type that lets you control how Route 53 responds to DNS queries based on the geographic origin of the query and your resources. </p>")
  geoProximityLocation?: GeoProximityLocation;

  @doc("<p>If you want Amazon Route 53 to return this resource record set in response to a DNS query only when the status of a health check is healthy, include the <code>HealthCheckId</code> element and specify the ID of the applicable health check.</p> <p>Route 53 determines whether a resource record set is healthy based on one of the following:</p> <ul> <li> <p>By periodically sending a request to the endpoint that is specified in the health check</p> </li> <li> <p>By aggregating the status of a specified group of health checks (calculated health checks)</p> </li> <li> <p>By determining the current state of a CloudWatch alarm (CloudWatch metric health checks)</p> </li> </ul> <important> <p>Route 53 doesn't check the health of the endpoint that is specified in the resource record set, for example, the endpoint specified by the IP address in the <code>Value</code> element. When you add a <code>HealthCheckId</code> element to a resource record set, Route 53 checks the health of the endpoint that you specified in the health check. </p> </important> <p>For more information, see the following topics in the <i>Amazon Route 53 Developer Guide</i>:</p> <ul> <li> <p> <a href='https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/dns-failover-determining-health-of-endpoints.html'>How Amazon Route 53 Determines Whether an Endpoint Is Healthy</a> </p> </li> <li> <p> <a href='https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/dns-failover.html'>Route 53 Health Checks and DNS Failover</a> </p> </li> <li> <p> <a href='https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/dns-failover-private-hosted-zones.html'>Configuring Failover in a Private Hosted Zone</a> </p> </li> </ul> <p> <b>When to Specify HealthCheckId</b> </p> <p>Specifying a value for <code>HealthCheckId</code> is useful only when Route 53 is choosing between two or more resource record sets to respond to a DNS query, and you want Route 53 to base the choice in part on the status of a health check. Configuring health checks makes sense only in the following configurations:</p> <ul> <li> <p> <b>Non-alias resource record sets</b>: You're checking the health of a group of non-alias resource record sets that have the same routing policy, name, and type (such as multiple weighted records named www.example.com with a type of A) and you specify health check IDs for all the resource record sets. </p> <p>If the health check status for a resource record set is healthy, Route 53 includes the record among the records that it responds to DNS queries with.</p> <p>If the health check status for a resource record set is unhealthy, Route 53 stops responding to DNS queries using the value for that resource record set.</p> <p>If the health check status for all resource record sets in the group is unhealthy, Route 53 considers all resource record sets in the group healthy and responds to DNS queries accordingly. </p> </li> <li> <p> <b>Alias resource record sets</b>: You specify the following settings:</p> <ul> <li> <p>You set <code>EvaluateTargetHealth</code> to true for an alias resource record set in a group of resource record sets that have the same routing policy, name, and type (such as multiple weighted records named www.example.com with a type of A). </p> </li> <li> <p>You configure the alias resource record set to route traffic to a non-alias resource record set in the same hosted zone.</p> </li> <li> <p>You specify a health check ID for the non-alias resource record set. </p> </li> </ul> <p>If the health check status is healthy, Route 53 considers the alias resource record set to be healthy and includes the alias record among the records that it responds to DNS queries with.</p> <p>If the health check status is unhealthy, Route 53 stops responding to DNS queries using the alias resource record set.</p> <note> <p>The alias resource record set can also route traffic to a <i>group</i> of non-alias resource record sets that have the same routing policy, name, and type. In that configuration, associate health checks with all of the resource record sets in the group of non-alias resource record sets.</p> </note> </li> </ul> <p> <b>Geolocation Routing</b> </p> <p>For geolocation resource record sets, if an endpoint is unhealthy, Route 53 looks for a resource record set for the larger, associated geographic region. For example, suppose you have resource record sets for a state in the United States, for the entire United States, for North America, and a resource record set that has <code>*</code> for <code>CountryCode</code> is <code>*</code>, which applies to all locations. If the endpoint for the state resource record set is unhealthy, Route 53 checks for healthy resource record sets in the following order until it finds a resource record set for which the endpoint is healthy:</p> <ul> <li> <p>The United States</p> </li> <li> <p>North America</p> </li> <li> <p>The default resource record set</p> </li> </ul> <p> <b>Specifying the Health Check Endpoint by Domain Name</b> </p> <p>If your health checks specify the endpoint only by domain name, we recommend that you create a separate health check for each endpoint. For example, create a health check for each <code>HTTP</code> server that is serving content for <code>www.example.com</code>. For the value of <code>FullyQualifiedDomainName</code>, specify the domain name of the server (such as <code>us-east-2-www.example.com</code>), not the name of the resource record sets (<code>www.example.com</code>).</p> <important> <p>Health check results will be unpredictable if you do the following:</p> <ul> <li> <p>Create a health check that has the same value for <code>FullyQualifiedDomainName</code> as the name of a resource record set.</p> </li> <li> <p>Associate that health check with the resource record set.</p> </li> </ul> </important>")
  healthCheckId?: string;

  @doc("<p> <i>Multivalue answer resource record sets only</i>: To route traffic approximately randomly to multiple resources, such as web servers, create one multivalue answer record for each resource and specify <code>true</code> for <code>MultiValueAnswer</code>. Note the following:</p> <ul> <li> <p>If you associate a health check with a multivalue answer resource record set, Amazon Route 53 responds to DNS queries with the corresponding IP address only when the health check is healthy.</p> </li> <li> <p>If you don't associate a health check with a multivalue answer record, Route 53 always considers the record to be healthy.</p> </li> <li> <p>Route 53 responds to DNS queries with up to eight healthy records; if you have eight or fewer healthy records, Route 53 responds to all DNS queries with all the healthy records.</p> </li> <li> <p>If you have more than eight healthy records, Route 53 responds to different DNS resolvers with different combinations of healthy records.</p> </li> <li> <p>When all records are unhealthy, Route 53 responds to DNS queries with up to eight unhealthy records.</p> </li> <li> <p>If a resource becomes unavailable after a resolver caches a response, client software typically tries another of the IP addresses in the response.</p> </li> </ul> <p>You can't create multivalue answer alias records.</p>")
  multiValueAnswer?: boolean;

  @doc("<p>For <code>ChangeResourceRecordSets</code> requests, the name of the record that you want to create, update, or delete. For <code>ListResourceRecordSets</code> responses, the name of a record in the specified hosted zone.</p> <p> <b>ChangeResourceRecordSets Only</b> </p> <p>Enter a fully qualified domain name, for example, <code>www.example.com</code>. You can optionally include a trailing dot. If you omit the trailing dot, Amazon Route 53 assumes that the domain name that you specify is fully qualified. This means that Route 53 treats <code>www.example.com</code> (without a trailing dot) and <code>www.example.com.</code> (with a trailing dot) as identical.</p> <p>For information about how to specify characters other than <code>a-z</code>, <code>0-9</code>, and <code>-</code> (hyphen) and how to specify internationalized domain names, see <a href='https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/DomainNameFormat.html'>DNS Domain Name Format</a> in the <i>Amazon Route 53 Developer Guide</i>.</p> <p>You can use the asterisk (*) wildcard to replace the leftmost label in a domain name, for example, <code>*.example.com</code>. Note the following:</p> <ul> <li> <p>The * must replace the entire label. For example, you can't specify <code>*prod.example.com</code> or <code>prod*.example.com</code>.</p> </li> <li> <p>The * can't replace any of the middle labels, for example, marketing.*.example.com.</p> </li> <li> <p>If you include * in any position other than the leftmost label in a domain name, DNS treats it as an * character (ASCII 42), not as a wildcard.</p> <important> <p>You can't use the * wildcard for resource records sets that have a type of NS.</p> </important> </li> </ul>")
  name?: string;

  @doc("<p> <i>Latency-based resource record sets only:</i> The Amazon EC2 Region where you created the resource that this resource record set refers to. The resource typically is an Amazon Web Services resource, such as an EC2 instance or an ELB load balancer, and is referred to by an IP address or a DNS domain name, depending on the record type.</p> <p>When Amazon Route 53 receives a DNS query for a domain name and type for which you have created latency resource record sets, Route 53 selects the latency resource record set that has the lowest latency between the end user and the associated Amazon EC2 Region. Route 53 then returns the value that is associated with the selected resource record set.</p> <p>Note the following:</p> <ul> <li> <p>You can only specify one <code>ResourceRecord</code> per latency resource record set.</p> </li> <li> <p>You can only create one latency resource record set for each Amazon EC2 Region.</p> </li> <li> <p>You aren't required to create latency resource record sets for all Amazon EC2 Regions. Route 53 will choose the region with the best latency from among the regions that you create latency resource record sets for.</p> </li> <li> <p>You can't create non-latency resource record sets that have the same values for the <code>Name</code> and <code>Type</code> elements as latency resource record sets.</p> </li> </ul>")
  region?: ResourceRecordSetRegionEnumValue;

  @doc("<p>Information about the resource records to act upon.</p> <note> <p>If you're creating an alias resource record set, omit <code>ResourceRecords</code>.</p> </note>")
  @extension("x-ms-identifiers", [])
  resourceRecords?: ResourceRecord[];

  @doc("<p> <i>Resource record sets that have a routing policy other than simple:</i> An identifier that differentiates among multiple resource record sets that have the same combination of name and type, such as multiple weighted resource record sets named acme.example.com that have a type of A. In a group of resource record sets that have the same name and type, the value of <code>SetIdentifier</code> must be unique for each resource record set. </p> <p>For information about routing policies, see <a href='https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/routing-policy.html'>Choosing a Routing Policy</a> in the <i>Amazon Route 53 Developer Guide</i>.</p>")
  setIdentifier?: string;

  @doc("<p>The resource record cache time to live (TTL), in seconds. Note the following:</p> <ul> <li> <p>If you're creating or updating an alias resource record set, omit <code>TTL</code>. Amazon Route 53 uses the value of <code>TTL</code> for the alias target. </p> </li> <li> <p>If you're associating this resource record set with a health check (if you're adding a <code>HealthCheckId</code> element), we recommend that you specify a <code>TTL</code> of 60 seconds or less so clients respond quickly to changes in health status.</p> </li> <li> <p>All of the resource record sets in a group of weighted resource record sets must have the same value for <code>TTL</code>.</p> </li> <li> <p>If a group of weighted resource record sets includes one or more weighted alias resource record sets for which the alias target is an ELB load balancer, we recommend that you specify a <code>TTL</code> of 60 seconds for all of the non-alias weighted resource record sets that have the same name and type. Values other than 60 seconds (the TTL for load balancers) will change the effect of the values that you specify for <code>Weight</code>.</p> </li> </ul>")
  ttl?: int64;

  @doc("<p>When you create a traffic policy instance, Amazon Route 53 automatically creates a resource record set. <code>TrafficPolicyInstanceId</code> is the ID of the traffic policy instance that Route 53 created this resource record set for.</p> <important> <p>To delete the resource record set that is associated with a traffic policy instance, use <code>DeleteTrafficPolicyInstance</code>. Route 53 will delete the resource record set automatically. If you delete the resource record set by using <code>ChangeResourceRecordSets</code>, Route 53 doesn't automatically delete the traffic policy instance, and you'll continue to be charged for it even though it's no longer in use. </p> </important>")
  trafficPolicyInstanceId?: string;

  @doc("<p>The DNS record type. For information about different record types and how data is encoded for them, see <a href='https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/ResourceRecordTypes.html'>Supported DNS Resource Record Types</a> in the <i>Amazon Route 53 Developer Guide</i>.</p> <p>Valid values for basic resource record sets: <code>A</code> | <code>AAAA</code> | <code>CAA</code> | <code>CNAME</code> | <code>DS</code> |<code>MX</code> | <code>NAPTR</code> | <code>NS</code> | <code>PTR</code> | <code>SOA</code> | <code>SPF</code> | <code>SRV</code> | <code>TXT</code> </p> <p>Values for weighted, latency, geolocation, and failover resource record sets: <code>A</code> | <code>AAAA</code> | <code>CAA</code> | <code>CNAME</code> | <code>MX</code> | <code>NAPTR</code> | <code>PTR</code> | <code>SPF</code> | <code>SRV</code> | <code>TXT</code>. When creating a group of weighted, latency, geolocation, or failover resource record sets, specify the same value for all of the resource record sets in the group.</p> <p>Valid values for multivalue answer resource record sets: <code>A</code> | <code>AAAA</code> | <code>MX</code> | <code>NAPTR</code> | <code>PTR</code> | <code>SPF</code> | <code>SRV</code> | <code>TXT</code> </p> <note> <p>SPF records were formerly used to verify the identity of the sender of email messages. However, we no longer recommend that you create resource record sets for which the value of <code>Type</code> is <code>SPF</code>. RFC 7208, <i>Sender Policy Framework (SPF) for Authorizing Use of Domains in Email, Version 1</i>, has been updated to say, '...[I]ts existence and mechanism defined in [RFC4408] have led to some interoperability issues. Accordingly, its use is no longer appropriate for SPF version 1; implementations are not to use it.' In RFC 7208, see section 14.1, <a href='http://tools.ietf.org/html/rfc7208#section-14.1'>The SPF DNS Record Type</a>.</p> </note> <p>Values for alias resource record sets:</p> <ul> <li> <p> <b>Amazon API Gateway custom regional APIs and edge-optimized APIs:</b> <code>A</code> </p> </li> <li> <p> <b>CloudFront distributions:</b> <code>A</code> </p> <p>If IPv6 is enabled for the distribution, create two resource record sets to route traffic to your distribution, one with a value of <code>A</code> and one with a value of <code>AAAA</code>. </p> </li> <li> <p> <b>Amazon API Gateway environment that has a regionalized subdomain</b>: <code>A</code> </p> </li> <li> <p> <b>ELB load balancers:</b> <code>A</code> | <code>AAAA</code> </p> </li> <li> <p> <b>Amazon S3 buckets:</b> <code>A</code> </p> </li> <li> <p> <b>Amazon Virtual Private Cloud interface VPC endpoints</b> <code>A</code> </p> </li> <li> <p> <b>Another resource record set in this hosted zone:</b> Specify the type of the resource record set that you're creating the alias for. All values are supported except <code>NS</code> and <code>SOA</code>.</p> <note> <p>If you're creating an alias record that has the same name as the hosted zone (known as the zone apex), you can't route traffic to a record for which the value of <code>Type</code> is <code>CNAME</code>. This is because the alias record must have the same type as the record you're routing traffic to, and creating a CNAME record for the zone apex isn't supported even for an alias record.</p> </note> </li> </ul>")
  type?: RRTypeEnumValue;

  @doc("<p> <i>Weighted resource record sets only:</i> Among resource record sets that have the same combination of DNS name and type, a value that determines the proportion of DNS queries that Amazon Route 53 responds to using the current resource record set. Route 53 calculates the sum of the weights for the resource record sets that have the same combination of DNS name and type. Route 53 then responds to queries based on the ratio of a resource's weight to the total. Note the following:</p> <ul> <li> <p>You must specify a value for the <code>Weight</code> element for every weighted resource record set.</p> </li> <li> <p>You can only specify one <code>ResourceRecord</code> per weighted resource record set.</p> </li> <li> <p>You can't create latency, failover, or geolocation resource record sets that have the same values for the <code>Name</code> and <code>Type</code> elements as weighted resource record sets.</p> </li> <li> <p>You can create a maximum of 100 weighted resource record sets that have the same values for the <code>Name</code> and <code>Type</code> elements.</p> </li> <li> <p>For weighted (but not weighted alias) resource record sets, if you set <code>Weight</code> to <code>0</code> for a resource record set, Route 53 never responds to queries with the applicable value for that resource record set. However, if you set <code>Weight</code> to <code>0</code> for all resource record sets that have the same combination of DNS name and type, traffic is routed to all resources with equal probability.</p> <p>The effect of setting <code>Weight</code> to <code>0</code> is different when you associate health checks with weighted resource record sets. For more information, see <a href='https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/dns-failover-configuring-options.html'>Options for Configuring Route 53 Active-Active and Active-Passive Failover</a> in the <i>Amazon Route 53 Developer Guide</i>.</p> </li> </ul>")
  weight?: int64;
}

@doc("ResourceRecordSetFailover enum")
union ResourceRecordSetFailover {
  @doc("ResourceRecordSetFailover enum PRIMARY")
  PRIMARY: "PRIMARY",

  @doc("ResourceRecordSetFailover enum SECONDARY")
  SECONDARY: "SECONDARY",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ResourceRecordSetFailoverEnumValue")
model ResourceRecordSetFailoverEnumValue {
  @doc("Property value")
  value?: ResourceRecordSetFailover;
}

@doc("RRType enum")
union RRType {
  @doc("RRType enum A")
  A: "A",

  @doc("RRType enum AAAA")
  AAAA: "AAAA",

  @doc("RRType enum CAA")
  CAA: "CAA",

  @doc("RRType enum CNAME")
  CNAME: "CNAME",

  @doc("RRType enum DS")
  DS: "DS",

  @doc("RRType enum MX")
  MX: "MX",

  @doc("RRType enum NAPTR")
  NAPTR: "NAPTR",

  @doc("RRType enum NS")
  NS: "NS",

  @doc("RRType enum PTR")
  PTR: "PTR",

  @doc("RRType enum SOA")
  SOA: "SOA",

  @doc("RRType enum SPF")
  SPF: "SPF",

  @doc("RRType enum SRV")
  SRV: "SRV",

  @doc("RRType enum TXT")
  TXT: "TXT",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RRTypeEnumValue")
model RRTypeEnumValue {
  @doc("Property value")
  value?: RRType;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AliasTarget")
model AliasTarget {
  @doc("<p> <i>Alias resource record sets only:</i> The value that you specify depends on where you want to route queries:</p> <dl> <dt>Amazon API Gateway custom regional APIs and edge-optimized APIs</dt> <dd> <p>Specify the applicable domain name for your API. You can get the applicable value using the CLI command <a href='https://docs.aws.amazon.com/cli/latest/reference/apigateway/get-domain-names.html'>get-domain-names</a>:</p> <ul> <li> <p>For regional APIs, specify the value of <code>regionalDomainName</code>.</p> </li> <li> <p>For edge-optimized APIs, specify the value of <code>distributionDomainName</code>. This is the name of the associated CloudFront distribution, such as <code>da1b2c3d4e5.cloudfront.net</code>.</p> </li> </ul> <note> <p>The name of the record that you're creating must match a custom domain name for your API, such as <code>api.example.com</code>.</p> </note> </dd> <dt>Amazon Virtual Private Cloud interface VPC endpoint</dt> <dd> <p>Enter the API endpoint for the interface endpoint, such as <code>vpce-123456789abcdef01-example-us-east-1a.elasticloadbalancing.us-east-1.vpce.amazonaws.com</code>. For edge-optimized APIs, this is the domain name for the corresponding CloudFront distribution. You can get the value of <code>DnsName</code> using the CLI command <a href='https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-vpc-endpoints.html'>describe-vpc-endpoints</a>.</p> </dd> <dt>CloudFront distribution</dt> <dd> <p>Specify the domain name that CloudFront assigned when you created your distribution.</p> <p>Your CloudFront distribution must include an alternate domain name that matches the name of the resource record set. For example, if the name of the resource record set is <i>acme.example.com</i>, your CloudFront distribution must include <i>acme.example.com</i> as one of the alternate domain names. For more information, see <a href='https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/CNAMEs.html'>Using Alternate Domain Names (CNAMEs)</a> in the <i>Amazon CloudFront Developer Guide</i>.</p> <p>You can't create a resource record set in a private hosted zone to route traffic to a CloudFront distribution.</p> <note> <p>For failover alias records, you can't specify a CloudFront distribution for both the primary and secondary records. A distribution must include an alternate domain name that matches the name of the record. However, the primary and secondary records have the same name, and you can't include the same alternate domain name in more than one distribution. </p> </note> </dd> <dt>Elastic Beanstalk environment</dt> <dd> <p>If the domain name for your Elastic Beanstalk environment includes the region that you deployed the environment in, you can create an alias record that routes traffic to the environment. For example, the domain name <code>my-environment.<i>us-west-2</i>.elasticbeanstalk.com</code> is a regionalized domain name. </p> <important> <p>For environments that were created before early 2016, the domain name doesn't include the region. To route traffic to these environments, you must create a CNAME record instead of an alias record. Note that you can't create a CNAME record for the root domain name. For example, if your domain name is example.com, you can create a record that routes traffic for acme.example.com to your Elastic Beanstalk environment, but you can't create a record that routes traffic for example.com to your Elastic Beanstalk environment.</p> </important> <p>For Elastic Beanstalk environments that have regionalized subdomains, specify the <code>CNAME</code> attribute for the environment. You can use the following methods to get the value of the CNAME attribute:</p> <ul> <li> <p> <i>Amazon Web Services Management Console</i>: For information about how to get the value by using the console, see <a href='https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/customdomains.html'>Using Custom Domains with Elastic Beanstalk</a> in the <i>Elastic Beanstalk Developer Guide</i>.</p> </li> <li> <p> <i>Elastic Beanstalk API</i>: Use the <code>DescribeEnvironments</code> action to get the value of the <code>CNAME</code> attribute. For more information, see <a href='https://docs.aws.amazon.com/elasticbeanstalk/latest/api/API_DescribeEnvironments.html'>DescribeEnvironments</a> in the <i>Elastic Beanstalk API Reference</i>.</p> </li> <li> <p> <i>CLI</i>: Use the <code>describe-environments</code> command to get the value of the <code>CNAME</code> attribute. For more information, see <a href='https://docs.aws.amazon.com/cli/latest/reference/elasticbeanstalk/describe-environments.html'>describe-environments</a> in the <i>CLI Command Reference</i>.</p> </li> </ul> </dd> <dt>ELB load balancer</dt> <dd> <p>Specify the DNS name that is associated with the load balancer. Get the DNS name by using the Amazon Web Services Management Console, the ELB API, or the CLI. </p> <ul> <li> <p> <b>Amazon Web Services Management Console</b>: Go to the EC2 page, choose <b>Load Balancers</b> in the navigation pane, choose the load balancer, choose the <b>Description</b> tab, and get the value of the <b>DNS name</b> field. </p> <p>If you're routing traffic to a Classic Load Balancer, get the value that begins with <b>dualstack</b>. If you're routing traffic to another type of load balancer, get the value that applies to the record type, A or AAAA.</p> </li> <li> <p> <b>Elastic Load Balancing API</b>: Use <code>DescribeLoadBalancers</code> to get the value of <code>DNSName</code>. For more information, see the applicable guide:</p> <ul> <li> <p>Classic Load Balancers: <a href='https://docs.aws.amazon.com/elasticloadbalancing/2012-06-01/APIReference/API_DescribeLoadBalancers.html'>DescribeLoadBalancers</a> </p> </li> <li> <p>Application and Network Load Balancers: <a href='https://docs.aws.amazon.com/elasticloadbalancing/latest/APIReference/API_DescribeLoadBalancers.html'>DescribeLoadBalancers</a> </p> </li> </ul> </li> <li> <p> <b>CLI</b>: Use <code>describe-load-balancers</code> to get the value of <code>DNSName</code>. For more information, see the applicable guide:</p> <ul> <li> <p>Classic Load Balancers: <a href='http://docs.aws.amazon.com/cli/latest/reference/elb/describe-load-balancers.html'>describe-load-balancers</a> </p> </li> <li> <p>Application and Network Load Balancers: <a href='http://docs.aws.amazon.com/cli/latest/reference/elbv2/describe-load-balancers.html'>describe-load-balancers</a> </p> </li> </ul> </li> </ul> </dd> <dt>Global Accelerator accelerator</dt> <dd> <p>Specify the DNS name for your accelerator:</p> <ul> <li> <p> <b>Global Accelerator API:</b> To get the DNS name, use <a href='https://docs.aws.amazon.com/global-accelerator/latest/api/API_DescribeAccelerator.html'>DescribeAccelerator</a>.</p> </li> <li> <p> <b>CLI:</b> To get the DNS name, use <a href='https://docs.aws.amazon.com/cli/latest/reference/globalaccelerator/describe-accelerator.html'>describe-accelerator</a>.</p> </li> </ul> </dd> <dt>Amazon S3 bucket that is configured as a static website</dt> <dd> <p>Specify the domain name of the Amazon S3 website endpoint that you created the bucket in, for example, <code>s3-website.us-east-2.amazonaws.com</code>. For more information about valid values, see the table <a href='https://docs.aws.amazon.com/general/latest/gr/s3.html#s3_website_region_endpoints'>Amazon S3 Website Endpoints</a> in the <i>Amazon Web Services General Reference</i>. For more information about using S3 buckets for websites, see <a href='https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/getting-started.html'>Getting Started with Amazon Route 53</a> in the <i>Amazon Route 53 Developer Guide.</i> </p> </dd> <dt>Another Route 53 resource record set</dt> <dd> <p>Specify the value of the <code>Name</code> element for a resource record set in the current hosted zone.</p> <note> <p>If you're creating an alias record that has the same name as the hosted zone (known as the zone apex), you can't specify the domain name for a record for which the value of <code>Type</code> is <code>CNAME</code>. This is because the alias record must have the same type as the record that you're routing traffic to, and creating a CNAME record for the zone apex isn't supported even for an alias record.</p> </note> </dd> </dl>")
  dnsName?: string;

  @doc("<p> <i>Applies only to alias, failover alias, geolocation alias, latency alias, and weighted alias resource record sets:</i> When <code>EvaluateTargetHealth</code> is <code>true</code>, an alias resource record set inherits the health of the referenced Amazon Web Services resource, such as an ELB load balancer or another resource record set in the hosted zone.</p> <p>Note the following:</p> <dl> <dt>CloudFront distributions</dt> <dd> <p>You can't set <code>EvaluateTargetHealth</code> to <code>true</code> when the alias target is a CloudFront distribution.</p> </dd> <dt>Elastic Beanstalk environments that have regionalized subdomains</dt> <dd> <p>If you specify an Elastic Beanstalk environment in <code>DNSName</code> and the environment contains an ELB load balancer, Elastic Load Balancing routes queries only to the healthy Amazon EC2 instances that are registered with the load balancer. (An environment automatically contains an ELB load balancer if it includes more than one Amazon EC2 instance.) If you set <code>EvaluateTargetHealth</code> to <code>true</code> and either no Amazon EC2 instances are healthy or the load balancer itself is unhealthy, Route 53 routes queries to other available resources that are healthy, if any. </p> <p>If the environment contains a single Amazon EC2 instance, there are no special requirements.</p> </dd> <dt>ELB load balancers</dt> <dd> <p>Health checking behavior depends on the type of load balancer:</p> <ul> <li> <p> <b>Classic Load Balancers</b>: If you specify an ELB Classic Load Balancer in <code>DNSName</code>, Elastic Load Balancing routes queries only to the healthy Amazon EC2 instances that are registered with the load balancer. If you set <code>EvaluateTargetHealth</code> to <code>true</code> and either no EC2 instances are healthy or the load balancer itself is unhealthy, Route 53 routes queries to other resources.</p> </li> <li> <p> <b>Application and Network Load Balancers</b>: If you specify an ELB Application or Network Load Balancer and you set <code>EvaluateTargetHealth</code> to <code>true</code>, Route 53 routes queries to the load balancer based on the health of the target groups that are associated with the load balancer:</p> <ul> <li> <p>For an Application or Network Load Balancer to be considered healthy, every target group that contains targets must contain at least one healthy target. If any target group contains only unhealthy targets, the load balancer is considered unhealthy, and Route 53 routes queries to other resources.</p> </li> <li> <p>A target group that has no registered targets is considered unhealthy.</p> </li> </ul> </li> </ul> <note> <p>When you create a load balancer, you configure settings for Elastic Load Balancing health checks; they're not Route 53 health checks, but they perform a similar function. Do not create Route 53 health checks for the EC2 instances that you register with an ELB load balancer. </p> </note> </dd> <dt>S3 buckets</dt> <dd> <p>There are no special requirements for setting <code>EvaluateTargetHealth</code> to <code>true</code> when the alias target is an S3 bucket.</p> </dd> <dt>Other records in the same hosted zone</dt> <dd> <p>If the Amazon Web Services resource that you specify in <code>DNSName</code> is a record or a group of records (for example, a group of weighted records) but is not another alias record, we recommend that you associate a health check with all of the records in the alias target. For more information, see <a href='https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/dns-failover-complex-configs.html#dns-failover-complex-configs-hc-omitting'>What Happens When You Omit Health Checks?</a> in the <i>Amazon Route 53 Developer Guide</i>.</p> </dd> </dl> <p>For more information and examples, see <a href='https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/dns-failover.html'>Amazon Route 53 Health Checks and DNS Failover</a> in the <i>Amazon Route 53 Developer Guide</i>.</p>")
  evaluateTargetHealth?: boolean;

  @doc("<p> <i>Alias resource records sets only</i>: The value used depends on where you want to route traffic:</p> <dl> <dt>Amazon API Gateway custom regional APIs and edge-optimized APIs</dt> <dd> <p>Specify the hosted zone ID for your API. You can get the applicable value using the CLI command <a href='https://docs.aws.amazon.com/cli/latest/reference/apigateway/get-domain-names.html'>get-domain-names</a>:</p> <ul> <li> <p>For regional APIs, specify the value of <code>regionalHostedZoneId</code>.</p> </li> <li> <p>For edge-optimized APIs, specify the value of <code>distributionHostedZoneId</code>.</p> </li> </ul> </dd> <dt>Amazon Virtual Private Cloud interface VPC endpoint</dt> <dd> <p>Specify the hosted zone ID for your interface endpoint. You can get the value of <code>HostedZoneId</code> using the CLI command <a href='https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-vpc-endpoints.html'>describe-vpc-endpoints</a>.</p> </dd> <dt>CloudFront distribution</dt> <dd> <p>Specify <code>Z2FDTNDATAQYW2</code>.</p> <note> <p>Alias resource record sets for CloudFront can't be created in a private zone.</p> </note> </dd> <dt>Elastic Beanstalk environment</dt> <dd> <p>Specify the hosted zone ID for the region that you created the environment in. The environment must have a regionalized subdomain. For a list of regions and the corresponding hosted zone IDs, see <a href='https://docs.aws.amazon.com/general/latest/gr/elasticbeanstalk.html'>Elastic Beanstalk endpoints and quotas</a> in the <i>Amazon Web Services General Reference</i>.</p> </dd> <dt>ELB load balancer</dt> <dd> <p>Specify the value of the hosted zone ID for the load balancer. Use the following methods to get the hosted zone ID:</p> <ul> <li> <p> <a href='https://docs.aws.amazon.com/general/latest/gr/elb.html'>Elastic Load Balancing endpoints and quotas</a> topic in the <i>Amazon Web Services General Reference</i>: Use the value that corresponds with the region that you created your load balancer in. Note that there are separate columns for Application and Classic Load Balancers and for Network Load Balancers.</p> </li> <li> <p> <b>Amazon Web Services Management Console</b>: Go to the Amazon EC2 page, choose <b>Load Balancers</b> in the navigation pane, select the load balancer, and get the value of the <b>Hosted zone</b> field on the <b>Description</b> tab.</p> </li> <li> <p> <b>Elastic Load Balancing API</b>: Use <code>DescribeLoadBalancers</code> to get the applicable value. For more information, see the applicable guide:</p> <ul> <li> <p>Classic Load Balancers: Use <a href='https://docs.aws.amazon.com/elasticloadbalancing/2012-06-01/APIReference/API_DescribeLoadBalancers.html'>DescribeLoadBalancers</a> to get the value of <code>CanonicalHostedZoneNameId</code>.</p> </li> <li> <p>Application and Network Load Balancers: Use <a href='https://docs.aws.amazon.com/elasticloadbalancing/latest/APIReference/API_DescribeLoadBalancers.html'>DescribeLoadBalancers</a> to get the value of <code>CanonicalHostedZoneId</code>.</p> </li> </ul> </li> <li> <p> <b>CLI</b>: Use <code>describe-load-balancers</code> to get the applicable value. For more information, see the applicable guide:</p> <ul> <li> <p>Classic Load Balancers: Use <a href='http://docs.aws.amazon.com/cli/latest/reference/elb/describe-load-balancers.html'>describe-load-balancers</a> to get the value of <code>CanonicalHostedZoneNameId</code>.</p> </li> <li> <p>Application and Network Load Balancers: Use <a href='http://docs.aws.amazon.com/cli/latest/reference/elbv2/describe-load-balancers.html'>describe-load-balancers</a> to get the value of <code>CanonicalHostedZoneId</code>.</p> </li> </ul> </li> </ul> </dd> <dt>Global Accelerator accelerator</dt> <dd> <p>Specify <code>Z2BJ6XQ5FK7U4H</code>.</p> </dd> <dt>An Amazon S3 bucket configured as a static website</dt> <dd> <p>Specify the hosted zone ID for the region that you created the bucket in. For more information about valid values, see the table <a href='https://docs.aws.amazon.com/general/latest/gr/s3.html#s3_website_region_endpoints'>Amazon S3 Website Endpoints</a> in the <i>Amazon Web Services General Reference</i>.</p> </dd> <dt>Another Route 53 resource record set in your hosted zone</dt> <dd> <p>Specify the hosted zone ID of your hosted zone. (An alias resource record set can't reference a resource record set in a different hosted zone.)</p> </dd> </dl>")
  hostedZoneId?: string;
}

@doc("ResourceRecordSetRegion enum")
union ResourceRecordSetRegion {
  @doc("ResourceRecordSetRegion enum af-south-1")
  AfSouth1: "af-south-1",

  @doc("ResourceRecordSetRegion enum ap-east-1")
  ApEast1: "ap-east-1",

  @doc("ResourceRecordSetRegion enum ap-northeast-1")
  ApNortheast1: "ap-northeast-1",

  @doc("ResourceRecordSetRegion enum ap-northeast-2")
  ApNortheast2: "ap-northeast-2",

  @doc("ResourceRecordSetRegion enum ap-northeast-3")
  ApNortheast3: "ap-northeast-3",

  @doc("ResourceRecordSetRegion enum ap-south-1")
  ApSouth1: "ap-south-1",

  @doc("ResourceRecordSetRegion enum ap-south-2")
  ApSouth2: "ap-south-2",

  @doc("ResourceRecordSetRegion enum ap-southeast-1")
  ApSoutheast1: "ap-southeast-1",

  @doc("ResourceRecordSetRegion enum ap-southeast-2")
  ApSoutheast2: "ap-southeast-2",

  @doc("ResourceRecordSetRegion enum ap-southeast-3")
  ApSoutheast3: "ap-southeast-3",

  @doc("ResourceRecordSetRegion enum ap-southeast-4")
  ApSoutheast4: "ap-southeast-4",

  @doc("ResourceRecordSetRegion enum ca-central-1")
  CaCentral1: "ca-central-1",

  @doc("ResourceRecordSetRegion enum ca-west-1")
  CaWest1: "ca-west-1",

  @doc("ResourceRecordSetRegion enum cn-north-1")
  CnNorth1: "cn-north-1",

  @doc("ResourceRecordSetRegion enum cn-northwest-1")
  CnNorthwest1: "cn-northwest-1",

  @doc("ResourceRecordSetRegion enum eu-central-1")
  EuCentral1: "eu-central-1",

  @doc("ResourceRecordSetRegion enum eu-central-2")
  EuCentral2: "eu-central-2",

  @doc("ResourceRecordSetRegion enum eu-north-1")
  EuNorth1: "eu-north-1",

  @doc("ResourceRecordSetRegion enum eu-south-1")
  EuSouth1: "eu-south-1",

  @doc("ResourceRecordSetRegion enum eu-south-2")
  EuSouth2: "eu-south-2",

  @doc("ResourceRecordSetRegion enum eu-west-1")
  EuWest1: "eu-west-1",

  @doc("ResourceRecordSetRegion enum eu-west-2")
  EuWest2: "eu-west-2",

  @doc("ResourceRecordSetRegion enum eu-west-3")
  EuWest3: "eu-west-3",

  @doc("ResourceRecordSetRegion enum il-central-1")
  IlCentral1: "il-central-1",

  @doc("ResourceRecordSetRegion enum me-central-1")
  MeCentral1: "me-central-1",

  @doc("ResourceRecordSetRegion enum me-south-1")
  MeSouth1: "me-south-1",

  @doc("ResourceRecordSetRegion enum sa-east-1")
  SaEast1: "sa-east-1",

  @doc("ResourceRecordSetRegion enum us-east-1")
  UsEast1: "us-east-1",

  @doc("ResourceRecordSetRegion enum us-east-2")
  UsEast2: "us-east-2",

  @doc("ResourceRecordSetRegion enum us-west-1")
  UsWest1: "us-west-1",

  @doc("ResourceRecordSetRegion enum us-west-2")
  UsWest2: "us-west-2",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ResourceRecordSetRegionEnumValue")
model ResourceRecordSetRegionEnumValue {
  @doc("Property value")
  value?: ResourceRecordSetRegion;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CidrRoutingConfig")
model CidrRoutingConfig {
  @doc("<p>The CIDR collection ID.</p>")
  collectionId?: string;

  @doc("<p>The CIDR collection location name.</p>")
  locationName?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of GeoLocation")
model GeoLocation {
  @doc("<p>The two-letter code for the continent.</p> <p>Amazon Route 53 supports the following continent codes:</p> <ul> <li> <p> <b>AF</b>: Africa</p> </li> <li> <p> <b>AN</b>: Antarctica</p> </li> <li> <p> <b>AS</b>: Asia</p> </li> <li> <p> <b>EU</b>: Europe</p> </li> <li> <p> <b>OC</b>: Oceania</p> </li> <li> <p> <b>NA</b>: North America</p> </li> <li> <p> <b>SA</b>: South America</p> </li> </ul> <p>Constraint: Specifying <code>ContinentCode</code> with either <code>CountryCode</code> or <code>SubdivisionCode</code> returns an <code>InvalidInput</code> error.</p>")
  continentCode?: string;

  @doc("<p>For geolocation resource record sets, the two-letter code for a country.</p> <p>Amazon Route 53 uses the two-letter country codes that are specified in <a href='https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2'>ISO standard 3166-1 alpha-2</a>.</p> <p>Route 53 also supports the country code <b>UA</b> for Ukraine.</p>")
  countryCode?: string;

  @doc("<p>For geolocation resource record sets, the two-letter code for a state of the United States. Route 53 doesn't support any other values for <code>SubdivisionCode</code>. For a list of state abbreviations, see <a href='https://pe.usps.com/text/pub28/28apb.htm'>Appendix B: Two–Letter State and Possession Abbreviations</a> on the United States Postal Service website. </p> <p>If you specify <code>subdivisioncode</code>, you must also specify <code>US</code> for <code>CountryCode</code>. </p>")
  subdivisionCode?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of GeoProximityLocation")
model GeoProximityLocation {
  @doc("<p> The Amazon Web Services Region the resource you are directing DNS traffic to, is in. </p>")
  awsRegion?: string;

  @doc("<p> The bias increases or decreases the size of the geographic region from which Route 53 routes traffic to a resource. </p> <p>To use <code>Bias</code> to change the size of the geographic region, specify the applicable value for the bias:</p> <ul> <li> <p>To expand the size of the geographic region from which Route 53 routes traffic to a resource, specify a positive integer from 1 to 99 for the bias. Route 53 shrinks the size of adjacent regions. </p> </li> <li> <p>To shrink the size of the geographic region from which Route 53 routes traffic to a resource, specify a negative bias of -1 to -99. Route 53 expands the size of adjacent regions. </p> </li> </ul>")
  bias?: int32;

  @doc("<p> Contains the longitude and latitude for a geographic region. </p>")
  coordinates?: Coordinates;

  @doc("<p> Specifies an Amazon Web Services Local Zone Group. </p> <p>A local Zone Group is usually the Local Zone code without the ending character. For example, if the Local Zone is <code>us-east-1-bue-1a</code> the Local Zone Group is <code>us-east-1-bue-1</code>.</p> <p>You can identify the Local Zones Group for a specific Local Zone by using the <a href='https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-availability-zones.html'>describe-availability-zones</a> CLI command:</p> <p>This command returns: <code>'GroupName': 'us-west-2-den-1'</code>, specifying that the Local Zone <code>us-west-2-den-1a</code> belongs to the Local Zone Group <code>us-west-2-den-1</code>.</p>")
  localZoneGroup?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ResourceRecord")
model ResourceRecord {
  @doc("<p>The current or new DNS record value, not to exceed 4,000 characters. In the case of a <code>DELETE</code> action, if the current value does not match the actual value, an error is returned. For descriptions about how to format <code>Value</code> for different record types, see <a href='https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/ResourceRecordTypes.html'>Supported DNS Resource Record Types</a> in the <i>Amazon Route 53 Developer Guide</i>.</p> <p>You can specify more than one value for all record types except <code>CNAME</code> and <code>SOA</code>. </p> <note> <p>If you're creating an alias resource record set, omit <code>Value</code>.</p> </note>")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Coordinates")
model Coordinates {
  @doc("<p> Specifies a coordinate of the north–south position of a geographic point on the surface of the Earth (-90 - 90). </p>")
  latitude?: string;

  @doc("<p> Specifies a coordinate of the east–west position of a geographic point on the surface of the Earth (-180 - 180). </p>")
  longitude?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface Route53ResourceRecordSets {
  get is ArmResourceRead<Route53ResourceRecordSet>;
  @doc("Create a Route53ResourceRecordSet. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<Route53ResourceRecordSet>;
  update is ArmCustomPatchAsync<
    Route53ResourceRecordSet,
    Azure.ResourceManager.Foundations.TagsUpdateModel<Route53ResourceRecordSet>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Route53ResourceRecordSet>;
  listByResourceGroup is ArmResourceListByParent<Route53ResourceRecordSet>;
  listBySubscription is ArmListBySubscription<Route53ResourceRecordSet>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\route53\route53-2013-04-01.normal.json
// AWS Shape: ResourceRecordSet
//
// Related information for backend service:
// AWS Servcie : Route 53
// Product Version : 3.7.798.0
// SDK Version : 3.7.302.50
//--------------------------------------------------------------------------------------------
