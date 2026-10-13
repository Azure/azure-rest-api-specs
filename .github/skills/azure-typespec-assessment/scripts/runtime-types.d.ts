export type JsonPrimitive = null | boolean | number | string;
export type JsonValue = JsonPrimitive | JsonObject | JsonArray;

export interface JsonObject {
  [key: string]: JsonValue;
}

export type JsonArray = JsonValue[];

export type SourceRevision = "base" | "current";

export interface SourceRange {
  startLine: number;
  endLine: number;
}

export interface DiffHunk {
  id: string;
  base: SourceRange;
  current: SourceRange;
  lines: string[];
}

export interface SourceLocation {
  revision: SourceRevision;
  startLine: number;
  endLine: number;
  link?: string;
  path?: string;
}

export interface SourceDeclaration {
  id: string;
  kind: string;
  qualifiedName: string;
  decorators: (string | { name?: string; definition?: string })[];
  baseType?: string;
  templateArguments?: string[];
  newDeclaration?: boolean;
  project?: string;
  revision?: string;
  versionedMembers: string[];
  hunkIds: string[];
  source: SourceLocation;
  documentationPresent?: boolean;
  compilerEvidence?: {
    kind: string;
    compilerTypeKind?: string;
    sourceFile?: string;
    position?: { start: number; end: number };
    referencedNames: string[];
  };
  sourceSnippet?: {
    startLine: number;
    endLine: number;
    lines: string[];
    truncated: boolean;
  };
}

export interface SourceChange {
  id: string;
  path: string;
  status: string;
  origins: string[];
  hunks: DiffHunk[];
  declarations: SourceDeclaration[];
  documentEvidence?: {
    schemaVersion: number;
    status: "blocked" | "ready";
    blockers: { revision: string; message: string }[];
    declarations: {
      declarationId: string;
      qualifiedName: string;
      kind: string;
      newDeclaration: boolean;
      documentationPresent?: boolean;
      source: SourceLocation;
    }[];
    documents?: (DocumentationDocument & {
      hunkIds: string[];
      blocker?: string;
    })[];
  };
}

export interface SourceIndex {
  schemaVersion: number;
  analysis: {
    status: string;
    authority: string;
    compilerVersions?: string[];
    operationProjectionStats?: {
      revision: string;
      project: string;
      operationCount: number;
      changedNameCount: number;
      matchedOperationCount: number;
    }[];
    blockers: { revision: string; project?: string; message: string }[];
  };
  sourceChanges: SourceChange[];
  referencedDeclarations?: Record<string, ReferencedDeclaration>;
  resourceModels?: Record<string, ResourceModel>;
}

export interface ReferencedDeclaration {
  id: string;
  kind: "operation";
  qualifiedName: string;
  revision: string;
  project: string;
  compilerEvidence: {
    kind: "operation-projection";
    referencedNames: string[];
  };
  source: {
    revision: string;
    path: string;
    startLine: number;
    endLine: number;
  };
}

export interface ResourceModel {
  name: string;
  revision: string;
  project: string;
  sourcePath: string;
  baseModel?: string;
  decorators: string[];
  parentResource?: string;
}

export interface CompilerFile {
  path: string;
  text: string;
  getLineAndCharacterOfPosition(position: number): {
    line: number;
    character: number;
  };
}

export interface CompilerTypeCollection {
  values(): Iterable<CompilerType>;
}

export interface CompilerDecorator {
  decorator?: { name?: string };
  definition?: { name?: string };
  node?: { target?: { sv?: string } };
  args?: { value?: { name?: string } }[];
}

export interface CompilerType {
  kind?: string;
  name?: string | number;
  interface?: CompilerType;
  model?: CompilerType;
  enum?: CompilerType;
  union?: CompilerType;
  parameters?: CompilerType;
  returnType?: CompilerType;
  baseModel?: CompilerType;
  sourceModel?: CompilerType;
  indexer?: { value?: CompilerType };
  properties?: CompilerTypeCollection;
  type?: CompilerType;
  variants?: CompilerTypeCollection;
  values?: CompilerType[];
  decorators?: CompilerDecorator[];
}

export interface CompilerProgram {
  diagnostics: { severity: string }[];
  sourceFiles: Map<string, { file: CompilerFile }>;
}

export interface CompilerLocation {
  file?: CompilerFile;
  pos: number;
  end: number;
}

export interface CompilerApi {
  compilerVersion?: string;
  NodeHost: unknown;
  compile(
    host: unknown,
    project: string,
    options: { noEmit: boolean },
  ): CompilerProgram | Promise<CompilerProgram>;
  navigateProgram(
    program: CompilerProgram,
    listeners: Record<string, (type: CompilerType) => void>,
  ): void;
  getSourceLocation(type: CompilerType): CompilerLocation;
  getDoc?(program: CompilerProgram, type: CompilerType): string | undefined;
}

export interface OpenApiSchema {
  $ref?: string;
  type?: string;
  format?: string;
  properties?: Record<string, OpenApiSchema>;
  required?: string[];
  enum?: unknown[];
  items?: OpenApiSchema;
  additionalProperties?: boolean | OpenApiSchema;
  allOf?: OpenApiSchema[];
  collectionFormat?: unknown;
  discriminator?: unknown;
  "x-nullable"?: unknown;
  "x-ms-discriminator-value"?: unknown;
  "x-ms-mutability"?: unknown;
  "x-ms-client-default"?: unknown;
  "x-ms-enum"?: { name?: unknown; modelAsString?: unknown };
  [key: string]: unknown;
}

export interface OpenApiParameter extends OpenApiSchema {
  name?: string;
  in?: string;
  schema?: OpenApiSchema;
  allowEmptyValue?: unknown;
  "x-ms-skip-url-encoding"?: unknown;
}

