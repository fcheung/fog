module Fog
  module AWS
    class AutoScaling
      class Real

        require 'fog/aws/parsers/auto_scaling/describe_scaling_activities'

        # Describe scaling activities for the specified group
        # 
        # ==== Parameters
        # * 
        # * options<~Hash>
        #   * AutoScalingGroupName<~String>: only show activity for the specified group
        #   * ActivityIds<~Array>: A list containing the activity IDs of the desired scaling activities. If this list is omitted, all activities are described
        #   * MaxRecords<~Integer>: The maximum number of records to return.
        #   * NextToken<~String>: A string that marks the start of the next batch of returned results

        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     *ResponseMetadata<~Hash>
        #       * 'RequestId'<~String> - Id of the request
        #       * 'NextToken<~String>
        #     *Activities<~Array> An array of hashes, describing the scaling activities
        #       *ActivityId<~String> Specifies the ID of the activity.
        #       *AutoScalingGroupName<~String> The name of the Auto Scaling group.
        #       *Cause<~String> Contains the reason the activity was begun.
        #       *Description<~String>Contains a friendly, more verbose description of the scaling activity.
        #       *EndTime<~DateTime>Provides the end time of this activity.
        #       *Progress<~Integer> Specifies a value between 0 and 100 that indicates the progress of the activity.
        #       *StartTime<~DateTime> Provides the start time of this activity.
        #       *StatusCode<~String> Contains the current status of the activity.
        #       *StatusMessage<~String> Contains a friendly, more verbose description of the activity status

        #
        # ==== See Also
        # http://docs.amazonwebservices.com/AutoScaling/latest/APIReference/API_DescribeScalingActivities.html
        #
        def describe_scaling_activities(options={})

          if activities = options.delete('ActivityIds')
            options.merge!(Fog::AWS.indexed_param('ActivityIds.member', [*activities]))
          end

          request({
            'Action'                => 'DescribeScalingActivities',
            :parser                 => Fog::Parsers::AWS::AutoScaling::DescribeScalingActivities.new
          }.merge(options))
          
        end

      end
    end
  end
end
