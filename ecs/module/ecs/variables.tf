variable "create" {
  description = "Determines whether resources will be created (affects all resources)"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

################################################################################
# Cluster
################################################################################

variable "cluster_name" {
  description = "Name of the cluster (up to 255 letters, numbers, hyphens, and underscores)"
  type        = string
  default     = ""
}

variable "cluster_configuration" {
  description = "The execute command configuration for the cluster"
  type        = any
  default     = {}
}

variable "cluster_settings" {
  description = "Configuration block(s) with cluster settings. For example, this can be used to enable CloudWatch Container Insights for a cluster"
  type        = map(string)
  default = {
    name  = "containerInsights"
    value = "enabled"
  }
}

variable "cluster_service_connect_defaults" {
  description = "Configures a default Service Connect namespace"
  type        = map(string)
  default     = {}
}

################################################################################
# CloudWatch Log Group
################################################################################

variable "create_cloudwatch_log_group" {
  description = "Determines whether a log group is created by this module for the cluster logs. If not, AWS will automatically create one if logging is enabled"
  type        = bool
  default     = true
}

variable "cloudwatch_log_group_retention_in_days" {
  description = "Number of days to retain log events"
  type        = number
  default     = 90
}

variable "cloudwatch_log_group_kms_key_id" {
  description = "If a KMS Key ARN is set, this key will be used to encrypt the corresponding log group. Please be sure that the KMS Key has an appropriate key policy (https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/encrypt-log-data-kms.html)"
  type        = string
  default     = null
}

variable "cloudwatch_log_group_tags" {
  description = "A map of additional tags to add to the log group created"
  type        = map(string)
  default     = {}
}

################################################################################
# Capacity Providers
################################################################################

variable "default_capacity_provider_use_fargate" {
  description = "Determines whether to use Fargate or autoscaling for default capacity provider strategy"
  type        = bool
  default     = true
}

variable "fargate_capacity_providers" {
  description = "Map of Fargate capacity provider definitions to use for the cluster"
  type        = any
  default     = {}
}

variable "autoscaling_capacity_providers" {
  description = "Map of autoscaling capacity provider definitions to create for the cluster"
  type        = any
  default     = {}
}

################################################################################
# Task Execution - IAM Role
# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_execution_IAM_role.html
################################################################################

variable "create_task_exec_iam_role" {
  description = "Determines whether the ECS task definition IAM role should be created"
  type        = bool
  default     = false
}

variable "task_exec_iam_role_name" {
  description = "Name to use on IAM role created"
  type        = string
  default     = null
}

variable "task_exec_iam_role_use_name_prefix" {
  description = "Determines whether the IAM role name (`task_exec_iam_role_name`) is used as a prefix"
  type        = bool
  default     = true
}

variable "task_exec_iam_role_path" {
  description = "IAM role path"
  type        = string
  default     = null
}

variable "task_exec_iam_role_description" {
  description = "Description of the role"
  type        = string
  default     = null
}

variable "task_exec_iam_role_permissions_boundary" {
  description = "ARN of the policy that is used to set the permissions boundary for the IAM role"
  type        = string
  default     = null
}

variable "task_exec_iam_role_tags" {
  description = "A map of additional tags to add to the IAM role created"
  type        = map(string)
  default     = {}
}

variable "task_exec_iam_role_policies" {
  description = "Map of IAM role policy ARNs to attach to the IAM role"
  type        = map(string)
  default     = {}
}

variable "create_task_exec_policy" {
  description = "Determines whether the ECS task definition IAM policy should be created. This includes permissions included in AmazonECSTaskExecutionRolePolicy as well as access to secrets and SSM parameters"
  type        = bool
  default     = true
}

variable "task_exec_ssm_param_arns" {
  description = "List of SSM parameter ARNs the task execution role will be permitted to get/read"
  type        = list(string)
  default     = ["arn:aws:ssm:*:*:parameter/*"]
}

variable "task_exec_secret_arns" {
  description = "List of SecretsManager secret ARNs the task execution role will be permitted to get/read"
  type        = list(string)
  default     = ["arn:aws:secretsmanager:*:*:secret:*"]
}

variable "task_exec_iam_statements" {
  description = "A map of IAM policy [statements](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document#statement) for custom permission usage"
  type        = any
  default     = {}
}

###################################################################################################################

###################################################################################################################
################################################################################
# Service
################################################################################

variable "ignore_task_definition_changes" {
  description = "Whether changes to service `task_definition` changes should be ignored"
  type        = bool
  default     = false
}

variable "alarms" {
  description = "Information about the CloudWatch alarms"
  type        = any
  default     = {}
}

variable "capacity_provider_strategy" {
  description = "Capacity provider strategies to use for the service. Can be one or more"
  type        = any
  default     = {}
}

variable "cluster_arn" {
  description = "ARN of the ECS cluster where the resources will be provisioned"
  type        = string
  default     = ""
}

variable "deployment_circuit_breaker" {
  description = "Configuration block for deployment circuit breaker"
  type        = any
  default     = {}
}

variable "deployment_controller" {
  description = "Configuration block for deployment controller configuration"
  type        = any
  default     = {}
}

variable "deployment_maximum_percent" {
  description = "Upper limit (as a percentage of the service's `desired_count`) of the number of running tasks that can be running in a service during a deployment"
  type        = number
  default     = 200
}

variable "deployment_minimum_healthy_percent" {
  description = "Lower limit (as a percentage of the service's `desired_count`) of the number of running tasks that must remain running and healthy in a service during a deployment"
  type        = number
  default     = 66
}

variable "desired_count" {
  description = "Number of instances of the task definition to place and keep running"
  type        = number
  default     = 1
}

variable "enable_ecs_managed_tags" {
  description = "Specifies whether to enable Amazon ECS managed tags for the tasks within the service"
  type        = bool
  default     = true
}

variable "enable_execute_command" {
  description = "Specifies whether to enable Amazon ECS Exec for the tasks within the service"
  type        = bool
  default     = false
}

variable "force_new_deployment" {
  description = "Enable to force a new task deployment of the service. This can be used to update tasks to use a newer Docker image with same image/tag combination, roll Fargate tasks onto a newer platform version, or immediately deploy `ordered_placement_strategy` and `placement_constraints` updates"
  type        = bool
  default     = true
}

variable "health_check_grace_period_seconds" {
  description = "Seconds to ignore failing load balancer health checks on newly instantiated tasks to prevent premature shutdown, up to 2147483647. Only valid for services configured to use load balancers"
  type        = number
  default     = null
}

variable "launch_type" {
  description = "Launch type on which to run your service. The valid values are `EC2`, `FARGATE`, and `EXTERNAL`. Defaults to `FARGATE`"
  type        = string
  default     = "FARGATE"
}

variable "load_balancer" {
  description = "Configuration block for load balancers"
  type        = any
  default     = {}
}

variable "name" {
  description = "Name of the service (up to 255 letters, numbers, hyphens, and underscores)"
  type        = string
  default     = null
}

variable "assign_public_ip" {
  description = "Assign a public IP address to the ENI (Fargate launch type only)"
  type        = bool
  default     = false
}

variable "security_group_ids" {
  description = "List of security groups to associate with the task or service"
  type        = list(string)
  default     = []
}

variable "subnet_ids" {
  description = "List of subnets to associate with the task or service"
  type        = list(string)
  default     = []
}

variable "ordered_placement_strategy" {
  description = "Service level strategy rules that are taken into consideration during task placement. List from top to bottom in order of precedence"
  type        = any
  default     = {}
}

variable "placement_constraints" {
  description = "Configuration block for rules that are taken into consideration during task placement (up to max of 10). This is set at the service, see `task_definition_placement_constraints` for setting at the task definition"
  type        = any
  default     = {}
}

variable "platform_version" {
  description = "Platform version on which to run your service. Only applicable for `launch_type` set to `FARGATE`. Defaults to `LATEST`"
  type        = string
  default     = null
}

variable "propagate_tags" {
  description = "Specifies whether to propagate the tags from the task definition or the service to the tasks. The valid values are `SERVICE` and `TASK_DEFINITION`"
  type        = string
  default     = null
}

variable "scheduling_strategy" {
  description = "Scheduling strategy to use for the service. The valid values are `REPLICA` and `DAEMON`. Defaults to `REPLICA`"
  type        = string
  default     = null
}

variable "service_connect_configuration" {
  description = "The ECS Service Connect configuration for this service to discover and connect to services, and be discovered by, and connected from, other services within a namespace"
  type        = any
  default     = {}
}

variable "service_registries" {
  description = "Service discovery registries for the service"
  type        = any
  default     = {}
}

variable "timeouts" {
  description = "Create, update, and delete timeout configurations for the service"
  type        = map(string)
  default     = {}
}

variable "triggers" {
  description = "Map of arbitrary keys and values that, when changed, will trigger an in-place update (redeployment). Useful with `timestamp()`"
  type        = any
  default     = {}
}

variable "wait_for_steady_state" {
  description = "If true, Terraform will wait for the service to reach a steady state before continuing. Default is `false`"
  type        = bool
  default     = null
}

################################################################################
# Service - IAM Role
################################################################################

variable "create_iam_role" {
  description = "Determines whether the ECS service IAM role should be created"
  type        = bool
  default     = true
}

variable "iam_role_arn" {
  description = "Existing IAM role ARN"
  type        = string
  default     = null
}

variable "iam_role_name" {
  description = "Name to use on IAM role created"
  type        = string
  default     = null
}

variable "iam_role_use_name_prefix" {
  description = "Determines whether the IAM role name (`iam_role_name`) is used as a prefix"
  type        = bool
  default     = true
}

variable "iam_role_path" {
  description = "IAM role path"
  type        = string
  default     = null
}

variable "iam_role_description" {
  description = "Description of the role"
  type        = string
  default     = null
}

variable "iam_role_permissions_boundary" {
  description = "ARN of the policy that is used to set the permissions boundary for the IAM role"
  type        = string
  default     = null
}

variable "iam_role_tags" {
  description = "A map of additional tags to add to the IAM role created"
  type        = map(string)
  default     = {}
}

variable "iam_role_statements" {
  description = "A map of IAM policy [statements](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document#statement) for custom permission usage"
  type        = any
  default     = {}
}

################################################################################
# Task Definition
################################################################################

variable "create_task_definition" {
  description = "Determines whether to create a task definition or use existing/provided"
  type        = bool
  default     = true
}

variable "task_definition_arn" {
  description = "Existing task definition ARN. Required when `create_task_definition` is `false`"
  type        = string
  default     = null
}

variable "container_definitions" {
  description = "A map of valid [container definitions](http://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ContainerDefinition.html). Please note that you should only provide values that are part of the container definition document"
  type        = any
  default     = {}
}

variable "container_definition_defaults" {
  description = "A map of default values for [container definitions](http://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ContainerDefinition.html) created by `container_definitions`"
  type        = any
  default     = {}
}

variable "cpu" {
  description = "Number of cpu units used by the task. If the `requires_compatibilities` is `FARGATE` this field is required"
  type        = number
  default     = 1024
}

variable "ephemeral_storage" {
  description = "The amount of ephemeral storage to allocate for the task. This parameter is used to expand the total amount of ephemeral storage available, beyond the default amount, for tasks hosted on AWS Fargate"
  type        = any
  default     = {}
}

variable "family" {
  description = "A unique name for your task definition"
  type        = string
  default     = null
}

variable "inference_accelerator" {
  description = "Configuration block(s) with Inference Accelerators settings"
  type        = any
  default     = {}
}

variable "ipc_mode" {
  description = "IPC resource namespace to be used for the containers in the task The valid values are `host`, `task`, and `none`"
  type        = string
  default     = null
}

variable "memory" {
  description = "Amount (in MiB) of memory used by the task. If the `requires_compatibilities` is `FARGATE` this field is required"
  type        = number
  default     = 2048
}

variable "network_mode" {
  description = "Docker networking mode to use for the containers in the task. Valid values are `none`, `bridge`, `awsvpc`, and `host`"
  type        = string
  default     = "awsvpc"
}

variable "pid_mode" {
  description = "Process namespace to use for the containers in the task. The valid values are `host` and `task`"
  type        = string
  default     = null
}

variable "task_definition_placement_constraints" {
  description = "Configuration block for rules that are taken into consideration during task placement (up to max of 10). This is set at the task definition, see `placement_constraints` for setting at the service"
  type        = any
  default     = {}
}

variable "proxy_configuration" {
  description = "Configuration block for the App Mesh proxy"
  type        = any
  default     = {}
}

variable "requires_compatibilities" {
  description = "Set of launch types required by the task. The valid values are `EC2` and `FARGATE`"
  type        = list(string)
  default     = ["FARGATE"]
}

variable "runtime_platform" {
  description = "Configuration block for `runtime_platform` that containers in your task may use"
  type        = any
  default = {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}

variable "skip_destroy" {
  description = "If true, the task is not deleted when the service is deleted"
  type        = bool
  default     = null
}

variable "volume" {
  description = "Configuration block for volumes that containers in your task may use"
  type        = any
  default     = {}
}

variable "task_tags" {
  description = "A map of additional tags to add to the task definition/set created"
  type        = map(string)
  default     = {}
}

################################################################################
# Task Execution - IAM Role
# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_execution_IAM_role.html
################################################################################

# variable "create_task_exec_iam_role" {
#   description = "Determines whether the ECS task definition IAM role should be created"
#   type        = bool
#   default     = true
# }

variable "task_exec_iam_role_arn" {
  description = "Existing IAM role ARN"
  type        = string
  default     = null
}

# variable "task_exec_iam_role_name" {
#   description = "Name to use on IAM role created"
#   type        = string
#   default     = null
# }

# variable "task_exec_iam_role_use_name_prefix" {
#   description = "Determines whether the IAM role name (`task_exec_iam_role_name`) is used as a prefix"
#   type        = bool
#   default     = true
# }

# variable "task_exec_iam_role_path" {
#   description = "IAM role path"
#   type        = string
#   default     = null
# }

# variable "task_exec_iam_role_description" {
#   description = "Description of the role"
#   type        = string
#   default     = null
# }

# variable "task_exec_iam_role_permissions_boundary" {
#   description = "ARN of the policy that is used to set the permissions boundary for the IAM role"
#   type        = string
#   default     = null
# }

# variable "task_exec_iam_role_tags" {
#   description = "A map of additional tags to add to the IAM role created"
#   type        = map(string)
#   default     = {}
# }

# variable "task_exec_iam_role_policies" {
#   description = "Map of IAM role policy ARNs to attach to the IAM role"
#   type        = map(string)
#   default     = {}
# }

# variable "create_task_exec_policy" {
#   description = "Determines whether the ECS task definition IAM policy should be created. This includes permissions included in AmazonECSTaskExecutionRolePolicy as well as access to secrets and SSM parameters"
#   type        = bool
#   default     = true
# }

# variable "task_exec_ssm_param_arns" {
#   description = "List of SSM parameter ARNs the task execution role will be permitted to get/read"
#   type        = list(string)
#   default     = ["arn:aws:ssm:*:*:parameter/*"]
# }

# variable "task_exec_secret_arns" {
#   description = "List of SecretsManager secret ARNs the task execution role will be permitted to get/read"
#   type        = list(string)
#   default     = ["arn:aws:secretsmanager:*:*:secret:*"]
# }

# variable "task_exec_iam_statements" {
#   description = "A map of IAM policy [statements](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document#statement) for custom permission usage"
#   type        = any
#   default     = {}
# }

################################################################################
# Tasks - IAM role
# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-iam-roles.html
################################################################################

variable "create_tasks_iam_role" {
  description = "Determines whether the ECS tasks IAM role should be created"
  type        = bool
  default     = true
}

variable "tasks_iam_role_arn" {
  description = "Existing IAM role ARN"
  type        = string
  default     = null
}

variable "tasks_iam_role_name" {
  description = "Name to use on IAM role created"
  type        = string
  default     = null
}

variable "tasks_iam_role_use_name_prefix" {
  description = "Determines whether the IAM role name (`tasks_iam_role_name`) is used as a prefix"
  type        = bool
  default     = true
}

variable "tasks_iam_role_path" {
  description = "IAM role path"
  type        = string
  default     = null
}

variable "tasks_iam_role_description" {
  description = "Description of the role"
  type        = string
  default     = null
}

variable "tasks_iam_role_permissions_boundary" {
  description = "ARN of the policy that is used to set the permissions boundary for the IAM role"
  type        = string
  default     = null
}

variable "tasks_iam_role_tags" {
  description = "A map of additional tags to add to the IAM role created"
  type        = map(string)
  default     = {}
}

variable "tasks_iam_role_policies" {
  description = "Map of IAM role policy ARNs to attach to the IAM role"
  type        = map(string)
  default     = {}
}

variable "tasks_iam_role_statements" {
  description = "A map of IAM policy [statements](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document#statement) for custom permission usage"
  type        = any
  default     = {}
}

################################################################################
# Task Set
################################################################################

variable "external_id" {
  description = "The external ID associated with the task set"
  type        = string
  default     = null
}

variable "scale" {
  description = "A floating-point percentage of the desired number of tasks to place and keep running in the task set"
  type        = any
  default     = {}
}

variable "force_delete" {
  description = "Whether to allow deleting the task set without waiting for scaling down to 0"
  type        = bool
  default     = null
}

variable "wait_until_stable" {
  description = "Whether terraform should wait until the task set has reached `STEADY_STATE`"
  type        = bool
  default     = null
}

variable "wait_until_stable_timeout" {
  description = "Wait timeout for task set to reach `STEADY_STATE`. Valid time units include `ns`, `us` (or µs), `ms`, `s`, `m`, and `h`. Default `10m`"
  type        = string
  default     = null
}

################################################################################
# Autoscaling
################################################################################

variable "enable_autoscaling" {
  description = "Determines whether to enable autoscaling for the service"
  type        = bool
  default     = true
}

variable "autoscaling_min_capacity" {
  description = "Minimum number of tasks to run in your service"
  type        = number
  default     = 1
}

variable "autoscaling_max_capacity" {
  description = "Maximum number of tasks to run in your service"
  type        = number
  default     = 10
}

variable "autoscaling_policies" {
  description = "Map of autoscaling policies to create for the service"
  type        = any
  default = {
    cpu = {
      policy_type = "TargetTrackingScaling"

      target_tracking_scaling_policy_configuration = {
        predefined_metric_specification = {
          predefined_metric_type = "ECSServiceAverageCPUUtilization"
        }
      }
    }
    memory = {
      policy_type = "TargetTrackingScaling"

      target_tracking_scaling_policy_configuration = {
        predefined_metric_specification = {
          predefined_metric_type = "ECSServiceAverageMemoryUtilization"
        }
      }
    }
  }
}

variable "autoscaling_scheduled_actions" {
  description = "Map of autoscaling scheduled actions to create for the service"
  type        = any
  default     = {}
}

################################################################################
# Security Group
################################################################################

variable "create_security_group" {
  description = "Determines if a security group is created"
  type        = bool
  default     = true
}

variable "security_group_name" {
  description = "Name to use on security group created"
  type        = string
  default     = null
}

variable "security_group_use_name_prefix" {
  description = "Determines whether the security group name (`security_group_name`) is used as a prefix"
  type        = bool
  default     = true
}

variable "security_group_description" {
  description = "Description of the security group created"
  type        = string
  default     = null
}

variable "security_group_rules" {
  description = "Security group rules to add to the security group created"
  type        = any
  default     = {}
}

variable "security_group_tags" {
  description = "A map of additional tags to add to the security group created"
  type        = map(string)
  default     = {}
}



variable "operating_system_family" {
  description = "The OS family for task"
  type        = string
  default     = "LINUX"
}

################################################################################
# Container Definition
################################################################################

variable "command" {
  description = "The command that's passed to the container"
  type        = list(string)
  default     = []
}

variable "dependencies" {
  description = "The dependencies defined for container startup and shutdown. A container can contain multiple dependencies. When a dependency is defined for container startup, for container shutdown it is reversed. The condition can be one of START, COMPLETE, SUCCESS or HEALTHY"
  type = list(object({
    condition     = string
    containerName = string
  }))
  default = []
}

variable "disable_networking" {
  description = "When this parameter is true, networking is disabled within the container"
  type        = bool
  default     = null
}

variable "dns_search_domains" {
  description = "Container DNS search domains. A list of DNS search domains that are presented to the container"
  type        = list(string)
  default     = []
}

variable "dns_servers" {
  description = "Container DNS servers. This is a list of strings specifying the IP addresses of the DNS servers"
  type        = list(string)
  default     = []
}

variable "docker_labels" {
  description = "A key/value map of labels to add to the container"
  type        = map(string)
  default     = {}
}

variable "docker_security_options" {
  description = "A list of strings to provide custom labels for SELinux and AppArmor multi-level security systems. This field isn't valid for containers in tasks using the Fargate launch type"
  type        = list(string)
  default     = []
}



variable "entrypoint" {
  description = "The entry point that is passed to the container"
  type        = list(string)
  default     = []
}

variable "environment" {
  description = "The environment variables to pass to the container"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "environment_files" {
  description = "A list of files containing the environment variables to pass to a container"
  type = list(object({
    value = string
    type  = string
  }))
  default = []
}

variable "essential" {
  description = "If the `essential` parameter of a container is marked as `true`, and that container fails or stops for any reason, all other containers that are part of the task are stopped"
  type        = bool
  default     = null
}

variable "extra_hosts" {
  description = "A list of hostnames and IP address mappings to append to the `/etc/hosts` file on the container"
  type = list(object({
    hostname  = string
    ipAddress = string
  }))
  default = []
}

variable "firelens_configuration" {
  description = "The FireLens configuration for the container. This is used to specify and configure a log router for container logs. For more information, see [Custom Log Routing](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/using_firelens.html) in the Amazon Elastic Container Service Developer Guide"
  type        = any
  default     = {}
}

variable "health_check" {
  description = "The container health check command and associated configuration parameters for the container. See [HealthCheck](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_HealthCheck.html)"
  type        = any
  default     = {}
}

variable "hostname" {
  description = "The hostname to use for your container"
  type        = string
  default     = null
}

variable "image" {
  description = "The image used to start a container. This string is passed directly to the Docker daemon. By default, images in the Docker Hub registry are available. Other repositories are specified with either `repository-url/image:tag` or `repository-url/image@digest`"
  type        = string
  default     = null
}

variable "interactive" {
  description = "When this parameter is `true`, you can deploy containerized applications that require `stdin` or a `tty` to be allocated"
  type        = bool
  default     = false
}

variable "links" {
  description = "The links parameter allows containers to communicate with each other without the need for port mappings. This parameter is only supported if the network mode of a task definition is `bridge`"
  type        = list(string)
  default     = []
}

variable "linux_parameters" {
  description = "Linux-specific modifications that are applied to the container, such as Linux kernel capabilities. For more information see [KernelCapabilities](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_KernelCapabilities.html)"
  type        = any
  default     = {}
}

variable "log_configuration" {
  description = "Linux-specific modifications that are applied to the container, such as Linux kernel capabilities. For more information see [KernelCapabilities](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_KernelCapabilities.html)"
  type        = any
  default     = {}
}



variable "memory_reservation" {
  description = "The soft limit (in MiB) of memory to reserve for the container. When system memory is under heavy contention, Docker attempts to keep the container memory to this soft limit. However, your container can consume more memory when it needs to, up to either the hard limit specified with the `memory` parameter (if applicable), or all of the available memory on the container instance"
  type        = number
  default     = null
}

variable "mount_points" {
  description = "The mount points for data volumes in your container"
  type        = list(any)
  default     = []
}



variable "port_mappings" {
  description = "The list of port mappings for the container. Port mappings allow containers to access ports on the host container instance to send or receive traffic. For task definitions that use the awsvpc network mode, only specify the containerPort. The hostPort can be left blank or it must be the same value as the containerPort"
  type        = list(any)
  default     = []
}

variable "privileged" {
  description = "When this parameter is true, the container is given elevated privileges on the host container instance (similar to the root user)"
  type        = bool
  default     = false
}

variable "pseudo_terminal" {
  description = "When this parameter is true, a `TTY` is allocated"
  type        = bool
  default     = false
}

variable "readonly_root_filesystem" {
  description = "When this parameter is true, the container is given read-only access to its root file system"
  type        = bool
  default     = true
}

variable "repository_credentials" {
  description = "Container repository credentials; required when using a private repo.  This map currently supports a single key; \"credentialsParameter\", which should be the ARN of a Secrets Manager's secret holding the credentials"
  type        = map(string)
  default     = {}
}

variable "resource_requirements" {
  description = "The type and amount of a resource to assign to a container. The only supported resource is a GPU"
  type = list(object({
    type  = string
    value = string
  }))
  default = []
}

variable "secrets" {
  description = "The secrets to pass to the container. For more information, see [Specifying Sensitive Data](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/specifying-sensitive-data.html) in the Amazon Elastic Container Service Developer Guide"
  type = list(object({
    name      = string
    valueFrom = string
  }))
  default = []
}

variable "start_timeout" {
  description = "Time duration (in seconds) to wait before giving up on resolving dependencies for a container"
  type        = number
  default     = 30
}

variable "stop_timeout" {
  description = "Time duration (in seconds) to wait before the container is forcefully killed if it doesn't exit normally on its own"
  type        = number
  default     = 120
}

variable "system_controls" {
  description = "A list of namespaced kernel parameters to set in the container"
  type        = list(map(string))
  default     = []
}

variable "ulimits" {
  description = "A list of ulimits to set in the container. If a ulimit value is specified in a task definition, it overrides the default values set by Docker"
  type = list(object({
    hardLimit = number
    name      = string
    softLimit = number
  }))
  default = []
}

variable "user" {
  description = "The user to run as inside the container. Can be any of these formats: user, user:group, uid, uid:gid, user:gid, uid:group. The default (null) will use the container's configured `USER` directive or root if not set"
  type        = string
  default     = null
}

variable "volumes_from" {
  description = "Data volumes to mount from another container"
  type        = list(any)
  default     = []
}

variable "working_directory" {
  description = "The working directory to run commands inside the container"
  type        = string
  default     = null
}

################################################################################
# CloudWatch Log Group
################################################################################

variable "service" {
  description = "The name of the service that the container definition is associated with"
  type        = string
  default     = ""
}

variable "enable_cloudwatch_logging" {
  description = "Determines whether CloudWatch logging is configured for this container definition. Set to `false` to use other logging drivers"
  type        = bool
  default     = true
}

variable "cloudwatch_log_group_use_name_prefix" {
  description = "Determines whether the log group name should be used as a prefix"
  type        = bool
  default     = false
}