export type OpenApiHeader = OpenApiSchema;

export interface OpenApiResponse {
  $ref?: string;
  headers?: Record<string, OpenApiHeader>;
  schema?: OpenApiSchema;
  "x-ms-error-response"?: boolean;
  [key: string]: unknown;
}

export interface OpenApiOperation {
  operationId?: string;
  parameters?: OpenApiParameter[];
  responses?: Record<string, OpenApiResponse>;
  consumes?: string[];
  produces?: string[];
  "x-ms-pageable"?: unknown;
  "x-ms-long-running-operation"?: boolean;
  "x-ms-long-running-operation-options"?: Record<string, unknown>;
  [key: string]: unknown;
}

export interface OpenApiPathItem {
  parameters?: OpenApiParameter[];
  [key: string]: unknown;
}

export interface OpenApiDocument {
  swagger?: string;
  openapi?: string;
  info?: { version?: string };
  consumes?: string[];
  produces?: string[];
  paths?: Record<string, OpenApiPathItem>;
  "x-ms-paths"?: Record<string, OpenApiPathItem>;
  [key: string]: unknown;
}

export interface AutorestDocument {
  path: string;
  absolutePath: string;
  documentRole: string;
  document: OpenApiDocument;
  id?: string;
}

export interface AutorestArtifact {
  format?: string;
  files?: { path: string; documentRole?: string }[];
  serviceManifestPath?: string;
  outputDirectory?: string;
}

export interface AutorestContext {
  document: AutorestDocument;
  registry: Map<string, AutorestDocument>;
  pointer: string;
  route?: string;
  routeSource?: string;
  method?: string;
}

export interface NormalizedSchema {
  kind: string;
  type?: string;
  format?: string;
  values?: (string | number | boolean)[];
  enumMetadata?: { name?: string; [key: string]: unknown };
  items?: NormalizedSchema;
  properties?: {
    name: string;
    required: boolean;
    schema: NormalizedSchema;
  }[];
  additionalProperties?: boolean | NormalizedSchema;
  allOf?: NormalizedSchema[];
  reference?: string;
  references?: string[];
  ref?: string;
  unresolved?: boolean;
  cycle?: boolean;
  [key: string]: unknown;
}

export type TcgcCollection<T> = Map<unknown, T> | Record<string, T>;

export interface TcgcNode {
  [key: string]: unknown;
  access?: string;
  additionalProperties?: TcgcNode;
  apiVersions?: unknown[] | TcgcCollection<unknown>;
  baseModel?: TcgcNode;
  binary?: TcgcNode;
  bodyParam?: TcgcNode;
  children?: TcgcNode[];
  clients?: TcgcNode[];
  correspondingMethodParams?: unknown[];
  crossLanguageDefinitionId?: string;
  discriminatorPropertyName?: string;
  discriminatedOptions?: TcgcNode;
  discriminatedSubtypes?: TcgcCollection<TcgcNode>;
  discriminator?: boolean;
  discriminatorProperty?: TcgcNode;
  enumType?: TcgcNode;
  external?: TcgcNode;
  finalResponse?: TcgcNode;
  finalResultPath?: string;
  finalStateVia?: string;
  finalStep?: TcgcNode;
  fullName?: string;
  headers?: TcgcNode[];
  json?: TcgcNode;
  keyType?: TcgcNode;
  kind?: string;
  link?: TcgcNode;
  location?: string;
  logicalPath?: string;
  logicalResult?: TcgcNode;
  lroMetadata?: TcgcNode;
  metadata?: TcgcNode;
  methodParameterSegments?: unknown[];
  methods?: TcgcNode[];
  models?: TcgcNode[];
  multipart?: TcgcNode;
  multipartOptions?: TcgcNode;
  name?: string;
  namespaces?: TcgcNode[];
  nextLinkOperation?: TcgcNode;
  operation?: TcgcNode;
  parameterMap?: TcgcCollection<TcgcNode | string>;
  parameters?: TcgcNode[] | TcgcCollection<TcgcNode>;
  parent?: TcgcNode;
  pagingMetadata?: TcgcNode;
  pollingInfo?: TcgcNode;
  pollingStep?: TcgcNode;
  properties?: TcgcNode[];
  property?: TcgcNode;
  response?: TcgcNode;
  responseModel?: TcgcNode | "void";
  responses?: TcgcNode[];
  resultProperty?: TcgcNode;
  errorProperty?: TcgcNode;
  resultSegments?: unknown[];
  scheme?: TcgcNode | string;
  serializationOptions?: TcgcNode;
  serializedName?: string;
  serverUrl?: string;
  source?: TcgcNode | string;
  sourceKind?: string;
  sourceProperty?: TcgcNode;
  statusMonitorStep?: TcgcNode;
  target?: TcgcNode;
  templateArguments?: TcgcNode[];
  terminationStatus?: TcgcNode;
  type?: TcgcNode;
  unions?: TcgcNode[];
  uriTemplate?: string;
  valueType?: TcgcNode;
  valueTypes?: TcgcNode[];
  values?: TcgcNode[];
  variantTypes?: TcgcNode[];
  verb?: string;
  version?: unknown;
  path?: string;
  wireType?: TcgcNode;
  xml?: TcgcNode;
}

export interface TcgcConflict {
  code: string;
  path: string;
  current: unknown;
  deprecated: unknown;
}

export interface TcgcContext {
  conflicts: TcgcConflict[];
}

export interface NormalizedTcgcType {
  kind: string;
  id?: string;
  name?: string;
  cycle?: boolean;
  encode?: unknown;
  wireType?: NormalizedTcgcType;
  valueType?: NormalizedTcgcType;
  valueTypes?: NormalizedTcgcType[];
  keyType?: NormalizedTcgcType;
  type?: NormalizedTcgcType;
  variantTypes?: NormalizedTcgcType[];
  templateArguments?: { serializedName?: unknown }[];
  discriminatedOptions?: unknown;
  [key: string]: unknown;
}

