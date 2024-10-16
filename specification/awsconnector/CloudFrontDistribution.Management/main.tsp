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

//---------------------------------------------- CloudFrontDistributions ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Cloud Front Distribution",
    plural: "Cloud Front Distributions",
  },
  keywords: ["Microsoft.AwsConnector", "Cloud", "Front", "Distribution"],
})
@doc("A Microsoft.AwsConnector resource")
model CloudFrontDistribution
  is TrackedResource<CloudFrontDistributionProperties> {
  @doc("Name of CloudFrontDistribution")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("cloudFrontDistributions")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CloudFrontDistribution")
model CloudFrontDistributionProperties {
  @doc("AWS Properties")
  awsProperties?: AwsCloudFrontDistributionProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsCloudFrontDistribution")
model AwsCloudFrontDistributionProperties {
  @doc("The distribution's configuration. A distribution configuration.")
  distributionConfig?: DistributionConfig;

  @doc("Property domainName")
  domainName?: string;

  @doc("Property id")
  id?: string;

  @doc("A complex type that contains zero or more ``Tag`` elements.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DistributionConfig")
model DistributionConfig {
  @doc("A complex type that contains information about CNAMEs (alternate domain names), if any, for this distribution.")
  @extension("x-ms-identifiers", [])
  aliases?: string[];

  @doc("Property cnamEs")
  @extension("x-ms-identifiers", [])
  cnamEs?: string[];

  @doc("A complex type that contains zero or more ``CacheBehavior`` elements.")
  @extension("x-ms-identifiers", [])
  cacheBehaviors?: CacheBehavior[];

  @doc("A comment to describe the distribution. The comment cannot be longer than 128 characters.")
  comment?: string;

  @doc("The identifier of a continuous deployment policy. For more information, see ``CreateContinuousDeploymentPolicy``.")
  continuousDeploymentPolicyId?: string;

  @doc("A complex type that controls the following:  +  Whether CloudFront replaces HTTP status codes in the 4xx and 5xx range with custom error messages before returning the response to the viewer.  +  How long CloudFront caches HTTP status codes in the 4xx and 5xx range.   For more information about custom error pages, see [Customizing Error Responses](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/custom-error-pages.html) in the *Amazon CloudFront Developer Guide*.")
  @extension("x-ms-identifiers", [])
  customErrorResponses?: CustomErrorResponse[];

  @doc("Property customOrigin")
  customOrigin?: LegacyCustomOrigin;

  @doc("A complex type that describes the default cache behavior if you don't specify a ``CacheBehavior`` element or if files don't match any of the values of ``PathPattern`` in ``CacheBehavior`` elements. You must create exactly one default cache behavior. A complex type that describes the default cache behavior if you don't specify a ``CacheBehavior`` element or if request URLs don't match any of the values of ``PathPattern`` in ``CacheBehavior`` elements. You must create exactly one default cache behavior.")
  defaultCacheBehavior?: DefaultCacheBehavior;

  @doc("The object that you want CloudFront to request from your origin (for example, ``index.html``) when a viewer requests the root URL for your distribution (``https://www.example.com``) instead of an object in your distribution (``https://www.example.com/product-description.html``). Specifying a default root object avoids exposing the contents of your distribution. Specify only the object name, for example, ``index.html``. Don't add a ``/`` before the object name. If you don't want to specify a default root object when you create a distribution, include an empty ``DefaultRootObject`` element. To delete the default root object from an existing distribution, update the distribution configuration and include an empty ``DefaultRootObject`` element. To replace the default root object, update the distribution configuration and specify the new object. For more information about the default root object, see [Creating a Default Root Object](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/DefaultRootObject.html) in the *Amazon CloudFront Developer Guide*.")
  defaultRootObject?: string;

  @doc("From this field, you can enable or disable the selected distribution.")
  enabled?: boolean;

  @doc("(Optional) Specify the maximum HTTP version(s) that you want viewers to use to communicate with CF. The default value for new distributions is ``http1.1``. For viewers and CF to use HTTP/2, viewers must support TLSv1.2 or later, and must support Server Name Indication (SNI). For viewers and CF to use HTTP/3, viewers must support TLSv1.3 and Server Name Indication (SNI). CF supports HTTP/3 connection migration to allow the viewer to switch networks without losing connection. For more information about connection migration, see [Connection Migration](https://docs.aws.amazon.com/https://www.rfc-editor.org/rfc/rfc9000.html#name-connection-migration) at RFC 9000. For more information about supported TLSv1.3 ciphers, see [Supported protocols and ciphers between viewers and CloudFront](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/secure-connections-supported-viewer-protocols-ciphers.html).")
  httpVersion?: string = "http1.1";

  @doc("If you want CloudFront to respond to IPv6 DNS requests with an IPv6 address for your distribution, specify ``true``. If you specify ``false``, CloudFront responds to IPv6 DNS requests with the DNS response code ``NOERROR`` and with no IP addresses. This allows viewers to submit a second request, for an IPv4 address for your distribution. In general, you should enable IPv6 if you have users on IPv6 networks who want to access your content. However, if you're using signed URLs or signed cookies to restrict access to your content, and if you're using a custom policy that includes the ``IpAddress`` parameter to restrict the IP addresses that can access your content, don't enable IPv6. If you want to restrict access to some content by IP address and not restrict access to other content (or restrict access but not by IP address), you can create two distributions. For more information, see [Creating a Signed URL Using a Custom Policy](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/private-content-creating-signed-url-custom-policy.html) in the *Amazon CloudFront Developer Guide*. If you're using an R53AWSIntlong alias resource record set to route traffic to your CloudFront distribution, you need to create a second alias resource record set when both of the following are true:  +  You enable IPv6 for the distribution  +  You're using alternate domain names in the URLs for your objects   For more information, see [Routing Traffic to an Amazon CloudFront Web Distribution by Using Your Domain Name](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/routing-to-cloudfront-distribution.html) in the *Developer Guide*. If you created a CNAME resource record set, either with R53AWSIntlong or with another DNS service, you don't need to make any changes. A CNAME record will route traffic to your distribution regardless of the IP address format of the viewer request.")
  ipV6Enabled?: boolean;

  @doc("A complex type that controls whether access logs are written for the distribution. For more information about logging, see [Access Logs](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/AccessLogs.html) in the *Amazon CloudFront Developer Guide*. A complex type that controls whether access logs are written for the distribution.")
  logging?: Logging;

  @doc("A complex type that contains information about origin groups for this distribution. A complex data type for the origin groups specified for a distribution.")
  originGroups?: OriginGroups;

  @doc("A complex type that contains information about origins for this distribution.")
  @extension("x-ms-identifiers", [])
  origins?: Origin[];

  @doc("The price class that corresponds with the maximum price that you want to pay for CloudFront service. If you specify ``PriceClass_All``, CloudFront responds to requests for your objects from all CloudFront edge locations. If you specify a price class other than ``PriceClass_All``, CloudFront serves your objects from the CloudFront edge location that has the lowest latency among the edge locations in your price class. Viewers who are in or near regions that are excluded from your specified price class may encounter slower performance. For more information about price classes, see [Choosing the Price Class for a CloudFront Distribution](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/PriceClass.html) in the *Amazon CloudFront Developer Guide*. For information about CloudFront pricing, including how price classes (such as Price Class 100) map to CloudFront regions, see [Amazon CloudFront Pricing](https://docs.aws.amazon.com/cloudfront/pricing/).")
  priceClass?: string = "PriceClass_All";

  @doc("A complex type that identifies ways in which you want to restrict distribution of your content. A complex type that identifies ways in which you want to restrict distribution of your content.")
  restrictions?: Restrictions;

  @doc("Property s3Origin")
  s3Origin?: LegacyS3Origin;

  @doc("A Boolean that indicates whether this is a staging distribution. When this value is ``true``, this is a staging distribution. When this value is ``false``, this is not a staging distribution.")
  staging?: boolean;

  @doc("A complex type that determines the distribution's SSL/TLS configuration for communicating with viewers. A complex type that determines the distribution's SSL/TLS configuration for communicating with viewers. If the distribution doesn't use ``Aliases`` (also known as alternate domain names or CNAMEs)—that is, if the distribution uses the CloudFront domain name such as ``d111111abcdef8.cloudfront.net``—set ``CloudFrontDefaultCertificate`` to ``true`` and leave all other fields empty. If the distribution uses ``Aliases`` (alternate domain names or CNAMEs), use the fields in this type to specify the following settings:  +  Which viewers the distribution accepts HTTPS connections from: only viewers that support [server name indication (SNI)](https://docs.aws.amazon.com/https://en.wikipedia.org/wiki/Server_Name_Indication) (recommended), or all viewers including those that don't support SNI.  +  To accept HTTPS connections from only viewers that support SNI, set ``SSLSupportMethod`` to ``sni-only``. This is recommended. Most browsers and clients support SNI. (In CloudFormation, the field name is ``SslSupportMethod``. Note the different capitalization.)  +  To accept HTTPS connections from all viewers, including those that don't support SNI, set ``SSLSupportMethod`` to ``vip``. This is not recommended, and results in additional monthly charges from CloudFront. (In CloudFormation, the field name is ``SslSupportMethod``. Note the different capitalization.)    +  The minimum SSL/TLS protocol version that the distribution can use to communicate with viewers. To specify a minimum version, choose a value for ``MinimumProtocolVersion``. For more information, see [Security Policy](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/distribution-web-values-specify.html#DownloadDistValues-security-policy) in the *Amazon CloudFront Developer Guide*.  +  The location of the SSL/TLS certificate, [(ACM)](https://docs.aws.amazon.com/acm/latest/userguide/acm-overview.html) (recommended) or [(IAM)](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_server-certs.html). You specify the location by setting a value in one of the following fields (not both):  +   ``ACMCertificateArn`` (In CloudFormation, this field name is ``AcmCertificateArn``. Note the different capitalization.)  +   ``IAMCertificateId`` (In CloudFormation, this field name is ``IamCertificateId``. Note the different capitalization.)     All distributions support HTTPS connections from viewers. To require viewers to use HTTPS only, or to redirect them from HTTP to HTTPS, use ``ViewerProtocolPolicy`` in the ``CacheBehavior`` or ``DefaultCacheBehavior``. To specify how CloudFront should use SSL/TLS to communicate with your custom origin, use ``CustomOriginConfig``. For more information, see [Using HTTPS with CloudFront](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/using-https.html) and [Using Alternate Domain Names and HTTPS](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/using-https-alternate-domain-names.html) in the *Amazon CloudFront Developer Guide*.")
  viewerCertificate?: ViewerCertificate;

  @doc("A unique identifier that specifies the WAF web ACL, if any, to associate with this distribution. To specify a web ACL created using the latest version of WAF, use the ACL ARN, for example ``arn:aws:wafv2:us-east-1:123456789012:global/webacl/ExampleWebACL/473e64fd-f30b-4765-81a0-62ad96dd167a``. To specify a web ACL created using WAF Classic, use the ACL ID, for example ``473e64fd-f30b-4765-81a0-62ad96dd167a``.  WAF is a web application firewall that lets you monitor the HTTP and HTTPS requests that are forwarded to CloudFront, and lets you control access to your content. Based on conditions that you specify, such as the IP addresses that requests originate from or the values of query strings, CloudFront responds to requests either with the requested content or with an HTTP 403 status code (Forbidden). You can also configure CloudFront to return a custom error page when a request is blocked. For more information about WAF, see the [Developer Guide](https://docs.aws.amazon.com/waf/latest/developerguide/what-is-aws-waf.html).")
  webACLId?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("A string that contains ``Tag`` key. The string length should be between 1 and 128 characters. Valid characters include ``a-z``, ``A-Z``, ``0-9``, space, and the special characters ``_ - . : / = + @``.")
  key?: string;

  @doc("A string that contains an optional ``Tag`` value. The string length should be between 0 and 256 characters. Valid characters include ``a-z``, ``A-Z``, ``0-9``, space, and the special characters ``_ - . : / = + @``.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CacheBehavior")
model CacheBehavior {
  @doc("A complex type that controls which HTTP methods CloudFront processes and forwards to your Amazon S3 bucket or your custom origin. There are three choices:  +  CloudFront forwards only ``GET`` and ``HEAD`` requests.  +  CloudFront forwards only ``GET``, ``HEAD``, and ``OPTIONS`` requests.  +  CloudFront forwards ``GET, HEAD, OPTIONS, PUT, PATCH, POST``, and ``DELETE`` requests.   If you pick the third choice, you may need to restrict access to your Amazon S3 bucket or to your custom origin so users can't perform operations that you don't want them to. For example, you might not want users to have permissions to delete objects from your origin.")
  @extension("x-ms-identifiers", [])
  allowedMethods?: string[];

  @doc("The unique identifier of the cache policy that is attached to this cache behavior. For more information, see [Creating cache policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/controlling-the-cache-key.html#cache-key-create-cache-policy) or [Using the managed cache policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/using-managed-cache-policies.html) in the *Amazon CloudFront Developer Guide*. A ``CacheBehavior`` must include either a ``CachePolicyId`` or ``ForwardedValues``. We recommend that you use a ``CachePolicyId``.")
  cachePolicyId?: string;

  @doc("A complex type that controls whether CloudFront caches the response to requests using the specified HTTP methods. There are two choices:  +  CloudFront caches responses to ``GET`` and ``HEAD`` requests.  +  CloudFront caches responses to ``GET``, ``HEAD``, and ``OPTIONS`` requests.   If you pick the second choice for your Amazon S3 Origin, you may need to forward Access-Control-Request-Method, Access-Control-Request-Headers, and Origin headers for the responses to be cached correctly.")
  @extension("x-ms-identifiers", [])
  cachedMethods?: string[];

  @doc("Whether you want CloudFront to automatically compress certain files for this cache behavior. If so, specify true; if not, specify false. For more information, see [Serving Compressed Files](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/ServingCompressedFiles.html) in the *Amazon CloudFront Developer Guide*.")
  compress?: boolean;

  @doc("This field is deprecated. We recommend that you use the ``DefaultTTL`` field in a cache policy instead of this field. For more information, see [Creating cache policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/controlling-the-cache-key.html#cache-key-create-cache-policy) or [Using the managed cache policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/using-managed-cache-policies.html) in the *Amazon CloudFront Developer Guide*. The default amount of time that you want objects to stay in CloudFront caches before CloudFront forwards another request to your origin to determine whether the object has been updated. The value that you specify applies only when your origin does not add HTTP headers such as ``Cache-Control max-age``, ``Cache-Control s-maxage``, and ``Expires`` to objects. For more information, see [Managing How Long Content Stays in an Edge Cache (Expiration)](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Expiration.html) in the *Amazon CloudFront Developer Guide*.")
  defaultTTL?: int32 = 86400;

  @doc("The value of ``ID`` for the field-level encryption configuration that you want CloudFront to use for encrypting specific fields of data for this cache behavior.")
  fieldLevelEncryptionId?: string;

  @doc("This field is deprecated. We recommend that you use a cache policy or an origin request policy instead of this field. For more information, see [Working with policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/working-with-policies.html) in the *Amazon CloudFront Developer Guide*. If you want to include values in the cache key, use a cache policy. For more information, see [Creating cache policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/controlling-the-cache-key.html#cache-key-create-cache-policy) or [Using the managed cache policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/using-managed-cache-policies.html) in the *Amazon CloudFront Developer Guide*. If you want to send values to the origin but not include them in the cache key, use an origin request policy. For more information, see [Creating origin request policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/controlling-origin-requests.html#origin-request-create-origin-request-policy) or [Using the managed origin request policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/using-managed-origin-request-policies.html) in the *Amazon CloudFront Developer Guide*. A ``CacheBehavior`` must include either a ``CachePolicyId`` or ``ForwardedValues``. We recommend that you use a ``CachePolicyId``. A complex type that specifies how CloudFront handles query strings, cookies, and HTTP headers. This field is deprecated. We recommend that you use a cache policy or an origin request policy instead of this field. If you want to include values in the cache key, use a cache policy. For more information, see [Creating cache policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/controlling-the-cache-key.html#cache-key-create-cache-policy) in the *Amazon CloudFront Developer Guide*. If you want to send values to the origin but not include them in the cache key, use an origin request policy. For more information, see [Creating origin request policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/controlling-origin-requests.html#origin-request-create-origin-request-policy) in the *Amazon CloudFront Developer Guide*. A complex type that specifies how CloudFront handles query strings, cookies, and HTTP headers.")
  forwardedValues?: ForwardedValues;

  @doc("A list of CloudFront functions that are associated with this cache behavior. CloudFront functions must be published to the ``LIVE`` stage to associate them with a cache behavior.")
  @extension("x-ms-identifiers", [])
  functionAssociations?: FunctionAssociation[];

  @doc("A complex type that contains zero or more Lambda@Edge function associations for a cache behavior.")
  @extension("x-ms-identifiers", [])
  lambdaFunctionAssociations?: LambdaFunctionAssociation[];

  @doc("This field is deprecated. We recommend that you use the ``MaxTTL`` field in a cache policy instead of this field. For more information, see [Creating cache policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/controlling-the-cache-key.html#cache-key-create-cache-policy) or [Using the managed cache policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/using-managed-cache-policies.html) in the *Amazon CloudFront Developer Guide*. The maximum amount of time that you want objects to stay in CloudFront caches before CloudFront forwards another request to your origin to determine whether the object has been updated. The value that you specify applies only when your origin adds HTTP headers such as ``Cache-Control max-age``, ``Cache-Control s-maxage``, and ``Expires`` to objects. For more information, see [Managing How Long Content Stays in an Edge Cache (Expiration)](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Expiration.html) in the *Amazon CloudFront Developer Guide*.")
  maxTTL?: int32 = 31536000;

  @doc("This field is deprecated. We recommend that you use the ``MinTTL`` field in a cache policy instead of this field. For more information, see [Creating cache policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/controlling-the-cache-key.html#cache-key-create-cache-policy) or [Using the managed cache policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/using-managed-cache-policies.html) in the *Amazon CloudFront Developer Guide*. The minimum amount of time that you want objects to stay in CloudFront caches before CloudFront forwards another request to your origin to determine whether the object has been updated. For more information, see [Managing How Long Content Stays in an Edge Cache (Expiration)](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Expiration.html) in the *Amazon CloudFront Developer Guide*. You must specify ``0`` for ``MinTTL`` if you configure CloudFront to forward all headers to your origin (under ``Headers``, if you specify ``1`` for ``Quantity`` and ``*`` for ``Name``).")
  minTTL?: int32;

  @doc("The unique identifier of the origin request policy that is attached to this cache behavior. For more information, see [Creating origin request policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/controlling-origin-requests.html#origin-request-create-origin-request-policy) or [Using the managed origin request policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/using-managed-origin-request-policies.html) in the *Amazon CloudFront Developer Guide*.")
  originRequestPolicyId?: string;

  @doc("The pattern (for example, ``images/*.jpg``) that specifies which requests to apply the behavior to. When CloudFront receives a viewer request, the requested path is compared with path patterns in the order in which cache behaviors are listed in the distribution.  You can optionally include a slash (``/``) at the beginning of the path pattern. For example, ``/images/*.jpg``. CloudFront behavior is the same with or without the leading ``/``.  The path pattern for the default cache behavior is ``*`` and cannot be changed. If the request for an object does not match the path pattern for any cache behaviors, CloudFront applies the behavior in the default cache behavior. For more information, see [Path Pattern](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/distribution-web-values-specify.html#DownloadDistValuesPathPattern) in the *Amazon CloudFront Developer Guide*.")
  pathPattern?: string;

  @doc("The Amazon Resource Name (ARN) of the real-time log configuration that is attached to this cache behavior. For more information, see [Real-time logs](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/real-time-logs.html) in the *Amazon CloudFront Developer Guide*.")
  realtimeLogConfigArn?: string;

  @doc("The identifier for a response headers policy.")
  responseHeadersPolicyId?: string;

  @doc("Indicates whether you want to distribute media files in the Microsoft Smooth Streaming format using the origin that is associated with this cache behavior. If so, specify ``true``; if not, specify ``false``. If you specify ``true`` for ``SmoothStreaming``, you can still distribute other content using this cache behavior if the content matches the value of ``PathPattern``.")
  smoothStreaming?: boolean;

  @doc("The value of ``ID`` for the origin that you want CloudFront to route requests to when they match this cache behavior.")
  targetOriginId?: string;

  @doc("A list of key groups that CloudFront can use to validate signed URLs or signed cookies. When a cache behavior contains trusted key groups, CloudFront requires signed URLs or signed cookies for all requests that match the cache behavior. The URLs or cookies must be signed with a private key whose corresponding public key is in the key group. The signed URL or cookie contains information about which public key CloudFront should use to verify the signature. For more information, see [Serving private content](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/PrivateContent.html) in the *Amazon CloudFront Developer Guide*.")
  @extension("x-ms-identifiers", [])
  trustedKeyGroups?: string[];

  @doc("We recommend using ``TrustedKeyGroups`` instead of ``TrustedSigners``.  A list of AWS-account IDs whose public keys CloudFront can use to validate signed URLs or signed cookies. When a cache behavior contains trusted signers, CloudFront requires signed URLs or signed cookies for all requests that match the cache behavior. The URLs or cookies must be signed with the private key of a CloudFront key pair in the trusted signer's AWS-account. The signed URL or cookie contains information about which public key CloudFront should use to verify the signature. For more information, see [Serving private content](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/PrivateContent.html) in the *Amazon CloudFront Developer Guide*.")
  @extension("x-ms-identifiers", [])
  trustedSigners?: string[];

  @doc("The protocol that viewers can use to access the files in the origin specified by ``TargetOriginId`` when a request matches the path pattern in ``PathPattern``. You can specify the following options:  +   ``allow-all``: Viewers can use HTTP or HTTPS.  +   ``redirect-to-https``: If a viewer submits an HTTP request, CloudFront returns an HTTP status code of 301 (Moved Permanently) to the viewer along with the HTTPS URL. The viewer then resubmits the request using the new URL.  +   ``https-only``: If a viewer sends an HTTP request, CloudFront returns an HTTP status code of 403 (Forbidden).   For more information about requiring the HTTPS protocol, see [Requiring HTTPS Between Viewers and CloudFront](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/using-https-viewers-to-cloudfront.html) in the *Amazon CloudFront Developer Guide*.  The only way to guarantee that viewers retrieve an object that was fetched from the origin using HTTPS is never to use any other protocol to fetch the object. If you have recently changed from HTTP to HTTPS, we recommend that you clear your objects' cache because cached objects are protocol agnostic. That means that an edge location will return an object from the cache regardless of whether the current request protocol matches the protocol used previously. For more information, see [Managing Cache Expiration](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Expiration.html) in the *Amazon CloudFront Developer Guide*.")
  viewerProtocolPolicy?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CustomErrorResponse")
model CustomErrorResponse {
  @doc("The minimum amount of time, in seconds, that you want CloudFront to cache the HTTP status code specified in ``ErrorCode``. When this time period has elapsed, CloudFront queries your origin to see whether the problem that caused the error has been resolved and the requested object is now available. For more information, see [Customizing Error Responses](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/custom-error-pages.html) in the *Amazon CloudFront Developer Guide*.")
  errorCachingMinTTL?: int32 = 300;

  @doc("The HTTP status code for which you want to specify a custom error page and/or a caching duration.")
  errorCode?: int32;

  @doc("The HTTP status code that you want CloudFront to return to the viewer along with the custom error page. There are a variety of reasons that you might want CloudFront to return a status code different from the status code that your origin returned to CloudFront, for example:  +  Some Internet devices (some firewalls and corporate proxies, for example) intercept HTTP 4xx and 5xx and prevent the response from being returned to the viewer. If you substitute ``200``, the response typically won't be intercepted.  +  If you don't care about distinguishing among different client errors or server errors, you can specify ``400`` or ``500`` as the ``ResponseCode`` for all 4xx or 5xx errors.  +  You might want to return a ``200`` status code (OK) and static website so your customers don't know that your website is down.   If you specify a value for ``ResponseCode``, you must also specify a value for ``ResponsePagePath``.")
  responseCode?: int32;

  @doc("The path to the custom error page that you want CloudFront to return to a viewer when your origin returns the HTTP status code specified by ``ErrorCode``, for example, ``/4xx-errors/403-forbidden.html``. If you want to store your objects and your custom error pages in different locations, your distribution must include a cache behavior for which the following is true:  +  The value of ``PathPattern`` matches the path to your custom error messages. For example, suppose you saved custom error pages for 4xx errors in an Amazon S3 bucket in a directory named ``/4xx-errors``. Your distribution must include a cache behavior for which the path pattern routes requests for your custom error pages to that location, for example, ``/4xx-errors/*``.  +  The value of ``TargetOriginId`` specifies the value of the ``ID`` element for the origin that contains your custom error pages.   If you specify a value for ``ResponsePagePath``, you must also specify a value for ``ResponseCode``. We recommend that you store custom error pages in an Amazon S3 bucket. If you store custom error pages on an HTTP server and the server starts to return 5xx errors, CloudFront can't get the files that you want to return to viewers because the origin server is unavailable.")
  responsePagePath?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LegacyCustomOrigin")
model LegacyCustomOrigin {
  @doc("Property dnsName")
  dnsName?: string;

  @doc("Property httpPort")
  httpPort?: int32 = 80;

  @doc("Property httpsPort")
  httpsPort?: int32 = 443;

  @doc("Property originProtocolPolicy")
  originProtocolPolicy?: string;

  @doc("Property originSSLProtocols")
  @extension("x-ms-identifiers", [])
  originSSLProtocols?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DefaultCacheBehavior")
model DefaultCacheBehavior {
  @doc("A complex type that controls which HTTP methods CloudFront processes and forwards to your Amazon S3 bucket or your custom origin. There are three choices:  +  CloudFront forwards only ``GET`` and ``HEAD`` requests.  +  CloudFront forwards only ``GET``, ``HEAD``, and ``OPTIONS`` requests.  +  CloudFront forwards ``GET, HEAD, OPTIONS, PUT, PATCH, POST``, and ``DELETE`` requests.   If you pick the third choice, you may need to restrict access to your Amazon S3 bucket or to your custom origin so users can't perform operations that you don't want them to. For example, you might not want users to have permissions to delete objects from your origin.")
  @extension("x-ms-identifiers", [])
  allowedMethods?: string[];

  @doc("The unique identifier of the cache policy that is attached to the default cache behavior. For more information, see [Creating cache policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/controlling-the-cache-key.html#cache-key-create-cache-policy) or [Using the managed cache policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/using-managed-cache-policies.html) in the *Amazon CloudFront Developer Guide*. A ``DefaultCacheBehavior`` must include either a ``CachePolicyId`` or ``ForwardedValues``. We recommend that you use a ``CachePolicyId``.")
  cachePolicyId?: string;

  @doc("A complex type that controls whether CloudFront caches the response to requests using the specified HTTP methods. There are two choices:  +  CloudFront caches responses to ``GET`` and ``HEAD`` requests.  +  CloudFront caches responses to ``GET``, ``HEAD``, and ``OPTIONS`` requests.   If you pick the second choice for your Amazon S3 Origin, you may need to forward Access-Control-Request-Method, Access-Control-Request-Headers, and Origin headers for the responses to be cached correctly.")
  @extension("x-ms-identifiers", [])
  cachedMethods?: string[];

  @doc("Whether you want CloudFront to automatically compress certain files for this cache behavior. If so, specify ``true``; if not, specify ``false``. For more information, see [Serving Compressed Files](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/ServingCompressedFiles.html) in the *Amazon CloudFront Developer Guide*.")
  compress?: boolean;

  @doc("This field is deprecated. We recommend that you use the ``DefaultTTL`` field in a cache policy instead of this field. For more information, see [Creating cache policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/controlling-the-cache-key.html#cache-key-create-cache-policy) or [Using the managed cache policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/using-managed-cache-policies.html) in the *Amazon CloudFront Developer Guide*. The default amount of time that you want objects to stay in CloudFront caches before CloudFront forwards another request to your origin to determine whether the object has been updated. The value that you specify applies only when your origin does not add HTTP headers such as ``Cache-Control max-age``, ``Cache-Control s-maxage``, and ``Expires`` to objects. For more information, see [Managing How Long Content Stays in an Edge Cache (Expiration)](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Expiration.html) in the *Amazon CloudFront Developer Guide*.")
  defaultTTL?: int32 = 86400;

  @doc("The value of ``ID`` for the field-level encryption configuration that you want CloudFront to use for encrypting specific fields of data for the default cache behavior.")
  fieldLevelEncryptionId?: string;

  @doc("This field is deprecated. We recommend that you use a cache policy or an origin request policy instead of this field. For more information, see [Working with policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/working-with-policies.html) in the *Amazon CloudFront Developer Guide*. If you want to include values in the cache key, use a cache policy. For more information, see [Creating cache policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/controlling-the-cache-key.html#cache-key-create-cache-policy) or [Using the managed cache policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/using-managed-cache-policies.html) in the *Amazon CloudFront Developer Guide*. If you want to send values to the origin but not include them in the cache key, use an origin request policy. For more information, see [Creating origin request policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/controlling-origin-requests.html#origin-request-create-origin-request-policy) or [Using the managed origin request policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/using-managed-origin-request-policies.html) in the *Amazon CloudFront Developer Guide*. A ``DefaultCacheBehavior`` must include either a ``CachePolicyId`` or ``ForwardedValues``. We recommend that you use a ``CachePolicyId``. A complex type that specifies how CloudFront handles query strings, cookies, and HTTP headers. This field is deprecated. We recommend that you use a cache policy or an origin request policy instead of this field. If you want to include values in the cache key, use a cache policy. For more information, see [Creating cache policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/controlling-the-cache-key.html#cache-key-create-cache-policy) in the *Amazon CloudFront Developer Guide*. If you want to send values to the origin but not include them in the cache key, use an origin request policy. For more information, see [Creating origin request policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/controlling-origin-requests.html#origin-request-create-origin-request-policy) in the *Amazon CloudFront Developer Guide*. A complex type that specifies how CloudFront handles query strings, cookies, and HTTP headers.")
  forwardedValues?: ForwardedValues;

  @doc("A list of CloudFront functions that are associated with this cache behavior. CloudFront functions must be published to the ``LIVE`` stage to associate them with a cache behavior.")
  @extension("x-ms-identifiers", [])
  functionAssociations?: FunctionAssociation[];

  @doc("A complex type that contains zero or more Lambda@Edge function associations for a cache behavior.")
  @extension("x-ms-identifiers", [])
  lambdaFunctionAssociations?: LambdaFunctionAssociation[];

  @doc("This field is deprecated. We recommend that you use the ``MaxTTL`` field in a cache policy instead of this field. For more information, see [Creating cache policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/controlling-the-cache-key.html#cache-key-create-cache-policy) or [Using the managed cache policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/using-managed-cache-policies.html) in the *Amazon CloudFront Developer Guide*. The maximum amount of time that you want objects to stay in CloudFront caches before CloudFront forwards another request to your origin to determine whether the object has been updated. The value that you specify applies only when your origin adds HTTP headers such as ``Cache-Control max-age``, ``Cache-Control s-maxage``, and ``Expires`` to objects. For more information, see [Managing How Long Content Stays in an Edge Cache (Expiration)](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Expiration.html) in the *Amazon CloudFront Developer Guide*.")
  maxTTL?: int32 = 31536000;

  @doc("This field is deprecated. We recommend that you use the ``MinTTL`` field in a cache policy instead of this field. For more information, see [Creating cache policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/controlling-the-cache-key.html#cache-key-create-cache-policy) or [Using the managed cache policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/using-managed-cache-policies.html) in the *Amazon CloudFront Developer Guide*. The minimum amount of time that you want objects to stay in CloudFront caches before CloudFront forwards another request to your origin to determine whether the object has been updated. For more information, see [Managing How Long Content Stays in an Edge Cache (Expiration)](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Expiration.html) in the *Amazon CloudFront Developer Guide*. You must specify ``0`` for ``MinTTL`` if you configure CloudFront to forward all headers to your origin (under ``Headers``, if you specify ``1`` for ``Quantity`` and ``*`` for ``Name``).")
  minTTL?: int32;

  @doc("The unique identifier of the origin request policy that is attached to the default cache behavior. For more information, see [Creating origin request policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/controlling-origin-requests.html#origin-request-create-origin-request-policy) or [Using the managed origin request policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/using-managed-origin-request-policies.html) in the *Amazon CloudFront Developer Guide*.")
  originRequestPolicyId?: string;

  @doc("The Amazon Resource Name (ARN) of the real-time log configuration that is attached to this cache behavior. For more information, see [Real-time logs](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/real-time-logs.html) in the *Amazon CloudFront Developer Guide*.")
  realtimeLogConfigArn?: string;

  @doc("The identifier for a response headers policy.")
  responseHeadersPolicyId?: string;

  @doc("Indicates whether you want to distribute media files in the Microsoft Smooth Streaming format using the origin that is associated with this cache behavior. If so, specify ``true``; if not, specify ``false``. If you specify ``true`` for ``SmoothStreaming``, you can still distribute other content using this cache behavior if the content matches the value of ``PathPattern``.")
  smoothStreaming?: boolean;

  @doc("The value of ``ID`` for the origin that you want CloudFront to route requests to when they use the default cache behavior.")
  targetOriginId?: string;

  @doc("A list of key groups that CloudFront can use to validate signed URLs or signed cookies. When a cache behavior contains trusted key groups, CloudFront requires signed URLs or signed cookies for all requests that match the cache behavior. The URLs or cookies must be signed with a private key whose corresponding public key is in the key group. The signed URL or cookie contains information about which public key CloudFront should use to verify the signature. For more information, see [Serving private content](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/PrivateContent.html) in the *Amazon CloudFront Developer Guide*.")
  @extension("x-ms-identifiers", [])
  trustedKeyGroups?: string[];

  @doc("We recommend using ``TrustedKeyGroups`` instead of ``TrustedSigners``.  A list of AWS-account IDs whose public keys CloudFront can use to validate signed URLs or signed cookies. When a cache behavior contains trusted signers, CloudFront requires signed URLs or signed cookies for all requests that match the cache behavior. The URLs or cookies must be signed with the private key of a CloudFront key pair in a trusted signer's AWS-account. The signed URL or cookie contains information about which public key CloudFront should use to verify the signature. For more information, see [Serving private content](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/PrivateContent.html) in the *Amazon CloudFront Developer Guide*.")
  @extension("x-ms-identifiers", [])
  trustedSigners?: string[];

  @doc("The protocol that viewers can use to access the files in the origin specified by ``TargetOriginId`` when a request matches the path pattern in ``PathPattern``. You can specify the following options:  +   ``allow-all``: Viewers can use HTTP or HTTPS.  +   ``redirect-to-https``: If a viewer submits an HTTP request, CloudFront returns an HTTP status code of 301 (Moved Permanently) to the viewer along with the HTTPS URL. The viewer then resubmits the request using the new URL.  +   ``https-only``: If a viewer sends an HTTP request, CloudFront returns an HTTP status code of 403 (Forbidden).   For more information about requiring the HTTPS protocol, see [Requiring HTTPS Between Viewers and CloudFront](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/using-https-viewers-to-cloudfront.html) in the *Amazon CloudFront Developer Guide*.  The only way to guarantee that viewers retrieve an object that was fetched from the origin using HTTPS is never to use any other protocol to fetch the object. If you have recently changed from HTTP to HTTPS, we recommend that you clear your objects' cache because cached objects are protocol agnostic. That means that an edge location will return an object from the cache regardless of whether the current request protocol matches the protocol used previously. For more information, see [Managing Cache Expiration](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Expiration.html) in the *Amazon CloudFront Developer Guide*.")
  viewerProtocolPolicy?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Logging")
model Logging {
  @doc("The Amazon S3 bucket to store the access logs in, for example, ``myawslogbucket.s3.amazonaws.com``.")
  bucket?: string;

  @doc("Specifies whether you want CloudFront to include cookies in access logs, specify ``true`` for ``IncludeCookies``. If you choose to include cookies in logs, CloudFront logs all cookies regardless of how you configure the cache behaviors for this distribution. If you don't want to include cookies when you create a distribution or if you want to disable include cookies for an existing distribution, specify ``false`` for ``IncludeCookies``.")
  includeCookies?: boolean;

  @doc("An optional string that you want CloudFront to prefix to the access log ``filenames`` for this distribution, for example, ``myprefix/``. If you want to enable logging, but you don't want to specify a prefix, you still must include an empty ``Prefix`` element in the ``Logging`` element.")
  prefix?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of OriginGroups")
model OriginGroups {
  @doc("The items (origin groups) in a distribution.")
  @extension("x-ms-identifiers", [])
  items?: OriginGroup[];

  @doc("The number of origin groups.")
  quantity?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Origin")
model Origin {
  @doc("The number of times that CloudFront attempts to connect to the origin. The minimum number is 1, the maximum is 3, and the default (if you don't specify otherwise) is 3. For a custom origin (including an Amazon S3 bucket that's configured with static website hosting), this value also specifies the number of times that CloudFront attempts to get a response from the origin, in the case of an [Origin Response Timeout](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/distribution-web-values-specify.html#DownloadDistValuesOriginResponseTimeout). For more information, see [Origin Connection Attempts](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/distribution-web-values-specify.html#origin-connection-attempts) in the *Amazon CloudFront Developer Guide*.")
  connectionAttempts?: int32;

  @doc("The number of seconds that CloudFront waits when trying to establish a connection to the origin. The minimum timeout is 1 second, the maximum is 10 seconds, and the default (if you don't specify otherwise) is 10 seconds. For more information, see [Origin Connection Timeout](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/distribution-web-values-specify.html#origin-connection-timeout) in the *Amazon CloudFront Developer Guide*.")
  connectionTimeout?: int32;

  @doc("Use this type to specify an origin that is not an Amazon S3 bucket, with one exception. If the Amazon S3 bucket is configured with static website hosting, use this type. If the Amazon S3 bucket is not configured with static website hosting, use the ``S3OriginConfig`` type instead. A custom origin. A custom origin is any origin that is *not* an Amazon S3 bucket, with one exception. An Amazon S3 bucket that is [configured with static website hosting](https://docs.aws.amazon.com/AmazonS3/latest/dev/WebsiteHosting.html) *is* a custom origin.")
  customOriginConfig?: CustomOriginConfig;

  @doc("The domain name for the origin. For more information, see [Origin Domain Name](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/distribution-web-values-specify.html#DownloadDistValuesDomainName) in the *Amazon CloudFront Developer Guide*.")
  domainName?: string;

  @doc("A unique identifier for the origin. This value must be unique within the distribution. Use this value to specify the ``TargetOriginId`` in a ``CacheBehavior`` or ``DefaultCacheBehavior``.")
  id?: string;

  @doc("The unique identifier of an origin access control for this origin. For more information, see [Restricting access to an Amazon S3 origin](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/private-content-restricting-access-to-s3.html) in the *Amazon CloudFront Developer Guide*.")
  originAccessControlId?: string;

  @doc("A list of HTTP header names and values that CloudFront adds to the requests that it sends to the origin. For more information, see [Adding Custom Headers to Origin Requests](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/add-origin-custom-headers.html) in the *Amazon CloudFront Developer Guide*.")
  @extension("x-ms-identifiers", [])
  originCustomHeaders?: OriginCustomHeader[];

  @doc("An optional path that CloudFront appends to the origin domain name when CloudFront requests content from the origin. For more information, see [Origin Path](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/distribution-web-values-specify.html#DownloadDistValuesOriginPath) in the *Amazon CloudFront Developer Guide*.")
  originPath?: string;

  @doc("CloudFront Origin Shield. Using Origin Shield can help reduce the load on your origin. For more information, see [Using Origin Shield](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/origin-shield.html) in the *Amazon CloudFront Developer Guide*. CloudFront Origin Shield. Using Origin Shield can help reduce the load on your origin. For more information, see [Using Origin Shield](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/origin-shield.html) in the *Amazon CloudFront Developer Guide*.")
  originShield?: OriginShield;

  @doc("Use this type to specify an origin that is an Amazon S3 bucket that is not configured with static website hosting. To specify any other type of origin, including an Amazon S3 bucket that is configured with static website hosting, use the ``CustomOriginConfig`` type instead. A complex type that contains information about the Amazon S3 origin. If the origin is a custom origin or an S3 bucket that is configured as a website endpoint, use the ``CustomOriginConfig`` element instead.")
  s3OriginConfig?: S3OriginConfig;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Restrictions")
model Restrictions {
  @doc("A complex type that controls the countries in which your content is distributed. CF determines the location of your users using ``MaxMind`` GeoIP databases. To disable geo restriction, remove the [Restrictions](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-cloudfront-distribution-distributionconfig.html#cfn-cloudfront-distribution-distributionconfig-restrictions) property from your stack template. A complex type that controls the countries in which your content is distributed. CF determines the location of your users using ``MaxMind`` GeoIP databases. To disable geo restriction, remove the [Restrictions](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-cloudfront-distribution-distributionconfig.html#cfn-cloudfront-distribution-distributionconfig-restrictions) property from your stack template.")
  geoRestriction?: GeoRestriction;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LegacyS3Origin")
model LegacyS3Origin {
  @doc("Property dnsName")
  dnsName?: string;

  @doc("Property originAccessIdentity")
  originAccessIdentity?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ViewerCertificate")
model ViewerCertificate {
  @doc("In CloudFormation, this field name is ``AcmCertificateArn``. Note the different capitalization.  If the distribution uses ``Aliases`` (alternate domain names or CNAMEs) and the SSL/TLS certificate is stored in [(ACM)](https://docs.aws.amazon.com/acm/latest/userguide/acm-overview.html), provide the Amazon Resource Name (ARN) of the ACM certificate. CloudFront only supports ACM certificates in the US East (N. Virginia) Region (``us-east-1``). If you specify an ACM certificate ARN, you must also specify values for ``MinimumProtocolVersion`` and ``SSLSupportMethod``. (In CloudFormation, the field name is ``SslSupportMethod``. Note the different capitalization.)")
  acmCertificateArn?: string;

  @doc("If the distribution uses the CloudFront domain name such as ``d111111abcdef8.cloudfront.net``, set this field to ``true``. If the distribution uses ``Aliases`` (alternate domain names or CNAMEs), omit this field and specify values for the following fields:  +   ``AcmCertificateArn`` or ``IamCertificateId`` (specify a value for one, not both)   +   ``MinimumProtocolVersion``   +   ``SslSupportMethod``")
  cloudFrontDefaultCertificate?: boolean;

  @doc("In CloudFormation, this field name is ``IamCertificateId``. Note the different capitalization.  If the distribution uses ``Aliases`` (alternate domain names or CNAMEs) and the SSL/TLS certificate is stored in [(IAM)](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_server-certs.html), provide the ID of the IAM certificate. If you specify an IAM certificate ID, you must also specify values for ``MinimumProtocolVersion`` and ``SSLSupportMethod``. (In CloudFormation, the field name is ``SslSupportMethod``. Note the different capitalization.)")
  iamCertificateId?: string;

  @doc("If the distribution uses ``Aliases`` (alternate domain names or CNAMEs), specify the security policy that you want CloudFront to use for HTTPS connections with viewers. The security policy determines two settings:  +  The minimum SSL/TLS protocol that CloudFront can use to communicate with viewers.  +  The ciphers that CloudFront can use to encrypt the content that it returns to viewers.   For more information, see [Security Policy](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/distribution-web-values-specify.html#DownloadDistValues-security-policy) and [Supported Protocols and Ciphers Between Viewers and CloudFront](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/secure-connections-supported-viewer-protocols-ciphers.html#secure-connections-supported-ciphers) in the *Amazon CloudFront Developer Guide*.  On the CloudFront console, this setting is called *Security Policy*.  When you're using SNI only (you set ``SSLSupportMethod`` to ``sni-only``), you must specify ``TLSv1`` or higher. (In CloudFormation, the field name is ``SslSupportMethod``. Note the different capitalization.) If the distribution uses the CloudFront domain name such as ``d111111abcdef8.cloudfront.net`` (you set ``CloudFrontDefaultCertificate`` to ``true``), CloudFront automatically sets the security policy to ``TLSv1`` regardless of the value that you set here.")
  minimumProtocolVersion?: string;

  @doc("In CloudFormation, this field name is ``SslSupportMethod``. Note the different capitalization.  If the distribution uses ``Aliases`` (alternate domain names or CNAMEs), specify which viewers the distribution accepts HTTPS connections from.  +   ``sni-only`` – The distribution accepts HTTPS connections from only viewers that support [server name indication (SNI)](https://docs.aws.amazon.com/https://en.wikipedia.org/wiki/Server_Name_Indication). This is recommended. Most browsers and clients support SNI.  +   ``vip`` – The distribution accepts HTTPS connections from all viewers including those that don't support SNI. This is not recommended, and results in additional monthly charges from CloudFront.  +   ``static-ip`` - Do not specify this value unless your distribution has been enabled for this feature by the CloudFront team. If you have a use case that requires static IP addresses for a distribution, contact CloudFront through the [Center](https://docs.aws.amazon.com/support/home).   If the distribution uses the CloudFront domain name such as ``d111111abcdef8.cloudfront.net``, don't set a value for this field.")
  sslSupportMethod?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ForwardedValues")
model ForwardedValues {
  @doc("This field is deprecated. We recommend that you use a cache policy or an origin request policy instead of this field. If you want to include cookies in the cache key, use a cache policy. For more information, see [Creating cache policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/controlling-the-cache-key.html#cache-key-create-cache-policy) in the *Amazon CloudFront Developer Guide*. If you want to send cookies to the origin but not include them in the cache key, use an origin request policy. For more information, see [Creating origin request policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/controlling-origin-requests.html#origin-request-create-origin-request-policy) in the *Amazon CloudFront Developer Guide*. A complex type that specifies whether you want CloudFront to forward cookies to the origin and, if so, which ones. For more information about forwarding cookies to the origin, see [How CloudFront Forwards, Caches, and Logs Cookies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Cookies.html) in the *Amazon CloudFront Developer Guide*. This field is deprecated. We recommend that you use a cache policy or an origin request policy instead of this field. If you want to include cookies in the cache key, use a cache policy. For more information, see [Creating cache policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/controlling-the-cache-key.html#cache-key-create-cache-policy) in the *Amazon CloudFront Developer Guide*. If you want to send cookies to the origin but not include them in the cache key, use an origin request policy. For more information, see [Creating origin request policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/controlling-origin-requests.html#origin-request-create-origin-request-policy) in the *Amazon CloudFront Developer Guide*. A complex type that specifies whether you want CloudFront to forward cookies to the origin and, if so, which ones. For more information about forwarding cookies to the origin, see [How CloudFront Forwards, Caches, and Logs Cookies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Cookies.html) in the *Amazon CloudFront Developer Guide*.")
  cookies?: Cookies;

  @doc("This field is deprecated. We recommend that you use a cache policy or an origin request policy instead of this field. If you want to include headers in the cache key, use a cache policy. For more information, see [Creating cache policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/controlling-the-cache-key.html#cache-key-create-cache-policy) in the *Amazon CloudFront Developer Guide*. If you want to send headers to the origin but not include them in the cache key, use an origin request policy. For more information, see [Creating origin request policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/controlling-origin-requests.html#origin-request-create-origin-request-policy) in the *Amazon CloudFront Developer Guide*. A complex type that specifies the ``Headers``, if any, that you want CloudFront to forward to the origin for this cache behavior (whitelisted headers). For the headers that you specify, CloudFront also caches separate versions of a specified object that is based on the header values in viewer requests. For more information, see [Caching Content Based on Request Headers](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/header-caching.html) in the *Amazon CloudFront Developer Guide*.")
  @extension("x-ms-identifiers", [])
  headers?: string[];

  @doc("This field is deprecated. We recommend that you use a cache policy or an origin request policy instead of this field. If you want to include query strings in the cache key, use a cache policy. For more information, see [Creating cache policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/controlling-the-cache-key.html#cache-key-create-cache-policy) in the *Amazon CloudFront Developer Guide*. If you want to send query strings to the origin but not include them in the cache key, use an origin request policy. For more information, see [Creating origin request policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/controlling-origin-requests.html#origin-request-create-origin-request-policy) in the *Amazon CloudFront Developer Guide*. Indicates whether you want CloudFront to forward query strings to the origin that is associated with this cache behavior and cache based on the query string parameters. CloudFront behavior depends on the value of ``QueryString`` and on the values that you specify for ``QueryStringCacheKeys``, if any: If you specify true for ``QueryString`` and you don't specify any values for ``QueryStringCacheKeys``, CloudFront forwards all query string parameters to the origin and caches based on all query string parameters. Depending on how many query string parameters and values you have, this can adversely affect performance because CloudFront must forward more requests to the origin. If you specify true for ``QueryString`` and you specify one or more values for ``QueryStringCacheKeys``, CloudFront forwards all query string parameters to the origin, but it only caches based on the query string parameters that you specify. If you specify false for ``QueryString``, CloudFront doesn't forward any query string parameters to the origin, and doesn't cache based on query string parameters. For more information, see [Configuring CloudFront to Cache Based on Query String Parameters](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/QueryStringParameters.html) in the *Amazon CloudFront Developer Guide*.")
  queryString?: boolean;

  @doc("This field is deprecated. We recommend that you use a cache policy or an origin request policy instead of this field. If you want to include query strings in the cache key, use a cache policy. For more information, see [Creating cache policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/controlling-the-cache-key.html#cache-key-create-cache-policy) in the *Amazon CloudFront Developer Guide*. If you want to send query strings to the origin but not include them in the cache key, use an origin request policy. For more information, see [Creating origin request policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/controlling-origin-requests.html#origin-request-create-origin-request-policy) in the *Amazon CloudFront Developer Guide*. A complex type that contains information about the query string parameters that you want CloudFront to use for caching for this cache behavior.")
  @extension("x-ms-identifiers", [])
  queryStringCacheKeys?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of FunctionAssociation")
model FunctionAssociation {
  @doc("The event type of the function, either ``viewer-request`` or ``viewer-response``. You cannot use origin-facing event types (``origin-request`` and ``origin-response``) with a CloudFront function.")
  eventType?: string;

  @doc("The Amazon Resource Name (ARN) of the function.")
  functionARN?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LambdaFunctionAssociation")
model LambdaFunctionAssociation {
  @doc("Specifies the event type that triggers a Lambda@Edge function invocation. You can specify the following values:  +   ``viewer-request``: The function executes when CloudFront receives a request from a viewer and before it checks to see whether the requested object is in the edge cache.  +   ``origin-request``: The function executes only when CloudFront sends a request to your origin. When the requested object is in the edge cache, the function doesn't execute.  +   ``origin-response``: The function executes after CloudFront receives a response from the origin and before it caches the object in the response. When the requested object is in the edge cache, the function doesn't execute.  +   ``viewer-response``: The function executes before CloudFront returns the requested object to the viewer. The function executes regardless of whether the object was already in the edge cache. If the origin returns an HTTP status code other than HTTP 200 (OK), the function doesn't execute.")
  eventType?: string;

  @doc("A flag that allows a Lambda@Edge function to have read access to the body content. For more information, see [Accessing the Request Body by Choosing the Include Body Option](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/lambda-include-body-access.html) in the Amazon CloudFront Developer Guide.")
  includeBody?: boolean;

  @doc("The ARN of the Lambda@Edge function. You must specify the ARN of a function version; you can't specify an alias or $LATEST.")
  lambdaFunctionARN?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of OriginGroup")
model OriginGroup {
  @doc("A complex type that contains information about the failover criteria for an origin group. A complex data type that includes information about the failover criteria for an origin group, including the status codes for which CloudFront will failover from the primary origin to the second origin.")
  failoverCriteria?: OriginGroupFailoverCriteria;

  @doc("The origin group's ID.")
  id?: string;

  @doc("A complex type that contains information about the origins in an origin group. A complex data type for the origins included in an origin group.")
  members?: OriginGroupMembers;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CustomOriginConfig")
model CustomOriginConfig {
  @doc("The HTTP port that CloudFront uses to connect to the origin. Specify the HTTP port that the origin listens on.")
  httpPort?: int32 = 80;

  @doc("The HTTPS port that CloudFront uses to connect to the origin. Specify the HTTPS port that the origin listens on.")
  httpsPort?: int32 = 443;

  @doc("Specifies how long, in seconds, CloudFront persists its connection to the origin. The minimum timeout is 1 second, the maximum is 60 seconds, and the default (if you don't specify otherwise) is 5 seconds. For more information, see [Origin Keep-alive Timeout](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/distribution-web-values-specify.html#DownloadDistValuesOriginKeepaliveTimeout) in the *Amazon CloudFront Developer Guide*.")
  originKeepaliveTimeout?: int32 = 5;

  @doc("Specifies the protocol (HTTP or HTTPS) that CloudFront uses to connect to the origin. Valid values are:  +   ``http-only`` – CloudFront always uses HTTP to connect to the origin.  +   ``match-viewer`` – CloudFront connects to the origin using the same protocol that the viewer used to connect to CloudFront.  +   ``https-only`` – CloudFront always uses HTTPS to connect to the origin.")
  originProtocolPolicy?: string;

  @doc("Specifies how long, in seconds, CloudFront waits for a response from the origin. This is also known as the *origin response timeout*. The minimum timeout is 1 second, the maximum is 60 seconds, and the default (if you don't specify otherwise) is 30 seconds. For more information, see [Origin Response Timeout](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/distribution-web-values-specify.html#DownloadDistValuesOriginResponseTimeout) in the *Amazon CloudFront Developer Guide*.")
  originReadTimeout?: int32 = 30;

  @doc("Specifies the minimum SSL/TLS protocol that CloudFront uses when connecting to your origin over HTTPS. Valid values include ``SSLv3``, ``TLSv1``, ``TLSv1.1``, and ``TLSv1.2``. For more information, see [Minimum Origin SSL Protocol](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/distribution-web-values-specify.html#DownloadDistValuesOriginSSLProtocols) in the *Amazon CloudFront Developer Guide*.")
  @extension("x-ms-identifiers", [])
  originSSLProtocols?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of OriginCustomHeader")
model OriginCustomHeader {
  @doc("The name of a header that you want CloudFront to send to your origin. For more information, see [Adding Custom Headers to Origin Requests](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/forward-custom-headers.html) in the *Amazon CloudFront Developer Guide*.")
  headerName?: string;

  @doc("The value for the header that you specified in the ``HeaderName`` field.")
  headerValue?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of OriginShield")
model OriginShield {
  @doc("A flag that specifies whether Origin Shield is enabled. When it's enabled, CloudFront routes all requests through Origin Shield, which can help protect your origin. When it's disabled, CloudFront might send requests directly to your origin from multiple edge locations or regional edge caches.")
  enabled?: boolean;

  @doc("The AWS-Region for Origin Shield. Specify the AWS-Region that has the lowest latency to your origin. To specify a region, use the region code, not the region name. For example, specify the US East (Ohio) region as ``us-east-2``. When you enable CloudFront Origin Shield, you must specify the AWS-Region for Origin Shield. For the list of AWS-Regions that you can specify, and for help choosing the best Region for your origin, see [Choosing the for Origin Shield](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/origin-shield.html#choose-origin-shield-region) in the *Amazon CloudFront Developer Guide*.")
  originShieldRegion?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of S3OriginConfig")
model S3OriginConfig {
  @doc("The CloudFront origin access identity to associate with the origin. Use an origin access identity to configure the origin so that viewers can *only* access objects in an Amazon S3 bucket through CloudFront. The format of the value is: origin-access-identity/cloudfront/*ID-of-origin-access-identity*  where ``ID-of-origin-access-identity`` is the value that CloudFront returned in the ``ID`` element when you created the origin access identity. If you want viewers to be able to access objects using either the CloudFront URL or the Amazon S3 URL, specify an empty ``OriginAccessIdentity`` element. To delete the origin access identity from an existing distribution, update the distribution configuration and include an empty ``OriginAccessIdentity`` element. To replace the origin access identity, update the distribution configuration and specify the new origin access identity. For more information about the origin access identity, see [Serving Private Content through CloudFront](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/PrivateContent.html) in the *Amazon CloudFront Developer Guide*.")
  originAccessIdentity?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of GeoRestriction")
model GeoRestriction {
  @doc("A complex type that contains a ``Location`` element for each country in which you want CloudFront either to distribute your content or not distribute your content.")
  @extension("x-ms-identifiers", [])
  locations?: string[];

  @doc("The method that you want to use to restrict distribution of your content by country.")
  restrictionType?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Cookies")
model Cookies {
  @doc("This field is deprecated. We recommend that you use a cache policy or an origin request policy instead of this field. If you want to include cookies in the cache key, use a cache policy. For more information, see [Creating cache policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/controlling-the-cache-key.html#cache-key-create-cache-policy) in the *Amazon CloudFront Developer Guide*. If you want to send cookies to the origin but not include them in the cache key, use origin request policy. For more information, see [Creating origin request policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/controlling-origin-requests.html#origin-request-create-origin-request-policy) in the *Amazon CloudFront Developer Guide*. Specifies which cookies to forward to the origin for this cache behavior: all, none, or the list of cookies specified in the ``WhitelistedNames`` complex type. Amazon S3 doesn't process cookies. When the cache behavior is forwarding requests to an Amazon S3 origin, specify none for the ``Forward`` element.")
  forward?: string;

  @doc("This field is deprecated. We recommend that you use a cache policy or an origin request policy instead of this field. If you want to include cookies in the cache key, use a cache policy. For more information, see [Creating cache policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/controlling-the-cache-key.html#cache-key-create-cache-policy) in the *Amazon CloudFront Developer Guide*. If you want to send cookies to the origin but not include them in the cache key, use an origin request policy. For more information, see [Creating origin request policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/controlling-origin-requests.html#origin-request-create-origin-request-policy) in the *Amazon CloudFront Developer Guide*.")
  @extension("x-ms-identifiers", [])
  whitelistedNames?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of OriginGroupFailoverCriteria")
model OriginGroupFailoverCriteria {
  @doc("The status codes that, when returned from the primary origin, will trigger CloudFront to failover to the second origin. A complex data type for the status codes that you specify that, when returned by a primary origin, trigger CloudFront to failover to a second origin.")
  statusCodes?: StatusCodes;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of OriginGroupMembers")
model OriginGroupMembers {
  @doc("Items (origins) in an origin group.")
  @extension("x-ms-identifiers", [])
  items?: OriginGroupMember[];

  @doc("The number of origins in an origin group.")
  quantity?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of StatusCodes")
model StatusCodes {
  @doc("The items (status codes) for an origin group.")
  @extension("x-ms-identifiers", [])
  items?: int32[];

  @doc("The number of status codes.")
  quantity?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of OriginGroupMember")
model OriginGroupMember {
  @doc("The ID for an origin in an origin group.")
  originId?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface CloudFrontDistributions {
  get is ArmResourceRead<CloudFrontDistribution>;
  @doc("Create a CloudFrontDistribution. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<CloudFrontDistribution>;
  update is ArmCustomPatchAsync<
    CloudFrontDistribution,
    Azure.ResourceManager.Foundations.TagsUpdateModel<CloudFrontDistribution>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<CloudFrontDistribution>;
  listByResourceGroup is ArmResourceListByParent<CloudFrontDistribution>;
  listBySubscription is ArmListBySubscription<CloudFrontDistribution>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::CloudFront::Distribution
//--------------------------------------------------------------------------------------------
