import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.PortalServices;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The types of dashboard tiles.")
enum DashboardTileType {
  @doc("The tile type for Arc Snapshot tile.")
  ArcSnapshotTile,

  @doc("The tile type for Markdown tile.")
  MarkdownTile,

  @doc("The tile type for Navigation tile.")
  NavigationTile,

  @doc("The tile type for Policy tile.")
  PolicyTile,

  @doc("The tile type for Query tile.")
  QueryTile,

  @doc("The tile type for Resource tile.")
  ResourceTile,
}

@doc("The types of dashboard tile on click actions.")
enum ActionsOnClickType {
  @doc("The on click action type for openBlade.")
  openBlade,

  @doc("The on click action type for updateParameters.")
  updateParameters,
}

@doc("The types of dashboard tile action references.")
enum ActionReferenceType {
  @doc("The action reference type for blade.")
  blade,

  @doc("The action reference type for url.")
  url,
}

@doc("The types of dashboard tile parameters.")
enum DashboardParameterType {
  @doc("The parameter type for location.")
  location,

  @doc("The parameter type for resourceGroup.")
  resourceGroup,

  @doc("The parameter type for resourceType.")
  resourceType,

  @doc("The parameter type for subscription.")
  subscription,

  @doc("The parameter type for timeGranularity.")
  timeGranularity,

  @doc("The parameter type for timeRange.")
  timeRange,
}

@doc("The types of created by.")
enum CreatedByType {
  @doc("The created by type for user.")
  User,

  @doc("The created by type for application.")
  Application,

  @doc("The created by type for managedIdentity.")
  ManagedIdentity,

  @doc("The created by type for key.")
  Key,
}

@doc("The types of modified by.")
enum ArcSnapshotTileDataKind {
  @doc("The data kind arg for Arc Snapshot tile.")
  arg,
}

@doc("The types of Dashboard Visualizations.")
enum VisualizationType {
  @doc("The visualization type for area.")
  area,

  @doc("The visualization type for bar.")
  bar,

  @doc("The visualization type for card.")
  card,

  @doc("The visualization type for column.")
  column,

  @doc("The visualization type for donut.")
  donut,

  @doc("The visualization type for line.")
  line,

  @doc("The visualization type for multistat.")
  multistat,

  @doc("The visualization type for pie.")
  pie,

  @doc("The visualization type for scatter.")
  scatter,

  @doc("The visualization type for table.")
  table,

  @doc("The visualization type for timechart.")
  timechart,
}

@doc("The types of Dashboard Markdown tile sources.")
enum MarkdownSource {
  @doc("The source type for inline.")
  inline,

  @doc("The source type for uri.")
  uri,
}

@doc("The types of Dashboard Query tile kinds.")
enum Kind {
  @doc("The kind type for arg.")
  arg,

  @doc("The kind type for app-insights.")
  `app-insights`,

  @doc("The kind type for policy.")
  policy,
}

@doc("The types of Dashboard Query tile aggregation types.")
enum AggregationType {
  @doc("The aggregation type for avg.")
  avg,

  @doc("The aggregation type for count.")
  count,

  @doc("The aggregation type for max.")
  max,

  @doc("The aggregation type for min.")
  min,

  @doc("The aggregation type for percentile.")
  percentile,

  @doc("The aggregation type for sum.")
  sum,

  @doc("The aggregation type for total.")
  unique,
}

@doc("The shared dashboard properties.")
model DashboardProperties {
  @doc("The title of dashboard.")
  title?: string;

  @doc("The dashboard pages.")
  pages?: DashboardPage[];

  @doc("The dashboard parameters.")
  parameters?: DashboardParameter[];
}

@doc("Dashboard Properties with Provisioning state")
model DashboardPropertiesWithProvisioningState {
  ...DashboardProperties;

  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: DashboardProvisioningState;
}

@doc("The provisioning state of the last accepted operation.")
enum DashboardProvisioningState {
  ...ResourceProvisioningState,
}

@doc("A dashboard page.")
model DashboardPage {
  @doc("The title of dashboard page.")
  title?: string;

  @doc("The dashboard tiles.")
  tiles?: DashboardTile[];
}

@doc("A dashboard tile.")
@discriminator("type")
model DashboardTile {
  @doc("Discriminator property for DashboardTile.")
  type: DashboardTileType;

  @doc("The title of dashboard title.")
  title: string;

  @doc("The title of dashboard subtitle.")
  subtitle?: string;

  @doc("The dashboard tile's layout.")
  layout: DashboardTileLayout;

  @doc("The dashboard parameter list.")
  visible?: DashboardParameterValuesList;

  @doc("The dashboard parameter list.")
  highlight?: DashboardParameterValuesList;

  @doc("Actions available on the tile.")
  actions?: Actions;
}

@doc("The dashboard tile's layout.")
model DashboardTileLayout {
  @doc("The dashboard tile's x position.")
  x: int32;

  @doc("The dashboard tile's y position.")
  y: int32;

  @doc("The dashboard tile's width in grid units.")
  width: int32;

  @doc("The dashboard tile's height in grid units.")
  height: int32;
}