export interface TcgcArtifact {
  format?: string;
  files?: { path: string }[];
}

export interface NormalizedTcgcParameter {
  type: NormalizedTcgcType;
  name?: string;
  crossLanguageDefinitionId?: string;
  methodParameterSegments?: unknown[];
  kind?: string;
  [key: string]: unknown;
}

export interface NormalizedTcgcMethod {
  identity: string;
  crossLanguageDefinitionId?: string;
  access?: string;
  name?: string;
  client?: string;
  clientName?: string;
  kind?: string;
  apiVersions: unknown[];
  parameters: NormalizedTcgcParameter[];
  responseType?: NormalizedTcgcType;
  paging?: {
    nextLinkName?: string;
    itemName?: string;
    [key: string]: unknown;
  };
  lro?: unknown;
  operation?: {
    verb?: string;
    path?: string;
    parameters?: NormalizedTcgcParameter[];
    bodyParam?: NormalizedTcgcParameter;
    responses?: {
      headers?: NormalizedTcgcParameter[];
      [key: string]: unknown;
    }[];
    exceptions?: {
      headers?: NormalizedTcgcParameter[];
      [key: string]: unknown;
    }[];
  };
  [key: string]: unknown;
}

export interface NormalizedTcgcNamedType {
  identity: string;
  crossLanguageDefinitionId?: string;
  name?: string;
  access?: string;
  reachable?: boolean;
  usage?: unknown;
  properties?: {
    name?: string;
    type: NormalizedTcgcType;
    optional?: boolean;
    [key: string]: unknown;
  }[];
  baseModel?: string;
  discriminatorProperty?: string;
  discriminatorValue?: unknown;
  discriminatedSubtypes?: { name?: string; type?: string }[];
  additionalProperties?: NormalizedTcgcType;
  variantTypes?: NormalizedTcgcType[];
  valueType?: NormalizedTcgcType;
  values?: { name?: string; value?: unknown }[];
  isFixed?: boolean;
  isUnionAsEnum?: boolean;
  type?: NormalizedTcgcType;
  discriminatedOptions?: unknown;
  [key: string]: unknown;
}

export interface NormalizedTcgcContract {
  schemaVersion: number;
  package: {
    apiVersions: unknown[];
    [key: string]: unknown;
  };
  clients: {
    identity: string;
    crossLanguageDefinitionId?: string;
    name?: string;
    owner?: string;
    parent?: string;
    [key: string]: unknown;
  }[];
  methods: NormalizedTcgcMethod[];
  models: NormalizedTcgcNamedType[];
  enums: NormalizedTcgcNamedType[];
  unions: NormalizedTcgcNamedType[];
  conflicts: TcgcConflict[];
}

export interface SemanticOperationReference {
  operationId: string;
  beforeFactId?: string;
  afterFactId?: string;
  restChanged?: boolean;
  matchBasis?: string;
  sourceChangeIds?: string[];
  hunkIds?: string[];
  declarationIds?: string[];
  publicationEligible?: boolean;
  [key: string]: unknown;
}

export interface SemanticReviewUnit {
  id: string;
  projectId?: string;
  projectIds?: string[];
  sourceChangeIds: string[];
  hunkIds?: string[];
  declarationIds?: string[];
  declarationNames?: string[];
  beforeFactIds?: string[];
  afterFactIds?: string[];
  operationIds?: string[];
  ownedOperationIds?: string[];
  operations?: SemanticOperationReference[];
  action?: string;
  changeKind?: string;
  intentType?: string;
  groupingEvidence?: {
    reasons?: string[];
    edges?: { summary?: string }[];
    memberHunkIds?: string[];
  };
  changedAspects?: string[];
  versionTransitionOperationIds?: string[];
  sourceMappedOperationIds?: string[];
  publicationEligibleOperationIds?: string[];
  [key: string]: unknown;
}

export interface InternalSemanticOperation extends SemanticOperationReference {
  sourceChangeIds: string[];
  hunkIds: string[];
  declarationIds: string[];
  matchBasis: string;
}

export interface InternalSemanticUnit extends SemanticReviewUnit {
  projectId: string;
  sourceChangeIds: string[];
  hunkIds: string[];
  declarationIds: string[];
  declarationNames: string[];
  ownedOperationIds: string[];
  operations: InternalSemanticOperation[];
  operationIds: string[];
  beforeFactIds: string[];
  afterFactIds: string[];
  changedAspects: string[];
  groupingEvidence?: {
    reasons?: string[];
    edges?: { summary?: string }[];
    memberHunkIds?: string[];
    [key: string]: unknown;
  };
}

