module Fog
  module AWS
    class AutoScaling
      class Real

        require 'fog/aws/parsers/auto_scaling/basic'

        # Delete an auto scaling group
        # 
        # ==== Parameters
        # * GroupName<~String>: name of the launch configuration to delete
        #
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * 'RequestId'<~String> - Id of the request
        #
        # ==== See Also
        # http://docs.amazonwebservices.com/AutoScaling/latest/APIReference/API_DeleteAutoScalingGroup.html
        #
        def delete_auto_scaling_group(group_name)
          request({
            'Action'    => 'DeleteAutoScalingGroup',
            'AutoScalingGroupName' => group_name,
            :parser     => Fog::Parsers::AWS::AutoScaling::Basic.new
          })
        end
      end
    end
  end
end
