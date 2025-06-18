# redis_exporter['enable'] = true
# redis_exporter['log_directory'] = '/var/log/gitlab/redis-exporter'
# redis_exporter['log_group'] = nil
# redis_exporter['flags'] = {
#   'redis.addr' => "unix:///var/opt/gitlab/redis/redis.socket",
# }
# redis_exporter['env_directory'] = '/opt/gitlab/etc/redis-exporter/env'
# redis_exporter['env'] = {
#   'SSL_CERT_DIR' => "/opt/gitlab/embedded/ssl/certs/"
# }

##! Advanced settings. Should be changed only if absolutely needed.
# redis_exporter['listen_address'] = 'localhost:9121'

##! Service name used to register Redis Exporter as a Consul service
# redis_exporter['consul_service_name'] = 'redis-exporter'
##! Semantic metadata used when registering Redis Exporter as a Consul service
# redis_exporter['consul_service_meta'] = {}

################################################################################
## Prometheus Postgres exporter
##! Docs: https://docs.gitlab.com/ee/administration/monitoring/prometheus/postgres_exporter.html
################################################################################

# postgres_exporter['enable'] = true
# postgres_exporter['home'] = '/var/opt/gitlab/postgres-exporter'
# postgres_exporter['log_directory'] = '/var/log/gitlab/postgres-exporter'
# postgres_exporter['log_group'] = nil
# postgres_exporter['flags'] = {
#  'collector.stat_user_tables' => false,
#  'collector.postmaster' => true
# }
# postgres_exporter['listen_address'] = 'localhost:9187'
# postgres_exporter['env_directory'] = '/opt/gitlab/etc/postgres-exporter/env'
# postgres_exporter['env'] = {
#   'SSL_CERT_DIR' => "/opt/gitlab/embedded/ssl/certs/"
# }
# postgres_exporter['sslmode'] = nil

##! Service name used to register Postgres Exporter as a Consul service
# postgres_exporter['consul_service_name'] = 'postgres-exporter'
##! Semantic metadata used when registering Postgres Exporter as a Consul service
# postgres_exporter['consul_service_meta'] = {}

################################################################################
## Prometheus PgBouncer exporter (EE only)
##! Docs: https://docs.gitlab.com/ee/administration/monitoring/prometheus/pgbouncer_exporter.html
################################################################################

# pgbouncer_exporter['enable'] = false
# pgbouncer_exporter['log_directory'] = "/var/log/gitlab/pgbouncer-exporter"
# pgbouncer_exporter['log_group'] = nil
# pgbouncer_exporter['listen_address'] = 'localhost:9188'
# pgbouncer_exporter['env_directory'] = '/opt/gitlab/etc/pgbouncer-exporter/env'
# pgbouncer_exporter['env'] = {
#   'SSL_CERT_DIR' => "/opt/gitlab/embedded/ssl/certs/"
# }

################################################################################
## Prometheus Gitlab exporter
##! Docs: https://docs.gitlab.com/ee/administration/monitoring/prometheus/gitlab_exporter.html
################################################################################

# gitlab_exporter['enable'] = true
# gitlab_exporter['log_directory'] = "/var/log/gitlab/gitlab-exporter"
# gitlab_exporter['log_group'] = nil
# gitlab_exporter['home'] = "/var/opt/gitlab/gitlab-exporter"

##! Advanced settings. Should be changed only if absolutely needed.
# gitlab_exporter['server_name'] = 'webrick'
# gitlab_exporter['listen_address'] = 'localhost'
# gitlab_exporter['listen_port'] = '9168'

##! TLS settings.
# gitlab_exporter['tls_enabled'] = false
# gitlab_exporter['tls_cert_path'] = '/etc/gitlab/ssl/gitlab-exporter.crt'
# gitlab_exporter['tls_key_path'] = '/etc/gitlab/ssl/gitlab-exporter.key'

##! Prometheus scrape related configs
# gitlab_exporter['prometheus_scrape_scheme'] = 'http'
# gitlab_exporter['prometheus_scrape_tls_server_name'] = 'localhost'
# gitlab_exporter['prometheus_scrape_tls_skip_verification'] = false

##! Manage gitlab-exporter sidekiq probes. false by default when Sentinels are
##! found.
# gitlab_exporter['probe_sidekiq'] = true

##! Manage gitlab-exporter elasticsearch probes. Add authorization header if security
##! is enabled.
# gitlab_exporter['probe_elasticsearch'] = false
# gitlab_exporter['elasticsearch_url'] = 'http://localhost:9200'
# gitlab_exporter['elasticsearch_authorization'] = 'Basic <yourbase64encodedcredentials>'

##! Service name used to register GitLab Exporter as a Consul service
# gitlab_exporter['consul_service_name'] = 'gitlab-exporter'
##! Semantic metadata used when registering GitLab Exporter as a Consul service
# gitlab_exporter['consul_service_meta'] = {}

##! Command to generate extra configuration
# gitlab_exporter['extra_config_command'] = nil

##! To completely disable prometheus, and all of it's exporters, set to false
# prometheus_monitoring['enable'] = true

################################################################################
## Gitaly
##! Docs: https://docs.gitlab.com/ee/administration/gitaly/configure_gitaly.html
################################################################################

##! The gitaly['enable'] option exists for the purpose of cluster
##! deployments, see https://docs.gitlab.com/ee/administration/gitaly/index.html .
# gitaly['enable'] = true
# gitaly['dir'] = "/var/opt/gitlab/gitaly"
# gitaly['log_group'] = nil
# gitaly['bin_path'] = "/opt/gitlab/embedded/bin/gitaly"
# gitaly['use_wrapper'] = true
# gitaly['env_directory'] = "/opt/gitlab/etc/gitaly/env"
# gitaly['env'] = {
#  'PATH' => "/opt/gitlab/bin:/opt/gitlab/embedded/bin:/bin:/usr/bin",
#  'HOME' => '/var/opt/gitlab',
#  'TZ' => ':/etc/localtime',
#  'PYTHONPATH' => "/opt/gitlab/embedded/lib/python3.9/site-packages",
#  'ICU_DATA' => "/opt/gitlab/embedded/share/icu/current",
#  'SSL_CERT_DIR' => "/opt/gitlab/embedded/ssl/certs/",
#  'WRAPPER_JSON_LOGGING' => true
# }
# gitaly['gitlab_secret'] = <secret>