export interface AssessmentFact {
  id?: string;
  projectId?: string;
  revision?: string;
  comparisonRole?: string;
  sourceRevision?: string;
  sourceCommit?: string;
  apiVersion?: string;
  apiVersions?: string[];
  factKind?: string;
  kind?: string;
  identity?: string;
  crossLanguageDefinitionId?: string;
  operationId?: string;
  method?: string;
  path?: string;
  routeSource?: string;
  name?: string;
  client?: string;
  clientName?: string;
  operation?: {
    operationId?: string;
    method?: string;
    verb?: string;
    path?: string;
    parameters?: {
      name?: string;
      kind?: string;
      serializedName?: string;
      crossLanguageDefinitionId?: string;
      methodParameterSegments?: unknown[];
      type?: SdkType | string;
      schema?: SdkType | string;
    }[];
    bodyParam?: {
      name?: string;
      kind?: string;
      serializedName?: string;
      crossLanguageDefinitionId?: string;
      methodParameterSegments?: unknown[];
      type?: SdkType | string;
    };
    responses?: {
      headers?: {
        name?: string;
        serializedName?: string;
        type?: SdkType | string;
      }[];
      [key: string]: unknown;
    }[];
  };
  owner?: string;
  parent?: string;
  access?: string;
  usage?: string[];
  reachable?: boolean;
  parameters?: {
    position?: number;
    name?: string;
    in?: string;
    required?: boolean;
    collectionFormat?: string;
    optional?: boolean;
    onClient?: boolean;
    crossLanguageDefinitionId?: string;
    isApiVersionParam?: boolean;
    schema?: NormalizedSchema;
    type?: SdkType;
  }[];
  request?: {
    kind?: string;
    required?: boolean;
    schema?: NormalizedSchema;
    members?: {
      name?: string;
      in?: string;
      required?: boolean;
      collectionFormat?: string;
      schema?: NormalizedSchema;
    }[];
  };
  responses?: {
    status?: string;
    statusKind?: string;
    schema?: NormalizedSchema;
    headers?: {
      name?: string;
      collectionFormat?: string;
      schema?: NormalizedSchema;
    }[];
  }[];
  responseType?: SdkType | string;
  properties?: {
    name?: string;
    serializedName?: string;
    optional?: boolean;
    access?: string;
    flatten?: boolean;
    type?: SdkType | string;
    schema?: SdkType | string;
  }[];
  values?: {
    name?: string;
    value?: string | number;
  }[];
  paging?: {
    nextLinkName?: string;
    itemName?: string;
    [key: string]: unknown;
  };
  lro?: LongRunningOperation;
  decorators?: string[];
  isFixed?: boolean;
  isUnionAsEnum?: boolean;
  [key: string]: unknown;
}

export interface SdkType {
  kind?: string;
  crossLanguageDefinitionId?: string;
  identity?: string;
  id?: string;
  name?: string;
  valueType?: SdkType;
  keyType?: SdkType;
  valueTypes?: SdkType[];
  type?: SdkType;
  items?: SdkType;
  value?: unknown;
}

export interface LongRunningOperation {
  operation?: { kind?: unknown; path?: unknown; verb?: unknown };
  finalStateVia?: unknown;
  pollingStep?: { kind?: string; responseBody?: { kind?: string } };
  finalStep?: { kind?: string; responseBody?: { kind?: string } };
  statusMonitorStep?: { kind?: string; responseBody?: { kind?: string } };
  logicalResult?: SdkType | string;
  pollingInfo?: unknown;
  envelopeResult?: unknown;
  finalEnvelopeResult?: unknown;
  finalResult?: unknown;
  logicalPath?: unknown;
  finalResultPath?: unknown;
  finalResponse?: unknown;
}

export interface SemanticAnalysis {
  schemaVersion: number;
  status: "ready" | "blocked";
  facts: Record<string, AssessmentFact>;
  reviewUnits: InternalSemanticUnit[];
  blockers: unknown[];
}

export interface AssessmentPackageManager {
  name: "npm" | "pnpm";
  version: string | null;
  lockFile: string;
  lockPath: string;
  packagePath: string;
}

export interface ProcessCommand {
  executable: string;
  args: string[];
}

export interface EvidenceSet {
  evidenceFactIds?: string[];
  [key: string]: unknown;
}

export interface ModelInputItem {
  id?: string;
  reviewUnitId?: string;
  requestId?: string;
  evidenceSetId?: string;
  [key: string]: unknown;
}

export interface ModelSemanticReviewUnit extends ModelInputItem {
  reviewUnitId: string;
  deterministicCoverage?: {
    uncoveredHunkIds: string[];
    classifications: {
      status: string;
      reason: string;
      [key: string]: unknown;
    }[];
    [key: string]: unknown;
  };
  inferenceRequired?: boolean;
}

export interface InferenceRequest extends ModelInputItem {
  requestId: string;
  reviewUnitId: string;
  sourceChangeId: string;
  hunkId: string;
  reason?: string;
  sourceExcerpt: string;
  relatedOperationIds: string[];
  allowedDimensions: ("rest" | "downstream")[];
  evidenceRef: {
    artifact: string;
    sourceChangeId: string;
    hunkId: string;
  };
}

export interface InferenceCandidate {
  id: string;
  dimension: "rest" | "downstream";
  rule: string;
  defaultSeverity: "high" | "medium" | "low";
  actual: string;
  expected: string;
  crossLanguageDefinitionId?: string;
  sourceChangeIds: string[];
  hunkIds: string[];
  declarationIds?: string[];
  operationIds: string[];
  evidenceFactIds: string[];
  reviewRequired: true;
  rootCauseIds?: string[];
}

export interface InferenceResult {
  requestId: string;
  reviewUnitId: string;
  hunkId: string;
  decision: "candidates" | "no-impact" | "blocked";
  rationale: string;
  candidates: InferenceCandidate[];
}

export interface AssessmentInference {
  schemaVersion: 1;
  results: InferenceResult[];
}

export interface CandidateDecision {
  candidateId: string;
  decision: "approve" | "reject";
  severity?: "high" | "medium" | "low";
  rationale: string;
}

export interface AssessmentJudgment {
  schemaVersion: 1;
  semanticIntents: {
    reviewUnitId: string;
    title: string;
    summary: string;
  }[];
  restDecisions: CandidateDecision[];
  downstreamDecisions: CandidateDecision[];
  complianceDecisions: ComplianceDecision[];
  overallConfidence: "high" | "medium" | "low";
  blockers: string[];
}

export interface ComplianceSearchRequest extends ModelInputItem {
  requestId: string;
  reviewUnitId: string;
  sourceChangeIds: string[];
  hunkIds: string[];
  declarationIds: string[];
  queryProfile: {
    servicePlane: string;
    action: string;
    declarationKinds: string[];
    qualifiedNames: string[];
    symbols: string[];
    categories: string[];
    changedTokens: string[];
    representativeSourceExcerpts: unknown[];
    affectedOperationCount: number;
  };
}

