module Fog
  module AWS
    class AutoScaling
      class Real

        require 'fog/aws/parsers/auto_scaling/basic'

        # Updates the configuration for the specified AutoScalingGroup. You cannot update an group while scaling activities are in process
        # 
        # ==== Parameters
        # * AutoScalingGroupName<~String>: name of the auto scaling group
        # * options<~Hash>
        #    * AvailabilityZones<~Array>: array of availability zone names 
        #    * DefaultCooldown<~Integer>: The amount of time, in seconds, after a scaling activity completes before any further trigger-related scaling activities can start
        #    * DesiredCapacity<~Integer>: The desired capacity for the Auto Scaling group.
        #    * HealthCheckGracePeriod<~Integer>: The length of time that Auto Scaling waits before checking an instance's health status. The grace period begins when an instance comes into service
        #    * HealthCheckType<~String>: The service of interest for the health status check, either "EC2" for Amazon EC2 or "ELB" for Elastic Load Balancing.
        #    * LaunchConfigurationName<~String>: The name of the launch configuration.
        #    * MaxSize<~Integer>: The maximum size of the Auto Scaling group
        #    * MinSize<~Integer>: The minimum size of the Auto Scaling group.
        #    * PlacementGroup<~String>: The name of the cluster placement group, if applicable
        #    * VPCZoneIdentifier<~String>: The identifier for the VPC connection, if applicable.
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * 'RequestId'<~String> - Id of the request
        #
        # ==== See Also
        # http://docs.amazonwebservices.com/AutoScaling/latest/APIReference/API_UpdateAutoScalingGroup.html
        #
        def update_auto_scaling_group(group_name, options=nil)

          if availability_zones = options.delete('AvailabilityZones')
            options.merge!(Fog::AWS.indexed_param('AvailabilityZones.member', [*availability_zones]))
          end

          request({
            'Action'                => 'UpdateAutoScalingGroup',
            'AutoScalingGroupName'  => group_name,
            :parser                 => Fog::Parsers::AWS::AutoScaling::Basic.new
          }.merge(options))
          
        end

      end
    end
  end
end