@doc("The dashboard parameter list.")
model DashboardParameterValuesList {
  @doc("The array of dashboard parameter values.")
  parameters?: DashboardParameterValues[];
}

@doc("The dashboard parameter values.")
model DashboardParameterValues {
  @doc("The unique names to serve as placeholders for the parameter values.")
  parameterNames: string[];

  @doc("The parameter value(s) that will be selected by default when the parameter is displayed.")
  values: string[];
}

@doc("Actions available on the tile.")
model Actions {
  @doc("Actions available on the tile on click.")
  onClick?: ActionsOnClick;

  @doc("Actions available on the tile on footer.")
  footer?: ActionReference[];

  @doc("Actions available on the tile on context menu.")
  contextMenu?: ActionReference[];
}

@discriminator("type")
@doc("Model for Actions on click.")
model ActionsOnClick {
  @doc("Discriminator property for ActionsOnClick.")
  type: ActionsOnClickType;
}

@discriminator("type")
@doc("Model for Action reference.")
model ActionReference {}

@doc("A dashboard parameter.")
model DashboardParameter {
  @doc("The title of dashboard filter.")
  title: string;

  @doc("Types of dashboard parameters.")
  kind: DashboardParameterType;

  @doc("The unique names to serve as placeholders for the parameter values.")
  parameterNames: string[];

  @doc("The parameter value(s) that will be selected by default when the parameter is displayed.")
  defaultValues: string[];

  @doc("A list of integers that represent indexes of the pages that this parameter applies to.")
  showOnPages: string[];
}

@doc("The shared dashboard resource definition.")
model PatchableDashboard {
  @doc("The shared dashboard properties.")
  properties?: DashboardProperties;

  @doc("Resource tags")
  tags?: Record<string>;
}

@doc("Model for Actions on click open blade")
model ActionOpenBlade extends ActionsOnClick {
  @doc("open a blade in context pane")
  blade: BladeReferenceWithContextPane;

  @doc("Types of action on click.")
  type: ActionsOnClickType.openBlade;
}

@doc("open a blade in context pane")
model BladeReferenceWithContextPane {
  @doc("The name of the blade to open.")
  name: string;

  @doc("The extension name of the blade to open.")
  extension?: string;

  @doc("The parameters to pass to the blade.")
  parameters?: {};

  @doc("Whether the blade should be opened in the context pane.")
  inContextPane?: boolean;

  @doc("Specify whether to open this blade as Provisioning blade")
  doesProvisioning?: boolean;
}

@doc("Model for actions on click update parameters")
model ActionParameters extends ActionsOnClick {
  ...DashboardParameterValuesList;

  @doc("Types of action on click.")
  type: ActionsOnClickType.updateParameters;
}

@doc("Model for action reference to a url.")
model ActionReferenceUrl extends ActionReference {
  @doc("The URI that will be opened")
  url: string;

  @doc("The display name of the link")
  displayName: string;

  @doc("Types of action references.")
  type: "url";
}

@doc("Model for action reference to a blade.")
model ActionReferenceBlade extends ActionReference {
  @doc("open a blade in context pane")
  blade: BladeReferenceWithContextPane;

  @doc("The display name of the link")
  displayName: string;

  @doc("Types of action references.")
  type: "blade";
}

@doc("Display information of your Arc enabled resources with the arc snapshot tile.")
model ArcSnapshotTile extends DashboardTile {
  @doc("The definition of data for the arc snapshot tile.")
  data: ArcSnapshotTileData;

  @doc("Query tile visualizations.")
  visualization: QueryTileVisualization;

  @doc("Dashboard tile type.")
  type: DashboardTileType.ArcSnapshotTile;
}

@doc("Data definition for a arc snapshot tile.")
model ArcSnapshotTileData {
  @doc("The ARG data source of the query tile. Enum permitting the value: \"arg\"")
  kind: ArcSnapshotTileDataKind;

  @doc("A valid ARG query used to fetch the data.")
  query: string;

  @doc("The column names to get from the query result.")
  columns: ArcSnapshotTileDataColumn;

  @doc("The text to be shown when all the resources are configured with the service.")
  allResourcesConfiguredText?: string;

  @doc("Parameter names that are applied to the tile. It can be used within the query.")
  usedParameters?: string[];

  @doc("Used when the resource count returned from the count is zero.")
  noResources?: ArcSnapshotTileDataNoResources;

  @doc("Actions that can be taken on the arc snapshot tile.")
  actions?: ArcSnapshotTileDataActions;
}

@doc("The column names to get from the query result.")
model ArcSnapshotTileDataColumn {
  @doc("The column name that will return the count of resources that are not configured.")
  notConfiguredResourcesCount: string;

  @doc("The column name that will return the total count of resources.")
  totalCount: string;
}

