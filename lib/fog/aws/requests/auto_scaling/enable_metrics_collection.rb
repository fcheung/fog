module Fog
  module AWS
    class AutoScaling
      class Real

        require 'fog/aws/parsers/auto_scaling/basic'

        # Enables monitoring of group metrics for the Auto Scaling group specified in AutoScalingGroupName
        # 
        # ==== Parameters
        # * group_name<~String>: name of the auto scaling group
        # * metrics<~Array>: list of the metrics to enable (omit to enable all)
        #
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * 'RequestId'<~String> - Id of the request
        #
        # ==== See Also
        # http://docs.amazonwebservices.com/AutoScaling/latest/APIReference/API_EnableMetricsCollection.html
        #
        def enable_metrics_collection(group_name, metrics=nil)
          options = {
            'AutoScalingGroupName'  => group_name,
            'Granularity' => "1Minute" #this is currently the only legal value for this (mandatory) parameter
          }
          options.merge!(Fog::AWS.indexed_param('Metrics.member', [*metrics])) if metrics
          
          request({
            'Action'    => 'EnableMetricsCollection',
            :parser     => Fog::Parsers::AWS::AutoScaling::Basic.new
          }.merge(options))
          
        end
      end
    end
  end
end
