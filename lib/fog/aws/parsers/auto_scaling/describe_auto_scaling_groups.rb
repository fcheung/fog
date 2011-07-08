module Fog
  module Parsers
    module AWS
      module AutoScaling

        class DescribeAutoScalingGroups < Fog::Parsers::Base

          def reset
            @response = { 'AutoScalingGroups' => [] , 'ResponseMetadata' => {} }
            @in_auto_scaling_groups = false
            fresh_auto_scaling_group
          end

          def fresh_auto_scaling_group
            @group = {
              'Instances' => [],
              'AvailabilityZones' => [],
              'EnabledMetrics' => [],
              'LoadBalancerNames' => [],
              'SuspendedProcesses' => [],
            }
          end

          def start_element(name, attrs=[])
            super
            case name
            when 'AutoScalingGroups'
              @in_auto_scaling_groups = true
            when 'SuspendedProcesses'
              @in_suspended_processes = true
            when 'Instances'
              @in_instances = true
            when 'AvailabilityZones'
              @in_availability_zones = true
            when 'LoadBalancerNames'
              @in_load_balancer_names = true
            when 'EnabledMetrics'
              @in_enabled_metrics = true
            when 'member'
              if @in_enabled_metrics
                @metric = {}
              elsif @in_instances
                @instance = {}
              elsif @in_suspended_processes
                @suspended_process = {}
              end
            end
          end
          
          def end_element(name)
            
            case name
              
            when 'CreatedTime'
              @group[name] = Time.parse(value)
            when 'AutoScalingGroupARN', 'AutoScalingGroupName', 'HealthCheckType', 'PlacementGroup', 'VPCZoneIdentifier'
              @group[name] = value
            when 'HealthCheckGracePeriod', 'MaxSize', 'MinSize', 'DefaultCooldown', 'DesiredCapacity'
              @group[name] = value.to_i
            when 'Granularity', 'Metric'
              @metric[name] = value
            when 'AvailabilityZone', 'HealthStatus', 'InstanceId', 'LifecycleState'
              @instance[name] = value
            when 'ProcessName', 'SuspensionReason'
              @suspended_process[name] = value
            when 'LaunchConfigurationName'
              if @in_instances
                @instance[name] = value
              else
                @group[name] = value
              end

            when 'AutoScalingGroups'
              @in_auto_scaling_groups = false
            when 'SuspendedProcesses'
              @in_suspended_processes = false
            when 'Instances'
              @in_instances = false
            when 'AvailabilityZones'
              @in_availability_zones = false
            when 'LoadBalancerNames'
              @in_load_balancer_names = false
            when 'EnabledMetrics'
              @in_enabled_metrics = false

            when 'member'
              if @in_load_balancer_names
                @group['LoadBalancerNames'] << value
              elsif @in_availability_zones
                @group['AvailabilityZones'] << value
              elsif @in_enabled_metrics
                @group['EnabledMetrics'] << @metric
              elsif @in_suspended_processes
                @group['SuspendedProcesses'] << @suspended_process
              elsif @in_instances
                @group['Instances'] << @instance
              elsif @in_auto_scaling_groups
                @response['AutoScalingGroups'] << @group
                fresh_auto_scaling_group
              end
            when 'NextToken', 'RequestId'
              @response['ResponseMetadata'][name] = value
            end
          end

        end
      end
    end
  end
end