# gitaly['open_files_ulimit'] = 15000 # Maximum number of open files allowed for the gitaly process        
##! Service name used to register Gitaly as a Consul service
# gitaly['consul_service_name'] = 'gitaly'
##! Semantic metadata used when registering Gitaly as a Consul service
# gitaly['consul_service_meta'] = {}
# gitaly['configuration'] = {
#   socket_path: '/var/opt/gitlab/gitaly/gitaly.socket',
#   runtime_dir: '/var/opt/gitlab/gitaly/run',
#   listen_addr: 'localhost:8075',
#   prometheus_listen_addr: 'localhost:9236',
#   tls_listen_addr: 'localhost:9075',
#   tls: {
#     certificate_path: '/var/opt/gitlab/gitaly/certificate.pem',
#     key_path: '/var/opt/gitlab/gitaly/key.pem',
#   },
#   graceful_restart_timeout: '1m', # Grace time for a gitaly process to finish ongoing requests
#   logging: {
#     dir: "/var/log/gitlab/gitaly",
#     level: 'warn',
#     format: 'json',
#     sentry_dsn: 'https://<key>:<secret>@sentry.io/<project>',
#     sentry_environment: 'production',
#   },
#   prometheus: {
#     grpc_latency_buckets: [0.001, 0.005, 0.025, 0.1, 0.5, 1.0, 10.0, 30.0, 60.0, 300.0, 1500.0],
#   },
#   auth: {
#     token: '<secret>',
#     transitioning: false, # When true, auth is logged to Prometheus but NOT enforced
#   },
#   git: {
#     catfile_cache_size: 100, # Number of 'git cat-file' processes kept around for re-use
#     bin_path: '/opt/gitlab/embedded/bin/git', # A custom path for the 'git' executable
#     use_bundled_binaries: true, # Whether to use bundled Git.
#     signing_key: '/var/opt/gitlab/gitaly/signing_key.gpg',
#     ## Gitaly knows to set up the required default configuration for spawned Git
#     ## commands automatically. It should thus not be required to configure anything
#     ## here, except in very special situations where you must e.g. tweak specific
#     ## performance-related settings or enable debugging facilities. It is not safe in
#     ## general to set Git configuration that may change Git output in ways that are
#     ## unexpected by Gitaly.
#     config: [
#       { key: 'pack.threads', value: '4' },
#       { key: 'http.http://example.com.proxy', value: 'http://example.proxy.com' },
#     ],
#   },
#   gitlab: {
#     url: 'http://localhost:9999',
#     relative_url_root: '/gitlab-ee',
#   },
#   hooks: {
#     custom_hooks_dir: '/var/opt/gitlab/gitaly/custom_hooks',
#   },
#   daily_maintenance: {
#     disabled: false,
#     start_hour: 22,
#     start_minute: 30,
#     duration: '30m',
#     storages: ['default'],
#   },
#   cgroups: {
#     mountpoint: '/sys/fs/cgroup',
#     hierarchy_root: 'gitaly',
#     memory_bytes: 1048576,
#     cpu_shares: 512,
#     cpu_quota_us: 400000,
#     repositories: {
#       count: 1000,
#       memory_bytes: 12884901888,
#       cpu_shares: 128,
#       cpu_quota_us: 200000
#       max_cgroups_per_repo: 2
#     },
#   },
#   concurrency: [
#     {
#       rpc: '/gitaly.SmartHTTPService/PostReceivePack',
#       max_per_repo: 20,
#     },
#     {
#       rpc: '/gitaly.SSHService/SSHUploadPack',
#       max_per_repo: 5,
#     },
#   ],
#   rate_limiting: [
#     {
#       rpc: '/gitaly.SmartHTTPService/PostReceivePack',
#       interval: '1m',
#       burst: 10,
#     },
#     {
#       rpc: '/gitaly.SSHService/SSHUploadPack',
#       interval: '1m',
#       burst: 5,
#     },
#   ],
#   pack_objects_cache: {
#     enabled: true,
#     dir: '/var/opt/gitlab/git-data/repositories/+gitaly/PackObjectsCache',
#     max_age: '5m',
#   },
#   storage: [
#     {
#       name: 'gitaly-1',
#       path: '/var/opt/gitlab/git-data/repositories',
#     },
#   ],
# }

################################################################################
## Praefect
##! Docs: https://docs.gitlab.com/ee/administration/gitaly/praefect.html
################################################################################

