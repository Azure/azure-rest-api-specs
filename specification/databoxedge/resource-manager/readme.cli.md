## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  cli-name: databoxedge
  package-name: azure-mgmt-databoxedge
  namespace: azure.mgmt.databoxedge
  test-scenario:
    - name: DataBoxEdgeDevicePut
    - name: UserPut
    - name: RolePut
    - name: SharePut
    - name: OrderPut
    - name: TriggerPut
    - name: StorageAccountPut
    - name: BandwidthSchedulePut
    - name: SACPut
    - name: ContainerPut
    - name: ContainerGet
    - name: SACGet
    - name: ContainerListAllInDevice
    - name: BandwidthScheduleGet
    - name: OperationsStatusGet
    - name: StorageAccountGet
    - name: NetworkSettingsGet
    - name: UpdateSummaryGet
    - name: TriggerGet
    - name: SACGetAllInDevice
    - name: AlertGet
    - name: ShareGet
    - name: OrderGet
    - name: UserGet
    - name: RoleGet
    - name: JobsGet
    - name: BandwidthScheduleGetAllInDevice
    - name: StorageAccountGetAllInDevice
    - name: TriggerGetAllInDevice
    - name: OrderGetAllInDevice
    - name: AlertGetAllInDevice
    - name: ShareGetAllInDevice
    - name: NodesGetAllInDevice
    - name: RoleGetAllInDevice
    - name: UserGetAllInDevice
    - name: DataBoxEdgeDeviceGetByName
    - name: DataBoxEdgeDeviceGetByResourceGroup
    - name: DataBoxEdgeDeviceGetBySubscription
    - name: ListSkus
    - name: OperationsGet
    - name: ContainerRefresh
    - name: CreateOrUpdateSecuritySettings
    - name: ShareRefreshPost
    - name: ExtendedInfoPost
    - name: UploadCertificatePost
    - name: DownloadUpdatesPost
    - name: ScanForUpdatesPost
    - name: InstallUpdatesPost
    - name: DataBoxEdgeDevicePatch
    - name: ContainerDelete
    - name: SACDelete
    - name: BandwidthScheduleDelete
    - name: StorageAccountDelete
    - name: TriggerDelete
    - name: ShareDelete
    - name: OrderDelete
    - name: UserDelete
    - name: RoleDelete
    - name: DataBoxEdgeDeviceDelete
```