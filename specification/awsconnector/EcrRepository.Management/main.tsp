import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "../shared/main.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;
using Azure.Core;
using Azure.ClientGenerator.Core;
using Azure.ResourceManager;

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
  /** 2024-08-01-preview api version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  `2024-08-01-preview`,
}

//---------------------------------------------- EcrRepositories ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@doc("A Microsoft.AwsConnector resource")
model EcrRepository is TrackedResource<EcrRepositoryProperties> {
  @doc("Name of EcrRepository")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("ecrRepositories")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EcrRepository")
model EcrRepositoryProperties {
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsEcrRepositoryProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsEcrRepository")
model AwsEcrRepositoryProperties {
  @doc("Gets and sets the property arn.")
  arn?: string;

  @doc("Gets and sets the property emptyOnDelete. If true, deleting the repository force deletes the contents of the repository. Without a force delete, you can only delete empty repositories.")
  emptyOnDelete?: boolean;

  @doc("Gets and sets the property encryptionConfiguration. The encryption configuration for the repository. This determines how the contents of your repository are encrypted at rest.By default, when no encryption configuration is set or the AES256 encryption type is used, Amazon ECR uses server-side encryption with Amazon S3-managed encryption keys which encrypts your data at rest using an AES-256 encryption algorithm. This does not require any action on your part.For more information, see https://docs.aws.amazon.com/AmazonECR/latest/userguide/encryption-at-rest.html")
  encryptionConfiguration?: EncryptionConfiguration;

  @doc("Gets and sets the property imageScanningConfiguration. The image scanning configuration for the repository. This setting determines whether images are scanned for known vulnerabilities after being pushed to the repository.")
  imageScanningConfiguration?: ImageScanningConfiguration;

  @doc("Gets and sets the property imageTagMutability. The image tag mutability setting for the repository.")
  imageTagMutability?: ImageTagMutability;

  @doc("Gets and sets the property lifecyclePolicy. The LifecyclePolicy property type specifies a lifecycle policy. For information about lifecycle policy syntax, see https://docs.aws.amazon.com/AmazonECR/latest/userguide/LifecyclePolicies.html")
  lifecyclePolicy?: LifecyclePolicy;

  @doc("Gets and sets the property repositoryName. The name to use for the repository. The repository name may be specified on its own (such as nginx-web-app) or it can be prepended with a namespace to group the repository into a category (such as project-a/nginx-web-app). If you don't specify a name, AWS CloudFormation generates a unique physical ID and uses that ID for the repository name. For more information, see https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-name.html.")
  repositoryName?: string;

  @doc("Gets and sets the property repositoryPolicyText. The JSON repository policy text to apply to the repository. For more information, see https://docs.aws.amazon.com/AmazonECR/latest/userguide/RepositoryPolicyExamples.html in the Amazon Elastic Container Registry User Guide. ")
  repositoryPolicyText?: string;

  @doc("Gets and sets the property repositoryUri.")
  repositoryUri?: string;

  @doc("Gets and sets the property tags. An array of key-value pairs to apply to this resource.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];
}

@doc("ImageTagMutability enum")
union ImageTagMutability {
  @doc("ImageTagMutability enum IMMUTABLE")
  IMMUTABLE: "IMMUTABLE",

  @doc("ImageTagMutability enum MUTABLE")
  MUTABLE: "MUTABLE",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EncryptionConfiguration")
model EncryptionConfiguration {
  @doc("Gets and sets the property encryptionType. The encryption type to use.")
  encryptionType?: string;

  @doc("Gets and sets the property kmsKey. If you use the KMS encryption type, specify the CMK to use for encryption. The alias, key ID, or full ARN of the CMK can be specified. The key must exist in the same Region as the repository. If no key is specified, the default AWS managed CMK for Amazon ECR will be used.")
  kmsKey?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ImageScanningConfiguration")
model ImageScanningConfiguration {
  @doc("Gets and sets the property scanOnPush. The setting that determines whether images are scanned after being pushed to a repository.")
  scanOnPush?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LifecyclePolicy")
model LifecyclePolicy {
  @doc("Gets and sets the property lifecyclePolicyText. The JSON repository policy text to apply to the repository.")
  lifecyclePolicyText?: string;

  @doc("Gets and sets the property registryId. The AWS account ID associated with the registry that contains the repository. If you do not specify a registry, the default registry is assumed. ")
  registryId?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("Gets and sets the property key. The key name of the tag. You can specify a value that is 1 to 127 Unicode characters in length and cannot be prefixed with aws:. You can use any of the following characters: the set of Unicode letters, digits, whitespace, _, ., /, =, +, and -. ")
  key?: string;

  @doc("Gets and sets the property value. The value for the tag. You can specify a value that is 1 to 255 Unicode characters in length and cannot be prefixed with aws:. You can use any of the following characters: the set of Unicode letters, digits, whitespace, _, ., /, =, +, and -. ")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface EcrRepositories {
  get is ArmResourceRead<EcrRepository>;
  @doc("Create a EcrRepository. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EcrRepository>;
  update is ArmCustomPatchAsync<
    EcrRepository,
    Azure.ResourceManager.Foundations.TagsUpdateModel<EcrRepository>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<EcrRepository>;
  listByResourceGroup is ArmResourceListByParent<EcrRepository>;
  listBySubscription is ArmListBySubscription<EcrRepository>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::ECR::Repository
//--------------------------------------------------------------------------------------------