# praefect['enable'] = false
# praefect['dir'] = "/var/opt/gitlab/praefect"
# praefect['log_directory'] = "/var/log/gitlab/praefect"
# praefect['log_group'] = nil
# praefect['env_directory'] = "/opt/gitlab/etc/praefect/env"
# praefect['env'] = {
#  'SSL_CERT_DIR' => "/opt/gitlab/embedded/ssl/certs/",
#  'GITALY_PID_FILE' => "/var/opt/gitlab/praefect/praefect.pid",
#  'WRAPPER_JSON_LOGGING' => true
# }
# praefect['wrapper_path'] = "/opt/gitlab/embedded/bin/gitaly-wrapper"
# praefect['auto_migrate'] = true
##! Service name used to register Praefect as a Consul service
# praefect['consul_service_name'] = 'praefect'
##! Semantic metadata used when registering Praefect as a Consul service
# praefect['consul_service_meta'] = {}
# praefect['configuration'] = {
#   listen_addr: 'localhost:2305',
#   prometheus_listen_addr: 'localhost:9652',
#   tls_listen_addr: 'localhost:3305',
#   auth: {
#     token: '',
#     transitioning: false,
#   },
#   logging: {
#     format: 'json',
#     level: 'warn',
#   },
#   failover: {
#     enabled: true,
#   },
#   background_verification: {
#     delete_invalid_records: false,
#     verification_interval: '72h',
#   },
#   reconciliation: {
#     scheduling_interval: '5m',
#     histogram_buckets: [0.001, 0.005, 0.025, 0.1, 0.5, 1.0, 10.0],
#   },
#   tls: {
#     certificate_path: '/var/opt/gitlab/prafect/certificate.pem',
#     key_path: '/var/opt/gitlab/prafect/key.pem',
#   },
#   database: {
#     host: 'postgres.external',
#     port: 6432,
#     user: 'praefect',
#     password: 'secret',
#     dbname: 'praefect_production',
#     sslmode: 'disable',
#     sslcert: '/path/to/client-cert',
#     sslkey: '/path/to/client-key',
#     sslrootcert: '/path/to/rootcert',
#     session_pooled: {
#       host: 'postgres.internal',
#       port: 5432,
#       user: 'praefect',
#       password: 'secret',
#       dbname: 'praefect_production_direct',
#       sslmode: 'disable',
#       sslcert: '/path/to/client-cert',
#       sslkey: '/path/to/client-key',
#       sslrootcert: '/path/to/rootcert',
#     },
#   },
#   sentry: {
#     sentry_dsn: 'https://<key>:<secret>@sentry.io/<project>',
#     sentry_environment: 'production',
#   },
#   prometheus: {
#     grpc_latency_buckets: [0.001, 0.005, 0.025, 0.1, 0.5, 1.0, 10.0, 30.0, 60.0, 300.0, 1500.0],
#   },
#   graceful_stop_timeout: '1m',
#   virtual_storage: [
#     {
#       name: 'default',
#       default_replication_factor: 3,
#       node: [
#         {
#           storage: 'praefect-internal-0',
#           address: 'tcp://10.23.56.78:8075',
#           token: 'abc123',
#         },
#         {
#           storage: 'praefect-internal-1',
#           address: 'tcp://10.76.23.31:8075',
#           token: 'xyz456',
#         },
#       ],
#       },
#     {
#       name: 'alternative',
#       node: [
#         {
#           storage: 'praefect-internal-2',
#           address: 'tcp://10.34.1.16:8075',
#           token: 'abc321',
#         },
#         {
#           storage: 'praefect-internal-3',
#           address: 'tcp://10.23.18.6:8075',
#           token: 'xyz890',
#         },
#       ],
#     },
#   ],
# }

################################################################################
## Storage check
################################################################################
# storage_check['enable'] = false
# storage_check['target'] = 'unix:///var/opt/gitlab/gitlab-rails/sockets/gitlab.socket'
# storage_check['log_directory'] = '/var/log/gitlab/storage-check'
# storage_check['log_group'] = nil

################################################################################
## Let's Encrypt integration
################################################################################
# letsencrypt['enable'] = nil
# letsencrypt['contact_emails'] = [] # This should be an array of email addresses to add as contacts       
# letsencrypt['group'] = 'root'
# letsencrypt['key_size'] = 2048
# letsencrypt['owner'] = 'root'
# letsencrypt['wwwroot'] = '/var/opt/gitlab/nginx/www'
##! See https://docs.gitlab.com/omnibus/settings/ssl/index.html#renew-the-certificates-automatically for more on these settings
# letsencrypt['auto_renew'] = true
# letsencrypt['auto_renew_hour'] = 0
# letsencrypt['auto_renew_minute'] = nil # Should be a number or cron expression, if specified.
# letsencrypt['auto_renew_day_of_month'] = "*/4"
# letsencrypt['auto_renew_log_directory'] = '/var/log/gitlab/lets-encrypt'
# letsencrypt['alt_names'] = []

##! Turn off automatic init system detection. To skip init detection in
##! non-docker containers. Recommended not to change.
# package['detect_init'] = true

##! Attempt to modify kernel paramaters. To skip this in containers where the
##! relevant file system is read-only, set the value to false.
# package['modify_kernel_parameters'] = true

##! Specify maximum number of tasks that can be created by the systemd unit
##! Will be populated as TasksMax value to the unit file if user is on a systemd
##! version that supports it (>= 227). Will be a no-op if user is not on systemd.
# package['systemd_tasks_max'] = 4915

##! Settings to configure order of GitLab's systemd unit.
##! Note: We do not recommend changing these values unless absolutely necessary
# package['systemd_after'] = 'multi-user.target'
# package['systemd_wanted_by'] = 'multi-user.target'

##! Settings to control secret generation and storage
##! Note: We do not recommend changing these values unless absolutely necessary
##! Set to false to only parse secrets from `gitlab-secrets.json` file but not generate them.
# package['generate_default_secrets'] = true
##! Set to false to prevent creating the default `gitlab-secrets.json` file
# package['generate_secrets_json_file'] = true

##! Settings to control SELinux policy
##! Experimental. Set to 1.0 to switch from legacy multiple policy modules to
##! newer single `gitlab` SELinux policy module.
# package['selinux_policy_version'] = nil
################################################################################
################################################################################
##                  Configuration Settings for GitLab EE only                 ##
################################################################################
################################################################################


################################################################################
## Auxiliary cron jobs applicable to GitLab EE only
################################################################################

