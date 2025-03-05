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

//---------------------------------------------- SecretsManagerSecrets ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Secrets Manager Secret",
    plural: "Secrets Manager Secrets",
  },
  keywords: ["Microsoft.AwsConnector", "Secrets", "Manager", "Secret"],
})
@doc("A Microsoft.AwsConnector resource")
model SecretsManagerSecret is TrackedResource<SecretsManagerSecretProperties> {
  @doc("Name of SecretsManagerSecret")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("secretsManagerSecrets")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SecretsManagerSecret")
model SecretsManagerSecretProperties {
  @doc("AWS Properties")
  awsProperties?: AwsSecretsManagerSecretProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsSecretsManagerSecret")
model AwsSecretsManagerSecretProperties {
  @doc("The description of the secret.")
  description?: string;

  @doc("A structure that specifies how to generate a password to encrypt and store in the secret. To include a specific string in the secret, use ``SecretString`` instead. If you omit both ``GenerateSecretString`` and ``SecretString``, you create an empty secret. When you make a change to this property, a new secret version is created. We recommend that you specify the maximum length and include every character type that the system you are generating a password for can support. Generates a random password. We recommend that you specify the maximum length and include every character type that the system you are generating a password for can support.  *Required permissions:* ``secretsmanager:GetRandomPassword``. For more information, see [IAM policy actions for Secrets Manager](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awssecretsmanager.html#awssecretsmanager-actions-as-permissions) and [Authentication and access control in Secrets Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/auth-and-access.html).")
  generateSecretString?: GenerateSecretString;

  @doc("Property id")
  id?: string;

  @doc("The ARN, key ID, or alias of the KMS key that Secrets Manager uses to encrypt the secret value in the secret. An alias is always prefixed by ``alias/``, for example ``alias/aws/secretsmanager``. For more information, see [About aliases](https://docs.aws.amazon.com/kms/latest/developerguide/alias-about.html). To use a KMS key in a different account, use the key ARN or the alias ARN. If you don't specify this value, then Secrets Manager uses the key ``aws/secretsmanager``. If that key doesn't yet exist, then Secrets Manager creates it for you automatically the first time it encrypts the secret value. If the secret is in a different AWS account from the credentials calling the API, then you can't use ``aws/secretsmanager`` to encrypt the secret, and you must create and use a customer managed KMS key.")
  kmsKeyId?: string;

  @doc("The name of the new secret. The secret name can contain ASCII letters, numbers, and the following characters: /_+=.@- Do not end your secret name with a hyphen followed by six characters. If you do so, you risk confusion and unexpected results when searching for a secret by partial ARN. Secrets Manager automatically adds a hyphen and six random characters after the secret name at the end of the ARN.")
  name?: string;

  @doc("A custom type that specifies a ``Region`` and the ``KmsKeyId`` for a replica secret.")
  @extension("x-ms-identifiers", [])
  replicaRegions?: ReplicaRegion[];

  @doc("The text to encrypt and store in the secret. We recommend you use a JSON structure of key/value pairs for your secret value. To generate a random password, use ``GenerateSecretString`` instead. If you omit both ``GenerateSecretString`` and ``SecretString``, you create an empty secret. When you make a change to this property, a new secret version is created.")
  secretString?: string;

  @doc("A list of tags to attach to the secret. Each tag is a key and value pair of strings in a JSON text string, for example:  ``[{'Key':'CostCenter','Value':'12345'},{'Key':'environment','Value':'production'}]``  Secrets Manager tag key names are case sensitive. A tag with the key 'ABC' is a different tag from one with key 'abc'. Stack-level tags, tags you apply to the CloudFormation stack, are also attached to the secret.  If you check tags in permissions policies as part of your security strategy, then adding or removing a tag can change permissions. If the completion of this operation would result in you losing your permissions for this secret, then Secrets Manager blocks the operation and returns an ``Access Denied`` error. For more information, see [Control access to secrets using tags](https://docs.aws.amazon.com/secretsmanager/latest/userguide/auth-and-access_examples.html#tag-secrets-abac) and [Limit access to identities with tags that match secrets' tags](https://docs.aws.amazon.com/secretsmanager/latest/userguide/auth-and-access_examples.html#auth-and-access_tags2). For information about how to format a JSON parameter for the various command line tool environments, see [Using JSON for Parameters](https://docs.aws.amazon.com/cli/latest/userguide/cli-using-param.html#cli-using-param-json). If your command-line tool or SDK requires quotation marks around the parameter, you should use single quotes to avoid confusion with the double quotes required in the JSON text. The following restrictions apply to tags:  +  Maximum number of tags per secret: 50  +  Maximum key length: 127 Unicode characters in UTF-8  +  Maximum value length: 255 Unicode characters in UTF-8  +  Tag keys and values are case sensitive.  +  Do not use the ``aws:`` prefix in your tag names or values because AWS reserves it for AWS use. You can't edit or delete tag names or values with this prefix. Tags with this prefix do not count against your tags per secret limit.  +  If you use your tagging schema across multiple services and resources, other services might have restrictions on allowed characters. Generally allowed characters: letters, spaces, and numbers representable in UTF-8, plus the following special characters: + - = . _ : / @.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of GenerateSecretString")
model GenerateSecretString {
  @doc("A string of the characters that you don't want in the password.")
  excludeCharacters?: string;

  @doc("Specifies whether to exclude lowercase letters from the password. If you don't include this switch, the password can contain lowercase letters.")
  excludeLowercase?: boolean;

  @doc("Specifies whether to exclude numbers from the password. If you don't include this switch, the password can contain numbers.")
  excludeNumbers?: boolean;

  @doc("Specifies whether to exclude the following punctuation characters from the password: ``! ' # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \\ ] ^ _ ` { | } ~``. If you don't include this switch, the password can contain punctuation.")
  excludePunctuation?: boolean;

  @doc("Specifies whether to exclude uppercase letters from the password. If you don't include this switch, the password can contain uppercase letters.")
  excludeUppercase?: boolean;

  @doc("The JSON key name for the key/value pair, where the value is the generated password. This pair is added to the JSON structure specified by the ``SecretStringTemplate`` parameter. If you specify this parameter, then you must also specify ``SecretStringTemplate``.")
  generateStringKey?: string;

  @doc("Specifies whether to include the space character. If you include this switch, the password can contain space characters.")
  includeSpace?: boolean;

  @doc("The length of the password. If you don't include this parameter, the default length is 32 characters.")
  passwordLength?: int32;

  @doc("Specifies whether to include at least one upper and lowercase letter, one number, and one punctuation. If you don't include this switch, the password contains at least one of every character type.")
  requireEachIncludedType?: boolean;

  @doc("A template that the generated string must match. When you make a change to this property, a new secret version is created.")
  secretStringTemplate?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ReplicaRegion")
model ReplicaRegion {
  @doc("The ARN, key ID, or alias of the KMS key to encrypt the secret. If you don't include this field, Secrets Manager uses ``aws/secretsmanager``.")
  kmsKeyId?: string;

  @doc("A string that represents a ``Region``, for example 'us-east-1'.")
  region?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("The key identifier, or name, of the tag.")
  key?: string;

  @doc("The string value associated with the key of the tag.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface SecretsManagerSecrets {
  get is ArmResourceRead<SecretsManagerSecret>;
  @doc("Create a SecretsManagerSecret. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<SecretsManagerSecret>;
  update is ArmCustomPatchAsync<
    SecretsManagerSecret,
    Azure.ResourceManager.Foundations.TagsUpdateModel<SecretsManagerSecret>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<SecretsManagerSecret>;
  listByResourceGroup is ArmResourceListByParent<SecretsManagerSecret>;
  listBySubscription is ArmListBySubscription<SecretsManagerSecret>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::SecretsManager::Secret
//--------------------------------------------------------------------------------------------
