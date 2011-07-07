module Fog
  module AWS
    class AutoScaling
      class Real

        require 'fog/aws/parsers/auto_scaling/basic'

        # Creates an auto scaling group
        # 
        # ==== Parameters
        # * AutoScalingGroupName<~String>: name of the auto scaling group
        # * AvailabilityZones<~Array>: array of availability zone names 
        # * LaunchConfigurationName<~String>: The name of the launch configuration.
        # * MinSize<~Integer>: The minimum size of the Auto Scaling group.
        # * MaxSize<~Integer>: The maximum size of the Auto Scaling group
        # * options<~Hash>
        #    * DefaultCooldown<~Integer>: The amount of time, in seconds, after a scaling activity completes before any further trigger-related scaling activities can start
        #    * DesiredCapacity<~Integer>: The desired capacity for the Auto Scaling group.
        #    * HealthCheckGracePeriod<~Integer>: The length of time that Auto Scaling waits before checking an instance's health status. The grace period begins when an instance comes into service
        #    * HealthCheckType<~String>: The service of interest for the health status check, either "EC2" for Amazon EC2 or "ELB" for Elastic Load Balancing.
        #    * LoadBalancerNames<~Array>: An array of load balancer names
        #    * PlacementGroup<~String>: The name of the cluster placement group, if applicable
        #    * VPCZoneIdentifier<~String>: The identifier for the VPC connection, if applicable.
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * 'RequestId'<~String> - Id of the request
        #
        # ==== See Also
        # http://docs.amazonwebservices.com/AutoScaling/latest/APIReference/API_CreateAutoScalingGroup.html
        #
        def create_auto_scaling_group(group_name, availability_zones, launch_configuration_name, min_size, max_size, options={})

          options.merge!(Fog::AWS.indexed_param('AvailabilityZones.member', [*availability_zones]))
          
          if load_balancers =  options.delete('LoadBalancerNames')
            options.merge!(Fog::AWS.indexed_param('LoadBalancerNames.member', [*load_balancers]))
          end
          
          request({
            'Action'                => 'CreateAutoScalingGroup',
            'AutoScalingGroupName'  => group_name,
            'MinSize'               => min_size,
            'MaxSize'               => min_size,
            'LaunchConfigurationName' => launch_configuration_name,
            :parser                 => Fog::Parsers::AWS::AutoScaling::Basic.new
          }.merge(options))
          
        end

      end
    end
  end
end