# gitlab_rails['geo_repository_sync_worker_cron'] = "*/5 * * * *"
# gitlab_rails['geo_secondary_registry_consistency_worker'] = "* * * * *"
# gitlab_rails['geo_secondary_usage_data_cron_worker'] = "0 0 * * 0"
# gitlab_rails['geo_prune_event_log_worker_cron'] = "*/5 * * * *"
# gitlab_rails['geo_repository_verification_primary_batch_worker_cron'] = "*/5 * * * *"
# gitlab_rails['geo_repository_verification_secondary_scheduler_worker_cron'] = "*/5 * * * *"
# gitlab_rails['geo_metrics_update_worker_cron'] = "*/1 * * * *"
# gitlab_rails['ldap_sync_worker_cron'] = "30 1 * * *"
# gitlab_rails['ldap_group_sync_worker_cron'] = "0 * * * *"
# gitlab_rails['historical_data_worker_cron'] = "0 12 * * *"
# gitlab_rails['elastic_index_bulk_cron'] = "*/1 * * * *"
# gitlab_rails['analytics_devops_adoption_create_all_snapshots_worker_cron'] = "0 4 * * 0"
# gitlab_rails['ci_runners_stale_group_runners_prune_worker_cron'] = "30 * * * *"
# gitlab_rails['click_house_ci_finished_builds_sync_worker_cron'] = "*/3 * * * *"
# gitlab_rails['click_house_ci_finished_builds_sync_worker_args'] = [1]

################################################################################
## Kerberos (EE Only)
##! Docs: https://docs.gitlab.com/ee/integration/kerberos.html#http-git-access
################################################################################

# gitlab_rails['kerberos_enabled'] = true
# gitlab_rails['kerberos_keytab'] = /etc/http.keytab
# gitlab_rails['kerberos_service_principal_name'] = HTTP/gitlab.example.com@EXAMPLE.COM
# gitlab_rails['kerberos_simple_ldap_linking_allowed_realms'] = ['example.com','kerberos.example.com']     
# gitlab_rails['kerberos_use_dedicated_port'] = true
# gitlab_rails['kerberos_port'] = 8443
# gitlab_rails['kerberos_https'] = true

################################################################################
## Package repository
##! Docs: https://docs.gitlab.com/ee/administration/packages/
################################################################################

# gitlab_rails['packages_enabled'] = true
# gitlab_rails['packages_storage_path'] = "/var/opt/gitlab/gitlab-rails/shared/packages"
# gitlab_rails['packages_object_store_enabled'] = false
# gitlab_rails['packages_object_store_proxy_download'] = false
# gitlab_rails['packages_object_store_remote_directory'] = "packages"
# gitlab_rails['packages_object_store_connection'] = {
#   'provider' => 'AWS',
#   'region' => 'eu-west-1',
#   'aws_access_key_id' => 'AWS_ACCESS_KEY_ID',
#   'aws_secret_access_key' => 'AWS_SECRET_ACCESS_KEY',
#   # # The below options configure an S3 compatible host instead of AWS
#   # 'host' => 's3.amazonaws.com',
#   # 'aws_signature_version' => 4, # For creation of signed URLs. Set to 2 if provider does not support v4.
#   # 'endpoint' => 'https://s3.amazonaws.com', # default: nil - Useful for S3 compliant services such as DigitalOcean Spaces
#   # 'path_style' => false # Use 'host/bucket_name/object' instead of 'bucket_name.host/object'
# }

################################################################################
## Dependency proxy
##! Docs: https://docs.gitlab.com/ee/administration/packages/dependency_proxy.html
################################################################################

# gitlab_rails['dependency_proxy_enabled'] = true
# gitlab_rails['dependency_proxy_storage_path'] = "/var/opt/gitlab/gitlab-rails/shared/dependency_proxy"   
# gitlab_rails['dependency_proxy_object_store_enabled'] = false
# gitlab_rails['dependency_proxy_object_store_proxy_download'] = false
# gitlab_rails['dependency_proxy_object_store_remote_directory'] = "dependency_proxy"
# gitlab_rails['dependency_proxy_object_store_connection'] = {
#   'provider' => 'AWS',
#   'region' => 'eu-west-1',
#   'aws_access_key_id' => 'AWS_ACCESS_KEY_ID',
#   'aws_secret_access_key' => 'AWS_SECRET_ACCESS_KEY',
#   # # The below options configure an S3 compatible host instead of AWS
#   # 'host' => 's3.amazonaws.com',
#   # 'aws_signature_version' => 4, # For creation of signed URLs. Set to 2 if provider does not support v4.
#   # 'endpoint' => 'https://s3.amazonaws.com', # default: nil - Useful for S3 compliant services such as DigitalOcean Spaces
#   # 'path_style' => false # Use 'host/bucket_name/object' instead of 'bucket_name.host/object'
# }

################################################################################
## GitLab Sentinel (EE Only)
##! Docs: https://docs.gitlab.com/ee/administration/redis/replication_and_failover.html
################################################################################

##! **Make sure you configured all redis['master_*'] keys above before
##!   continuing.**

##! To enable Sentinel and disable all other services in this machine,
##! uncomment the line below (if you've enabled Redis role, it will keep it).
##! Docs: https://docs.gitlab.com/ee/administration/redis/replication_and_failover.html
# redis_sentinel_role['enable'] = true

# sentinel['enable'] = true

##! Bind to all interfaces, uncomment to specify an IP and bind to a single one
# sentinel['bind'] = '0.0.0.0'

##! Uncomment to change default port
# sentinel['port'] = 26379

##! Uncomment to require a Sentinel password. This may be different from the Redis master password.        
# sentinel['password'] = 'sentinel-password-goes-here'

### Support to run sentinels in a Docker or NAT environment
###! Docs: https://redis.io/topics/sentinel#sentinel-docker-nat-and-possible-issues
###! In an standard case, Sentinel will run in the same network service as Redis, so the same IP will be announce for Redis and Sentinel
###! Only define these values if it is needed to announce for Sentinel a differen IP service than Redis    
# sentinel['announce_ip'] = nil # If not defined, its value will be taken from redis['announce_ip'] or nil if not present
# sentinel['announce_port'] = nil # If not defined, its value will be taken from sentinel['port'] or nil if redis['announce_ip'] not present

