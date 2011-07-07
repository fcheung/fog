module Fog
  module AWS
    class AutoScaling
      class Real

        require 'fog/aws/parsers/auto_scaling/basic'

        # Disable monitoring of group metrics for the Auto Scaling group specified in AutoScalingGroupName
        # 
        # ==== Parameters
        # * group_name<~String>: name of the auto scaling group
        # * metrics<~Array>: list of the metrics to disable (omit to disable all)
        #
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * 'RequestId'<~String> - Id of the request
        #
        # ==== See Also
        # http://docs.amazonwebservices.com/AutoScaling/latest/APIReference/API_DisableMetricsCollection.html
        #
        def disable_metrics_collection(group_name, metrics=nil)
          options = {
            'AutoScalingGroupName'  => group_name,
          }
          options.merge!(Fog::AWS.indexed_param('Metrics.member', [*metrics])) if metrics
          
          request({
            'Action'    => 'DisableMetricsCollection',
            :parser     => Fog::Parsers::AWS::AutoScaling::Basic.new
          }.merge(options))
          
        end
      end
    end
  end
end
