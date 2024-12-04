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

//---------------------------------------------- SageMakerNotebookInstanceSummaries ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Sage Maker Notebook Instance Summary",
    plural: "Sage Maker Notebook Instance Summaries",
  },
  keywords: [
    "Microsoft.AwsConnector",
    "Sage",
    "Maker",
    "Notebook",
    "Instance",
    "Summary"
  ],
})
@doc("A Microsoft.AwsConnector resource")
model SageMakerNotebookInstanceSummary
  is TrackedResource<SageMakerNotebookInstanceSummaryProperties> {
  @doc("Name of SageMakerNotebookInstanceSummary")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("sageMakerNotebookInstanceSummaries")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SageMakerNotebookInstanceSummary")
model SageMakerNotebookInstanceSummaryProperties {
  @doc("AWS Properties")
  awsProperties?: AwsSageMakerNotebookInstanceSummaryProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsSageMakerNotebookInstanceSummary")
model AwsSageMakerNotebookInstanceSummaryProperties {
  @doc("<p>An array of up to three Git repositories associated with the notebook instance. These can be either the names of Git repositories stored as resources in your account, or the URL of Git repositories in <a href='https://docs.aws.amazon.com/codecommit/latest/userguide/welcome.html'>Amazon Web Services CodeCommit</a> or in any other Git repository. These repositories are cloned at the same level as the default repository of your notebook instance. For more information, see <a href='https://docs.aws.amazon.com/sagemaker/latest/dg/nbi-git-repo.html'>Associating Git Repositories with SageMaker Notebook Instances</a>.</p>")
  @extension("x-ms-identifiers", [])
  additionalCodeRepositories?: string[];

  @doc("<p>A timestamp that shows when the notebook instance was created.</p>")
  creationTime?: utcDateTime;

  @doc("<p>The Git repository associated with the notebook instance as its default code repository. This can be either the name of a Git repository stored as a resource in your account, or the URL of a Git repository in <a href='https://docs.aws.amazon.com/codecommit/latest/userguide/welcome.html'>Amazon Web Services CodeCommit</a> or in any other Git repository. When you open a notebook instance, it opens in the directory that contains this repository. For more information, see <a href='https://docs.aws.amazon.com/sagemaker/latest/dg/nbi-git-repo.html'>Associating Git Repositories with SageMaker Notebook Instances</a>.</p>")
  defaultCodeRepository?: string;

  @doc("<p>The type of ML compute instance that the notebook instance is running on.</p>")
  instanceType?: InstanceTypeEnumValue;

  @doc("<p>A timestamp that shows when the notebook instance was last modified.</p>")
  lastModifiedTime?: utcDateTime;

  @doc("<p>The Amazon Resource Name (ARN) of the notebook instance.</p>")
  notebookInstanceArn?: string;

  @doc("<p>The name of a notebook instance lifecycle configuration associated with this notebook instance.</p> <p>For information about notebook instance lifestyle configurations, see <a href='https://docs.aws.amazon.com/sagemaker/latest/dg/notebook-lifecycle-config.html'>Step 2.1: (Optional) Customize a Notebook Instance</a>.</p>")
  notebookInstanceLifecycleConfigName?: string;

  @doc("<p>The name of the notebook instance that you want a summary for.</p>")
  notebookInstanceName?: string;

  @doc("<p>The status of the notebook instance.</p>")
  notebookInstanceStatus?: NotebookInstanceStatusEnumValue;

  @doc("<p>The URL that you use to connect to the Jupyter notebook running in your notebook instance. </p>")
  url?: string;
}

@doc("InstanceType enum")
union InstanceType {
  @doc("InstanceType enum ml.c4.2xlarge")
  MlC42xlarge: "ml.c4.2xlarge",

  @doc("InstanceType enum ml.c4.4xlarge")
  MlC44xlarge: "ml.c4.4xlarge",

  @doc("InstanceType enum ml.c4.8xlarge")
  MlC48xlarge: "ml.c4.8xlarge",

  @doc("InstanceType enum ml.c4.xlarge")
  MlC4Xlarge: "ml.c4.xlarge",

  @doc("InstanceType enum ml.c5.18xlarge")
  MlC518xlarge: "ml.c5.18xlarge",

  @doc("InstanceType enum ml.c5.2xlarge")
  MlC52xlarge: "ml.c5.2xlarge",

  @doc("InstanceType enum ml.c5.4xlarge")
  MlC54xlarge: "ml.c5.4xlarge",

  @doc("InstanceType enum ml.c5.9xlarge")
  MlC59xlarge: "ml.c5.9xlarge",

  @doc("InstanceType enum ml.c5.xlarge")
  MlC5Xlarge: "ml.c5.xlarge",

  @doc("InstanceType enum ml.c5d.18xlarge")
  MlC5d18xlarge: "ml.c5d.18xlarge",

  @doc("InstanceType enum ml.c5d.2xlarge")
  MlC5d2xlarge: "ml.c5d.2xlarge",

  @doc("InstanceType enum ml.c5d.4xlarge")
  MlC5d4xlarge: "ml.c5d.4xlarge",

  @doc("InstanceType enum ml.c5d.9xlarge")
  MlC5d9xlarge: "ml.c5d.9xlarge",

  @doc("InstanceType enum ml.c5d.xlarge")
  MlC5dXlarge: "ml.c5d.xlarge",

  @doc("InstanceType enum ml.c6i.12xlarge")
  MlC6i12xlarge: "ml.c6i.12xlarge",

  @doc("InstanceType enum ml.c6i.16xlarge")
  MlC6i16xlarge: "ml.c6i.16xlarge",

  @doc("InstanceType enum ml.c6i.24xlarge")
  MlC6i24xlarge: "ml.c6i.24xlarge",

  @doc("InstanceType enum ml.c6i.2xlarge")
  MlC6i2xlarge: "ml.c6i.2xlarge",

  @doc("InstanceType enum ml.c6i.32xlarge")
  MlC6i32xlarge: "ml.c6i.32xlarge",

  @doc("InstanceType enum ml.c6i.4xlarge")
  MlC6i4xlarge: "ml.c6i.4xlarge",

  @doc("InstanceType enum ml.c6i.8xlarge")
  MlC6i8xlarge: "ml.c6i.8xlarge",

  @doc("InstanceType enum ml.c6i.large")
  MlC6iLarge: "ml.c6i.large",

  @doc("InstanceType enum ml.c6i.xlarge")
  MlC6iXlarge: "ml.c6i.xlarge",

  @doc("InstanceType enum ml.c6id.12xlarge")
  MlC6id12xlarge: "ml.c6id.12xlarge",

  @doc("InstanceType enum ml.c6id.16xlarge")
  MlC6id16xlarge: "ml.c6id.16xlarge",

  @doc("InstanceType enum ml.c6id.24xlarge")
  MlC6id24xlarge: "ml.c6id.24xlarge",

  @doc("InstanceType enum ml.c6id.2xlarge")
  MlC6id2xlarge: "ml.c6id.2xlarge",

  @doc("InstanceType enum ml.c6id.32xlarge")
  MlC6id32xlarge: "ml.c6id.32xlarge",

  @doc("InstanceType enum ml.c6id.4xlarge")
  MlC6id4xlarge: "ml.c6id.4xlarge",

  @doc("InstanceType enum ml.c6id.8xlarge")
  MlC6id8xlarge: "ml.c6id.8xlarge",

  @doc("InstanceType enum ml.c6id.large")
  MlC6idLarge: "ml.c6id.large",

  @doc("InstanceType enum ml.c6id.xlarge")
  MlC6idXlarge: "ml.c6id.xlarge",

  @doc("InstanceType enum ml.c7i.12xlarge")
  MlC7i12xlarge: "ml.c7i.12xlarge",

  @doc("InstanceType enum ml.c7i.16xlarge")
  MlC7i16xlarge: "ml.c7i.16xlarge",

  @doc("InstanceType enum ml.c7i.24xlarge")
  MlC7i24xlarge: "ml.c7i.24xlarge",

  @doc("InstanceType enum ml.c7i.2xlarge")
  MlC7i2xlarge: "ml.c7i.2xlarge",

  @doc("InstanceType enum ml.c7i.48xlarge")
  MlC7i48xlarge: "ml.c7i.48xlarge",

  @doc("InstanceType enum ml.c7i.4xlarge")
  MlC7i4xlarge: "ml.c7i.4xlarge",

  @doc("InstanceType enum ml.c7i.8xlarge")
  MlC7i8xlarge: "ml.c7i.8xlarge",

  @doc("InstanceType enum ml.c7i.large")
  MlC7iLarge: "ml.c7i.large",

  @doc("InstanceType enum ml.c7i.xlarge")
  MlC7iXlarge: "ml.c7i.xlarge",

  @doc("InstanceType enum ml.g4dn.12xlarge")
  MlG4dn12xlarge: "ml.g4dn.12xlarge",

  @doc("InstanceType enum ml.g4dn.16xlarge")
  MlG4dn16xlarge: "ml.g4dn.16xlarge",

  @doc("InstanceType enum ml.g4dn.2xlarge")
  MlG4dn2xlarge: "ml.g4dn.2xlarge",

  @doc("InstanceType enum ml.g4dn.4xlarge")
  MlG4dn4xlarge: "ml.g4dn.4xlarge",

  @doc("InstanceType enum ml.g4dn.8xlarge")
  MlG4dn8xlarge: "ml.g4dn.8xlarge",

  @doc("InstanceType enum ml.g4dn.xlarge")
  MlG4dnXlarge: "ml.g4dn.xlarge",

  @doc("InstanceType enum ml.g5.12xlarge")
  MlG512xlarge: "ml.g5.12xlarge",

  @doc("InstanceType enum ml.g5.16xlarge")
  MlG516xlarge: "ml.g5.16xlarge",

  @doc("InstanceType enum ml.g5.24xlarge")
  MlG524xlarge: "ml.g5.24xlarge",

  @doc("InstanceType enum ml.g5.2xlarge")
  MlG52xlarge: "ml.g5.2xlarge",

  @doc("InstanceType enum ml.g5.48xlarge")
  MlG548xlarge: "ml.g5.48xlarge",

  @doc("InstanceType enum ml.g5.4xlarge")
  MlG54xlarge: "ml.g5.4xlarge",

  @doc("InstanceType enum ml.g5.8xlarge")
  MlG58xlarge: "ml.g5.8xlarge",

  @doc("InstanceType enum ml.g5.xlarge")
  MlG5Xlarge: "ml.g5.xlarge",

  @doc("InstanceType enum ml.inf1.24xlarge")
  MlInf124xlarge: "ml.inf1.24xlarge",

  @doc("InstanceType enum ml.inf1.2xlarge")
  MlInf12xlarge: "ml.inf1.2xlarge",

  @doc("InstanceType enum ml.inf1.6xlarge")
  MlInf16xlarge: "ml.inf1.6xlarge",

  @doc("InstanceType enum ml.inf1.xlarge")
  MlInf1Xlarge: "ml.inf1.xlarge",

  @doc("InstanceType enum ml.m4.10xlarge")
  MlM410xlarge: "ml.m4.10xlarge",

  @doc("InstanceType enum ml.m4.16xlarge")
  MlM416xlarge: "ml.m4.16xlarge",

  @doc("InstanceType enum ml.m4.2xlarge")
  MlM42xlarge: "ml.m4.2xlarge",

  @doc("InstanceType enum ml.m4.4xlarge")
  MlM44xlarge: "ml.m4.4xlarge",

  @doc("InstanceType enum ml.m4.xlarge")
  MlM4Xlarge: "ml.m4.xlarge",

  @doc("InstanceType enum ml.m5.12xlarge")
  MlM512xlarge: "ml.m5.12xlarge",

  @doc("InstanceType enum ml.m5.24xlarge")
  MlM524xlarge: "ml.m5.24xlarge",

  @doc("InstanceType enum ml.m5.2xlarge")
  MlM52xlarge: "ml.m5.2xlarge",

  @doc("InstanceType enum ml.m5.4xlarge")
  MlM54xlarge: "ml.m5.4xlarge",

  @doc("InstanceType enum ml.m5.xlarge")
  MlM5Xlarge: "ml.m5.xlarge",

  @doc("InstanceType enum ml.m5d.12xlarge")
  MlM5d12xlarge: "ml.m5d.12xlarge",

  @doc("InstanceType enum ml.m5d.16xlarge")
  MlM5d16xlarge: "ml.m5d.16xlarge",

  @doc("InstanceType enum ml.m5d.24xlarge")
  MlM5d24xlarge: "ml.m5d.24xlarge",

  @doc("InstanceType enum ml.m5d.2xlarge")
  MlM5d2xlarge: "ml.m5d.2xlarge",

  @doc("InstanceType enum ml.m5d.4xlarge")
  MlM5d4xlarge: "ml.m5d.4xlarge",

  @doc("InstanceType enum ml.m5d.8xlarge")
  MlM5d8xlarge: "ml.m5d.8xlarge",

  @doc("InstanceType enum ml.m5d.large")
  MlM5dLarge: "ml.m5d.large",

  @doc("InstanceType enum ml.m5d.xlarge")
  MlM5dXlarge: "ml.m5d.xlarge",

  @doc("InstanceType enum ml.m6i.12xlarge")
  MlM6i12xlarge: "ml.m6i.12xlarge",

  @doc("InstanceType enum ml.m6i.16xlarge")
  MlM6i16xlarge: "ml.m6i.16xlarge",

  @doc("InstanceType enum ml.m6i.24xlarge")
  MlM6i24xlarge: "ml.m6i.24xlarge",

  @doc("InstanceType enum ml.m6i.2xlarge")
  MlM6i2xlarge: "ml.m6i.2xlarge",

  @doc("InstanceType enum ml.m6i.32xlarge")
  MlM6i32xlarge: "ml.m6i.32xlarge",

  @doc("InstanceType enum ml.m6i.4xlarge")
  MlM6i4xlarge: "ml.m6i.4xlarge",

  @doc("InstanceType enum ml.m6i.8xlarge")
  MlM6i8xlarge: "ml.m6i.8xlarge",

  @doc("InstanceType enum ml.m6i.large")
  MlM6iLarge: "ml.m6i.large",

  @doc("InstanceType enum ml.m6i.xlarge")
  MlM6iXlarge: "ml.m6i.xlarge",

  @doc("InstanceType enum ml.m6id.12xlarge")
  MlM6id12xlarge: "ml.m6id.12xlarge",

  @doc("InstanceType enum ml.m6id.16xlarge")
  MlM6id16xlarge: "ml.m6id.16xlarge",

  @doc("InstanceType enum ml.m6id.24xlarge")
  MlM6id24xlarge: "ml.m6id.24xlarge",

  @doc("InstanceType enum ml.m6id.2xlarge")
  MlM6id2xlarge: "ml.m6id.2xlarge",

  @doc("InstanceType enum ml.m6id.32xlarge")
  MlM6id32xlarge: "ml.m6id.32xlarge",

  @doc("InstanceType enum ml.m6id.4xlarge")
  MlM6id4xlarge: "ml.m6id.4xlarge",

  @doc("InstanceType enum ml.m6id.8xlarge")
  MlM6id8xlarge: "ml.m6id.8xlarge",

  @doc("InstanceType enum ml.m6id.large")
  MlM6idLarge: "ml.m6id.large",

  @doc("InstanceType enum ml.m6id.xlarge")
  MlM6idXlarge: "ml.m6id.xlarge",

  @doc("InstanceType enum ml.m7i.12xlarge")
  MlM7i12xlarge: "ml.m7i.12xlarge",

  @doc("InstanceType enum ml.m7i.16xlarge")
  MlM7i16xlarge: "ml.m7i.16xlarge",

  @doc("InstanceType enum ml.m7i.24xlarge")
  MlM7i24xlarge: "ml.m7i.24xlarge",

  @doc("InstanceType enum ml.m7i.2xlarge")
  MlM7i2xlarge: "ml.m7i.2xlarge",

  @doc("InstanceType enum ml.m7i.48xlarge")
  MlM7i48xlarge: "ml.m7i.48xlarge",

  @doc("InstanceType enum ml.m7i.4xlarge")
  MlM7i4xlarge: "ml.m7i.4xlarge",

  @doc("InstanceType enum ml.m7i.8xlarge")
  MlM7i8xlarge: "ml.m7i.8xlarge",

  @doc("InstanceType enum ml.m7i.large")
  MlM7iLarge: "ml.m7i.large",

  @doc("InstanceType enum ml.m7i.xlarge")
  MlM7iXlarge: "ml.m7i.xlarge",

  @doc("InstanceType enum ml.p2.16xlarge")
  MlP216xlarge: "ml.p2.16xlarge",

  @doc("InstanceType enum ml.p2.8xlarge")
  MlP28xlarge: "ml.p2.8xlarge",

  @doc("InstanceType enum ml.p2.xlarge")
  MlP2Xlarge: "ml.p2.xlarge",

  @doc("InstanceType enum ml.p3.16xlarge")
  MlP316xlarge: "ml.p3.16xlarge",

  @doc("InstanceType enum ml.p3.2xlarge")
  MlP32xlarge: "ml.p3.2xlarge",

  @doc("InstanceType enum ml.p3.8xlarge")
  MlP38xlarge: "ml.p3.8xlarge",

  @doc("InstanceType enum ml.p3dn.24xlarge")
  MlP3dn24xlarge: "ml.p3dn.24xlarge",

  @doc("InstanceType enum ml.p4d.24xlarge")
  MlP4d24xlarge: "ml.p4d.24xlarge",

  @doc("InstanceType enum ml.p4de.24xlarge")
  MlP4de24xlarge: "ml.p4de.24xlarge",

  @doc("InstanceType enum ml.p5.48xlarge")
  MlP548xlarge: "ml.p5.48xlarge",

  @doc("InstanceType enum ml.r5.12xlarge")
  MlR512xlarge: "ml.r5.12xlarge",

  @doc("InstanceType enum ml.r5.16xlarge")
  MlR516xlarge: "ml.r5.16xlarge",

  @doc("InstanceType enum ml.r5.24xlarge")
  MlR524xlarge: "ml.r5.24xlarge",

  @doc("InstanceType enum ml.r5.2xlarge")
  MlR52xlarge: "ml.r5.2xlarge",

  @doc("InstanceType enum ml.r5.4xlarge")
  MlR54xlarge: "ml.r5.4xlarge",

  @doc("InstanceType enum ml.r5.8xlarge")
  MlR58xlarge: "ml.r5.8xlarge",

  @doc("InstanceType enum ml.r5.large")
  MlR5Large: "ml.r5.large",

  @doc("InstanceType enum ml.r5.xlarge")
  MlR5Xlarge: "ml.r5.xlarge",

  @doc("InstanceType enum ml.r6i.12xlarge")
  MlR6i12xlarge: "ml.r6i.12xlarge",

  @doc("InstanceType enum ml.r6i.16xlarge")
  MlR6i16xlarge: "ml.r6i.16xlarge",

  @doc("InstanceType enum ml.r6i.24xlarge")
  MlR6i24xlarge: "ml.r6i.24xlarge",

  @doc("InstanceType enum ml.r6i.2xlarge")
  MlR6i2xlarge: "ml.r6i.2xlarge",

  @doc("InstanceType enum ml.r6i.32xlarge")
  MlR6i32xlarge: "ml.r6i.32xlarge",

  @doc("InstanceType enum ml.r6i.4xlarge")
  MlR6i4xlarge: "ml.r6i.4xlarge",

  @doc("InstanceType enum ml.r6i.8xlarge")
  MlR6i8xlarge: "ml.r6i.8xlarge",

  @doc("InstanceType enum ml.r6i.large")
  MlR6iLarge: "ml.r6i.large",

  @doc("InstanceType enum ml.r6i.xlarge")
  MlR6iXlarge: "ml.r6i.xlarge",

  @doc("InstanceType enum ml.r6id.12xlarge")
  MlR6id12xlarge: "ml.r6id.12xlarge",

  @doc("InstanceType enum ml.r6id.16xlarge")
  MlR6id16xlarge: "ml.r6id.16xlarge",

  @doc("InstanceType enum ml.r6id.24xlarge")
  MlR6id24xlarge: "ml.r6id.24xlarge",

  @doc("InstanceType enum ml.r6id.2xlarge")
  MlR6id2xlarge: "ml.r6id.2xlarge",

  @doc("InstanceType enum ml.r6id.32xlarge")
  MlR6id32xlarge: "ml.r6id.32xlarge",

  @doc("InstanceType enum ml.r6id.4xlarge")
  MlR6id4xlarge: "ml.r6id.4xlarge",

  @doc("InstanceType enum ml.r6id.8xlarge")
  MlR6id8xlarge: "ml.r6id.8xlarge",

  @doc("InstanceType enum ml.r6id.large")
  MlR6idLarge: "ml.r6id.large",

  @doc("InstanceType enum ml.r6id.xlarge")
  MlR6idXlarge: "ml.r6id.xlarge",

  @doc("InstanceType enum ml.r7i.12xlarge")
  MlR7i12xlarge: "ml.r7i.12xlarge",

  @doc("InstanceType enum ml.r7i.16xlarge")
  MlR7i16xlarge: "ml.r7i.16xlarge",

  @doc("InstanceType enum ml.r7i.24xlarge")
  MlR7i24xlarge: "ml.r7i.24xlarge",

  @doc("InstanceType enum ml.r7i.2xlarge")
  MlR7i2xlarge: "ml.r7i.2xlarge",

  @doc("InstanceType enum ml.r7i.48xlarge")
  MlR7i48xlarge: "ml.r7i.48xlarge",

  @doc("InstanceType enum ml.r7i.4xlarge")
  MlR7i4xlarge: "ml.r7i.4xlarge",

  @doc("InstanceType enum ml.r7i.8xlarge")
  MlR7i8xlarge: "ml.r7i.8xlarge",

  @doc("InstanceType enum ml.r7i.large")
  MlR7iLarge: "ml.r7i.large",

  @doc("InstanceType enum ml.r7i.xlarge")
  MlR7iXlarge: "ml.r7i.xlarge",

  @doc("InstanceType enum ml.t2.2xlarge")
  MlT22xlarge: "ml.t2.2xlarge",

  @doc("InstanceType enum ml.t2.large")
  MlT2Large: "ml.t2.large",

  @doc("InstanceType enum ml.t2.medium")
  MlT2Medium: "ml.t2.medium",

  @doc("InstanceType enum ml.t2.xlarge")
  MlT2Xlarge: "ml.t2.xlarge",

  @doc("InstanceType enum ml.t3.2xlarge")
  MlT32xlarge: "ml.t3.2xlarge",

  @doc("InstanceType enum ml.t3.large")
  MlT3Large: "ml.t3.large",

  @doc("InstanceType enum ml.t3.medium")
  MlT3Medium: "ml.t3.medium",

  @doc("InstanceType enum ml.t3.xlarge")
  MlT3Xlarge: "ml.t3.xlarge",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InstanceTypeEnumValue")
model InstanceTypeEnumValue {
  @doc("Property value")
  value?: InstanceType;
}

@doc("NotebookInstanceStatus enum")
union NotebookInstanceStatus {
  @doc("NotebookInstanceStatus enum Deleting")
  Deleting: "Deleting",

  @doc("NotebookInstanceStatus enum Failed")
  Failed: "Failed",

  @doc("NotebookInstanceStatus enum InService")
  InService: "InService",

  @doc("NotebookInstanceStatus enum Pending")
  Pending: "Pending",

  @doc("NotebookInstanceStatus enum Stopped")
  Stopped: "Stopped",

  @doc("NotebookInstanceStatus enum Stopping")
  Stopping: "Stopping",

  @doc("NotebookInstanceStatus enum Updating")
  Updating: "Updating",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of NotebookInstanceStatusEnumValue")
model NotebookInstanceStatusEnumValue {
  @doc("Property value")
  value?: NotebookInstanceStatus;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface SageMakerNotebookInstanceSummaries {
  get is ArmResourceRead<SageMakerNotebookInstanceSummary>;
  @doc("Create a SageMakerNotebookInstanceSummary. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<SageMakerNotebookInstanceSummary>;
  update is ArmCustomPatchAsync<
    SageMakerNotebookInstanceSummary,
    Azure.ResourceManager.Foundations.TagsUpdateModel<SageMakerNotebookInstanceSummary>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<SageMakerNotebookInstanceSummary>;
  listByResourceGroup is ArmResourceListByParent<SageMakerNotebookInstanceSummary>;
  listBySubscription is ArmListBySubscription<SageMakerNotebookInstanceSummary>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\sagemaker\sagemaker-2017-07-24.normal.json
// AWS Shape: NotebookInstanceSummary
//
// Related information for backend service:
// AWS Servcie : SageMaker
// Product Version : 3.7.798.0
// SDK Version : 3.7.319.4
//--------------------------------------------------------------------------------------------