export interface ComplianceModelInputRequest extends ModelInputItem {
  requestId: string;
  reviewUnitId: string;
  evidenceSetId: string;
  querySummary: {
    servicePlane: string;
    action: string;
    declarationKinds: string[];
    qualifiedNames: string[];
    qualifiedNameCount: number;
    symbols: string[];
    symbolCount: number;
    categories: string[];
    changedTokens: string[];
    changedTokenCount: number;
    affectedOperationCount: number;
  };
}

export interface AssessmentModelInput {
  context?: {
    sourceComparison?: unknown;
    projects?: {
      id: string;
      path: string;
      artifactComparison?: unknown;
    }[];
  };
  semanticReviewUnits: ModelSemanticReviewUnit[];
  informationalSemanticIntentIds?: string[];
  restCandidates: (ModelInputItem & { id: string })[];
  downstreamCandidates: (ModelInputItem & { id: string })[];
  inferenceRequests: InferenceRequest[];
  complianceSearchRequests: ComplianceModelInputRequest[];
  evidenceSets?: Record<string, EvidenceSet>;
  facts?: Record<string, AssessmentFact>;
  artifactReferences: {
    sourceIndex: string;
    complianceSearchRequests: string;
    [key: string]: string;
  };
  comparison?: Record<string, unknown>;
  documentQualityAssessmentVersion?: number;
  documentQualityCriterion?: string;
  documentQualityReviewUnits?: {
    reviewUnitId: string;
    status: string;
    documentIds: string[];
    evidenceSetId: string;
    reason?: string;
    qualifiedNames?: string[];
    sourceChangeIds?: string[];
    hunkIds?: string[];
    declarationIds?: string[];
    inheritedDocumentCount?: number;
  }[];
  inputAccounting?: Record<string, unknown>;
  [key: string]: unknown;
}

export interface ChangedFile {
  path: string;
  previousPath?: string;
  status: "added" | "removed" | "modified";
  origins: string[];
}

export interface PreparationBlocker {
  code: string;
  message: string;
  projectId?: string;
  comparisonRole?: string;
  sourceRevision?: string;
}

export interface ArtifactSelection {
  sourceRevision: string;
  commit?: string;
  apiVersion?: string;
  reason: string;
}

export interface ArtifactComparison {
  mode?: string;
  baseline: ArtifactSelection;
  target: ArtifactSelection;
  addedCurrentVersions: string[];
  available: { base: string[]; current: string[] };
}

export interface CompilerArtifactSet {
  autorest: AutorestArtifact & { status?: string; [key: string]: unknown };
  tcgc: TcgcArtifact & { status?: string; [key: string]: unknown };
  [key: string]: unknown;
}

export interface PreparationProject {
  id: string;
  path: string;
  sourceChangeIds: string[];
  artifacts: Record<string, CompilerArtifactSet>;
  blockers: PreparationBlocker[];
  artifactComparison?: ArtifactComparison;
  apiVersions?: {
    base?: string;
    current?: string;
    baseReason: string;
    currentReason: string;
    addedCurrentVersions: string[];
    available: { base: string[]; current: string[] };
  };
}

export interface PreparationManifest {
  schemaVersion: number;
  repository: { root: string; remoteUrl: string };
  pullRequest?: unknown;
  invocation?: Record<string, unknown>;
  comparison: {
    baseRef: string;
    mergeBaseCommit: string;
    headCommit: string;
    workingTree: {
      staged: boolean;
      unstaged: boolean;
      untracked: boolean;
    };
    [key: string]: unknown;
  };
  sparseCheckout: { mode: string; roots: string[]; verified: boolean };
  changedFiles: ChangedFile[];
  projects: PreparationProject[];
  blockers: PreparationBlocker[];
  timings: Record<string, number>;
  dependencySetup?: Record<string, unknown>;
  status?: string;
}

export interface NormalizedAutorestParameter {
  name: string;
  in: string;
  required: boolean;
  schema?: NormalizedSchema;
  collectionFormat?: unknown;
}

export interface NormalizedAutorestRequest {
  kind: string;
  required?: boolean;
  schema?: NormalizedSchema;
  members?: NormalizedAutorestParameter[];
}

export interface NormalizedAutorestHeader {
  name: string;
  schema: NormalizedSchema;
}

export interface NormalizedAutorestResponse {
  status: string;
  statusKind: string;
  schema?: NormalizedSchema;
  headers: NormalizedAutorestHeader[];
}

export interface NormalizedAutorestOperation {
  operationId: string;
  apiVersion?: string;
  path: string;
  method: string;
  routeSource: string;
  parameters: NormalizedAutorestParameter[];
  request?: NormalizedAutorestRequest;
  responses: NormalizedAutorestResponse[];
  paging?: unknown;
  lro?: unknown;
  [key: string]: unknown;
}

export interface NormalizedAutorestContract {
  schemaVersion: number;
  documents: Record<string, unknown>[];
  operations: NormalizedAutorestOperation[];
}

export interface BreakingChange {
  rule: string;
  location?: string;
  removed?: unknown[];
}

export interface BreakingCandidate {
  id: string;
  rule: string;
  defaultSeverity: "high" | "medium" | "low";
  actual: string;
  expected: string;
  operationIds: string[];
  crossLanguageDefinitionId?: string;
  sourceChangeIds: string[];
  hunkIds?: string[];
  declarationIds: string[];
  evidenceFactIds: string[];
  reviewRequired: true;
  contractChange: BreakingChange;
}

