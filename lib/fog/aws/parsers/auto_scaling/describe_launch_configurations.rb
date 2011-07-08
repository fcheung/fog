module Fog
  module Parsers
    module AWS
      module AutoScaling

        class DescribeLaunchConfigurations < Fog::Parsers::Base

          def reset
            @response = { 'LaunchConfigurations' => [] , 'ResponseMetadata' => {} }
            fresh_launch_configuration
          end

          def fresh_launch_configuration
            @launch_configuration = {
              'SecurityGroups' => [],
              'BlockDeviceMappings' => [],
            }
          end

          def start_element(name, attrs=[])
            super
            case name

            when 'InstanceMonitoring'
              @in_instance_monitoring = true
            when 'LaunchConfigurations'
              @in_launch_configurations = true
            when 'BlockDeviceMappings'
              @in_block_device_mappings = true
            when 'SecurityGroups'
              @in_security_groups = true
            when 'member'
              if @in_block_device_mappings
                @block_device_mapping = {}
              end
            end
          end
          
          def end_element(name)
            
            case name
              
            when 'DeviceName', 'VirtualDevice'
              @block_device_mapping[name] = value
            when 'SnapshotId', 'VolumeSize'
              @block_device_mapping['Ebs.' + name] = value
            when  'ImageId', 'InstanceType', 'KernelId', 'KeyName', 'LaunchConfigurationARN','LaunchConfigurationName', 'RamdiskId', 'UserData'
              @launch_configuration[name] = value
            when 'Enabled'
              if @in_instance_monitoring
                if value == 'false'
                  @launch_configuration['InstanceMonitoring'] = false
                else
                  @launch_configuration['InstanceMonitoring'] = true
                end                
              end
            when 'InstanceMonitoring'
              @in_instance_monitoring = false
            when 'LaunchConfigurations'
              @in_launch_configurations = false
            when 'BlockDeviceMappings'
              @in_block_device_mappings = false
            when 'SecurityGroups'
              @in_security_groups = false
            
            when 'member'
              if @in_security_groups
                @launch_configuration['SecurityGroups'] << value
              elsif @in_block_device_mappings
                @launch_configuration['BlockDeviceMappings'] << @block_device_mapping
              elsif @in_launch_configurations
                @response['LaunchConfigurations'] << @launch_configuration
                fresh_launch_configuration
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