##! Quorum must reflect the amount of voting sentinels it take to start a
##! failover.
##! **Value must NOT be greater then the amount of sentinels.**
##! The quorum can be used to tune Sentinel in two ways:
##! 1. If a the quorum is set to a value smaller than the majority of Sentinels
##!    we deploy, we are basically making Sentinel more sensible to master
##!    failures, triggering a failover as soon as even just a minority of
##!    Sentinels is no longer able to talk with the master.
##! 2. If a quorum is set to a value greater than the majority of Sentinels, we
##!    are making Sentinel able to failover only when there are a very large
##!    number (larger than majority) of well connected Sentinels which agree
##!    about the master being down.
# sentinel['quorum'] = 1

### Consider unresponsive server down after x amount of ms.
# sentinel['down_after_milliseconds'] = 10000

### Specifies the failover timeout in milliseconds.
##! It is used in many ways:
##!
##! - The time needed to re-start a failover after a previous failover was
##!   already tried against the same master by a given Sentinel, is two
##!   times the failover timeout.
##!
##! - The time needed for a replica replicating to a wrong master according
##!   to a Sentinel current configuration, to be forced to replicate
##!   with the right master, is exactly the failover timeout (counting since
##!   the moment a Sentinel detected the misconfiguration).
##!
##! - The time needed to cancel a failover that is already in progress but
##!   did not produced any configuration change (REPLICAOF NO ONE yet not
##!   acknowledged by the promoted replica).
##!
##! - The maximum time a failover in progress waits for all the replicas to be
##!   reconfigured as replicas of the new master. However even after this time
##!   the replicas will be reconfigured by the Sentinels anyway, but not with
##!   the exact parallel-syncs progression as specified.
# sentinel['failover_timeout'] = 60000

### Sentinel TLS settings
###! To run Sentinel over TLS, specify values for the following settings
# sentinel['tls_port'] = nil
# sentinel['tls_cert_file'] = nil
# sentinel['tls_key_file'] = nil

###! Other TLS related optional settings
# sentinel['tls_dh_params_file'] = nil
# sentinel['tls_ca_cert_dir'] = '/opt/gitlab/embedded/ssl/certs/'
# sentinel['tls_ca_cert_file'] = '/opt/gitlab/embedded/ssl/certs/cacert.pem'
# sentinel['tls_auth_clients'] = 'optional'
# sentinel['tls_replication'] = nil
# sentinel['tls_cluster'] = nil
# sentinel['tls_protocols'] = nil
# sentinel['tls_ciphers'] = nil
# sentinel['tls_ciphersuites'] = nil
# sentinel['tls_prefer_server_ciphers'] = nil
# sentinel['tls_session_caching'] = nil
# sentinel['tls_session_cache_size'] = nil
# sentinel['tls_session_cache_timeout'] = nil

### Sentinel hostname support
###! When enabled, Redis will leverage hostname support
###! Generally this does not need to be changed as we determine this based on
###! the provided input from `redis['announce_ip']`
###! * This is configured to `true` when a fully qualified hostname is provided
###! * This is configured to `false` when an IP address is provided
# sentinel['use_hostnames'] = <calculated>

### Sentinel log settings
# sentinel['log_directory'] = '/var/log/gitlab/sentinel'

################################################################################
## Additional Database Settings (EE only)
##! Docs: https://docs.gitlab.com/ee/administration/postgresql/database_load_balancing.html
################################################################################
# gitlab_rails['db_load_balancing'] = { 'hosts' => ['secondary1.example.com'] }

################################################################################
## GitLab Geo
##! Docs: https://docs.gitlab.com/ee/administration/geo/
################################################################################
##! Geo roles 'geo_primary_role' and 'geo_secondary_role' are set above with
##! other roles. For more information, see: https://docs.gitlab.com/omnibus/roles/index.html#roles .       

##! This is an optional identifier which Geo nodes can use to identify themselves.
##! For example, if external_url is the same for two secondaries, you must specify
##! a unique Geo node name for those secondaries.

##! If it is blank, it defaults to external_url.
# gitlab_rails['geo_node_name'] = nil

# gitlab_rails['geo_registry_replication_enabled'] = true
# gitlab_rails['geo_registry_replication_primary_api_url'] = 'https://example.com:5050'


################################################################################
## GitLab Geo Secondary (EE only)
################################################################################
# geo_secondary['auto_migrate'] = true
# geo_secondary['db_adapter'] = "postgresql"
# geo_secondary['db_encoding'] = "unicode"
# geo_secondary['db_collation'] = nil
# geo_secondary['db_database'] = "gitlabhq_geo_production"
# geo_secondary['db_username'] = "gitlab_geo"
# geo_secondary['db_password'] = nil
# geo_secondary['db_host'] = "/var/opt/gitlab/geo-postgresql"
# geo_secondary['db_port'] = 5431
# geo_secondary['db_socket'] = nil
# geo_secondary['db_sslmode'] = nil
# geo_secondary['db_sslcompression'] = 0
# geo_secondary['db_sslrootcert'] = nil
# geo_secondary['db_sslca'] = nil
# geo_secondary['db_prepared_statements'] = false
# geo_secondary['db_database_tasks'] = true

################################################################################
## GitLab Geo Secondary Tracking Database (EE only)
################################################################################

# geo_postgresql['enable'] = false
# geo_postgresql['ha'] = false
# geo_postgresql['dir'] = '/var/opt/gitlab/geo-postgresql'
# geo_postgresql['pgbouncer_user'] = nil
# geo_postgresql['pgbouncer_user_password'] = nil
##! `SQL_USER_PASSWORD_HASH` can be generated using the command `gitlab-ctl pg-password-md5 gitlab`        
# geo_postgresql['sql_user_password'] = 'SQL_USER_PASSWORD_HASH'
# geo_postgresql['log_directory'] = '/var/log/gitlab/geo-postgresql'

