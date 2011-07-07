module Fog
  module AWS
    class AutoScaling
      class Real

        require 'fog/aws/parsers/auto_scaling/basic'

        # Delete a launch configuration
        # 
        # ==== Parameters
        # * LaunchConfigurationName<~String>: name of the launch configuration to delete
        #
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * 'RequestId'<~String> - Id of the request
        #
        # ==== See Also
        # http://docs.amazonwebservices.com/AutoScaling/latest/APIReference/API_DeleteLaunchConfiguration.html
        #
        def delete_launch_configuration(configuration_name)
          request({
            'Action'    => 'DeleteLaunchConfiguration',
            'LaunchConfigurationName' => configuration_name,
            :parser     => Fog::Parsers::AWS::AutoScaling::Basic.new
          })
        end

      end
    end
  end
end