@doc("Used when the resource count returned from the count is zero.")
model ArcSnapshotTileDataNoResources {
  @doc("Text to be shown when there are no resources to be configured with the service.")
  text: string;

  @doc("Icon to be shown when there are no resources to be configured with.")
  icon: string;
}

@doc("Actions that can be taken on the arc snapshot tile.")
model ArcSnapshotTileDataActions {
  @doc("Action on configure service.")
  configureService?: ActionReference;

  @doc("Action on view configure resources.")
  viewConfiguredService?: ActionReference;

  @doc("Action on view not configure resources.")
  viewNotConfiguredResources?: ActionReference;
}

@doc("Query tile visualizations.")
model QueryTileVisualization {
  @doc("Enumeration of supported visualization types.")
  type?: VisualizationType;

  @doc("Options for Query Tile visualizations.")
  options?: {};
}

@doc("A markdown tile.")
model MarkdownTile extends DashboardTile {
  @doc("The definition of data for the markdown tile.")
  data?: MarkdownTileData;

  @doc("Dashboard tile type.")
  type: DashboardTileType.MarkdownTile;
}

@doc("Data definition for a markdown tile.")
@discriminator("source")
model MarkdownTileData {
  @doc("Discriminator property for MarkdownTileData.")
  source: MarkdownSource;
}

@doc("The data definition of Markdown with inline content")
model MarkdownInlineData extends MarkdownTileData {
  @doc("Dashboard Markdown Tile content.")
  content: string;

  @doc("Dashboard Markdown Tile source.")
  source: MarkdownSource.inline;
}

@doc("The data definition of Markdown with uri content")
model MarkdownUriData extends MarkdownTileData {
  @doc("Dashboard Markdown Tile uri.")
  uri: string;

  @doc("Dashboard Markdown Tile source.")
  source: MarkdownSource.uri;
}

@doc("Navigate with a click to assets or blades within Azure Portal with the navigation tile.")
model NavigationTile extends DashboardTile {
  @doc("The definition of data for the navigation tile.")
  data: NavigationTileData;

  @doc("Dashboard tile type.")
  type: DashboardTileType.NavigationTile;
}

@doc("The data that determines the content of the navigation tile.")
model NavigationTileData {
  @doc("Icon to be displayed on the navigation tile.")
  icon: string;

  @doc("The description displayed within the navigation tile.")
  description?: string;
}

@doc("Display information of your resources that are compliant with configured Azure policies with the policy tile.")
model PolicyTile extends DashboardTile {
  @doc("The definition of data for the policy tile.")
  data: QueryTileData;

  @doc("Dashboard tile type.")
  type: DashboardTileType.PolicyTile;
}

@doc("A dashboard query tile.")
@discriminator("kind")
model QueryTileData {
  @doc("The dashboard parameter names used in the tiles.")
  usedParameters?: string[];
}

@doc("A query tile.")
model QueryTile extends DashboardTile {
  @doc("Query tile visualizations.")
  visualization?: QueryTileVisualization;

  @doc("The definition of data source object within the Query tile.")
  data?: QueryTileData;

  @doc("Dashboard tile type.")
  type: DashboardTileType.QueryTile;
}

@doc("The data definition of ARG Query Tile.")
model ArgDataDefinition extends QueryTileData {
  @doc("The ARG query.")
  query: string;

  @doc("Dashboard Query tile kind.")
  kind: "arg";
}

@doc("The data definition of App Insights Query Tile.")
model AppInsightsDataDefinition extends QueryTileData {
  @doc("Array of metrics object for an app insights query tile data.")
  metrics: QueryTileMetricsItem[];

  @doc("Dashboard Query tile kind.")
  kind: "app-insights";
}

@doc("The metrics object for an app insights query tile data.")
model QueryTileMetricsItem {
  @doc("The aggregation type to use for this metric item.")
  aggregationType: AggregationType;

  @doc("The name of the metric item.")
  name: string;

  @doc("The custom namespace to use.")
  `namespace`?: string;

  @doc("The information that identifies the resource to which the metric belongs.")
  resourceMetadata: QueryTileMetricsItemResourceMetadata;
}

@doc("The information that identifies the resource to which the metric belongs.")
model QueryTileMetricsItemResourceMetadata {
  @doc("The ARM resource id of the resource.")
  id: string;
}

@doc("The data that determines the content of the policy tile.")
model PolicyTileDataDefinition extends QueryTileData {
  @doc("Dashboard Query tile kind.")
  kind: "policy";
}

@doc("A resource tile.")
model ResourceTile extends DashboardTile {
  @doc("Data definition for a resource tile.")
  data?: ResourceTileData;

  @doc("Dashboard tile type.")
  type: DashboardTileType.ResourceTile;
}

@doc("Data definition for a resource tile.")
model ResourceTileData {
  @doc("The ARM Id of a resource.")
  resourceId: string;

  @doc("List of visible properties.")
  visibleProperties?: string[];

  @doc("List of allowed commands.")
  allowedCommands?: string[];
}