##! Automatically restart PostgreSQL service when version changes.
# geo_postgresql['auto_restart_on_version_change'] = true

################################################################################
## GitLab Geo Log Cursor Daemon (EE only)
################################################################################

# geo_logcursor['enable'] = false
# geo_logcursor['log_directory'] = '/var/log/gitlab/geo-logcursor'
# geo_logcursor['log_group'] = nil

################################################################################
## Unleash
##! These settings are for GitLab internal use.
##! They are used to control feature flags during GitLab development.
##! Docs: https://docs.gitlab.com/ee/development/feature_flags
################################################################################
# gitlab_rails['feature_flags_unleash_enabled'] = false
# gitlab_rails['feature_flags_unleash_url'] = nil
# gitlab_rails['feature_flags_unleash_app_name'] = nil
# gitlab_rails['feature_flags_unleash_instance_id'] = nil

################################################################################
## Pgbouncer (EE only)
##! See the GitLab PgBouncer documentation: https://docs.gitlab.com/ee/administration/postgresql/pgbouncer.html
##! See the PgBouncer page http://www.pgbouncer.org/config.html for details
################################################################################
# pgbouncer['enable'] = false
# pgbouncer['log_directory'] = '/var/log/gitlab/pgbouncer'
# pgbouncer['log_group'] = nil
# pgbouncer['data_directory'] = '/var/opt/gitlab/pgbouncer'
# pgbouncer['env_directory'] = '/opt/gitlab/etc/pgbouncer/env'
# pgbouncer['env'] = {
#   'SSL_CERT_DIR' => "/opt/gitlab/embedded/ssl/certs/"
# }
# pgbouncer['listen_addr'] = '0.0.0.0'
# pgbouncer['listen_port'] = '6432'
# pgbouncer['pool_mode'] = 'transaction'
# pgbouncer['max_prepared_statements'] = 0
# pgbouncer['server_reset_query'] = 'DISCARD ALL'
# pgbouncer['application_name_add_host'] = '1'
# pgbouncer['max_client_conn'] = '2048'
# pgbouncer['default_pool_size'] = '100'
# pgbouncer['min_pool_size'] = '0'
# pgbouncer['reserve_pool_size'] = '5'
# pgbouncer['reserve_pool_timeout'] = '5.0'
# pgbouncer['server_round_robin'] = '0'
# pgbouncer['log_connections'] = '0'
# pgbouncer['server_idle_timeout'] = '30'
# pgbouncer['dns_max_ttl'] = '15.0'
# pgbouncer['dns_zone_check_period'] = '0'
# pgbouncer['dns_nxdomain_ttl'] = '15.0'
# pgbouncer['admin_users'] = %w(gitlab-psql postgres pgbouncer)
# pgbouncer['stats_users'] = %w(gitlab-psql postgres pgbouncer)
# pgbouncer['ignore_startup_parameters'] = 'extra_float_digits'
# pgbouncer['track_extra_parameters'] = %w(IntervalStyle)
# pgbouncer['databases'] = {
#   DATABASE_NAME: {
#     host: HOSTNAME,
#     port: PORT
#     user: USERNAME,
#     password: PASSWORD
##! generate this with `echo -n '$password + $username' | md5sum`
#   }
#   ...
# }
# pgbouncer['logfile'] = nil
# pgbouncer['unix_socket_dir'] = nil
# pgbouncer['unix_socket_mode'] = '0777'
# pgbouncer['unix_socket_group'] = nil
# pgbouncer['auth_type'] = 'md5'
# pgbouncer['auth_hba_file'] = nil
# pgbouncer['auth_dbname'] = nil
# pgbouncer['auth_query'] = 'SELECT username, password FROM public.pg_shadow_lookup($1)'
# pgbouncer['users'] = {
#   USERNAME: {
#     'password': MD5_PASSWORD_HASH,
#   }
# }
# postgresql['pgbouncer_user'] = nil
# postgresql['pgbouncer_user_password'] = nil
# pgbouncer['server_reset_query_always'] = 0
# pgbouncer['server_check_query'] = 'select 1'
# pgbouncer['server_check_delay'] = 30
# pgbouncer['max_db_connections'] = nil
# pgbouncer['max_user_connections'] = nil
# pgbouncer['syslog'] = 0
# pgbouncer['syslog_facility'] = 'daemon'
# pgbouncer['syslog_ident'] = 'pgbouncer'
# pgbouncer['log_disconnections'] = 1
# pgbouncer['log_pooler_errors'] = 1
# pgbouncer['stats_period'] = 60
# pgbouncer['verbose'] = 0
# pgbouncer['server_lifetime'] = 3600
# pgbouncer['server_connect_timeout'] = 15
# pgbouncer['server_login_retry'] = 15
# pgbouncer['query_timeout'] = 0
# pgbouncer['query_wait_timeout'] = 120
# pgbouncer['client_idle_timeout'] = 0
# pgbouncer['client_login_timeout'] = 60
# pgbouncer['autodb_idle_timeout'] = 3600
# pgbouncer['suspend_timeout'] = 10
# pgbouncer['idle_transaction_timeout'] = 0
# pgbouncer['cancel_wait_timeout'] = 10
# pgbouncer['pkt_buf'] = 4096
# pgbouncer['listen_backlog'] = 128
# pgbouncer['sbuf_loopcnt'] = 5
# pgbouncer['max_packet_size'] = 2147483647
# pgbouncer['so_reuseport'] = 0
# pgbouncer['tcp_defer_accept'] = 0
# pgbouncer['tcp_socket_buffer'] = 0
# pgbouncer['tcp_keepalive'] = 1
# pgbouncer['tcp_keepcnt'] = 0
# pgbouncer['tcp_keepidle'] = 0
# pgbouncer['tcp_keepintvl'] = 0
# pgbouncer['disable_pqexec'] = 0
# default['pgbouncer']['peers'] = {}

