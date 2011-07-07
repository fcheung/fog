module Fog
  module AWS
    class AutoScaling
      class Real

        require 'fog/aws/parsers/auto_scaling/basic'

        # Create a new launch configuration
        # 
        # ==== Parameters
        # * name<~String>: name of the launch configuration
        # * ami_id<~String>: id of the image to launch
        # * instance_type<~String>: type of instance to launcg 
        # * options<~Hash>
        #   * BlockDeviceMappings: array of hashes
        #     * 'DeviceName'<~String> - where the volume will be exposed to instance
        #     * 'VirtualName'<~String> - volume virtual device name
        #     * 'Ebs.SnapshotId'<~String> - id of snapshot to boot volume from
        #     * 'Ebs.VolumeSize'<~String> - size of volume in GiBs required unless snapshot is specified
        #     * 'Ebs.DeleteOnTermination'<~Boolean> - specifies whether or not to delete the volume on instance termination
        #   * InstanceMonitoring <~Boolean> whether to enable detailed monitoring
        #   * KernelId <~String> the ID of the kernel associated with the EC2 AMI
        #   * KeyName <~String> The name of the EC2 key pai
        #   * RamdiskId <~String> The ID of the RAM disk associated with the EC2 AMI
        #   * SecurityGroups <~Array> Array of the names of the security groups
        #   * UserData <~String> The user data available to the launched EC2 instances
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * 'RequestId'<~String> - Id of the request
        #
        # ==== See Also
        # http://docs.amazonwebservices.com/AutoScaling/latest/APIReference/API_CreateLaunchConfiguration.html
        #
        def create_launch_configuration(name, ami_id, instance_type, options={})
          
          if block_device_mapping = options.delete('BlockDeviceMappings')
            block_device_mapping.each_with_index do |mapping, index|
              for key, value in mapping
                options.merge!({ format("BlockDeviceMappings.member.%d.#{key}", index + 1) => value })
              end
            end
          end
          
          if !(instance_monitoring = options.delete('InstanceMonitoring')).nil?
            options['InstanceMonitoring.Enabled'] =  instance_monitoring
          end
          if security_groups = options.delete('SecurityGroups')
            options.merge!(Fog::AWS.indexed_param('SecurityGroups.member.%d', [*security_groups]))
          end
          
          if options['UserData']
            options['UserData'] = Base64.encode64(options['UserData'])
          end
          
          request({
            'Action'    => 'CreateLaunchConfiguration',
            'LaunchConfigurationName'  => name,
            'ImageId' => ami_id,
            'InstanceType' => instance_type,
            :parser     => Fog::Parsers::AWS::AutoScaling::Basic.new
          }.merge(options))
          
        end

      end
    end
  end
end
