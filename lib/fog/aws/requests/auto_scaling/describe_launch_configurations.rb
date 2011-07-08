module Fog
  module AWS
    class AutoScaling
      class Real

        require 'fog/aws/parsers/auto_scaling/describe_launch_configurations'

        # Describe launch configurations
        # 
        # ==== Parameters
        # * LaunchConfigurationNames <~Array>: A list of Auto Scaling group names
        # * MaxRecords<~Integer>: The maximum number of records to return.
        # * NextToken<~String>: A string that marks the start of the next batch of returned results
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * 'RequestId'<~String> - Id of the request
        #     * 'NextToken'<~String> -  A string that marks the start of the next batch of returned resul
        #     * LaunchConfigurations<~Array> An array of Auto scaling groups
        #       * BlockDeviceMappings<~Array> An array of hashes specifying block device mappings
        #         * 'DeviceName' <~String> The unix device name
        #         * 'VirtualName' <~String> The device virtual name
        #         * 'Ebs.SnapshotId' <~String> The id of a snapshot from which to create the volume
        #         * 'VolumeSize' <~Integer> The volume size, in gigabytes
        #       * CreatedTime<~DateTime>
        #       * ImageId<~String> ID of the AMI to use for new instances
        #       * InstanceMonitoring<~Boolean> Whether instance monitoring is enabled or not
        #       * InstanceType<~String> The type of instance to create
        #       * KernelId<~String>
        #       * KeyName<~String> The name of an amazon keypair.
        #       * LaunchConfigurationARN<~String> The launch configuration's Amazon Resource Name (ARN).
        #       * LaunchConfigurationName<~String> The launch configuration name
        #       * RamdiskId<~String> 
        #       * SecurityGroups<~Array> A list of security group names instances are added to
        #       * UserData<~String>
        #
        #
        # ==== See Also
        # http://docs.amazonwebservices.com/AutoScaling/latest/APIReference/API_DescribeLaunchConfigurations.html
        #
        def describe_launch_configurations(options={})

          if group_names = options.delete('LaunchConfigurationNames')
            options.merge!(Fog::AWS.indexed_param('LaunchConfigurationNames.member.%d', [*group_names]))
          end

          request({
            'Action'                => 'DescribeLaunchConfigurations',
            :parser                 => Fog::Parsers::AWS::AutoScaling::DescribeLaunchConfigurations.new
          }.merge(options))
          
        end

      end
    end
  end
end