### Pgbouncer client TLS options
# pgbouncer['client_tls_sslmode'] = 'disable'
# pgbouncer['client_tls_ca_file'] = nil
# pgbouncer['client_tls_key_file'] = nil
# pgbouncer['client_tls_cert_file'] = nil
# pgbouncer['client_tls_protocols'] = 'all'
# pgbouncer['client_tls_dheparams'] = 'auto'
# pgbouncer['client_tls_ecdhcurve'] = 'auto'
#
### Pgbouncer server  TLS options
# pgbouncer['server_tls_sslmode'] = 'disable'
# pgbouncer['server_tls_ca_file'] = nil
# pgbouncer['server_tls_key_file'] = nil
# pgbouncer['server_tls_cert_file'] = nil
# pgbouncer['server_tls_protocols'] = 'all'
# pgbouncer['server_tls_ciphers'] = 'fast'

################################################################################
## Patroni (EE only)
################################################################################
# patroni['enable'] = false

# patroni['dir'] = '/var/opt/gitlab/patroni'
# patroni['ctl_command'] = '/opt/gitlab/embedded/bin/patronictl'

### Patroni dynamic configuration settings
# patroni['loop_wait'] = 10
# patroni['ttl'] = 30
# patroni['retry_timeout'] = 10
# patroni['maximum_lag_on_failover'] = 1_048_576
# patroni['max_timelines_history'] = 0
# patroni['master_start_timeout'] = 300
# patroni['use_pg_rewind'] = true
# patroni['remove_data_directory_on_rewind_failure'] = false
# patroni['remove_data_directory_on_diverged_timelines'] = false
# patroni['use_slots'] = true
# patroni['replication_password'] = nil
# patroni['replication_slots'] = {}
# patroni['callbacks'] = {}
# patroni['recovery_conf'] = {}
# patroni['tags'] = {}

### Standby cluster replication settings
# patroni['standby_cluster']['enable'] = false
# patroni['standby_cluster']['host'] = nil
# patroni['standby_cluster']['port'] = 5432
# patroni['standby_cluster']['primary_slot_name'] = nil

### Global/Universal settings
# patroni['scope'] = 'gitlab-postgresql-ha'
# patroni['name'] = nil

### Log settings
# patroni['log_directory'] = '/var/log/gitlab/patroni'
# patroni['log_group'] = nil
# patroni['log_level'] = 'INFO'

### Consul specific settings
# patroni['consul']['url'] = 'http://127.0.0.1:8500'
# patroni['consul']['service_check_interval'] = '10s'
# patroni['consul']['register_service'] = true
# patroni['consul']['checks'] = []

### PostgreSQL configuration override
# patroni['postgresql']['hot_standby'] = 'on'

###! The following must hold the same values on all nodes.
###! Leave unassined to use PostgreSQL's default values.
# patroni['postgresql']['wal_level'] = 'replica'
# patroni['postgresql']['wal_log_hints'] = 'on'
# patroni['postgresql']['max_worker_processes'] = 8
# patroni['postgresql']['max_locks_per_transaction'] = 64
# patroni['postgresql']['max_connections'] = 400
# patroni['postgresql']['checkpoint_timeout'] = 30

###! The following can hold different values on all nodes.
###! Leave unassined to use PostgreSQL's default values.
# patroni['postgresql']['wal_keep_segments'] = 8
# patroni['postgresql']['max_wal_senders'] = 5
# patroni['postgresql']['max_replication_slots'] = 5

### Permanent replication slots for Streaming Replication
# patroni['replication_slots'] = {
#   'geo_secondary' => { 'type' => 'physical' }
# }

###! The address and port that Patroni API binds to and listens on.
# patroni['listen_address'] = nil
# patroni['port'] = '8008'

###! The address of the Patroni node that is advertized to other cluster
###! members to communicate with its API and PostgreSQL. If it is not specified,
###! it tries to use the first available private IP and falls back to the default
###! network interface.
# patroni['connect_address'] = nil

###! The port that Patroni API responds to other cluster members. This port is
###! advertized and by default is the same as patroni['port'].
# patroni['connect_port'] = '8008'

###! Specifies the set of hosts that are allowed to call unsafe REST API endpoints.
###! Each item can be an hostname, IP address, or CIDR address.
###! All hosts are allowed if this is unset.
# patroni['allowlist'] = []
# patroni['allowlist_include_members'] = false

###! The username and password to use for basic auth on write commands to the
###! Patroni API. If not specified then the API does not use basic auth.
# patroni['username'] = nil
# patroni['password'] = nil

###! TLS configuration for Patroni API. Both certificate and key files are
###! required to enable TLS. If not specified then the API uses plain HTTP.
# patroni['tls_certificate_file'] = nil
# patroni['tls_key_file'] = nil
# patroni['tls_key_password'] = nil
# patroni['tls_ca_file'] = nil
# patroni['tls_ciphers'] = nil
# patroni['tls_client_mode'] = nil
# patroni['tls_client_certificate_file'] = nil
# patroni['tls_client_key_file'] = nil
# patroni['tls_verify'] = true