export interface BreakingAnalysis {
  schemaVersion: number;
  status: "ready" | "blocked";
  facts: Record<string, AssessmentFact>;
  candidates: BreakingCandidate[];
  blockers: PreparationBlocker[];
}

export interface DownstreamCandidate {
  id: string;
  rule: string;
  defaultSeverity: "high" | "medium" | "low";
  actual: string;
  expected: string;
  crossLanguageDefinitionId: string;
  operationIds?: string[];
  sourceChangeIds: string[];
  declarationIds: string[];
  hunkIds: string[];
  evidenceFactIds: string[];
  reviewRequired: true;
  rootCauseIds?: string[];
}

export interface DownstreamRootCause {
  id: string;
  kind: string;
  directCandidateIds: string[];
  propagatedCandidateIds: string[];
  methodFactIds: string[];
  typeFactIds: string[];
  referenceEvidence: {
    fromFactId?: string;
    toFactId?: string;
    kind: string;
    memberName?: string;
    location?: string;
  }[];
  rootKey: string;
}

export interface DownstreamAnalysis {
  schemaVersion: number;
  status: "ready" | "blocked";
  facts: Record<string, AssessmentFact>;
  rootCauses: DownstreamRootCause[];
  candidates: DownstreamCandidate[];
  blockers: PreparationBlocker[];
}

export interface ComplianceDecision {
  reviewUnitId: string;
  applicableGuidance: {
    canonicalDocumentUrl: string;
    guidanceSection: string;
  }[];
  sourceChangeIds: string[];
  hunkIds: string[];
  declarationIds: string[];
  decision: "applicable-pass" | "applicable-fail" | "no-applicable-guidance" | "not-assessed";
  title?: string;
  severity?: "high" | "medium" | "low";
  expected?: string;
  actual: string;
  rationale: string;
}

export interface ComplianceAssessment {
  status: "passed" | "failed" | "not-assessed";
  summary: string;
  coverage: Record<string, unknown>;
  sharedSearch?: Record<string, unknown>;
  intentAssessments: Record<string, unknown>[];
  findings: Record<string, unknown>[];
  retrievalFailures: Record<string, unknown>[];
  blockers: Record<string, unknown>[];
}

export interface DocumentationSnapshot {
  doc: string;
  declaration: string;
  documentationOrigin?: "inherited";
  source: {
    path: string;
    revision: string;
    startLine: number;
    endLine: number;
  };
}

export interface DocumentationDocument {
  id: string;
  sourceChangeId: string;
  qualifiedName: string;
  kind: string;
  before: DocumentationSnapshot | null;
  after: DocumentationSnapshot;
}

export interface DocumentationDeclaration {
  declarationId: string;
  qualifiedName: string;
  kind: string;
  documentationPresent: boolean;
  source: SourceLocation;
  sourceChangeId: string;
}

export interface DocumentationReviewUnit {
  reviewUnitId: string;
  status: "ready" | "not-applicable" | "blocked";
  reason?: string;
  sourceChangeIds: string[];
  hunkIds: string[];
  declarationIds: string[];
  documents?: DocumentationDocument[];
  declarations?: DocumentationDeclaration[];
  inheritedDocumentIds?: string[];
}

export interface DocumentQualityInput {
  schemaVersion: number;
  status: "ready" | "blocked";
  blockers: Record<string, unknown>[];
  reviewUnits: DocumentationReviewUnit[];
}

export interface DocumentQualityDecision {
  reviewUnitId: string;
  documentId: string;
  check: "description" | "correctness" | "meaning";
  decision: "pass" | "fail" | "not-assessed";
  rationale: string;
  title?: string;
  expected?: string;
  docQuote?: string;
}

export interface SemanticDocumentItem extends SemanticReviewUnit {
  reviewUnitId?: string;
  sources?: SourceChange[];
}

export interface DocumentQualityDimension {
  assessmentVersion?: number;
  status: "passed" | "failed" | "not-assessed" | "not-applicable";
  summary: string;
  coverage?: {
    semanticIntentCount?: number;
    assessedIntentCount?: number;
    documentCount?: number;
    assessedDocumentCount?: number;
    checkCount?: number;
    assessedCheckCount?: number;
    inheritedDocumentCount?: number;
    declarationCount?: number;
    documentedDeclarationCount?: number;
    missingDeclarationCount?: number;
    unassessedIntentIds?: string[];
    notApplicableIntentIds?: string[];
  };
  intentAssessments?: {
    reviewUnitId: string;
    status?: string;
    documents?: DocumentationDocument[];
    checks?: DocumentQualityDecision[];
    inheritedDocumentIds?: string[];
    declarations?: DocumentationDeclaration[];
    [key: string]: unknown;
  }[];
  findings?: {
    id: string;
    reviewUnitId: string;
    documentId?: string;
    check?: string;
    title: string;
    expected: string;
    actual: string;
    rationale: string;
    docQuote?: string;
    semanticIntentIds?: string[];
    sources?: {
      id: string;
      path: string;
      status?: string;
      origins?: string[];
      startLine?: number;
      endLine?: number;
      [key: string]: unknown;
    }[];
    document?: DocumentationDocument;
    declaration?: DocumentationDeclaration;
    declarationId?: string;
    codeSnippet?: {
      path: string;
      startLine: number;
      endLine: number;
      lines: string[];
      truncated?: boolean;
    };
    [key: string]: unknown;
  }[];
  blockers?: unknown[];
  [key: string]: unknown;
}

export interface AssessmentFinding {
  id: string;
  actual: string;
  expected: string;
  severity: "high" | "medium" | "low";
  rationale: string;
  sources: SourceChange[];
  evidence: AssessmentFact[];
  operationIds?: string[];
  crossLanguageDefinitionId?: string;
  symbol?: string;
  inferred?: boolean;
  inferenceRequestIds?: string[];
  hunkIds?: string[];
  relatedSemanticIntents?: string[];
  semanticMatchBasis?: string;
  contractChange?: {
    location?: string;
    [key: string]: unknown;
  };
  rootCauseIds?: string[];
  rootCauseId?: string;
  evidenceFactIds?: string[];
  rule?: string;
  projectId?: string;
  title?: string;
  summary?: string;
  [key: string]: unknown;
}

