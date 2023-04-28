# TypeSpec end to end scenarios

## Scenario definitions

It is crucial having simple and smooth processes that allow developer to easily:

1. [Scaffolding TypeSpec project in `rest-api-specs` repo](#1-typespec-project-scaffolding)
2. [SDK code generation in SDK repos](#2-sdk-code-generation)
   1. All SDK required information (SDK path, namespace etc) should be set in `tspconfig.yaml`.
   2. Single call via `eng/scripts` in each language repo to complete the task
   3. Optional, intelligent CI pipeline component to create related PRs when a new service API PR is submitted.
3. [TypeSpec inner dev loop](#3-inner-dev-loop-sdk-generation-local-scenario)
   1. For spec writers:
      1. locally preview generated Swagger file
      2. gather relevant files to generate rest-api-spec PRs with green CI results
   2. For SDK writers or testing
      1. locally preview generated SDK files
      2. generating SDK PRs from checked in TypeSpec files in rest-api-spec with APIView
   3. any CI failures can be reproduced locally
4. [Typespec outer dev loop `rest-api-specs`](#4-outer-loop-overall-status-and-tracking).
   1. [Spec repo outer dev loop](#41-outer-dev-loop-azure-rest-api-specs-pipeline)
   2. [SDK outer dev loop](#42-outer-dev-loop-sdk-repo-pipeline)

Aside from the developer process, we have a few goals on managing repo package version
- Should adopt a centralized package version control to avoid chaos
- Centralized package version control should give flexibility, freedom of relative independent emitter versions

## Four main user scenarios to support
#### 1. TypeSpec project scaffolding

##### Flowchart
```mermaid
flowchart TD
classDef highlight fill:#ffd700
classDef grey fill:#CCCCCC,color:#555555;
User((::)) --> |Develop in rest-api repo|A[Clone rest-api repo]
User((::)) --> |Develop in custom service repo|B1[1.2 `tsp init https://aka.ms/azure-init`]
B1-->D
A --> B[1.1 Create folder structure per spec ]
B --> C["1.2 `tsp init https://aka.ms/azure-init`<br>delete package.json in project folder"]
C --> D[...iterate on *.tsp specs]
D ---> |Loop|F
D --> E["1.3 generate swagger examples
(need a new script)"]
E --> F["tsp compile . (generate swaggers)"]
F --> G1[Copy specs files into rest-api repo]
G1 --> G2[Optionally: Adopt shift-left pipeline]
G2--> G
F --> G[create a spec PR]
class A,G,D,F grey
```
##### Remaining Tasks
| Step | Step Detail | Assignee | Implemented | Verified |
|--|--|--|--:|--:|
| 1.1 | [Folder layout doc](./typespec-structure-guidelines.md) | Ray Chen | [X] | [X] |
| 1.2 | `tsp init`. <br> additional info may be collected for SDK | Allen Zhang | [X] | [ ] |
| 1.3 | Example generation instructions | Ray Chen | [ ] | [ ] |

##### Details & Open questions

#### 2. SDK code generation

##### Flowchart
```mermaid
flowchart TD
classDef highlight fill:#ffd700
classDef grey fill:#CCCCCC,color:#555555;
User((::))-->A
A["clone Rest-API and SDK repo locally"] --> B
B["2.1 pre-requsite dependencies installation
(each language would have a installation script)"] --> C
C["2.2 TypeSpec-Project-Sync.ps1
(a.create tsp-location.yaml and drop to temp location
b.update tsp-location.yaml if existed
c.fetch specs from remote spec repo or use local spec repo)"] --> D
 D["2.3 TypeSpec-Project-Generate.ps1
(a.create scaffolding for new project
b.update tsp-location.yaml
c.copy typespec specs to temp folder
d.generate sdk code)"]
D-->E["code build"]
class A,E grey
class C,D highlight
```
- 2.2 `TypeSpec-Project-Sync.ps1`
   - input: 
     - sdkProjectDirectory
     - typespecProjectDirectory
     - repo
     - commit
     - additionalDirectories
     - localMode (use local spec and don't fetch from remote)
     - localSpecRepoPath
    Note: we might pull out tsp-location.yaml create/update part as single script to be used by #2 scenario
   - output:
     - path of sdkProjectDirectory

- Function `Get-{Language}-Tsp-Location-Path`
   - input: sdkProjectDirectory
   - output: path of tsp-location.yaml

- 2.3 `TypeSpec-Project-Generate.ps1`
   - input: 
     - projectDirectory
     - typespecAdditionalOptions (emitter options)

- Function `Generate-{Language}-New-Project-Scaffolding`
   - input: path of tsp-location.yaml

##### Remaining Tasks
| Step | Step Detail | Assignee | Implemented | Verified |
|--|--|--|--:|--:|
| 2.1 | Dependencies scripts | SDK owner | [ ] | [] |
| 2.2 | common script | EngSys | [ ] | | [ ] |
| 2.3 | common script | EngSys | [ ] | | [ ] |
| 2.4 | language script to call common script | SDK owner | [] | []
| 2.5 | update to dotnet build target | Michael, Crystal | [] | []

##### Details & Open questions
- 2.1 Optional: Scripts should exists under `\eng\scripts\` folder on all repos.
- 2.2 would involve more than just creating folder and generate `tsp-location.yaml`. There are other custom steps such as creating `test` folder, `sln` files that would vary between language repos.

#### 3. Inner Dev loop SDK generation local scenario
##### Flowchart
```mermaid
flowchart TD;
  classDef highlight fill:#ffd700
  User((::))-->A
  A
  A["clone spec repo and clone sdk repo"]-->B
  B["... iterate on .tsp specs"]-->C
  C["tsp compile ."]-->D
  D["optional:copy all related files to spec repo folder if it's not there
  (*.tsp,*.json,tspconfig.yaml)"]-->E
  D-->F
  E["create API spec PR"]-->|loop|B
  F["docker run
  (a. call `initScript` - 2.1
  b. call `generateScript` 
  (2.2 + 2.3) )"]-->I  
  D-->K
  K["optional:2.1"]-->G
  G["2.2"]-->H
  H["2.3"]-->I
  I["build code and work on test,sample,readme,etc."]-->J
  I-->|loop|B
  J["create sdk PR"]
  class F,G,H highlight
```
- Note: docker run command is
  ```
  docker run -it --privileged -v {local_spec_repo_path}:/spec-repo -v {local_work_folder}:/work-dir -v sdkgeneration.azurecr.io/sdk-generation:latest --typespec-project={relative_typespec_project} --sdk={sdk_to_generate}
  ```
##### Remaining Tasks
| Step | Step Detail | Assignee | Implemented | Verified |
|--|--|--|--:|--:|


##### Details & Open questions
Dev Inner Loop is defined as what spec/sdk developer does locally on the dev box.

Use case and design proposals
1. Optional: Create a TypeSpec self installer/package that will install all prerequisits such as node, npm, and TypeSpec
2. Spec writers [create recommended folder structures](https://github.com/Azure/azure-rest-api-specs/blob/main/documentation/typespec-structure-guidelines.md) under local clone of `azure-rest-api-specs` repo. 
3. In the correct folder, run `tsp init https://aka.ms/typespec/azure` to create TypeSpec project: ARM or DP. Project will not contain package.json but rather rely on the one in the root level. 
4. Author TypeSpec files and run `tsp compile .` to verify no errors in the TypeSpec project. It should only run `typespec-autorest` given that is the only emitter enabled via init template project. Genereated swagger would be placed in the appropriate folder. It is not expected to use --emit flag to run any SDK emitters. For that, see step 5.
5. Having a script to call OAV to generate swagger examples.
6. Optionally, after successful compile of TypeSpec project, spec author is able to run simple docker command to generate SDK for particular lanaguages locally.
7. Optionally, sdk developer can work on sdk sample, sdk test, readme, etc., locally.

#### 4.Dev Outer loop

Dev Outer Loop is defined as the experience of Spec writers sherparding the TypeSpec documents thru `azure-rest-api-sepcs` and its other depedency repos/branches like `-pr`, `-pr/RPSaasMain`, and `-pr/RPSaaSDev`, to different lanaguge SDK repos.

The experience should allow as much validations can be verified/debugged locally to ensure a clean CI for simple and fast PR reviews.

##### Use case
- With the correct inner loop setup, the spec writer should be able to submit all relevant files as PR to `azure-rest-api-specs-pr` repo or `azure-rest-api-specs` repo
- CI pipeline should verify TypeSpec compliation
- CI Pipeline should be able to generate key language SDKs (.net,java,js,python)
- Optionally CI generated key lanauge SDKs changes can be used to directly create PR on SDK public repo
- Optionally user can add customized code to the working branch created by CI pipeline.

##### 4.1 Outer Dev loop azure-rest-api-specs pipeline
###### Flowchart
```mermaid
flowchart TD;
  classDef highlight fill:#ffd700
  Pipeline((::))-->A
A["filter SDK languages to be generated
(from tspconfig.yaml)"]-->B
B["get language scripts path for `initScript` and `generateScript`
(from codegen_to_sdk_config.json)"]-->C
C["run `initScript`
(2.1)"]-->G
subgraph D["run `generateScript`"]
  G
  H
end
G["2.2"]-->H
H["2.3"]-->I
I["package sdk code"]-->J
J["optional:build code and run test"]-->K
K["upload artifacts"]-->L
L["create sdk PR or update existing PR"]-->M
M["generate apiView"]
```

###### Details & Open questions

- Step of "run `initScript`":
   - output: a string map of environment variables to be set in following scripts.
  
- Step of "run `generateScript`":
   - input: [GenerateInputSchema](https://github.com/Azure/azure-rest-api-specs/blob/main/documentation/sdkautomation/GenerateInputSchema.json)
     - specFolder
     - headSha
     - repoUrl
     - relatedTypeSpecProjectFolder

   - output: [GenerateOutputSchema](https://github.com/Azure/azure-rest-api-specs/blob/main/documentation/sdkautomation/GenerateOutputSchema.json)
   - packageName
   - result
   - path
   - changelog
   - artifacts

##### 4.2 Outer Dev loop SDK repo pipeline
###### Flowchart
```mermaid
flowchart TD;
  classDef manualStep fill:#ffd700
  classDef automationStep fill:#7de188
  Pipeline((::))-->A
A["run `initScript`
(2.1)"]-->C
subgraph B["run `generateScript`"]
  C
  D
  E
  F
  G
end
C["2.2
(a.use existing tsp-location.yaml
b.fetch specs from remote spec repo
c.then copy typespec specs to temp folder)"]-->D
D["2.3
(generate sdk code)"]-->E
E["package sdk code"]-->F
F["build code"]-->G
G["run test"]
```
###### Details & Open questions

#### 4. Outer loop Overall Status and tracking

CI pipeline implementation
  - [x] 4.1 TypeSpec validation components
    - [x] compile
    - [ ] tspconfig validation (TBA?)
    - [ ] breaking change detection (TBA?)
    - [x] generated swagger validation
  - [x] 4.2 TypeSpec SDK generation components
    - [x] code generation
    - [ ] code build and test (not all languages have)
    - [x] package generation
    - [x] API view generation
  
###### Remaining Tasks
| Step | Step Detail | Assignee | Implemented | Verified |
|--|--|--|--:|--:|
| 4.1 | Validation Component |  | [ ] | [ ] |
| 4.2 | SDK generation Component |  | [ ] | | [ ] |
