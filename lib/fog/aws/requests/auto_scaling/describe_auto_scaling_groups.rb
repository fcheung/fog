module Fog
  module AWS
    class AutoScaling
      class Real

        require 'fog/aws/parsers/auto_scaling/describe_auto_scaling_groups'

        # Describe auto scaling groups
        # 
        # ==== Parameters
        # * AutoScalingGroupNames<~Array>: A list of Auto Scaling group names
        # * MaxRecords<~Integer>: The maximum number of records to return.
        # * NextToken<~String>: A string that marks the start of the next batch of returned results
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * 'RequestId'<~String> - Id of the request
        #     * 'NextToken'<~String> -  A string that marks the start of the next batch of returned resul
        #     * AutoScalingGroups<~Array> An array of Auto scaling groups
        #       * AutoScalingGroupARN<~String> The ARN for the auto scaling group
        #       * AutoScalingGroupName<~String>
        #       * AvailabilityZones<~Array> An array of availability zone names
        #       * CreatedTime<~DateTime>
        #       * DefaultCooldown<~Integer> The number of seconds after a scaling activity completes before any further scaling activities can start
        #       * DesiredCapacity<~Integer> Specifies the desired capacity for the AutoScalingGroup
        #       * EnabledMetrics<~Array> A array of hashes representing the metrics enabled for this Auto Scaling group
        #         * Granularity <~String>
        #         * Metric<~String>
        #       * HealthCheckGracePeriod<~Integer> The length of time that Auto Scaling waits before checking an instance's health status. The grace period begins when an instance comes into service
        #       * HealthCheckType<~String> The service of interest for the health status check, either "EC2" for Amazon EC2 or "ELB" for Elastic Load Balancing
        #       * Instances<~Array> an array of hashes representing the instances in the group
        #           * AvailabilityZone<~String>
        #           * HealthStatus<~String>
        #           * InstanceId<~String>
        #           * LaunchConfigurationName<~String>
        #           * LifecycleState<~String>
        #       * LaunchConfigurationName<~String> Specifies the name of the associated LaunchConfiguration.
        #       * LoadBalancerNames<~Array> An array of load balancer names
        #       * MaxSize<~Integer> Contains the maximum size of the AutoScalingGroup
        #       * MinSize<~Integer> Contains the minimum size of the AutoScalingGroup
        #       * PlacementGroup<~String> The name of the cluster placement group, if applicable
        #       * SuspendedProcesses<~Array> An array of hashes describing suspended auto scaling processes
        #          * ProcessName
        #          * SuspensionReason
        #       * VPCZoneIdentifier<~String>
        #
        #
        # ==== See Also
        # http://docs.amazonwebservices.com/AutoScaling/latest/APIReference/API_DescribeAutoScalingGroups.html
        #
        def describe_auto_scaling_groups(options={})

          if group_names = options.delete('AutoScalingGroupNames')
            options.merge!(Fog::AWS.indexed_param('AutoScalingGroupNames.member.%d', [*group_names]))
          end

          request({
            'Action'                => 'DescribeAutoScalingGroups',
            :parser                 => Fog::Parsers::AWS::AutoScaling::DescribeAutoScalingGroups.new
          }.merge(options))
          
        end

      end
    end
  end
end
