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

//---------------------------------------------- EksNodegroups ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@doc("A Microsoft.AwsConnector resource")
model EksNodegroup is TrackedResource<EksNodegroupProperties> {
  @doc("Name of EksNodegroup")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("eksNodegroups")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EksNodegroup")
model EksNodegroupProperties {
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsEksNodegroupProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsEksNodegroup")
model AwsEksNodegroupProperties {
  @doc("Gets and sets the property amiType. The AMI type for your node group.")
  amiType?: string;

  @doc("Gets and sets the property arn.")
  arn?: string;

  @doc("Gets and sets the property capacityType. The capacity type of your managed node group.")
  capacityType?: string;

  @doc("Gets and sets the property clusterName. Name of the cluster to create the node group in.")
  clusterName?: string;

  @doc("Gets and sets the property diskSize. The root device disk size (in GiB) for your node group instances.")
  diskSize?: int32;

  @doc("Gets and sets the property forceUpdateEnabled. Force the update if the existing node group's pods are unable to be drained due to a pod disruption budget issue.")
  forceUpdateEnabled?: boolean;

  @doc("Gets and sets the property id.")
  id?: string;

  @doc("Gets and sets the property instanceTypes. Specify the instance types for a node group.")
  @extension("x-ms-identifiers", [])
  instanceTypes?: string[];

  @doc("Gets and sets the property labels. The Kubernetes labels to be applied to the nodes in the node group when they are created.")
  labels?: Record<string>;

  @doc("Gets and sets the property launchTemplate. An object representing a node group's launch template specification. An object representing a launch template specification for AWS EKS Nodegroup.")
  launchTemplate?: LaunchTemplateSpecification;

  @doc("Gets and sets the property nodeRole. The Amazon Resource Name (ARN) of the IAM role to associate with your node group.")
  nodeRole?: string;

  @doc("Gets and sets the property nodegroupName. The unique name to give your node group.")
  nodegroupName?: string;

  @doc("Gets and sets the property releaseVersion. The AMI version of the Amazon EKS-optimized AMI to use with your node group.")
  releaseVersion?: string;

  @doc("Gets and sets the property remoteAccess. The remote access (SSH) configuration to use with your node group. An object representing a remote access configuration specification for AWS EKS Nodegroup.")
  remoteAccess?: RemoteAccess;

  @doc("Gets and sets the property scalingConfig. The scaling configuration details for the Auto Scaling group that is created for your node group. An object representing a auto scaling group specification for AWS EKS Nodegroup.")
  scalingConfig?: ScalingConfig;

  @doc("Gets and sets the property subnets. The subnets to use for the Auto Scaling group that is created for your node group.")
  @extension("x-ms-identifiers", [])
  subnets?: string[];

  @doc("Gets and sets the property tags. The metadata, as key-value pairs, to apply to the node group to assist with categorization and organization. Follows same schema as Labels for consistency.")
  tags?: Record<string>;

  @doc("Gets and sets the property taints. The Kubernetes taints to be applied to the nodes in the node group when they are created.")
  @extension("x-ms-identifiers", [])
  taints?: Taint[];

  @doc("Gets and sets the property updateConfig. The node group update configuration. The node group update configuration.")
  updateConfig?: UpdateConfig;

  @doc("Gets and sets the property version. The Kubernetes version to use for your managed nodes.")
  version?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LaunchTemplateSpecification")
model LaunchTemplateSpecification {
  @doc("Gets and sets the property id.")
  id?: string;

  @doc("Gets and sets the property name.")
  name?: string;

  @doc("Gets and sets the property version.")
  version?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RemoteAccess")
model RemoteAccess {
  @doc("Gets and sets the property ec2SshKey.")
  ec2SshKey?: string;

  @doc("Gets and sets the property sourceSecurityGroups.")
  @extension("x-ms-identifiers", [])
  sourceSecurityGroups?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ScalingConfig")
model ScalingConfig {
  @doc("Gets and sets the property desiredSize.")
  desiredSize?: int32;

  @doc("Gets and sets the property maxSize.")
  maxSize?: int32;

  @doc("Gets and sets the property minSize.")
  minSize?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Taint")
model Taint {
  @doc("Gets and sets the property effect.")
  effect?: string;

  @doc("Gets and sets the property key.")
  key?: string;

  @doc("Gets and sets the property value.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of UpdateConfig")
model UpdateConfig {
  @doc("Gets and sets the property maxUnavailable. The maximum number of nodes unavailable at once during a version update. Nodes will be updated in parallel. This value or maxUnavailablePercentage is required to have a value.The maximum number is 100. ")
  maxUnavailable?: int32;

  @doc("Gets and sets the property maxUnavailablePercentage. The maximum percentage of nodes unavailable during a version update. This percentage of nodes will be updated in parallel, up to 100 nodes at once. This value or maxUnavailable is required to have a value.")
  maxUnavailablePercentage?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface EksNodegroups {
  get is ArmResourceRead<EksNodegroup>;
  @doc("Create a EksNodegroup. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EksNodegroup>;
  update is ArmCustomPatchAsync<
    EksNodegroup,
    Azure.ResourceManager.Foundations.TagsUpdateModel<EksNodegroup>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<EksNodegroup>;
  listByResourceGroup is ArmResourceListByParent<EksNodegroup>;
  listBySubscription is ArmListBySubscription<EksNodegroup>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::EKS::Nodegroup
//--------------------------------------------------------------------------------------------