################################################################################
## Consul (EE only)
################################################################################
# consul['enable'] = false
# consul['binary_path'] = '/opt/gitlab/embedded/bin/consul'
# consul['dir'] = '/var/opt/gitlab/consul'
# consul['username'] = 'gitlab-consul'
# consul['group'] = 'gitlab-consul'
# consul['config_file'] = '/var/opt/gitlab/consul/config.json'
# consul['config_dir'] = '/var/opt/gitlab/consul/config.d'
# consul['data_dir'] = '/var/opt/gitlab/consul/data'
# consul['log_directory'] = '/var/log/gitlab/consul'
# consul['log_group'] = nil
# consul['env_directory'] = '/opt/gitlab/etc/consul/env'
# consul['env'] = {
#   'SSL_CERT_DIR' => "/opt/gitlab/embedded/ssl/certs/"
# }
# consul['monitoring_service_discovery'] = false
# consul['node_name'] = nil
# consul['script_directory'] = '/var/opt/gitlab/consul/scripts'
# consul['configuration'] = {
#   'client_addr' => nil,
#   'datacenter' => 'gitlab_consul',
#   'enable_script_checks' => false,
#   'enable_local_script_checks' => true,
#   'server' => false
# }
# consul['services'] = []
# consul['service_config'] = {
#   'postgresql' => {
#     'service' => {
#       'name' => "postgresql",
#       'address' => '',
#       'port' => 5432,
#       'checks' => [
#         {
#           'script' => "/var/opt/gitlab/consul/scripts/check_postgresql",
#           'interval' => "10s"
#         }
#       ]
#     }
#   }
# }
# consul['watchers'] = []
# consul['custom_config_dir'] = '/path/to/service/configs/directory'

### HTTP API ports
# consul['http_port'] = nil
# consul['https_port'] = nil

### Gossip encryption
# consul['encryption_key'] = nil
# consul['encryption_verify_incoming'] = nil
# consul['encryption_verify_outgoing'] = nil

### TLS settings
# consul['use_tls'] = false
# consul['tls_ca_file'] = nil
# consul['tls_certificate_file'] = nil
# consul['tls_key_file'] = nil
# consul['tls_verify_client'] = nil

################################################################################
## Service desk email settings
################################################################################
### Service desk email
###! Allow users to create new service desk issues by sending an email to
###! service desk address.
###! Docs: https://docs.gitlab.com/ee/user/project/service_desk/index.html
# gitlab_rails['service_desk_email_enabled'] = false

#### Service Desk Mailbox Settings (via `mail_room`)
#### Service Desk Email Address
####! The email address including the `%{key}` placeholder that will be replaced
####! to reference the item being replied to.
####! **The placeholder can be omitted but if present, it must appear in the
####!   "user" part of the address (before the `@`).**
# gitlab_rails['service_desk_email_address'] = "contact_project+%{key}@gmail.com"

#### Service Desk Email account username
####! **With third party providers, this is usually the full email address.**
####! **With self-hosted email servers, this is usually the user part of the
####!   email address.**
# gitlab_rails['service_desk_email_email'] = "contact_project@gmail.com"

#### Service Desk Email account password
# gitlab_rails['service_desk_email_password'] = "[REDACTED]"

####! The mailbox where service desk mail will end up. Usually "inbox".
# gitlab_rails['service_desk_email_mailbox_name'] = "inbox"
####! The IDLE command timeout.
# gitlab_rails['service_desk_email_idle_timeout'] = 60
####! The file name for internal `mail_room` JSON logfile
# gitlab_rails['service_desk_email_log_file'] = "/var/log/gitlab/mailroom/mail_room_json.log"

#### Service Desk IMAP Settings
# gitlab_rails['service_desk_email_host'] = "imap.gmail.com"
# gitlab_rails['service_desk_email_port'] = 993
# gitlab_rails['service_desk_email_ssl'] = true
# gitlab_rails['service_desk_email_start_tls'] = false

#### Inbox options (for Microsoft Graph)
# gitlab_rails['service_desk_email_inbox_method'] = 'microsoft_graph'
# gitlab_rails['service_desk_email_inbox_options'] = {
#    'tenant_id': 'YOUR-TENANT-ID',
#    'client_id': 'YOUR-CLIENT-ID',
#    'client_secret': 'YOUR-CLIENT-SECRET',
#    'poll_interval': 60  # Optional
# }

####! How service desk emails are delivered to Rails process. Accept either
####! sidekiq or webhook. The default config is webhook.
# gitlab_rails['service_desk_email_delivery_method'] = "webhook"

####! Token to authenticate webhook requests. The token must be exactly 32 bytes,
####! encoded with base64
# gitlab_rails['service_desk_email_auth_token'] = nil

#################################################################################
## Spamcheck (EE only)
#################################################################################

# spamcheck['enable'] = false
# spamcheck['dir'] = '/var/opt/gitlab/spamcheck'
# spamcheck['port'] = 8001
# spamcheck['external_port'] = nil
# spamcheck['monitoring_address'] = ':8003'
# spamcheck['log_level'] = 'info'
# spamcheck['log_format'] = 'json'
# spamcheck['log_output'] = 'stdout'
# spamcheck['monitor_mode'] = false
# spamcheck['allowlist'] = {}
# spamcheck['denylist'] = {}
# spamcheck['log_directory'] = "/var/log/gitlab/spamcheck"
# spamcheck['log_group'] = nil
# spamcheck['env_directory'] = "/opt/gitlab/etc/spamcheck/env"
# spamcheck['env'] = {
#   'SSL_CERT_DIR' => '/opt/gitlab/embedded/ssl/cers'
# }
# spamcheck['classifier']['log_directory'] = "/var/log/gitlab/spam-classifier"

#################################################################################
## (Go-)Crond
#################################################################################
# crond['log_directory'] = '/var/log/gitlab/crond'
# crond['cron_d'] = '/var/opt/gitlab/crond'
# crond['flags'] = {}

#################################################################################
## gitlab-backup-cli settings
#################################################################################
# gitlab_backup_cli['enable'] = false
# gitlab_backup_cli['user'] = 'gitlab-backup'
# gitlab_backup_cli['group'] = 'gitlab-backup'
# gitlab_backup_cli['dir'] = '/var/opt/gitlab/backups'
# gitlab_backup_cli['additional_groups'] = %w[git gitlab-psql registry]