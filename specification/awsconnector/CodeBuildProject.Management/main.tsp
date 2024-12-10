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

//---------------------------------------------- CodeBuildProjects ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Code Build Project",
    plural: "Code Build Projects",
  },
  keywords: ["Microsoft.AwsConnector", "Code", "Build", "Project"],
})
@doc("A Microsoft.AwsConnector resource")
model CodeBuildProject is TrackedResource<CodeBuildProjectProperties> {
  @doc("Name of CodeBuildProject")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("codeBuildProjects")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CodeBuildProject")
model CodeBuildProjectProperties {
  @doc("AWS Properties")
  awsProperties?: AwsCodeBuildProjectProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsCodeBuildProject")
model AwsCodeBuildProjectProperties {
  @doc("<p>The Amazon Resource Name (ARN) of the build project.</p>")
  arn?: string;

  @doc("<p>Information about the build output artifacts for the build project.</p>")
  artifacts?: ProjectArtifacts;

  @doc("<p>Information about the build badge for the build project.</p>")
  badge?: ProjectBadge;

  @doc("<p>A <a>ProjectBuildBatchConfig</a> object that defines the batch build options for the project.</p>")
  buildBatchConfig?: ProjectBuildBatchConfig;

  @doc("<p>Information about the cache for the build project.</p>")
  cache?: ProjectCache;

  @doc("<p>The maximum number of concurrent builds that are allowed for this project.</p> <p>New builds are only started if the current number of builds is less than or equal to this limit. If the current build count meets this limit, new builds are throttled and are not run.</p>")
  concurrentBuildLimit?: int32;

  @doc("<p>When the build project was created, expressed in Unix time format.</p>")
  created?: utcDateTime;

  @doc("<p>A description that makes the build project easy to identify.</p>")
  description?: string;

  @doc("<p>The Key Management Service customer master key (CMK) to be used for encrypting the build output artifacts.</p> <note> <p>You can use a cross-account KMS key to encrypt the build output artifacts if your service role has permission to that key. </p> </note> <p>You can specify either the Amazon Resource Name (ARN) of the CMK or, if available, the CMK's alias (using the format <code>alias/&lt;alias-name&gt;</code>). If you don't specify a value, CodeBuild uses the managed CMK for Amazon Simple Storage Service (Amazon S3). </p>")
  encryptionKey?: string;

  @doc("<p>Information about the build environment for this build project.</p>")
  environment?: ProjectEnvironment;

  @doc("<p> An array of <code>ProjectFileSystemLocation</code> objects for a CodeBuild build project. A <code>ProjectFileSystemLocation</code> object specifies the <code>identifier</code>, <code>location</code>, <code>mountOptions</code>, <code>mountPoint</code>, and <code>type</code> of a file system created using Amazon Elastic File System. </p>")
  @extension("x-ms-identifiers", [])
  fileSystemLocations?: ProjectFileSystemLocation[];

  @doc("<p>When the build project's settings were last modified, expressed in Unix time format.</p>")
  lastModified?: utcDateTime;

  @doc("<p>Information about logs for the build project. A project can create logs in CloudWatch Logs, an S3 bucket, or both. </p>")
  logsConfig?: LogsConfig;

  @doc("<p>The name of the build project.</p>")
  name?: string;

  @doc("Property projectVisibility")
  projectVisibility?: ProjectVisibilityTypeEnumValue;

  @doc("<p>Contains the project identifier used with the public build APIs. </p>")
  publicProjectAlias?: string;

  @doc("<p>The number of minutes a build is allowed to be queued before it times out. </p>")
  queuedTimeoutInMinutes?: int32;

  @doc("<p>The ARN of the IAM role that enables CodeBuild to access the CloudWatch Logs and Amazon S3 artifacts for the project's builds.</p>")
  resourceAccessRole?: string;

  @doc("<p>An array of <code>ProjectArtifacts</code> objects. </p>")
  @extension("x-ms-identifiers", [])
  secondaryArtifacts?: ProjectArtifacts[];

  @doc("<p>An array of <code>ProjectSourceVersion</code> objects. If <code>secondarySourceVersions</code> is specified at the build level, then they take over these <code>secondarySourceVersions</code> (at the project level). </p>")
  @extension("x-ms-identifiers", [])
  secondarySourceVersions?: ProjectSourceVersion[];

  @doc("<p>An array of <code>ProjectSource</code> objects. </p>")
  @extension("x-ms-identifiers", [])
  secondarySources?: ProjectSource[];

  @doc("<p>The ARN of the IAM role that enables CodeBuild to interact with dependent Amazon Web Services services on behalf of the Amazon Web Services account.</p>")
  serviceRole?: string;

  @doc("<p>Information about the build input source code for this build project.</p>")
  source?: ProjectSource;

  @doc("<p>A version of the build input to be built for this project. If not specified, the latest version is used. If specified, it must be one of:</p> <ul> <li> <p>For CodeCommit: the commit ID, branch, or Git tag to use.</p> </li> <li> <p>For GitHub: the commit ID, pull request ID, branch name, or tag name that corresponds to the version of the source code you want to build. If a pull request ID is specified, it must use the format <code>pr/pull-request-ID</code> (for example <code>pr/25</code>). If a branch name is specified, the branch's HEAD commit ID is used. If not specified, the default branch's HEAD commit ID is used.</p> </li> <li> <p>For Bitbucket: the commit ID, branch name, or tag name that corresponds to the version of the source code you want to build. If a branch name is specified, the branch's HEAD commit ID is used. If not specified, the default branch's HEAD commit ID is used.</p> </li> <li> <p>For Amazon S3: the version ID of the object that represents the build input ZIP file to use.</p> </li> </ul> <p>If <code>sourceVersion</code> is specified at the build level, then that version takes precedence over this <code>sourceVersion</code> (at the project level). </p> <p>For more information, see <a href='https://docs.aws.amazon.com/codebuild/latest/userguide/sample-source-version.html'>Source Version Sample with CodeBuild</a> in the <i>CodeBuild User Guide</i>. </p>")
  sourceVersion?: string;

  @doc("<p>A list of tag key and value pairs associated with this build project.</p> <p>These tags are available for use by Amazon Web Services services that support CodeBuild build project tags.</p>")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("<p>How long, in minutes, from 5 to 480 (8 hours), for CodeBuild to wait before timing out any related build that did not get marked as completed. The default is 60 minutes.</p>")
  timeoutInMinutes?: int32;

  @doc("<p>Information about the VPC configuration that CodeBuild accesses.</p>")
  vpcConfig?: VpcConfig;

  @doc("<p>Information about a webhook that connects repository events to a build project in CodeBuild.</p>")
  webhook?: Webhook;
}

@doc("ProjectVisibilityType enum")
union ProjectVisibilityType {
  @doc("ProjectVisibilityType enum PRIVATE")
  PRIVATE: "PRIVATE",

  @doc("ProjectVisibilityType enum PUBLIC_READ")
  PUBLIC_READ: "PUBLIC_READ",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ProjectVisibilityTypeEnumValue")
model ProjectVisibilityTypeEnumValue {
  @doc("Property value")
  value?: ProjectVisibilityType;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ProjectArtifacts")
model ProjectArtifacts {
  @doc("<p> An identifier for this artifact definition. </p>")
  artifactIdentifier?: string;

  @doc("Property bucketOwnerAccess")
  bucketOwnerAccess?: BucketOwnerAccessEnumValue;

  @doc("<p> Set to true if you do not want your output artifacts encrypted. This option is valid only if your artifacts type is Amazon S3. If this is set with another artifacts type, an invalidInputException is thrown. </p>")
  encryptionDisabled?: boolean;

  @doc("<p>Information about the build output artifact location:</p> <ul> <li> <p>If <code>type</code> is set to <code>CODEPIPELINE</code>, CodePipeline ignores this value if specified. This is because CodePipeline manages its build output locations instead of CodeBuild.</p> </li> <li> <p>If <code>type</code> is set to <code>NO_ARTIFACTS</code>, this value is ignored if specified, because no build output is produced.</p> </li> <li> <p>If <code>type</code> is set to <code>S3</code>, this is the name of the output bucket.</p> </li> </ul>")
  location?: string;

  @doc("<p>Along with <code>path</code> and <code>namespaceType</code>, the pattern that CodeBuild uses to name and store the output artifact:</p> <ul> <li> <p>If <code>type</code> is set to <code>CODEPIPELINE</code>, CodePipeline ignores this value if specified. This is because CodePipeline manages its build output names instead of CodeBuild.</p> </li> <li> <p>If <code>type</code> is set to <code>NO_ARTIFACTS</code>, this value is ignored if specified, because no build output is produced.</p> </li> <li> <p>If <code>type</code> is set to <code>S3</code>, this is the name of the output artifact object. If you set the name to be a forward slash ('/'), the artifact is stored in the root of the output bucket.</p> </li> </ul> <p>For example:</p> <ul> <li> <p> If <code>path</code> is set to <code>MyArtifacts</code>, <code>namespaceType</code> is set to <code>BUILD_ID</code>, and <code>name</code> is set to <code>MyArtifact.zip</code>, then the output artifact is stored in <code>MyArtifacts/&lt;build-ID&gt;/MyArtifact.zip</code>. </p> </li> <li> <p> If <code>path</code> is empty, <code>namespaceType</code> is set to <code>NONE</code>, and <code>name</code> is set to '<code>/</code>', the output artifact is stored in the root of the output bucket. </p> </li> <li> <p> If <code>path</code> is set to <code>MyArtifacts</code>, <code>namespaceType</code> is set to <code>BUILD_ID</code>, and <code>name</code> is set to '<code>/</code>', the output artifact is stored in <code>MyArtifacts/&lt;build-ID&gt;</code>. </p> </li> </ul>")
  name?: string;

  @doc("<p>Along with <code>path</code> and <code>name</code>, the pattern that CodeBuild uses to determine the name and location to store the output artifact:</p> <ul> <li> <p>If <code>type</code> is set to <code>CODEPIPELINE</code>, CodePipeline ignores this value if specified. This is because CodePipeline manages its build output names instead of CodeBuild.</p> </li> <li> <p>If <code>type</code> is set to <code>NO_ARTIFACTS</code>, this value is ignored if specified, because no build output is produced.</p> </li> <li> <p>If <code>type</code> is set to <code>S3</code>, valid values include:</p> <ul> <li> <p> <code>BUILD_ID</code>: Include the build ID in the location of the build output artifact.</p> </li> <li> <p> <code>NONE</code>: Do not include the build ID. This is the default if <code>namespaceType</code> is not specified.</p> </li> </ul> </li> </ul> <p>For example, if <code>path</code> is set to <code>MyArtifacts</code>, <code>namespaceType</code> is set to <code>BUILD_ID</code>, and <code>name</code> is set to <code>MyArtifact.zip</code>, the output artifact is stored in <code>MyArtifacts/&lt;build-ID&gt;/MyArtifact.zip</code>.</p>")
  namespaceType?: ArtifactNamespaceEnumValue;

  @doc("<p> If this flag is set, a name specified in the buildspec file overrides the artifact name. The name specified in a buildspec file is calculated at build time and uses the Shell Command Language. For example, you can append a date and time to your artifact name so that it is always unique. </p>")
  overrideArtifactName?: boolean;

  @doc("<p>The type of build output artifact to create:</p> <ul> <li> <p>If <code>type</code> is set to <code>CODEPIPELINE</code>, CodePipeline ignores this value if specified. This is because CodePipeline manages its build output artifacts instead of CodeBuild.</p> </li> <li> <p>If <code>type</code> is set to <code>NO_ARTIFACTS</code>, this value is ignored if specified, because no build output is produced.</p> </li> <li> <p>If <code>type</code> is set to <code>S3</code>, valid values include:</p> <ul> <li> <p> <code>NONE</code>: CodeBuild creates in the output bucket a folder that contains the build output. This is the default if <code>packaging</code> is not specified.</p> </li> <li> <p> <code>ZIP</code>: CodeBuild creates in the output bucket a ZIP file that contains the build output.</p> </li> </ul> </li> </ul>")
  packaging?: ArtifactPackagingEnumValue;

  @doc("<p>Along with <code>namespaceType</code> and <code>name</code>, the pattern that CodeBuild uses to name and store the output artifact:</p> <ul> <li> <p>If <code>type</code> is set to <code>CODEPIPELINE</code>, CodePipeline ignores this value if specified. This is because CodePipeline manages its build output names instead of CodeBuild.</p> </li> <li> <p>If <code>type</code> is set to <code>NO_ARTIFACTS</code>, this value is ignored if specified, because no build output is produced.</p> </li> <li> <p>If <code>type</code> is set to <code>S3</code>, this is the path to the output artifact. If <code>path</code> is not specified, <code>path</code> is not used.</p> </li> </ul> <p>For example, if <code>path</code> is set to <code>MyArtifacts</code>, <code>namespaceType</code> is set to <code>NONE</code>, and <code>name</code> is set to <code>MyArtifact.zip</code>, the output artifact is stored in the output bucket at <code>MyArtifacts/MyArtifact.zip</code>.</p>")
  path?: string;

  @doc("<p>The type of build output artifact. Valid values include:</p> <ul> <li> <p> <code>CODEPIPELINE</code>: The build project has build output generated through CodePipeline. </p> <note> <p>The <code>CODEPIPELINE</code> type is not supported for <code>secondaryArtifacts</code>.</p> </note> </li> <li> <p> <code>NO_ARTIFACTS</code>: The build project does not produce any build output.</p> </li> <li> <p> <code>S3</code>: The build project stores build output in Amazon S3.</p> </li> </ul>")
  type?: ArtifactsTypeEnumValue;
}

@doc("BucketOwnerAccess enum")
union BucketOwnerAccess {
  @doc("BucketOwnerAccess enum FULL")
  FULL: "FULL",

  @doc("BucketOwnerAccess enum NONE")
  NONE: "NONE",

  @doc("BucketOwnerAccess enum READ_ONLY")
  READ_ONLY: "READ_ONLY",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of BucketOwnerAccessEnumValue")
model BucketOwnerAccessEnumValue {
  @doc("Property value")
  value?: BucketOwnerAccess;
}

@doc("ArtifactPackaging enum")
union ArtifactPackaging {
  @doc("ArtifactPackaging enum NONE")
  NONE: "NONE",

  @doc("ArtifactPackaging enum ZIP")
  ZIP: "ZIP",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ArtifactPackagingEnumValue")
model ArtifactPackagingEnumValue {
  @doc("Property value")
  value?: ArtifactPackaging;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ProjectBadge")
model ProjectBadge {
  @doc("<p>Set this to true to generate a publicly accessible URL for your project's build badge.</p>")
  badgeEnabled?: boolean;

  @doc("<p>The publicly-accessible URL through which you can access the build badge for your project. </p>")
  badgeRequestUrl?: string;
}

@doc("ArtifactNamespace enum")
union ArtifactNamespace {
  @doc("ArtifactNamespace enum BUILD_ID")
  BUILD_ID: "BUILD_ID",

  @doc("ArtifactNamespace enum NONE")
  NONE: "NONE",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ArtifactNamespaceEnumValue")
model ArtifactNamespaceEnumValue {
  @doc("Property value")
  value?: ArtifactNamespace;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ProjectBuildBatchConfig")
model ProjectBuildBatchConfig {
  @doc("<p>Specifies how build status reports are sent to the source provider for the batch build. This property is only used when the source provider for your project is Bitbucket, GitHub, or GitHub Enterprise, and your project is configured to report build statuses to the source provider.</p> <dl> <dt>REPORT_AGGREGATED_BATCH</dt> <dd> <p>(Default) Aggregate all of the build statuses into a single status report.</p> </dd> <dt>REPORT_INDIVIDUAL_BUILDS</dt> <dd> <p>Send a separate status report for each individual build.</p> </dd> </dl>")
  batchReportMode?: BatchReportModeTypeEnumValue;

  @doc("<p>Specifies if the build artifacts for the batch build should be combined into a single artifact location.</p>")
  combineArtifacts?: boolean;

  @doc("<p>A <code>BatchRestrictions</code> object that specifies the restrictions for the batch build.</p>")
  restrictions?: BatchRestrictions;

  @doc("<p>Specifies the service role ARN for the batch build project.</p>")
  serviceRole?: string;

  @doc("<p>Specifies the maximum amount of time, in minutes, that the batch build must be completed in.</p>")
  timeoutInMins?: int32;
}

@doc("ArtifactsType enum")
union ArtifactsType {
  @doc("ArtifactsType enum CODEPIPELINE")
  CODEPIPELINE: "CODEPIPELINE",

  @doc("ArtifactsType enum NO_ARTIFACTS")
  NO_ARTIFACTS: "NO_ARTIFACTS",

  @doc("ArtifactsType enum S3")
  S3: "S3",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ArtifactsTypeEnumValue")
model ArtifactsTypeEnumValue {
  @doc("Property value")
  value?: ArtifactsType;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ProjectCache")
model ProjectCache {
  @doc("<p>Information about the cache location: </p> <ul> <li> <p> <code>NO_CACHE</code> or <code>LOCAL</code>: This value is ignored.</p> </li> <li> <p> <code>S3</code>: This is the S3 bucket name/prefix.</p> </li> </ul>")
  location?: string;

  @doc("<p>An array of strings that specify the local cache modes. You can use one or more local cache modes at the same time. This is only used for <code>LOCAL</code> cache types.</p> <p>Possible values are:</p> <dl> <dt>LOCAL_SOURCE_CACHE</dt> <dd> <p>Caches Git metadata for primary and secondary sources. After the cache is created, subsequent builds pull only the change between commits. This mode is a good choice for projects with a clean working directory and a source that is a large Git repository. If you choose this option and your project does not use a Git repository (GitHub, GitHub Enterprise, or Bitbucket), the option is ignored. </p> </dd> <dt>LOCAL_DOCKER_LAYER_CACHE</dt> <dd> <p>Caches existing Docker layers. This mode is a good choice for projects that build or pull large Docker images. It can prevent the performance issues caused by pulling large Docker images down from the network. </p> <note> <ul> <li> <p>You can use a Docker layer cache in the Linux environment only. </p> </li> <li> <p>The <code>privileged</code> flag must be set so that your project has the required Docker permissions. </p> </li> <li> <p>You should consider the security implications before you use a Docker layer cache. </p> </li> </ul> </note> </dd> <dt>LOCAL_CUSTOM_CACHE</dt> <dd> <p>Caches directories you specify in the buildspec file. This mode is a good choice if your build scenario is not suited to one of the other three local cache modes. If you use a custom cache: </p> <ul> <li> <p>Only directories can be specified for caching. You cannot specify individual files. </p> </li> <li> <p>Symlinks are used to reference cached directories. </p> </li> <li> <p>Cached directories are linked to your build before it downloads its project sources. Cached items are overridden if a source item has the same name. Directories are specified using cache paths in the buildspec file. </p> </li> </ul> </dd> </dl>")
  @extension("x-ms-identifiers", [])
  modes?: CacheMode[];

  @doc("<p>The type of cache used by the build project. Valid values include:</p> <ul> <li> <p> <code>NO_CACHE</code>: The build project does not use any cache.</p> </li> <li> <p> <code>S3</code>: The build project reads and writes from and to S3.</p> </li> <li> <p> <code>LOCAL</code>: The build project stores a cache locally on a build host that is only available to that build host.</p> </li> </ul>")
  type?: CacheTypeEnumValue;
}

@doc("BatchReportModeType enum")
union BatchReportModeType {
  @doc("BatchReportModeType enum REPORT_AGGREGATED_BATCH")
  REPORT_AGGREGATED_BATCH: "REPORT_AGGREGATED_BATCH",

  @doc("BatchReportModeType enum REPORT_INDIVIDUAL_BUILDS")
  REPORT_INDIVIDUAL_BUILDS: "REPORT_INDIVIDUAL_BUILDS",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of BatchReportModeTypeEnumValue")
model BatchReportModeTypeEnumValue {
  @doc("Property value")
  value?: BatchReportModeType;
}

@doc("CacheType enum")
union CacheType {
  @doc("CacheType enum LOCAL")
  LOCAL: "LOCAL",

  @doc("CacheType enum NO_CACHE")
  NO_CACHE: "NO_CACHE",

  @doc("CacheType enum S3")
  S3: "S3",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CacheTypeEnumValue")
model CacheTypeEnumValue {
  @doc("Property value")
  value?: CacheType;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ProjectEnvironment")
model ProjectEnvironment {
  @doc("<p>The ARN of the Amazon S3 bucket, path prefix, and object key that contains the PEM-encoded certificate for the build project. For more information, see <a href='https://docs.aws.amazon.com/codebuild/latest/userguide/create-project-cli.html#cli.environment.certificate'>certificate</a> in the <i>CodeBuild User Guide</i>.</p>")
  certificate?: string;

  @doc("<p>Information about the compute resources the build project uses. Available values include:</p> <ul> <li> <p> <code>BUILD_GENERAL1_SMALL</code>: Use up to 3 GB memory and 2 vCPUs for builds.</p> </li> <li> <p> <code>BUILD_GENERAL1_MEDIUM</code>: Use up to 7 GB memory and 4 vCPUs for builds.</p> </li> <li> <p> <code>BUILD_GENERAL1_LARGE</code>: Use up to 16 GB memory and 8 vCPUs for builds, depending on your environment type.</p> </li> <li> <p> <code>BUILD_GENERAL1_XLARGE</code>: Use up to 70 GB memory and 36 vCPUs for builds, depending on your environment type.</p> </li> <li> <p> <code>BUILD_GENERAL1_2XLARGE</code>: Use up to 145 GB memory, 72 vCPUs, and 824 GB of SSD storage for builds. This compute type supports Docker images up to 100 GB uncompressed.</p> </li> <li> <p> <code>BUILD_LAMBDA_1GB</code>: Use up to 1 GB memory for builds. Only available for environment type <code>LINUX_LAMBDA_CONTAINER</code> and <code>ARM_LAMBDA_CONTAINER</code>.</p> </li> <li> <p> <code>BUILD_LAMBDA_2GB</code>: Use up to 2 GB memory for builds. Only available for environment type <code>LINUX_LAMBDA_CONTAINER</code> and <code>ARM_LAMBDA_CONTAINER</code>.</p> </li> <li> <p> <code>BUILD_LAMBDA_4GB</code>: Use up to 4 GB memory for builds. Only available for environment type <code>LINUX_LAMBDA_CONTAINER</code> and <code>ARM_LAMBDA_CONTAINER</code>.</p> </li> <li> <p> <code>BUILD_LAMBDA_8GB</code>: Use up to 8 GB memory for builds. Only available for environment type <code>LINUX_LAMBDA_CONTAINER</code> and <code>ARM_LAMBDA_CONTAINER</code>.</p> </li> <li> <p> <code>BUILD_LAMBDA_10GB</code>: Use up to 10 GB memory for builds. Only available for environment type <code>LINUX_LAMBDA_CONTAINER</code> and <code>ARM_LAMBDA_CONTAINER</code>.</p> </li> </ul> <p> If you use <code>BUILD_GENERAL1_SMALL</code>: </p> <ul> <li> <p> For environment type <code>LINUX_CONTAINER</code>, you can use up to 3 GB memory and 2 vCPUs for builds. </p> </li> <li> <p> For environment type <code>LINUX_GPU_CONTAINER</code>, you can use up to 16 GB memory, 4 vCPUs, and 1 NVIDIA A10G Tensor Core GPU for builds.</p> </li> <li> <p> For environment type <code>ARM_CONTAINER</code>, you can use up to 4 GB memory and 2 vCPUs on ARM-based processors for builds.</p> </li> </ul> <p> If you use <code>BUILD_GENERAL1_LARGE</code>: </p> <ul> <li> <p> For environment type <code>LINUX_CONTAINER</code>, you can use up to 15 GB memory and 8 vCPUs for builds. </p> </li> <li> <p> For environment type <code>LINUX_GPU_CONTAINER</code>, you can use up to 255 GB memory, 32 vCPUs, and 4 NVIDIA Tesla V100 GPUs for builds.</p> </li> <li> <p> For environment type <code>ARM_CONTAINER</code>, you can use up to 16 GB memory and 8 vCPUs on ARM-based processors for builds.</p> </li> </ul> <note> <p>If you're using compute fleets during project creation, <code>computeType</code> will be ignored.</p> </note> <p>For more information, see <a href='https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-compute-types.html'>Build Environment Compute Types</a> in the <i>CodeBuild User Guide.</i> </p>")
  computeType?: ComputeTypeEnumValue;

  @doc("<p>A set of environment variables to make available to builds for this build project.</p>")
  @extension("x-ms-identifiers", [])
  environmentVariables?: EnvironmentVariable[];

  @doc("<p>A ProjectFleet object to use for this build project.</p>")
  fleet?: ProjectFleet;

  @doc("<p>The image tag or image digest that identifies the Docker image to use for this build project. Use the following formats:</p> <ul> <li> <p>For an image tag: <code>&lt;registry&gt;/&lt;repository&gt;:&lt;tag&gt;</code>. For example, in the Docker repository that CodeBuild uses to manage its Docker images, this would be <code>aws/codebuild/standard:4.0</code>. </p> </li> <li> <p>For an image digest: <code>&lt;registry&gt;/&lt;repository&gt;@&lt;digest&gt;</code>. For example, to specify an image with the digest 'sha256:cbbf2f9a99b47fc460d422812b6a5adff7dfee951d8fa2e4a98caa0382cfbdbf,' use <code>&lt;registry&gt;/&lt;repository&gt;@sha256:cbbf2f9a99b47fc460d422812b6a5adff7dfee951d8fa2e4a98caa0382cfbdbf</code>.</p> </li> </ul> <p>For more information, see <a href='https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-available.html'>Docker images provided by CodeBuild</a> in the <i>CodeBuild user guide</i>.</p>")
  image?: string;

  @doc("<p> The type of credentials CodeBuild uses to pull images in your build. There are two valid values: </p> <ul> <li> <p> <code>CODEBUILD</code> specifies that CodeBuild uses its own credentials. This requires that you modify your ECR repository policy to trust CodeBuild service principal. </p> </li> <li> <p> <code>SERVICE_ROLE</code> specifies that CodeBuild uses your build project's service role. </p> </li> </ul> <p> When you use a cross-account or private registry image, you must use SERVICE_ROLE credentials. When you use an CodeBuild curated image, you must use CODEBUILD credentials. </p>")
  imagePullCredentialsType?: ImagePullCredentialsTypeEnumValue;

  @doc("<p>Enables running the Docker daemon inside a Docker container. Set to true only if the build project is used to build Docker images. Otherwise, a build that attempts to interact with the Docker daemon fails. The default setting is <code>false</code>.</p> <p>You can initialize the Docker daemon during the install phase of your build by adding one of the following sets of commands to the install phase of your buildspec file:</p> <p>If the operating system's base image is Ubuntu Linux:</p> <p> <code>- nohup /usr/local/bin/dockerd --host=unix:///var/run/docker.sock --host=tcp://0.0.0.0:2375 --storage-driver=overlay&amp;</code> </p> <p> <code>- timeout 15 sh -c 'until docker info; do echo .; sleep 1; done'</code> </p> <p>If the operating system's base image is Alpine Linux and the previous command does not work, add the <code>-t</code> argument to <code>timeout</code>:</p> <p> <code>- nohup /usr/local/bin/dockerd --host=unix:///var/run/docker.sock --host=tcp://0.0.0.0:2375 --storage-driver=overlay&amp;</code> </p> <p> <code>- timeout -t 15 sh -c 'until docker info; do echo .; sleep 1; done'</code> </p>")
  privilegedMode?: boolean;

  @doc("<p> The credentials for access to a private registry.</p>")
  registryCredential?: RegistryCredential;

  @doc("<p>The type of build environment to use for related builds.</p> <ul> <li> <p>The environment type <code>ARM_CONTAINER</code> is available only in regions US East (N. Virginia), US East (Ohio), US West (Oregon), EU (Ireland), Asia Pacific (Mumbai), Asia Pacific (Tokyo), Asia Pacific (Sydney), and EU (Frankfurt).</p> </li> <li> <p>The environment type <code>LINUX_CONTAINER</code> is available only in regions US East (N. Virginia), US East (Ohio), US West (Oregon), Canada (Central), EU (Ireland), EU (London), EU (Frankfurt), Asia Pacific (Tokyo), Asia Pacific (Seoul), Asia Pacific (Singapore), Asia Pacific (Sydney), China (Beijing), and China (Ningxia).</p> </li> <li> <p>The environment type <code>LINUX_GPU_CONTAINER</code> is available only in regions US East (N. Virginia), US East (Ohio), US West (Oregon), Canada (Central), EU (Ireland), EU (London), EU (Frankfurt), Asia Pacific (Tokyo), Asia Pacific (Seoul), Asia Pacific (Singapore), Asia Pacific (Sydney) , China (Beijing), and China (Ningxia).</p> </li> </ul> <ul> <li> <p>The environment types <code>ARM_LAMBDA_CONTAINER</code> and <code>LINUX_LAMBDA_CONTAINER</code> are available only in regions US East (N. Virginia), US East (Ohio), US West (Oregon), Asia Pacific (Mumbai), Asia Pacific (Singapore), Asia Pacific (Sydney), Asia Pacific (Tokyo), EU (Frankfurt), EU (Ireland), and South America (São Paulo).</p> </li> </ul> <ul> <li> <p>The environment types <code>WINDOWS_CONTAINER</code> and <code>WINDOWS_SERVER_2019_CONTAINER</code> are available only in regions US East (N. Virginia), US East (Ohio), US West (Oregon), and EU (Ireland).</p> </li> </ul> <note> <p>If you're using compute fleets during project creation, <code>type</code> will be ignored.</p> </note> <p>For more information, see <a href='https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-compute-types.html'>Build environment compute types</a> in the <i>CodeBuild user guide</i>.</p>")
  type?: EnvironmentTypeEnumValue;
}

@doc("CacheMode enum")
union CacheMode {
  @doc("CacheMode enum LOCAL_CUSTOM_CACHE")
  LOCAL_CUSTOM_CACHE: "LOCAL_CUSTOM_CACHE",

  @doc("CacheMode enum LOCAL_DOCKER_LAYER_CACHE")
  LOCAL_DOCKER_LAYER_CACHE: "LOCAL_DOCKER_LAYER_CACHE",

  @doc("CacheMode enum LOCAL_SOURCE_CACHE")
  LOCAL_SOURCE_CACHE: "LOCAL_SOURCE_CACHE",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CacheModeEnumValue")
model CacheModeEnumValue {
  @doc("Property value")
  value?: CacheMode;
}

@doc("ImagePullCredentialsType enum")
union ImagePullCredentialsType {
  @doc("ImagePullCredentialsType enum CODEBUILD")
  CODEBUILD: "CODEBUILD",

  @doc("ImagePullCredentialsType enum SERVICE_ROLE")
  SERVICE_ROLE: "SERVICE_ROLE",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ImagePullCredentialsTypeEnumValue")
model ImagePullCredentialsTypeEnumValue {
  @doc("Property value")
  value?: ImagePullCredentialsType;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ProjectFileSystemLocation")
model ProjectFileSystemLocation {
  @doc("<p>The name used to access a file system created by Amazon EFS. CodeBuild creates an environment variable by appending the <code>identifier</code> in all capital letters to <code>CODEBUILD_</code>. For example, if you specify <code>my_efs</code> for <code>identifier</code>, a new environment variable is create named <code>CODEBUILD_MY_EFS</code>. </p> <p> The <code>identifier</code> is used to mount your file system. </p>")
  identifier?: string;

  @doc("<p>A string that specifies the location of the file system created by Amazon EFS. Its format is <code>efs-dns-name:/directory-path</code>. You can find the DNS name of file system when you view it in the Amazon EFS console. The directory path is a path to a directory in the file system that CodeBuild mounts. For example, if the DNS name of a file system is <code>fs-abcd1234.efs.us-west-2.amazonaws.com</code>, and its mount directory is <code>my-efs-mount-directory</code>, then the <code>location</code> is <code>fs-abcd1234.efs.us-west-2.amazonaws.com:/my-efs-mount-directory</code>. </p> <p>The directory path in the format <code>efs-dns-name:/directory-path</code> is optional. If you do not specify a directory path, the location is only the DNS name and CodeBuild mounts the entire file system. </p>")
  location?: string;

  @doc("<p> The mount options for a file system created by Amazon EFS. The default mount options used by CodeBuild are <code>nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2</code>. For more information, see <a href='https://docs.aws.amazon.com/efs/latest/ug/mounting-fs-nfs-mount-settings.html'>Recommended NFS Mount Options</a>. </p>")
  mountOptions?: string;

  @doc("<p>The location in the container where you mount the file system. </p>")
  mountPoint?: string;

  @doc("<p> The type of the file system. The one supported type is <code>EFS</code>. </p>")
  type?: FileSystemTypeEnumValue;
}

@doc("ComputeType enum")
union ComputeType {
  @doc("ComputeType enum BUILD_GENERAL1_2XLARGE")
  BUILD_GENERAL1_2XLARGE: "BUILD_GENERAL1_2XLARGE",

  @doc("ComputeType enum BUILD_GENERAL1_LARGE")
  BUILD_GENERAL1_LARGE: "BUILD_GENERAL1_LARGE",

  @doc("ComputeType enum BUILD_GENERAL1_MEDIUM")
  BUILD_GENERAL1_MEDIUM: "BUILD_GENERAL1_MEDIUM",

  @doc("ComputeType enum BUILD_GENERAL1_SMALL")
  BUILD_GENERAL1_SMALL: "BUILD_GENERAL1_SMALL",

  @doc("ComputeType enum BUILD_GENERAL1_XLARGE")
  BUILD_GENERAL1_XLARGE: "BUILD_GENERAL1_XLARGE",

  @doc("ComputeType enum BUILD_LAMBDA_10GB")
  BUILD_LAMBDA_10GB: "BUILD_LAMBDA_10GB",

  @doc("ComputeType enum BUILD_LAMBDA_1GB")
  BUILD_LAMBDA_1GB: "BUILD_LAMBDA_1GB",

  @doc("ComputeType enum BUILD_LAMBDA_2GB")
  BUILD_LAMBDA_2GB: "BUILD_LAMBDA_2GB",

  @doc("ComputeType enum BUILD_LAMBDA_4GB")
  BUILD_LAMBDA_4GB: "BUILD_LAMBDA_4GB",

  @doc("ComputeType enum BUILD_LAMBDA_8GB")
  BUILD_LAMBDA_8GB: "BUILD_LAMBDA_8GB",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ComputeTypeEnumValue")
model ComputeTypeEnumValue {
  @doc("Property value")
  value?: ComputeType;
}

@doc("FileSystemType enum")
union FileSystemType {
  @doc("FileSystemType enum EFS")
  EFS: "EFS",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of FileSystemTypeEnumValue")
model FileSystemTypeEnumValue {
  @doc("Property value")
  value?: FileSystemType;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LogsConfig")
model LogsConfig {
  @doc("<p> Information about CloudWatch Logs for a build project. CloudWatch Logs are enabled by default. </p>")
  cloudWatchLogs?: CloudWatchLogsConfig;

  @doc("<p> Information about logs built to an S3 bucket for a build project. S3 logs are not enabled by default. </p>")
  s3Logs?: S3LogsConfig;
}

@doc("EnvironmentType enum")
union EnvironmentType {
  @doc("EnvironmentType enum ARM_CONTAINER")
  ARM_CONTAINER: "ARM_CONTAINER",

  @doc("EnvironmentType enum ARM_LAMBDA_CONTAINER")
  ARM_LAMBDA_CONTAINER: "ARM_LAMBDA_CONTAINER",

  @doc("EnvironmentType enum LINUX_CONTAINER")
  LINUX_CONTAINER: "LINUX_CONTAINER",

  @doc("EnvironmentType enum LINUX_GPU_CONTAINER")
  LINUX_GPU_CONTAINER: "LINUX_GPU_CONTAINER",

  @doc("EnvironmentType enum LINUX_LAMBDA_CONTAINER")
  LINUX_LAMBDA_CONTAINER: "LINUX_LAMBDA_CONTAINER",

  @doc("EnvironmentType enum WINDOWS_CONTAINER")
  WINDOWS_CONTAINER: "WINDOWS_CONTAINER",

  @doc("EnvironmentType enum WINDOWS_SERVER_2019_CONTAINER")
  WINDOWS_SERVER_2019_CONTAINER: "WINDOWS_SERVER_2019_CONTAINER",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EnvironmentTypeEnumValue")
model EnvironmentTypeEnumValue {
  @doc("Property value")
  value?: EnvironmentType;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ProjectSourceVersion")
model ProjectSourceVersion {
  @doc("<p>An identifier for a source in the build project. The identifier can only contain alphanumeric characters and underscores, and must be less than 128 characters in length. </p>")
  sourceIdentifier?: string;

  @doc("<p>The source version for the corresponding source identifier. If specified, must be one of:</p> <ul> <li> <p>For CodeCommit: the commit ID, branch, or Git tag to use.</p> </li> <li> <p>For GitHub or GitLab: the commit ID, pull request ID, branch name, or tag name that corresponds to the version of the source code you want to build. If a pull request ID is specified, it must use the format <code>pr/pull-request-ID</code> (for example, <code>pr/25</code>). If a branch name is specified, the branch's HEAD commit ID is used. If not specified, the default branch's HEAD commit ID is used.</p> </li> <li> <p>For Bitbucket: the commit ID, branch name, or tag name that corresponds to the version of the source code you want to build. If a branch name is specified, the branch's HEAD commit ID is used. If not specified, the default branch's HEAD commit ID is used.</p> </li> <li> <p>For Amazon S3: the version ID of the object that represents the build input ZIP file to use.</p> </li> </ul> <p> For more information, see <a href='https://docs.aws.amazon.com/codebuild/latest/userguide/sample-source-version.html'>Source Version Sample with CodeBuild</a> in the <i>CodeBuild User Guide</i>. </p>")
  sourceVersion?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ProjectSource")
model ProjectSource {
  @doc("<p>Information about the authorization settings for CodeBuild to access the source code to be built.</p> <p>This information is for the CodeBuild console's use only. Your code should not get or set this information directly.</p>")
  auth?: SourceAuth;

  @doc("<p>Contains information that defines how the build project reports the build status to the source provider. This option is only used when the source provider is <code>GITHUB</code>, <code>GITHUB_ENTERPRISE</code>, or <code>BITBUCKET</code>.</p>")
  buildStatusConfig?: BuildStatusConfig;

  @doc("<p>The buildspec file declaration to use for the builds in this build project.</p> <p> If this value is set, it can be either an inline buildspec definition, the path to an alternate buildspec file relative to the value of the built-in <code>CODEBUILD_SRC_DIR</code> environment variable, or the path to an S3 bucket. The bucket must be in the same Amazon Web Services Region as the build project. Specify the buildspec file using its ARN (for example, <code>arn:aws:s3:::my-codebuild-sample2/buildspec.yml</code>). If this value is not provided or is set to an empty string, the source code must contain a buildspec file in its root directory. For more information, see <a href='https://docs.aws.amazon.com/codebuild/latest/userguide/build-spec-ref.html#build-spec-ref-name-storage'>Buildspec File Name and Storage Location</a>. </p>")
  buildspec?: string;

  @doc("<p>Information about the Git clone depth for the build project.</p>")
  gitCloneDepth?: int32;

  @doc("<p> Information about the Git submodules configuration for the build project. </p>")
  gitSubmodulesConfig?: GitSubmodulesConfig;

  @doc("<p>Enable this flag to ignore SSL warnings while connecting to the project source code.</p>")
  insecureSsl?: boolean;

  @doc("<p>Information about the location of the source code to be built. Valid values include:</p> <ul> <li> <p>For source code settings that are specified in the source action of a pipeline in CodePipeline, <code>location</code> should not be specified. If it is specified, CodePipeline ignores it. This is because CodePipeline uses the settings in a pipeline's source action instead of this value.</p> </li> <li> <p>For source code in an CodeCommit repository, the HTTPS clone URL to the repository that contains the source code and the buildspec file (for example, <code>https://git-codecommit.&lt;region-ID&gt;.amazonaws.com/v1/repos/&lt;repo-name&gt;</code>).</p> </li> <li> <p>For source code in an Amazon S3 input bucket, one of the following. </p> <ul> <li> <p>The path to the ZIP file that contains the source code (for example, <code>&lt;bucket-name&gt;/&lt;path&gt;/&lt;object-name&gt;.zip</code>). </p> </li> <li> <p>The path to the folder that contains the source code (for example, <code>&lt;bucket-name&gt;/&lt;path-to-source-code&gt;/&lt;folder&gt;/</code>). </p> </li> </ul> </li> <li> <p>For source code in a GitHub repository, the HTTPS clone URL to the repository that contains the source and the buildspec file. You must connect your Amazon Web Services account to your GitHub account. Use the CodeBuild console to start creating a build project. When you use the console to connect (or reconnect) with GitHub, on the GitHub <b>Authorize application</b> page, for <b>Organization access</b>, choose <b>Request access</b> next to each repository you want to allow CodeBuild to have access to, and then choose <b>Authorize application</b>. (After you have connected to your GitHub account, you do not need to finish creating the build project. You can leave the CodeBuild console.) To instruct CodeBuild to use this connection, in the <code>source</code> object, set the <code>auth</code> object's <code>type</code> value to <code>OAUTH</code>.</p> </li> <li> <p>For source code in an GitLab or self-managed GitLab repository, the HTTPS clone URL to the repository that contains the source and the buildspec file. You must connect your Amazon Web Services account to your GitLab account. Use the CodeBuild console to start creating a build project. When you use the console to connect (or reconnect) with GitLab, on the Connections <b>Authorize application</b> page, choose <b>Authorize</b>. Then on the CodeConnections <b>Create GitLab connection</b> page, choose <b>Connect to GitLab</b>. (After you have connected to your GitLab account, you do not need to finish creating the build project. You can leave the CodeBuild console.) To instruct CodeBuild to override the default connection and use this connection instead, set the <code>auth</code> object's <code>type</code> value to <code>CODECONNECTIONS</code> in the <code>source</code> object.</p> </li> <li> <p>For source code in a Bitbucket repository, the HTTPS clone URL to the repository that contains the source and the buildspec file. You must connect your Amazon Web Services account to your Bitbucket account. Use the CodeBuild console to start creating a build project. When you use the console to connect (or reconnect) with Bitbucket, on the Bitbucket <b>Confirm access to your account</b> page, choose <b>Grant access</b>. (After you have connected to your Bitbucket account, you do not need to finish creating the build project. You can leave the CodeBuild console.) To instruct CodeBuild to use this connection, in the <code>source</code> object, set the <code>auth</code> object's <code>type</code> value to <code>OAUTH</code>.</p> </li> </ul> <p> If you specify <code>CODEPIPELINE</code> for the <code>Type</code> property, don't specify this property. For all of the other types, you must specify <code>Location</code>. </p>")
  location?: string;

  @doc("<p> Set to true to report the status of a build's start and finish to your source provider. This option is valid only when your source provider is GitHub, GitHub Enterprise, GitLab, GitLab Self Managed, or Bitbucket. If this is set and you use a different source provider, an <code>invalidInputException</code> is thrown. </p> <p>To be able to report the build status to the source provider, the user associated with the source provider must have write access to the repo. If the user does not have write access, the build status cannot be updated. For more information, see <a href='https://docs.aws.amazon.com/codebuild/latest/userguide/access-tokens.html'>Source provider access</a> in the <i>CodeBuild User Guide</i>.</p> <p>The status of a build triggered by a webhook is always reported to your source provider. </p> <p>If your project's builds are triggered by a webhook, you must push a new commit to the repo for a change to this property to take effect.</p>")
  reportBuildStatus?: boolean;

  @doc("<p>An identifier for this project source. The identifier can only contain alphanumeric characters and underscores, and must be less than 128 characters in length. </p>")
  sourceIdentifier?: string;

  @doc("<p>The type of repository that contains the source code to be built. Valid values include:</p> <ul> <li> <p> <code>BITBUCKET</code>: The source code is in a Bitbucket repository.</p> </li> <li> <p> <code>CODECOMMIT</code>: The source code is in an CodeCommit repository.</p> </li> <li> <p> <code>CODEPIPELINE</code>: The source code settings are specified in the source action of a pipeline in CodePipeline.</p> </li> <li> <p> <code>GITHUB</code>: The source code is in a GitHub repository.</p> </li> <li> <p> <code>GITHUB_ENTERPRISE</code>: The source code is in a GitHub Enterprise Server repository.</p> </li> <li> <p> <code>GITLAB</code>: The source code is in a GitLab repository.</p> </li> <li> <p> <code>GITLAB_SELF_MANAGED</code>: The source code is in a self-managed GitLab repository.</p> </li> <li> <p> <code>NO_SOURCE</code>: The project does not have input source code.</p> </li> <li> <p> <code>S3</code>: The source code is in an Amazon S3 bucket.</p> </li> </ul>")
  type?: SourceTypeEnumValue;
}

@doc("SourceType enum")
union SourceType {
  @doc("SourceType enum BITBUCKET")
  BITBUCKET: "BITBUCKET",

  @doc("SourceType enum CODECOMMIT")
  CODECOMMIT: "CODECOMMIT",

  @doc("SourceType enum CODEPIPELINE")
  CODEPIPELINE: "CODEPIPELINE",

  @doc("SourceType enum GITHUB")
  GITHUB: "GITHUB",

  @doc("SourceType enum GITHUB_ENTERPRISE")
  GITHUB_ENTERPRISE: "GITHUB_ENTERPRISE",

  @doc("SourceType enum GITLAB")
  GITLAB: "GITLAB",

  @doc("SourceType enum GITLAB_SELF_MANAGED")
  GITLAB_SELF_MANAGED: "GITLAB_SELF_MANAGED",

  @doc("SourceType enum NO_SOURCE")
  NO_SOURCE: "NO_SOURCE",

  @doc("SourceType enum S3")
  S3: "S3",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SourceTypeEnumValue")
model SourceTypeEnumValue {
  @doc("Property value")
  value?: SourceType;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("<p>The tag's key.</p>")
  key?: string;

  @doc("<p>The tag's value.</p>")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of VpcConfig")
model VpcConfig {
  @doc("<p>A list of one or more security groups IDs in your Amazon VPC.</p>")
  @extension("x-ms-identifiers", [])
  securityGroupIds?: string[];

  @doc("<p>A list of one or more subnet IDs in your Amazon VPC.</p>")
  @extension("x-ms-identifiers", [])
  subnets?: string[];

  @doc("<p>The ID of the Amazon VPC.</p>")
  vpcId?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Webhook")
model Webhook {
  @doc("<p>A regular expression used to determine which repository branches are built when a webhook is triggered. If the name of a branch matches the regular expression, then it is built. If <code>branchFilter</code> is empty, then all branches are built.</p> <note> <p>It is recommended that you use <code>filterGroups</code> instead of <code>branchFilter</code>. </p> </note>")
  branchFilter?: string;

  @doc("<p>Specifies the type of build this webhook will trigger.</p>")
  buildType?: WebhookBuildTypeEnumValue;

  @doc("<p>An array of arrays of <code>WebhookFilter</code> objects used to determine which webhooks are triggered. At least one <code>WebhookFilter</code> in the array must specify <code>EVENT</code> as its <code>type</code>. </p> <p>For a build to be triggered, at least one filter group in the <code>filterGroups</code> array must pass. For a filter group to pass, each of its filters must pass. </p>")
  @extension("x-ms-identifiers", [])
  filterGroups?: FilterGroup[];

  @doc("<p>A timestamp that indicates the last time a repository's secret token was modified. </p>")
  lastModifiedSecret?: utcDateTime;

  @doc("<p>The CodeBuild endpoint where webhook events are sent.</p>")
  payloadUrl?: string;

  @doc("<p>The secret token of the associated repository. </p> <note> <p>A Bitbucket webhook does not support <code>secret</code>. </p> </note>")
  secret?: string;

  @doc("<p>The URL to the webhook.</p>")
  url?: string;
}

@doc("WebhookBuildType enum")
union WebhookBuildType {
  @doc("WebhookBuildType enum BUILD")
  BUILD: "BUILD",

  @doc("WebhookBuildType enum BUILD_BATCH")
  BUILD_BATCH: "BUILD_BATCH",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of WebhookBuildTypeEnumValue")
model WebhookBuildTypeEnumValue {
  @doc("Property value")
  value?: WebhookBuildType;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of BatchRestrictions")
model BatchRestrictions {
  @doc("<p>An array of strings that specify the compute types that are allowed for the batch build. See <a href='https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-compute-types.html'>Build environment compute types</a> in the <i>CodeBuild User Guide</i> for these values. </p>")
  @extension("x-ms-identifiers", [])
  computeTypesAllowed?: string[];

  @doc("<p>Specifies the maximum number of builds allowed.</p>")
  maximumBuildsAllowed?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EnvironmentVariable")
model EnvironmentVariable {
  @doc("<p>The name or key of the environment variable.</p>")
  name?: string;

  @doc("<p>The type of environment variable. Valid values include:</p> <ul> <li> <p> <code>PARAMETER_STORE</code>: An environment variable stored in Systems Manager Parameter Store. For environment variables of this type, specify the name of the parameter as the <code>value</code> of the EnvironmentVariable. The parameter value will be substituted for the name at runtime. You can also define Parameter Store environment variables in the buildspec. To learn how to do so, see <a href='https://docs.aws.amazon.com/codebuild/latest/userguide/build-spec-ref.html#build-spec.env.parameter-store'>env/parameter-store</a> in the <i>CodeBuild User Guide</i>.</p> </li> <li> <p> <code>PLAINTEXT</code>: An environment variable in plain text format. This is the default value.</p> </li> <li> <p> <code>SECRETS_MANAGER</code>: An environment variable stored in Secrets Manager. For environment variables of this type, specify the name of the secret as the <code>value</code> of the EnvironmentVariable. The secret value will be substituted for the name at runtime. You can also define Secrets Manager environment variables in the buildspec. To learn how to do so, see <a href='https://docs.aws.amazon.com/codebuild/latest/userguide/build-spec-ref.html#build-spec.env.secrets-manager'>env/secrets-manager</a> in the <i>CodeBuild User Guide</i>.</p> </li> </ul>")
  type?: EnvironmentVariableTypeEnumValue;

  @doc("<p>The value of the environment variable.</p> <important> <p>We strongly discourage the use of <code>PLAINTEXT</code> environment variables to store sensitive values, especially Amazon Web Services secret key IDs. <code>PLAINTEXT</code> environment variables can be displayed in plain text using the CodeBuild console and the CLI. For sensitive values, we recommend you use an environment variable of type <code>PARAMETER_STORE</code> or <code>SECRETS_MANAGER</code>. </p> </important>")
  value?: string;
}

@doc("EnvironmentVariableType enum")
union EnvironmentVariableType {
  @doc("EnvironmentVariableType enum PARAMETER_STORE")
  PARAMETER_STORE: "PARAMETER_STORE",

  @doc("EnvironmentVariableType enum PLAINTEXT")
  PLAINTEXT: "PLAINTEXT",

  @doc("EnvironmentVariableType enum SECRETS_MANAGER")
  SECRETS_MANAGER: "SECRETS_MANAGER",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EnvironmentVariableTypeEnumValue")
model EnvironmentVariableTypeEnumValue {
  @doc("Property value")
  value?: EnvironmentVariableType;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ProjectFleet")
model ProjectFleet {
  @doc("<p>Specifies the compute fleet ARN for the build project.</p>")
  fleetArn?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RegistryCredential")
model RegistryCredential {
  @doc("<p> The Amazon Resource Name (ARN) or name of credentials created using Secrets Manager. </p> <note> <p> The <code>credential</code> can use the name of the credentials only if they exist in your current Amazon Web Services Region. </p> </note>")
  credential?: string;

  @doc("<p> The service that created the credentials to access a private Docker registry. The valid value, SECRETS_MANAGER, is for Secrets Manager. </p>")
  credentialProvider?: CredentialProviderTypeEnumValue;
}

@doc("CredentialProviderType enum")
union CredentialProviderType {
  @doc("CredentialProviderType enum SECRETS_MANAGER")
  SECRETS_MANAGER: "SECRETS_MANAGER",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CredentialProviderTypeEnumValue")
model CredentialProviderTypeEnumValue {
  @doc("Property value")
  value?: CredentialProviderType;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CloudWatchLogsConfig")
model CloudWatchLogsConfig {
  @doc("<p> The group name of the logs in CloudWatch Logs. For more information, see <a href='https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/Working-with-log-groups-and-streams.html'>Working with Log Groups and Log Streams</a>. </p>")
  groupName?: string;

  @doc("<p>The current status of the logs in CloudWatch Logs for a build project. Valid values are:</p> <ul> <li> <p> <code>ENABLED</code>: CloudWatch Logs are enabled for this build project.</p> </li> <li> <p> <code>DISABLED</code>: CloudWatch Logs are not enabled for this build project.</p> </li> </ul>")
  status?: LogsConfigStatusTypeEnumValue;

  @doc("<p> The prefix of the stream name of the CloudWatch Logs. For more information, see <a href='https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/Working-with-log-groups-and-streams.html'>Working with Log Groups and Log Streams</a>. </p>")
  streamName?: string;
}

@doc("LogsConfigStatusType enum")
union LogsConfigStatusType {
  @doc("LogsConfigStatusType enum DISABLED")
  DISABLED: "DISABLED",

  @doc("LogsConfigStatusType enum ENABLED")
  ENABLED: "ENABLED",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LogsConfigStatusTypeEnumValue")
model LogsConfigStatusTypeEnumValue {
  @doc("Property value")
  value?: LogsConfigStatusType;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of S3LogsConfig")
model S3LogsConfig {
  @doc("Property bucketOwnerAccess")
  bucketOwnerAccess?: BucketOwnerAccessEnumValue;

  @doc("<p> Set to true if you do not want your S3 build log output encrypted. By default S3 build logs are encrypted. </p>")
  encryptionDisabled?: boolean;

  @doc("<p> The ARN of an S3 bucket and the path prefix for S3 logs. If your Amazon S3 bucket name is <code>my-bucket</code>, and your path prefix is <code>build-log</code>, then acceptable formats are <code>my-bucket/build-log</code> or <code>arn:aws:s3:::my-bucket/build-log</code>. </p>")
  location?: string;

  @doc("<p>The current status of the S3 build logs. Valid values are:</p> <ul> <li> <p> <code>ENABLED</code>: S3 build logs are enabled for this build project.</p> </li> <li> <p> <code>DISABLED</code>: S3 build logs are not enabled for this build project.</p> </li> </ul>")
  status?: LogsConfigStatusTypeEnumValue;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SourceAuth")
model SourceAuth {
  @doc("<p>The resource value that applies to the specified authorization type.</p>")
  resource?: string;

  @doc("<p>The authorization type to use. Valid options are OAUTH or CODECONNECTIONS.</p>")
  type?: SourceAuthTypeEnumValue;
}

@doc("SourceAuthType enum")
union SourceAuthType {
  @doc("SourceAuthType enum CODECONNECTIONS")
  CODECONNECTIONS: "CODECONNECTIONS",

  @doc("SourceAuthType enum OAUTH")
  OAUTH: "OAUTH",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SourceAuthTypeEnumValue")
model SourceAuthTypeEnumValue {
  @doc("Property value")
  value?: SourceAuthType;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of BuildStatusConfig")
model BuildStatusConfig {
  @doc("<p>Specifies the context of the build status CodeBuild sends to the source provider. The usage of this parameter depends on the source provider.</p> <dl> <dt>Bitbucket</dt> <dd> <p>This parameter is used for the <code>name</code> parameter in the Bitbucket commit status. For more information, see <a href='https://developer.atlassian.com/bitbucket/api/2/reference/resource/repositories/%7Bworkspace%7D/%7Brepo_slug%7D/commit/%7Bnode%7D/statuses/build'>build</a> in the Bitbucket API documentation.</p> </dd> <dt>GitHub/GitHub Enterprise Server</dt> <dd> <p>This parameter is used for the <code>context</code> parameter in the GitHub commit status. For more information, see <a href='https://developer.github.com/v3/repos/statuses/#create-a-commit-status'>Create a commit status</a> in the GitHub developer guide.</p> </dd> </dl>")
  context?: string;

  @doc("<p>Specifies the target url of the build status CodeBuild sends to the source provider. The usage of this parameter depends on the source provider.</p> <dl> <dt>Bitbucket</dt> <dd> <p>This parameter is used for the <code>url</code> parameter in the Bitbucket commit status. For more information, see <a href='https://developer.atlassian.com/bitbucket/api/2/reference/resource/repositories/%7Bworkspace%7D/%7Brepo_slug%7D/commit/%7Bnode%7D/statuses/build'>build</a> in the Bitbucket API documentation.</p> </dd> <dt>GitHub/GitHub Enterprise Server</dt> <dd> <p>This parameter is used for the <code>target_url</code> parameter in the GitHub commit status. For more information, see <a href='https://developer.github.com/v3/repos/statuses/#create-a-commit-status'>Create a commit status</a> in the GitHub developer guide.</p> </dd> </dl>")
  targetUrl?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of GitSubmodulesConfig")
model GitSubmodulesConfig {
  @doc("<p> Set to true to fetch Git submodules for your CodeBuild build project. </p>")
  fetchSubmodules?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of FilterGroup")
model FilterGroup {
  @doc("Property webhookFilter")
  webhookFilter?: WebhookFilter;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of WebhookFilter")
model WebhookFilter {
  @doc("<p> Used to indicate that the <code>pattern</code> determines which webhook events do not trigger a build. If true, then a webhook event that does not match the <code>pattern</code> triggers a build. If false, then a webhook event that matches the <code>pattern</code> triggers a build. </p>")
  excludeMatchedPattern?: boolean;

  @doc("<p> For a <code>WebHookFilter</code> that uses <code>EVENT</code> type, a comma-separated string that specifies one or more events. For example, the webhook filter <code>PUSH, PULL_REQUEST_CREATED, PULL_REQUEST_UPDATED</code> allows all push, pull request created, and pull request updated events to trigger a build. </p> <p> For a <code>WebHookFilter</code> that uses any of the other filter types, a regular expression pattern. For example, a <code>WebHookFilter</code> that uses <code>HEAD_REF</code> for its <code>type</code> and the pattern <code>^refs/heads/</code> triggers a build when the head reference is a branch with a reference name <code>refs/heads/branch-name</code>. </p>")
  pattern?: string;

  @doc("<p> The type of webhook filter. There are nine webhook filter types: <code>EVENT</code>, <code>ACTOR_ACCOUNT_ID</code>, <code>HEAD_REF</code>, <code>BASE_REF</code>, <code>FILE_PATH</code>, <code>COMMIT_MESSAGE</code>, <code>TAG_NAME</code>, <code>RELEASE_NAME</code>, and <code>WORKFLOW_NAME</code>. </p> <ul> <li> <p> EVENT </p> <ul> <li> <p> A webhook event triggers a build when the provided <code>pattern</code> matches one of nine event types: <code>PUSH</code>, <code>PULL_REQUEST_CREATED</code>, <code>PULL_REQUEST_UPDATED</code>, <code>PULL_REQUEST_CLOSED</code>, <code>PULL_REQUEST_REOPENED</code>, <code>PULL_REQUEST_MERGED</code>, <code>RELEASED</code>, <code>PRERELEASED</code>, and <code>WORKFLOW_JOB_QUEUED</code>. The <code>EVENT</code> patterns are specified as a comma-separated string. For example, <code>PUSH, PULL_REQUEST_CREATED, PULL_REQUEST_UPDATED</code> filters all push, pull request created, and pull request updated events. </p> <note> <p> The <code>PULL_REQUEST_REOPENED</code> works with GitHub and GitHub Enterprise only. The <code>RELEASED</code>, <code>PRERELEASED</code>, and <code>WORKFLOW_JOB_QUEUED</code> work with GitHub only.</p> </note> </li> </ul> </li> <li> <p>ACTOR_ACCOUNT_ID</p> <ul> <li> <p> A webhook event triggers a build when a GitHub, GitHub Enterprise, or Bitbucket account ID matches the regular expression <code>pattern</code>. </p> </li> </ul> </li> <li> <p>HEAD_REF</p> <ul> <li> <p> A webhook event triggers a build when the head reference matches the regular expression <code>pattern</code>. For example, <code>refs/heads/branch-name</code> and <code>refs/tags/tag-name</code>. </p> <note> <p> Works with GitHub and GitHub Enterprise push, GitHub and GitHub Enterprise pull request, Bitbucket push, and Bitbucket pull request events.</p> </note> </li> </ul> </li> <li> <p>BASE_REF</p> <ul> <li> <p> A webhook event triggers a build when the base reference matches the regular expression <code>pattern</code>. For example, <code>refs/heads/branch-name</code>. </p> <note> <p> Works with pull request events only. </p> </note> </li> </ul> </li> <li> <p>FILE_PATH</p> <ul> <li> <p> A webhook triggers a build when the path of a changed file matches the regular expression <code>pattern</code>. </p> <note> <p> Works with GitHub and Bitbucket events push and pull requests events. Also works with GitHub Enterprise push events, but does not work with GitHub Enterprise pull request events. </p> </note> </li> </ul> </li> <li> <p>COMMIT_MESSAGE</p> <ul> <li> <p>A webhook triggers a build when the head commit message matches the regular expression <code>pattern</code>.</p> <note> <p> Works with GitHub and Bitbucket events push and pull requests events. Also works with GitHub Enterprise push events, but does not work with GitHub Enterprise pull request events. </p> </note> </li> </ul> </li> <li> <p>TAG_NAME</p> <ul> <li> <p>A webhook triggers a build when the tag name of the release matches the regular expression <code>pattern</code>.</p> <note> <p> Works with <code>RELEASED</code> and <code>PRERELEASED</code> events only. </p> </note> </li> </ul> </li> <li> <p>RELEASE_NAME</p> <ul> <li> <p>A webhook triggers a build when the release name matches the regular expression <code>pattern</code>.</p> <note> <p> Works with <code>RELEASED</code> and <code>PRERELEASED</code> events only. </p> </note> </li> </ul> </li> <li> <p>WORKFLOW_NAME</p> <ul> <li> <p>A webhook triggers a build when the workflow name matches the regular expression <code>pattern</code>.</p> <note> <p> Works with <code>WORKFLOW_JOB_QUEUED</code> events only. </p> </note> </li> </ul> </li> </ul>")
  type?: WebhookFilterTypeEnumValue;
}

@doc("WebhookFilterType enum")
union WebhookFilterType {
  @doc("WebhookFilterType enum ACTOR_ACCOUNT_ID")
  ACTOR_ACCOUNT_ID: "ACTOR_ACCOUNT_ID",

  @doc("WebhookFilterType enum BASE_REF")
  BASE_REF: "BASE_REF",

  @doc("WebhookFilterType enum COMMIT_MESSAGE")
  COMMIT_MESSAGE: "COMMIT_MESSAGE",

  @doc("WebhookFilterType enum EVENT")
  EVENT: "EVENT",

  @doc("WebhookFilterType enum FILE_PATH")
  FILE_PATH: "FILE_PATH",

  @doc("WebhookFilterType enum HEAD_REF")
  HEAD_REF: "HEAD_REF",

  @doc("WebhookFilterType enum RELEASE_NAME")
  RELEASE_NAME: "RELEASE_NAME",

  @doc("WebhookFilterType enum TAG_NAME")
  TAG_NAME: "TAG_NAME",

  @doc("WebhookFilterType enum WORKFLOW_NAME")
  WORKFLOW_NAME: "WORKFLOW_NAME",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of WebhookFilterTypeEnumValue")
model WebhookFilterTypeEnumValue {
  @doc("Property value")
  value?: WebhookFilterType;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface CodeBuildProjects {
  get is ArmResourceRead<CodeBuildProject>;
  @doc("Create a CodeBuildProject. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<CodeBuildProject>;
  update is ArmCustomPatchAsync<
    CodeBuildProject,
    Azure.ResourceManager.Foundations.TagsUpdateModel<CodeBuildProject>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<CodeBuildProject>;
  listByResourceGroup is ArmResourceListByParent<CodeBuildProject>;
  listBySubscription is ArmListBySubscription<CodeBuildProject>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\codeBuild\codebuild-2016-10-06.normal.json
// AWS Shape: Project
//
// Related information for backend service:
// AWS Servcie : CodeBuild
// Product Version : 3.7.798.0
// SDK Version : 3.7.306.11
//--------------------------------------------------------------------------------------------
