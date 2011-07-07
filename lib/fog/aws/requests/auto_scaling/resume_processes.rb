module Fog
  module AWS
    class AutoScaling
      class Real

        require 'fog/aws/parsers/auto_scaling/basic'

        # Suspend auto scaling processes for and auto scaling
        # 
        # ==== Parameters
        # * group_name<~String>: name of the auto scaling group
        # * processes<~Array>: list of the processes to update (omit to suspend all processes)
        #
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * 'RequestId'<~String> - Id of the request
        #
        # ==== See Also
        # http://docs.amazonwebservices.com/AutoScaling/latest/APIReference/API_ResumeProcesses.html
        #
        def resume_processes(group_name, processes=nil)
          options = {
            'AutoScalingGroupName'  => group_name,
          }
          options.merge!(Fog::AWS.indexed_param('ScalingProcesses.member', [*processes])) if processes
          
          request({
            'Action'    => 'ResumeProcesses',
            :parser     => Fog::Parsers::AWS::AutoScaling::Basic.new
          }.merge(options))
          
        end

      end
    end
  end
end