export interface LegacyAssessmentFinding {
  id: string;
  title?: string;
  summary?: string;
  evidence?: string[];
  relatedSemanticIntents?: string[];
  sources?: SourceChange[];
  [key: string]: unknown;
}

export interface AssessmentSemanticItem extends InternalSemanticUnit {
  title: string;
  summary: string;
  informational?: boolean;
  operations: (InternalSemanticOperation & {
    projectId?: string;
    apiVersion?: string;
    method?: string;
    path?: string;
    restChanged?: boolean;
    outcome?: string;
    sources?: SourceChange[];
    before?: AssessmentFact;
    after?: AssessmentFact;
    changedAspects?: string[];
  })[];
  sources: SourceChange[];
  relatedFindings?: {
    rest?: string[];
    downstream?: string[];
    typeImpact?: string[];
    sharedTypeImpact?: string[];
    compliance?: string[];
    [key: string]: string[] | undefined;
  };
}

export interface ComplianceCatalogScore {
  exactSymbol: number;
  patternCategory: number;
  servicePlane: number;
  changeContext: number;
  total: number;
}

export interface ComplianceRankedEntry {
  rank: number;
  catalogOrder: number;
  title: string;
  canonicalUrl: string;
  score: ComplianceCatalogScore;
  selectionRationale?: string;
}

export interface ComplianceGuidance {
  section: string;
  excerpt: string;
  queryTerms: string[];
  applicableDeclarationIds: string[];
  examples?: string[];
}

export interface ComplianceDocument {
  canonicalUrl: string;
  title?: string;
  retrievedAt?: string;
  contentHash?: string;
  noRelevantGuidance: boolean;
  guidance: ComplianceGuidance[];
  [key: string]: unknown;
}

export interface ComplianceIntentAssessment {
  id?: string;
  semanticIntentId: string;
  declarationIds?: string[];
  documents?: ComplianceDocument[];
  catalogRanking?: ComplianceRankedEntry[];
  blockers?: string[];
  decision: "applicable-pass" | "applicable-fail" | "no-applicable-guidance" | "not-assessed";
  actual: string;
  gap: string;
  expected?: string;
  applicableGuidance: {
    canonicalDocumentUrl: string;
    guidanceSection: string;
  }[];
  sourceLinks?: {
    path: string;
    startLine?: number;
    endLine?: number;
    link?: string;
  }[];
  sourceReferences?: {
    path: string;
    startLine?: number;
    endLine?: number;
    link?: string;
  }[];
  codeSnippets?: {
    path: string;
    startLine?: number;
    endLine?: number;
    link?: string;
    lines?: string[];
  }[];
  title?: string;
  summary?: string;
  severity?: "high" | "medium" | "low";
  relatedSemanticIntents?: string[];
  canonicalDocumentUrl?: string;
  documentationUrl?: string;
  section?: string;
  evidence?: unknown[];
  [key: string]: unknown;
}

export interface FinalComplianceAssessment {
  status: "passed" | "failed" | "not-assessed";
  summary: string;
  coverage: {
    semanticIntentCount?: number;
    assessedIntentCount?: number;
    selectedDocumentCount?: number;
    unassessedIntentIds?: string[];
    [key: string]: unknown;
  };
  sharedSearch?: {
    documents?: ComplianceDocument[];
    catalogRanking?: ComplianceRankedEntry[];
    [key: string]: unknown;
  };
  intentAssessments: ComplianceIntentAssessment[];
  findings: (ComplianceIntentAssessment & { id: string })[];
  retrievalFailures: {
    reviewUnitId?: string;
    canonicalUrl: string;
    status: string;
    error: string;
  }[];
  blockers: ({ message?: string; [key: string]: unknown } | string)[];
  legacyFindings?: (ComplianceIntentAssessment & { id: string })[];
  legacyDocuments?: {
    url: string;
    title?: string;
    section?: string;
    guidanceExcerpt?: string;
    expectedCodeSnippets?: unknown[];
  }[];
}

export interface AssessmentMethodGroup {
  id: string;
  projectId?: string;
  symbol: string;
  before?: AssessmentFact;
  after?: AssessmentFact;
  deltas: {
    findingId: string;
    rule?: string;
    field?: string;
    rationale?: string;
    before?: unknown;
    after?: unknown;
    changes?: {
      added?: {
        parameter: NonNullable<AssessmentFact["parameters"]>[number];
      }[];
      removed?: {
        parameter: NonNullable<AssessmentFact["parameters"]>[number];
      }[];
      modified?: {
        name: string;
        before: NonNullable<AssessmentFact["parameters"]>[number];
        after: NonNullable<AssessmentFact["parameters"]>[number];
        changedFields: string[];
      }[];
      reordered?: {
        name: string;
        beforeIndex: number;
        afterIndex: number;
      }[];
      unchangedCount?: number;
    };
    [key: string]: unknown;
  }[];
  parametersUnchanged?: boolean;
  relatedSemanticIntents?: string[];
  [key: string]: unknown;
}

export interface AssessmentTypeImpact {
  id: string;
  projectId?: string;
  type?: string;
  types?: string[];
  summary?: string;
  locations?: string[];
  affectedMethodCount?: number;
  affectedMethods?: { symbol: string; [key: string]: unknown }[];
  findingIds?: string[];
  rootCauseIds?: string[];
  rootCauseId?: string;
  relatedSemanticIntents?: string[];
  [key: string]: unknown;
}

