using Azure.ClientGenerator.Core;
using Azure.AI.Projects;

interface Datasets {}
@@clientLocation(Azure.AI.Projects.DataGenerationJobs.get, Datasets);
@@clientLocation(Azure.AI.Projects.DataGenerationJobs.list, Datasets);
@@clientLocation(Azure.AI.Projects.DataGenerationJobs.create, Datasets);
@@clientLocation(Azure.AI.Projects.DataGenerationJobs.cancel, Datasets);
@@clientLocation(Azure.AI.Projects.DataGenerationJobs.delete, Datasets);