export type AssessmentParameter = NonNullable<AssessmentFact["parameters"]>[number];
export type AssessmentRequest = NonNullable<AssessmentFact["request"]>;
export type AssessmentResponse = NonNullable<AssessmentFact["responses"]>[number];
export type AssessmentResponseHeader = NonNullable<AssessmentResponse["headers"]>[number];
export type AssessmentOperation = AssessmentSemanticItem["operations"][number];

export interface ContractChangeRow {
  identity?: string;
  area: string;
  areaKind?: string;
  member?: string;
  before: string;
  after: string;
}

export interface RestContractCard {
  identity: string;
  severity: string;
  findings: (AssessmentFinding & { contractDelta: ContractChangeRow })[];
  operations: {
    operationId: string;
    apiVersion?: string;
    method?: string;
    path?: string;
  }[];
  relatedSemanticIntents: string[];
  sources: SourceChange[];
}

export interface DownstreamTypeCard {
  type: string;
  severity?: string;
  findings: AssessmentFinding[];
  relatedSemanticIntents: string[];
  affectedMethods: { symbol: string; [key: string]: unknown }[];
  locations: string[];
  rootCauses: {
    id: string;
    kind?: string;
    summary?: string;
  }[];
  legacyImpactIds: string[];
}

export interface SemanticFindingReference {
  id: string;
  kind: "rest" | "downstream" | "compliance";
  href: string;
  title?: string;
  detail?: string;
}

export interface LegacyAssessmentSourceReference {
  path: string;
  revision: "head" | "base";
  startLine: number;
  endLine: number;
  link?: string;
}

export interface LegacyAssessmentDiff {
  path: string;
  lines?: string[];
  oldStart?: number;
  oldCount?: number;
  newStart?: number;
  newCount?: number;
}

export interface LegacyAssessmentFindingInput {
  id: string;
  title?: string;
  summary?: string;
  severity?: "high" | "medium" | "low";
  sourceReferences?: LegacyAssessmentSourceReference[];
  codeSnippets?: {
    path: string;
    startLine: number;
    endLine: number;
    lines?: string[];
    link?: string;
  }[];
  evidence?: string[];
  [key: string]: unknown;
}

export interface LegacyAssessmentInput {
  schemaVersion?: number;
  title?: string;
  url?: string;
  pr: number;
  baseline: { commit: string };
  head: { commit: string };
  projects?: string[];
  overallCodeSafety?: string;
  overallConfidence?: "high" | "medium" | "low";
  errors?: ({ message?: string; [key: string]: unknown } | string)[];
  assessmentEvidence?: {
    changedTypeSpec?: (LegacyAssessmentSourceReference & {
      lines?: string[];
    })[];
  };
  dimensions: {
    semanticUnderstanding: {
      items: {
        id: string;
        intent: string;
        sourceReferences?: LegacyAssessmentSourceReference[];
        changes: {
          kind?: "added" | "modified" | "removed";
          summary?: string;
          effect?: string;
          linkedFindingIds?: string[];
          typeSpecDiffs?: LegacyAssessmentDiff[];
        }[];
        restRepresentation?: {
          summary?: string;
          operations?: (Record<string, unknown> & {
            operationId: string;
            apiVersion?: string;
            apiVersions?: string[];
          })[];
        };
      }[];
    };
    restBreakingChanges: { findings: LegacyAssessmentFindingInput[] };
    restCompatibleDownstreamBreakingChanges: {
      findings: LegacyAssessmentFindingInput[];
    };
    azureCompliance: {
      status?: "passed" | "failed" | "not-assessed";
      reason?: string;
      findings?: LegacyAssessmentFindingInput[];
      documents?: {
        url: string;
        title?: string;
        section?: string;
        guidanceExcerpt?: string;
        expectedCodeSnippets?: unknown[];
      }[];
    };
  };
}

export interface AssessmentOutput {
  schemaVersion: 1;
  displayTitle?: string;
  title?: string;
  pr?: string | number;
  repository?: { remoteUrl?: string; [key: string]: unknown };
  pullRequest?: { number: number; url: string };
  comparison: {
    baseRef?: string;
    baseCommit: string;
    headCommit: string;
    workingTree: boolean | Record<string, unknown>;
    [key: string]: unknown;
  };
  projects?: PreparationProject[];
  artifactComparisons?: {
    projectId: string;
    mode?: string;
    baseline?: ArtifactSelection;
    target?: ArtifactSelection;
  }[];
  confidence: "high" | "medium" | "low";
  safety: {
    scope: "rest-and-downstream-only";
    status: "passed" | "failed" | "not-assessed";
    [key: string]: unknown;
  };
  dimensions: {
    semantic: {
      status: string;
      items: AssessmentSemanticItem[];
      sourceHunkIds?: string[];
      blockers?: unknown[];
    };
    rest: {
      status: string;
      findings: AssessmentFinding[];
      blockers?: unknown[];
      legacyFindings?: LegacyAssessmentFinding[];
    };
    downstream: {
      status: string;
      findings: AssessmentFinding[];
      blockers?: unknown[];
      methodGroups?: AssessmentMethodGroup[];
      operationGroups?: AssessmentMethodGroup[];
      typeImpacts?: AssessmentTypeImpact[];
      sharedTypeImpacts?: AssessmentTypeImpact[];
      legacyFindings?: LegacyAssessmentFinding[];
    };
    compliance: FinalComplianceAssessment;
    documentQuality: DocumentQualityDimension;
    [key: string]: unknown;
  };
  blockers: unknown[];
  changedFiles?: SourceChange[];
  timings?: Record<string, number>;
  inputAccounting?: Record<string, unknown>;
  provenance?: {
    documentQuality?: string;
    [key: string]: unknown;
  };
  [key: string]: unknown;
}
